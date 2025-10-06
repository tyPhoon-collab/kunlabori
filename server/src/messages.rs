use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum SendMessage {
    Welcome {
        peer_id: String,
    },
    Update {
        bytes: String,
        peer_id: String,
    },
    Selection {
        start: u32,
        end: u32,
        peer_id: String,
    },
    Unselect {
        peer_id: String,
    },
    Read {
        bytes: String,
        from: String,
    },
    Init {
        bytes: String,
        to: String,
    },
    Connected {
        peer_id: String,
    },
    Disconnected {
        peer_id: String,
    },
}

#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum ReceiveMessage {
    Update { bytes: String },
    Selection { start: u32, end: u32 },
    Unselect {},
    Join { bytes: String },
    Init { bytes: String, to: String },
}
