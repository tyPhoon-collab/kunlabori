//! Kunlabori WebSocket サーバーのメインエントリーポイント

use log::info;
use tokio::net::TcpListener;

use server::{error::ServerResult, peer::PeerService, websocket::handle_connection};

#[tokio::main]
async fn main() -> ServerResult<()> {
    // ロギングを初期化
    env_logger::init();

    // Peerサービスを初期化
    let peer_service = PeerService::new();

    // TCPリスナーを開始
    let addr = "127.0.0.1:8080".to_string();
    let listener = TcpListener::bind(&addr).await?;
    info!("Kunlabori server listening on: {}", addr);

    // 接続を受け入れるループ
    while let Ok((stream, addr)) = listener.accept().await {
        let peer_service = peer_service.clone();
        tokio::spawn(async move {
            handle_connection(peer_service, stream, addr).await;
        });
    }

    Ok(())
}
