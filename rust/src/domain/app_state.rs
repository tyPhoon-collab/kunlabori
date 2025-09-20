use std::{
    collections::HashMap,
    sync::{Mutex, OnceLock},
};

use crate::domain::document::Document;

pub struct AppState {
    pub documents: Mutex<HashMap<String, Document>>,
}

unsafe impl Send for AppState {}
unsafe impl Sync for AppState {}

static DOCUMENTS: OnceLock<AppState> = OnceLock::new();

pub fn get_app_state() -> &'static AppState {
    DOCUMENTS.get_or_init(|| AppState {
        documents: Mutex::new(HashMap::new()),
    })
}

pub fn with_document_mut<F, R>(id: &str, f: F) -> Result<R, String>
where
    F: FnOnce(&mut Document) -> Result<R, String>,
{
    let app_state = get_app_state();
    let mut documents = app_state.documents.lock().map_err(|e| e.to_string())?;
    let document = documents
        .get_mut(id)
        .ok_or_else(|| format!("Document with id {id} not found"))?;
    f(document)
}

pub fn with_document<F, R>(id: &str, f: F) -> Result<R, String>
where
    F: FnOnce(&Document) -> R,
{
    let app_state = get_app_state();
    let documents = app_state.documents.lock().map_err(|e| e.to_string())?;
    let document = documents
        .get(id)
        .ok_or_else(|| format!("Document with id {id} not found"))?;
    Ok(f(document))
}
