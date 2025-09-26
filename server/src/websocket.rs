//! WebSocket接続とメッセージ処理を管理するモジュール

use std::net::SocketAddr;

use futures_util::{StreamExt, future, stream::TryStreamExt};
use log::{error, info, warn};
use tokio::net::TcpStream;

use crate::{
    messages::{ReceiveMessage, SendMessage},
    peer::PeerService,
};

/// Update メッセージを処理
fn handle_update_message(peer_service: &PeerService, addr: SocketAddr, bytes: String) {
    info!("Broadcasting update from {}", addr);
    let update_msg = SendMessage::Update {
        bytes,
        addr: addr.to_string(),
    };
    if let Err(e) = peer_service.broadcast(addr, &update_msg, true) {
        warn!("Failed to broadcast update: {}", e);
    }
}

/// Selection メッセージを処理
fn handle_selection_message(peer_service: &PeerService, addr: SocketAddr, start: u32, end: u32) {
    info!(
        "Received selection from {}: start={}, end={}",
        addr, start, end
    );
    let selection_msg = SendMessage::Selection {
        start,
        end,
        addr: addr.to_string(),
    };
    if let Err(e) = peer_service.broadcast(addr, &selection_msg, true) {
        warn!("Failed to broadcast selection: {}", e);
    }
}

/// Unselect メッセージを処理
fn handle_unselect_message(peer_service: &PeerService, addr: SocketAddr) {
    info!("Received unselect from {}", addr);
    let unselect_msg = SendMessage::Unselect {
        addr: addr.to_string(),
    };
    if let Err(e) = peer_service.broadcast(addr, &unselect_msg, true) {
        warn!("Failed to broadcast unselect: {}", e);
    }
}

/// Join メッセージを処理
fn handle_join_message(peer_service: &PeerService, addr: SocketAddr, bytes: String) {
    info!("Received join from {}", addr);
    if let Err(e) = peer_service.request_initial_state(addr, bytes) {
        warn!("Failed to request initial state for {}: {}", addr, e);
    }
}

/// Init メッセージを処理
fn handle_init_message(peer_service: &PeerService, addr: SocketAddr, bytes: String, to: String) {
    info!("Received init from {} to {}", addr, to);
    if let Err(e) = peer_service.send_init_to_peer(&to, bytes) {
        warn!("Failed to send init message to {}: {}", to, e);
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
    if let Err(e) = peer_service.add_peer(addr, tx) {
        error!("Failed to add peer {}: {}", addr, e);
        return;
    }

    let (outgoing, incoming) = ws_stream.split();

    // Send connect message
    let connect_msg = SendMessage::Connected {
        addr: addr.to_string(),
    };
    if let Err(e) = peer_service.send_to_peer(addr, &connect_msg) {
        warn!("Failed to send connect message to {}: {}", addr, e);
    }

    let broadcast_incoming = incoming.try_for_each(|msg| {
        let text = match msg.to_text() {
            Ok(text) => text,
            Err(_) => {
                warn!("Received non-text message from {}", addr);
                return future::ok(());
            }
        };

        info!("Received message from {}: {}", addr, text);

        // JSONメッセージをパース
        let message: ReceiveMessage = match serde_json::from_str(text) {
            Ok(msg) => msg,
            Err(e) => {
                warn!("Failed to parse message from {}: {}", addr, e);
                return future::ok(());
            }
        };

        // メッセージを処理
        match message {
            ReceiveMessage::Update { bytes } => {
                handle_update_message(&peer_service, addr, bytes);
            }
            ReceiveMessage::Selection { start, end } => {
                handle_selection_message(&peer_service, addr, start, end);
            }
            ReceiveMessage::Unselect {} => {
                handle_unselect_message(&peer_service, addr);
            }
            ReceiveMessage::Join { bytes } => {
                handle_join_message(&peer_service, addr, bytes);
            }
            ReceiveMessage::Init { bytes, to } => {
                handle_init_message(&peer_service, addr, bytes, to);
            }
        }

        future::ok(())
    });

    let receive_from_others = rx.map(Ok).forward(outgoing);

    tokio::select! {
        result = broadcast_incoming => {
            if let Err(e) = result {
                error!("Error in broadcast handling for {}: {}", addr, e);
            }
        }
        result = receive_from_others => {
            if let Err(e) = result {
                error!("Error in message forwarding for {}: {}", addr, e);
            }
        }
    }

    info!("{} disconnected", &addr);

    // Send disconnect message
    let disconnect_msg = SendMessage::Disconnected {
        addr: addr.to_string(),
    };
    if let Err(e) = peer_service.broadcast(addr, &disconnect_msg, true) {
        warn!("Failed to broadcast disconnect message: {}", e);
    }

    if let Err(e) = peer_service.remove_peer(addr) {
        error!("Failed to remove peer {}: {}", addr, e);
    }
}
