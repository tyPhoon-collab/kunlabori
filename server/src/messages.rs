use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum SendMessage {
    Update {
        bytes: String,
        addr: String,
    },
    Selection {
        offset: u32,
        length: u32,
        addr: String,
    },
    Unselect {
        addr: String,
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
        addr: String,
    },
    Disconnected {
        addr: String,
    },
}

#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
#[serde(rename_all = "snake_case")]
pub enum ReceiveMessage {
    Update { bytes: String },
    Selection { offset: u32, length: u32 },
    Unselect {},
    Join { bytes: String },
    Init { bytes: String, to: String },
}
