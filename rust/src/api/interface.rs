use log::info;

use crate::{
    api::model::SimpleDelta,
    domain::{
        app_state::{get_app_state, with_document, with_document_mut},
        document::Document,
    },
    frb_generated::StreamSink,
};

#[flutter_rust_bridge::frb(sync)]
pub fn create(id: String, sink: StreamSink<SimpleDelta>) -> Result<(), String> {
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;

    if documents.contains_key(&id) {
        return Err(format!("Document with id {id} already exists"));
    }

    let document = Document::new(id.clone(), sink);
    documents.insert(id.clone(), document);
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn destroy(id: String) -> Result<(), String> {
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;

    if documents.remove(&id).is_none() {
        return Err(format!("Document with id {id} not found"));
    }
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn insert(id: String, position: u32, text: String) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.insert(position, &text);
        info!("Inserted text into document with id {id}: pos={position}, text={text}");
        Ok(())
    })
}

#[flutter_rust_bridge::frb(sync)]
pub fn delete(id: String, position: u32, delete_count: u32) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.delete(position, delete_count);
        info!("Deleted text from document with id {id}: pos={position}, del={delete_count}");
        Ok(())
    })
}

#[flutter_rust_bridge::frb(sync)]
pub fn merge(id: String, update: Vec<u8>) -> Result<(), String> {
    with_document_mut(&id, |document| {
        document.merge(update).map_err(|e| e.to_string())?;
        info!("Merged update into document with id {id}");
        Ok(())
    })
}
#[flutter_rust_bridge::frb(sync)]
pub fn timestamp(id: String) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.timestamp())
}

#[flutter_rust_bridge::frb(sync)]
pub fn state_vector(id: String) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.state_vector())
}

#[flutter_rust_bridge::frb(sync)]
pub fn diff(id: String, since: Vec<u8>) -> Result<Vec<u8>, String> {
    with_document(&id, |document| document.diff(since))
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
