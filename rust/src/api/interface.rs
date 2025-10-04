use crate::{
    api::model::Partial,
    domain::app_state::{create_document, remove_document, with_document, with_document_mut},
    frb_generated::StreamSink,
};

fn to_api_error<E: std::fmt::Display>(error: E) -> String {
    error.to_string()
}

#[flutter_rust_bridge::frb(sync)]
pub fn create(id: String, stream_sink: StreamSink<Partial>, exists_ok: bool) -> Result<(), String> {
    create_document(id, stream_sink, exists_ok).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn destroy(id: String) -> Result<(), String> {
    remove_document(&id).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn insert(id: String, position: u32, text: String) -> Result<(), String> {
    with_document_mut(&id, |document| document.insert(position, &text)).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn delete(id: String, position: u32, delete_count: u32) -> Result<(), String> {
    with_document_mut(&id, |document| document.delete(position, delete_count)).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn merge(id: String, update: Vec<u8>) -> Result<(), String> {
    with_document_mut(&id, |document| document.merge(update)).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn state_vector(id: String) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.state_vector()).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn diff(id: String, since: Vec<u8>) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.diff(since))
        .and_then(|result| result)
        .map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn undo(id: String) -> Result<(), String> {
    with_document_mut(&id, |document| document.undo()).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn redo(id: String) -> Result<(), String> {
    with_document_mut(&id, |document| document.redo()).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn set_selection(id: String, start: u32, end: u32) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.set_selection(start, end);
        Ok(())
    })
    .map_err(to_api_error)
}

#[flutter_rust_bridge::frb(sync)]
pub fn selection(id: String) -> Result<(Option<u32>, Option<u32>), String> {
    with_document(&id, |document| document.selection()).map_err(to_api_error)
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}
