use std::{
    collections::HashMap,
    sync::{Mutex, OnceLock},
};

use crate::domain::{document::Document, error::DocumentError};

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

pub fn with_document_mut<F, R>(id: &str, f: F) -> Result<R, DocumentError>
where
    F: FnOnce(&mut Document) -> Result<R, DocumentError>,
{
    let mut documents = get_app_state()
        .documents
        .lock()
        .map_err(|e| DocumentError::LockError {
            message: e.to_string(),
        })?;
    let document = documents
        .get_mut(id)
        .ok_or_else(|| DocumentError::DocumentNotFound { id: id.to_string() })?;
    f(document)
}

pub fn with_document<F, R>(id: &str, f: F) -> Result<R, DocumentError>
where
    F: FnOnce(&Document) -> R,
{
    let documents = get_app_state()
        .documents
        .lock()
        .map_err(|e| DocumentError::LockError {
            message: e.to_string(),
        })?;
    let document = documents
        .get(id)
        .ok_or_else(|| DocumentError::DocumentNotFound { id: id.to_string() })?;
    Ok(f(document))
}

pub fn with_documents_mut<F, R>(f: F) -> Result<R, DocumentError>
where
    F: FnOnce(&mut HashMap<String, Document>) -> Result<R, DocumentError>,
{
    let mut documents = get_app_state()
        .documents
        .lock()
        .map_err(|e| DocumentError::LockError {
            message: e.to_string(),
        })?;
    f(&mut documents)
}

pub fn create_document(
    id: String,
    stream_sink: crate::frb_generated::StreamSink<crate::api::model::Partial>,
    exists_ok: bool,
) -> Result<(), DocumentError> {
    with_documents_mut(|documents| {
        if documents.contains_key(&id) {
            if exists_ok {
                // Update stream_sink for existing document
                if let Some(document) = documents.get_mut(&id) {
                    document.update_stream_sink(stream_sink)?;
                }
                return Ok(());
            } else {
                return Err(DocumentError::DocumentAlreadyExists { id });
            }
        }
        let document = Document::new(id.clone(), stream_sink)?;
        documents.insert(id, document);
        Ok(())
    })
}

pub fn remove_document(id: &str) -> Result<(), DocumentError> {
    with_documents_mut(|documents| {
        documents
            .remove(id)
            .ok_or_else(|| DocumentError::DocumentNotFound { id: id.to_string() })?;
        Ok(())
    })
}
