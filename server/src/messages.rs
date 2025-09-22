use serde::{Deserialize, Serialize};

/// Yrsプロトコル用のメッセージ型定義
#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum SendMessage {
    Update { bytes: String },
    Read { bytes: String, from: String },
    Init { bytes: String, to: String },
    Connected { addr: String },
}

#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum ReceiveMessage {
    Update { bytes: String },
    Join { bytes: String },
    Init { bytes: String, to: String },
}
