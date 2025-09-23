//! Error types for the Document domain
//!
//! This module defines all error types related to document operations,
//! using the `thiserror` crate for ergonomic error handling.

use thiserror::Error;

/// Errors that can occur during document operations
#[derive(Error, Debug, Clone)]
pub enum DocumentError {
    /// Stream communication failure
    #[error("Stream error: {0}")]
    StreamError(String),

    /// Data decoding failure
    #[error("Decode error: {message}")]
    DecodeError { message: String },

    /// Document update failure
    #[error("Update error: {message}")]
    UpdateError { message: String },

    /// Unexpected data type encountered
    #[error("Unexpected data type: expected {expected}, got {actual}")]
    UnexpectedDataType { expected: String, actual: String },

    /// Text reference not found
    #[error("Text not found: {id}")]
    TextNotFound { id: String },

    /// Document not found in app state
    #[error("Document not found: {id}")]
    DocumentNotFound { id: String },

    /// Document already exists in app state
    #[error("Document already exists: {id}")]
    DocumentAlreadyExists { id: String },

    /// Mutex lock error
    #[error("Lock error: {message}")]
    LockError { message: String },
}
