use std::{
    collections::HashMap,
    env,
    io::Error as IoError,
    net::SocketAddr,
    sync::{Arc, Mutex},
};

use futures_channel::mpsc::{UnboundedSender, unbounded};
use futures_util::{StreamExt, future, stream::TryStreamExt};
use log::{error, info, warn};

use tokio::net::{TcpListener, TcpStream};
use tokio_tungstenite::tungstenite::protocol::Message;

mod messages;
use messages::ReceiveMessage;
use messages::SendMessage;

type Tx = UnboundedSender<Message>;
type PeerMap = Arc<Mutex<HashMap<SocketAddr, Tx>>>;

// メッセージをブロードキャスト
fn broadcast_message_to_peers(
    peers: &HashMap<SocketAddr, Tx>,
    sender_addr: SocketAddr,
    message: &SendMessage,
    exclude_sender: bool,
) -> Result<(), String> {
    let json_str = serde_json::to_string(message)
        .map_err(|e| format!("Failed to serialize message: {}", e))?;
    let ws_message = Message::Text(json_str.into());

    let recipients: Vec<_> = peers
        .iter()
        .filter(|(peer_addr, _)| !exclude_sender || **peer_addr != sender_addr)
        .map(|(_, tx)| tx)
        .collect();

    for tx in recipients {
        if let Err(e) = tx.unbounded_send(ws_message.clone()) {
            warn!("Failed to send message to peer: {}", e);
        }
    }

    Ok(())
}

// 特定のpeerにメッセージを送信
fn send_message_to_peer(peer: &Tx, message: &SendMessage) -> Result<(), String> {
    let json_str = serde_json::to_string(message)
        .map_err(|e| format!("Failed to serialize message: {}", e))?;
    let ws_message = Message::Text(json_str.into());

    if let Err(e) = peer.unbounded_send(ws_message) {
        warn!("Failed to send message to peer: {}", e);
        return Err(format!("Failed to send message to peer: {}", e));
    }

    Ok(())
}

// updateメッセージの処理
fn handle_update_message(peers: &HashMap<SocketAddr, Tx>, sender_addr: SocketAddr, bytes: String) {
    info!("Broadcasting update from {}", sender_addr);
    let update_msg = SendMessage::Update { bytes };
    if let Err(e) = broadcast_message_to_peers(peers, sender_addr, &update_msg, true) {
        warn!("Failed to broadcast update: {}", e);
    }
}

fn pick_initial_peer(peers: &HashMap<SocketAddr, Tx>, exclude_addr: SocketAddr) -> Option<&Tx> {
    peers
        .iter()
        .find(|(addr, _)| **addr != exclude_addr)
        .map(|(_, tx)| tx)
}

fn pick_peer(peers: &HashMap<SocketAddr, Tx>, addr: String) -> Option<&Tx> {
    peers
        .iter()
        .find(|(a, _)| a.to_string() == addr)
        .map(|(_, tx)| tx)
}

// joinメッセージの処理
fn handle_join_message(peers: &HashMap<SocketAddr, Tx>, sender_addr: SocketAddr, bytes: String) {
    info!("Received join from {}", sender_addr);
    let read_msg = SendMessage::Read {
        bytes: bytes.clone(),
        from: sender_addr.to_string(),
    };

    let initial_peer = match pick_initial_peer(peers, sender_addr) {
        Some(peer) => peer,
        None => {
            warn!("No other peers available to request initial state");
            return;
        }
    };

    if let Err(e) = send_message_to_peer(initial_peer, &read_msg) {
        warn!("Failed to forward join as update: {}", e);
    }
}

fn handle_init_message(
    peers: &HashMap<SocketAddr, Tx>,
    sender_addr: SocketAddr,
    bytes: String,
    to: String,
) {
    info!("Received init from {} to {}", sender_addr, to);
    let init_msg = SendMessage::Init {
        bytes: bytes.clone(),
        to: to.clone(),
    };

    let target_peer = pick_peer(peers, to.clone());

    if let Some(tx) = target_peer {
        if let Err(e) = send_message_to_peer(tx, &init_msg) {
            warn!("Failed to send init message to {}: {}", to, e);
        }
    } else {
        warn!("Target peer {} not found for init message", to);
    }
}

async fn handle_connection(peer_map: PeerMap, raw_stream: TcpStream, addr: SocketAddr) {
    info!("WebSocket connection established: {}", addr);

    let ws_stream = match tokio_tungstenite::accept_async(raw_stream).await {
        Ok(stream) => stream,
        Err(e) => {
            error!("WebSocket handshake error for {}: {}", addr, e);
            return;
        }
    };

    // Insert the write part of this peer to the peer map.
    let (tx, rx) = unbounded();
    if let Ok(mut peers) = peer_map.lock() {
        peers.insert(addr, tx);
    } else {
        error!("Failed to acquire peer map lock for {}", addr);
        return;
    }

    let (outgoing, incoming) = ws_stream.split();

    // Send connect message
    if let Ok(peers) = peer_map.lock() {
        let connect_msg = SendMessage::Connected {
            addr: addr.to_string(),
        };
        if let Err(e) = send_message_to_peer(&peers[&addr], &connect_msg) {
            warn!("Failed to send connect message to {}: {}", addr, e);
        }
    } else {
        error!(
            "Failed to acquire peer map lock to send connect message for {}",
            addr
        );
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

        let peers = match peer_map.lock() {
            Ok(peers) => peers,
            Err(_) => {
                error!("Failed to acquire peer map lock during message processing");
                return future::ok(());
            }
        };

        match message {
            ReceiveMessage::Update { bytes } => {
                handle_update_message(&peers, addr, bytes);
            }
            ReceiveMessage::Join { bytes } => {
                handle_join_message(&peers, addr, bytes);
            }
            ReceiveMessage::Init { bytes, to } => {
                handle_init_message(&peers, addr, bytes, to);
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
    if let Ok(mut peers) = peer_map.lock() {
        peers.remove(&addr);
    } else {
        error!(
            "Failed to acquire peer map lock during cleanup for {}",
            addr
        );
    }
}

#[tokio::main]
async fn main() -> Result<(), IoError> {
    env_logger::init();

    let addr = env::args()
        .nth(1)
        .unwrap_or_else(|| "127.0.0.1:8080".to_string());

    let state = PeerMap::new(Mutex::new(HashMap::new()));

    let listener = TcpListener::bind(&addr).await?;
    info!("Listening on: {}", addr);

    while let Ok((stream, addr)) = listener.accept().await {
        tokio::spawn(handle_connection(state.clone(), stream, addr));
    }

    Ok(())
}
