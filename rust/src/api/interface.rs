use log::info;

use crate::{
    domain::{app_state::get_app_state, document::Document},
    frb_generated::StreamSink,
};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(sync)]
pub fn create(id: String, sink: StreamSink<String>) -> Result<(), String> {
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;

    if documents.contains_key(&id) {
        return Err(format!("Document with id {id} already exists"));
    }

    let document = Document::new(id.clone(), sink);
    documents.insert(id.clone(), document);

    info!("Created document with id {id}");

    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn insert(
    id: String,
    position: u32,
    text: String,
) -> Result<(), String> {
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;

    let document = documents
        .get_mut(&id)
        .ok_or_else(|| format!("Document with id {id} not found"))?;
    document
        .insert(position, &text).map_err(|e| format!("Insert error: {:?}", e))?;

    info!("Inserted text into document with id {id}: pos={position}, text={text}");

    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn delete(id: String, position: u32, delete_count: u32) -> Result<(), String> {
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;

    let document = documents
        .get_mut(&id)
        .ok_or_else(|| format!("Document with id {id} not found"))?;
    document
        .delete(position, delete_count).map_err(|e| format!("Delete error: {:?}", e))?;

    info!("Deleted text from document with id {id}: pos={position}, del={delete_count}");

    Ok(())
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
