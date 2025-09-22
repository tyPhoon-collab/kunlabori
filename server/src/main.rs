use std::{
    collections::HashMap,
    env,
    io::Error as IoError,
    net::SocketAddr,
    sync::{Arc, Mutex},
};

use futures_channel::mpsc::{UnboundedSender, unbounded};
use futures_util::{StreamExt, future, stream::TryStreamExt};
use log::{info, error, warn};

use tokio::net::{TcpListener, TcpStream};
use tokio_tungstenite::tungstenite::protocol::Message;

type Tx = UnboundedSender<Message>;
type PeerMap = Arc<Mutex<HashMap<SocketAddr, Tx>>>;

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

    let broadcast_incoming = incoming.try_for_each(|msg| {
        if let Ok(text) = msg.to_text() {
            info!("Received message from {}: {}", addr, text);
        }

        let peers = match peer_map.lock() {
            Ok(peers) => peers,
            Err(_) => {
                error!("Failed to acquire peer map lock during broadcast");
                return future::ok(());
            }
        };

        // We want to broadcast the message to everyone except ourselves.
        let broadcast_recipients: Vec<_> = peers
            .iter()
            .filter(|(peer_addr, _)| *peer_addr != &addr)
            .map(|(_, ws_sink)| ws_sink)
            .collect();

        for recp in broadcast_recipients {
            if let Err(e) = recp.unbounded_send(msg.clone()) {
                warn!("Failed to send message to peer: {}", e);
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
        error!("Failed to acquire peer map lock during cleanup for {}", addr);
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
