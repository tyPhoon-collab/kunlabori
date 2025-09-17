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
