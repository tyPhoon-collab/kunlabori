//! カスタムエラー型とエラーハンドリング

use thiserror::Error;

/// アプリケーション固有のエラー型
#[derive(Error, Debug)]
pub enum ServerError {
    /// WebSocketハンドシェイクエラー
    #[error("WebSocket handshake failed: {0}")]
    WebSocketHandshake(#[from] tokio_tungstenite::tungstenite::Error),

    /// Peer管理エラー
    #[error("Peer management error: {0}")]
    PeerManagement(String),

    /// メッセージシリアライゼーションエラー
    #[error("Message serialization error: {0}")]
    MessageSerialization(#[from] serde_json::Error),

    /// ネットワークI/Oエラー
    #[error("I/O error: {0}")]
    Io(#[from] std::io::Error),

    /// 設定エラー
    #[error("Configuration error: {0}")]
    Configuration(String),
}

/// アプリケーション共通のResult型
pub type ServerResult<T> = Result<T, ServerError>;
