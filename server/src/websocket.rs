//! WebSocket接続とメッセージ処理を管理するモジュール

use std::{collections::HashMap, net::SocketAddr, sync::Arc};

use futures_util::{StreamExt, future, stream::TryStreamExt};
use log::{debug, error, info, warn};
use tokio::net::TcpStream;

use crate::{
    messages::{ReceiveMessage, Selection, SendMessage},
    peer::{PeerId, PeerService},
};

/// メッセージハンドラー
///
/// PeerServiceとPeerIdをまとめて管理し、各種メッセージ処理を提供します。
/// Dropトレイトを実装することで、スコープを抜ける際に自動的に切断処理を行います。
struct MessageHandler {
    peer_service: PeerService,
    peer_id: PeerId,
    addr: SocketAddr,
}

impl MessageHandler {
    fn new(peer_service: PeerService, peer_id: PeerId, addr: SocketAddr) -> Self {
        // Send welcome message with peer ID
        let welcome_msg = SendMessage::Welcome {
            peer_id: peer_id.clone(),
        };
        if let Err(e) = peer_service.send(&peer_id, &welcome_msg) {
            warn!("Failed to send welcome message to {}: {}", peer_id, e);
        }

        // Broadcast connect message
        let connect_msg = SendMessage::Connected {
            peer_id: peer_id.clone(),
        };
        if let Err(e) = peer_service.broadcast(&peer_id, &connect_msg, true) {
            warn!("Failed to broadcast connect message for {}: {}", peer_id, e);
        }

        Self {
            peer_service,
            peer_id,
            addr,
        }
    }

    /// Update メッセージを処理
    fn handle_update(&self, bytes: String) {
        debug!("Received update from {}", self.peer_id);
        let update_msg = SendMessage::Update {
            bytes,
            peer_id: self.peer_id.clone(),
        };
        if let Err(e) = self
            .peer_service
            .broadcast(&self.peer_id, &update_msg, true)
        {
            warn!("Failed to broadcast update: {}", e);
        }
    }

    /// Selection メッセージを処理
    fn handle_selection(&self, start: u32, end: u32) {
        debug!(
            "Received selection from {}: start={}, end={}",
            self.peer_id, start, end
        );
        let selection_msg = SendMessage::Selection {
            start,
            end,
            peer_id: self.peer_id.clone(),
        };
        if let Err(e) = self
            .peer_service
            .broadcast(&self.peer_id, &selection_msg, true)
        {
            warn!("Failed to broadcast selection from {}: {}", self.peer_id, e);
        }
    }

    /// Unselect メッセージを処理
    fn handle_unselect(&self) {
        debug!("Received unselect from {}", self.peer_id);
        let unselect_msg = SendMessage::Unselect {
            peer_id: self.peer_id.clone(),
        };
        if let Err(e) = self
            .peer_service
            .broadcast(&self.peer_id, &unselect_msg, true)
        {
            warn!("Failed to broadcast unselect from {}: {}", self.peer_id, e);
        }
    }

    /// Join メッセージを処理
    fn handle_join(&self, bytes: String) {
        debug!("Received join from {}", self.peer_id);

        match self.peer_service.find_other_peer(&self.peer_id) {
            Ok(Some(peer_info)) => {
                let read_msg = SendMessage::Read {
                    bytes,
                    from: self.peer_id.clone(),
                };
                if let Err(e) = self.peer_service.send(&peer_info.id, &read_msg) {
                    warn!("Failed to send read request to {}: {}", peer_info.id, e);
                }
            }
            Ok(None) => {
                warn!("No other peers available to request initial state");
            }
            Err(e) => {
                warn!("Failed to find other peer for {}: {}", self.peer_id, e);
            }
        }
    }

    /// Init メッセージを処理
    fn handle_init(&self, bytes: String, to: &PeerId, selections: HashMap<String, Selection>) {
        debug!("Received init from {} to {}", self.peer_id, to);

        match self.peer_service.get_peer(to) {
            Ok(Some(_)) => {
                let init_msg = SendMessage::Init {
                    bytes,
                    to: to.clone(),
                    selections,
                };
                if let Err(e) = self.peer_service.send(to, &init_msg) {
                    warn!("Failed to send init message to {}: {}", to, e);
                }
            }
            Ok(None) => {
                warn!("Target peer {} not found for init message", to);
            }
            Err(e) => {
                warn!("Failed to get peer {}: {}", to, e);
            }
        }
    }

    /// Peer切断時の処理
    fn handle_disconnection(&self) {
        info!("WebSocket {} ({}) disconnected", self.peer_id, self.addr);

        // Send disconnect message
        let disconnect_msg = SendMessage::Disconnected {
            peer_id: self.peer_id.clone(),
        };
        if let Err(e) = self
            .peer_service
            .broadcast(&self.peer_id, &disconnect_msg, true)
        {
            warn!("Failed to broadcast disconnect message: {}", e);
        }

        if let Err(e) = self.peer_service.remove_peer(&self.peer_id) {
            error!("Failed to remove peer {}: {}", self.peer_id, e);
        }
    }
}

impl Drop for MessageHandler {
    fn drop(&mut self) {
        self.handle_disconnection();
    }
}

/// WebSocket接続を処理する
pub async fn handle_connection(peer_service: PeerService, raw_stream: TcpStream, addr: SocketAddr) {
    info!("WebSocket connection established: {}", addr);

    let ws_stream = match tokio_tungstenite::accept_async(raw_stream).await {
        Ok(stream) => stream,
        Err(e) => {
            error!("WebSocket handshake error for {}: {}", addr, e);
            return;
        }
    };

    // Insert the write part of this peer to the peer map.
    let (tx, rx) = futures_channel::mpsc::unbounded();
    let peer_id = match peer_service.add_peer(addr, tx) {
        Ok(id) => id,
        Err(e) => {
            error!("Failed to add peer {}: {}", addr, e);
            return;
        }
    };

    info!("Peer {} assigned ID: {}", addr, peer_id);

    let (outgoing, incoming) = ws_stream.split();

    let handler = Arc::new(MessageHandler::new(peer_service, peer_id.clone(), addr));
    let broadcast_incoming = incoming.try_for_each(move |msg| {
        let text = match msg.to_text() {
            Ok(text) => text,
            Err(_) => {
                warn!("Received non-text message from {}", handler.peer_id);
                return future::ok(());
            }
        };

        info!("Received message from {}: {}", handler.peer_id, text);

        // JSONメッセージをパース
        let message: ReceiveMessage = match serde_json::from_str(text) {
            Ok(msg) => msg,
            Err(e) => {
                warn!("Failed to parse message from {}: {}", handler.peer_id, e);
                return future::ok(());
            }
        };

        // メッセージを処理
        match message {
            ReceiveMessage::Update { bytes } => {
                handler.handle_update(bytes);
            }
            ReceiveMessage::Selection { start, end } => {
                handler.handle_selection(start, end);
            }
            ReceiveMessage::Unselect {} => {
                handler.handle_unselect();
            }
            ReceiveMessage::Join { bytes } => {
                handler.handle_join(bytes);
            }
            ReceiveMessage::Init {
                bytes,
                to,
                selections,
            } => {
                handler.handle_init(bytes, &to, selections);
            }
        }

        future::ok(())
    });

    let receive_from_others = rx.map(Ok).forward(outgoing);

    tokio::select! {
        result = broadcast_incoming => {
            if let Err(e) = result {
                error!("Error in broadcast handling for {}: {}", peer_id, e);
            }
        }
        result = receive_from_others => {
            if let Err(e) = result {
                error!("Error in message forwarding for {}: {}", peer_id, e);
            }
        }
    }
}
