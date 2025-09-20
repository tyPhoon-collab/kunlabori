#[flutter_rust_bridge::frb]
#[derive(Debug, Clone)]
pub enum SimpleDelta {
    Insert { text: String },
    Delete { delete_count: u32 },
    Retain { retain_count: u32 },
}

#[flutter_rust_bridge::frb]
#[derive(Debug, Clone)]
pub enum Partial {
    Delta(SimpleDelta),
    Update(Vec<u8>),
}
