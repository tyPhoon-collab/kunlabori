#[flutter_rust_bridge::frb]
#[derive(Debug, Clone)]
pub enum SimpleDelta {
    Insert { text: String, remote: bool },
    Delete { count: u32, remote: bool },
    Retain { count: u32, remote: bool },
}

#[flutter_rust_bridge::frb]
#[derive(Debug, Clone)]
pub enum Partial {
    Delta(SimpleDelta),
    Text(String),
    Update(Vec<u8>),
}
