//! Peer管理とメッセージブロードキャスト機能

use futures_channel::mpsc::UnboundedSender;
use log::warn;
use std::{
    collections::HashMap,
    net::SocketAddr,
    sync::{Arc, Mutex},
};
use tokio_tungstenite::tungstenite::protocol::Message;

use crate::error::{ServerError, ServerResult};
use crate::messages::SendMessage;

pub type Tx = UnboundedSender<Message>;
pub type PeerMap = Arc<Mutex<HashMap<SocketAddr, Tx>>>;

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

    /// Peerを追加
    pub fn add_peer(&self, addr: SocketAddr, tx: Tx) -> ServerResult<()> {
        let mut peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;
        peers.insert(addr, tx);
        Ok(())
    }

    /// Peerを削除
    pub fn remove_peer(&self, addr: SocketAddr) -> ServerResult<()> {
        let mut peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;
        peers.remove(&addr);
        Ok(())
    }

    /// 特定のpeerにメッセージを送信
    pub fn send_to_peer(&self, addr: SocketAddr, message: &SendMessage) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        if let Some(tx) = peers.get(&addr) {
            self.send_message_to_tx(tx, message)
        } else {
            Err(ServerError::PeerManagement(format!(
                "Peer {} not found",
                addr
            )))
        }
    }

    /// メッセージをブロードキャスト（送信者を除外可能）
    pub fn broadcast(
        &self,
        sender_addr: SocketAddr,
        message: &SendMessage,
        exclude_sender: bool,
    ) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        let json_str = serde_json::to_string(message)?;
        let ws_message = Message::Text(json_str.into());

        for (addr, tx) in peers.iter() {
            if exclude_sender && *addr == sender_addr {
                continue;
            }
            if let Err(e) = tx.unbounded_send(ws_message.clone()) {
                warn!("Failed to send message to peer {}: {}", addr, e);
            }
        }

        Ok(())
    }

    /// 初期状態要求を既存のpeerに送信
    pub fn request_initial_state(
        &self,
        requester_addr: SocketAddr,
        bytes: String,
    ) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        let initial_peer = peers
            .iter()
            .find(|(addr, _)| **addr != requester_addr)
            .map(|(_, tx)| tx);

        if let Some(tx) = initial_peer {
            let read_msg = SendMessage::Read {
                bytes,
                from: requester_addr.to_string(),
            };
            self.send_message_to_tx(tx, &read_msg)
        } else {
            warn!("No other peers available to request initial state");
            Ok(())
        }
    }

    /// 指定されたpeerに初期化メッセージを送信
    pub fn send_init_to_peer(&self, target_addr_string: &str, bytes: String) -> ServerResult<()> {
        let peers = self.peers.lock().map_err(|_| {
            ServerError::PeerManagement("Failed to acquire peer map lock".to_string())
        })?;

        let target_peer = peers
            .iter()
            .find(|(addr, _)| addr.to_string() == target_addr_string)
            .map(|(_, tx)| tx);

        if let Some(tx) = target_peer {
            let init_msg = SendMessage::Init {
                bytes,
                to: target_addr_string.to_string(),
            };
            self.send_message_to_tx(tx, &init_msg)
        } else {
            warn!(
                "Target peer {} not found for init message",
                target_addr_string
            );
            Ok(())
        }
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
