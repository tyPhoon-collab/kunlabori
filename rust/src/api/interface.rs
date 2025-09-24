use log::info;

use crate::{
    api::model::Partial,
    domain::app_state::{create_document, remove_document, with_document, with_document_mut},
    frb_generated::StreamSink,
};

#[flutter_rust_bridge::frb(sync)]
pub fn create(id: String, stream_sink: StreamSink<Partial>) -> Result<(), String> {
    create_document(id, stream_sink).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn destroy(id: String) -> Result<(), String> {
    remove_document(&id).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn insert(id: String, position: u32, text: String) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.insert(position, &text)?;
        info!("Inserted text into document with id {id}: pos={position}, text={text}");
        Ok(())
    })
    .map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn delete(id: String, position: u32, delete_count: u32) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.delete(position, delete_count)?;
        info!("Deleted text from document with id {id}: pos={position}, del={delete_count}");
        Ok(())
    })
    .map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn merge(id: String, update: Vec<u8>) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.merge(update)?;
        info!("Merged update into document with id {id}");
        Ok(())
    })
    .map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn state_vector(id: String) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.state_vector()).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn diff(id: String, since: Vec<u8>) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.diff(since))
        .and_then(|result| result)
        .map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn set_index(id: String, position: u32) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.set_index(position);
        Ok(())
    })
    .map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn index(id: String) -> Result<Option<u32>, String> {
    with_document(&id, |document| document.index()).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
