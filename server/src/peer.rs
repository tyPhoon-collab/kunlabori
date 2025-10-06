//! Peer管理とメッセージブロードキャスト機能

use futures_channel::mpsc::UnboundedSender;
use log::warn;
use std::{
    collections::HashMap,
    net::SocketAddr,
    sync::{Arc, Mutex},
};
use tokio_tungstenite::tungstenite::protocol::Message;
use uuid::Uuid;

use crate::error::{ServerError, ServerResult};
use crate::messages::SendMessage;

pub type Tx = UnboundedSender<Message>;
pub type PeerId = String;

/// Peer情報
#[derive(Clone, Debug)]
pub struct PeerInfo {
    pub id: PeerId,
    pub addr: SocketAddr,
    pub tx: Tx,
}

pub type PeerMap = Arc<Mutex<HashMap<PeerId, PeerInfo>>>;

/// Peer管理を行うサービス
#[derive(Clone)]
pub struct PeerService {
    peers: PeerMap,
}

impl PeerService {
    /// 新しいPeerServiceを作成
    pub fn new() -> Self {
        Self {
            peers: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    /// Peerを追加してIDを返す
    pub fn add_peer(&self, addr: SocketAddr, tx: Tx) -> ServerResult<PeerId> {
        let peer_id = Uuid::new_v4().to_string();
        let mut peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        let peer_info = PeerInfo {
            id: peer_id.clone(),
            addr,
            tx,
        };

        peers.insert(peer_id.clone(), peer_info);
        Ok(peer_id)
    }

    /// Peerを削除
    pub fn remove_peer(&self, peer_id: &PeerId) -> ServerResult<()> {
        let mut peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;
        peers.remove(peer_id);
        Ok(())
    }

    /// 特定のpeerにメッセージを送信
    pub fn send(&self, peer_id: &PeerId, message: &SendMessage) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        if let Some(peer_info) = peers.get(peer_id) {
            self.send_message_to_tx(&peer_info.tx, message)
        } else {
            Err(ServerError::PeerManagement(format!(
                "Peer {} not found",
                peer_id
            )))
        }
    }

    /// メッセージをブロードキャスト(送信者を除外可能)
    pub fn broadcast(
        &self,
        sender_peer_id: &PeerId,
        message: &SendMessage,
        exclude_sender: bool,
    ) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        let json_str = serde_json::to_string(message)?;
        let ws_message = Message::Text(json_str.into());

        for (peer_id, peer_info) in peers.iter() {
            if exclude_sender && peer_id == sender_peer_id {
                continue;
            }
            if let Err(e) = peer_info.tx.unbounded_send(ws_message.clone()) {
                warn!("Failed to send message to peer {}: {}", peer_id, e);
            }
        }

        Ok(())
    }

    /// 他のpeerを探す(特定のpeerを除外)
    pub fn find_other_peer(&self, exclude_peer_id: &PeerId) -> ServerResult<Option<PeerInfo>> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        Ok(peers
            .iter()
            .find(|(peer_id, _)| *peer_id != exclude_peer_id)
            .map(|(_, peer_info)| peer_info.clone()))
    }

    /// 指定されたpeerを取得
    pub fn get_peer(&self, peer_id: &PeerId) -> ServerResult<Option<PeerInfo>> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        Ok(peers.get(peer_id).cloned())
    }

    /// Txを使って直接メッセージを送信
    fn send_message_to_tx(&self, tx: &Tx, message: &SendMessage) -> ServerResult<()> {
        let json_str = serde_json::to_string(message)?;
        let ws_message = Message::Text(json_str.into());

        if let Err(e) = tx.unbounded_send(ws_message) {
            warn!("Failed to send message to peer: {}", e);
            return Err(ServerError::PeerManagement(format!(
                "Failed to send message to peer: {}",
                e
            )));
        }

        Ok(())
    }
}

impl Default for PeerService {
    fn default() -> Self {
        Self::new()
    }
}
