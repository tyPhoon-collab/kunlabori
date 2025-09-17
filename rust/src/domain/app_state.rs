use std::{
    collections::HashMap,
    sync::{Mutex, OnceLock},
};

use crate::domain::document::Document;
pub struct AppState {
    pub documents: Mutex<HashMap<String, Document>>,
}

static DOCUMENTS: OnceLock<AppState> = OnceLock::new();

pub fn get_app_state() -> &'static AppState {
    DOCUMENTS.get_or_init(|| AppState {
        documents: Mutex::new(HashMap::new()),
    })
}
