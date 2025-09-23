use std::sync::Arc;

use log::{error, info};
use yrs::{
    types::Delta,
    updates::{decoder::Decode, encoder::Encode},
    Doc, GetString, Observable, Out, ReadTxn, StateVector, Subscription, Text, TextRef, Transact,
    Update,
};

use crate::{
    api::model::{Partial, SimpleDelta},
    domain::DocumentError,
    frb_generated::StreamSink,
};

pub struct Document {
    pub id: String,
    doc: Arc<Doc>,
    stream_sink: StreamSink<Partial>,
    _text_subscription: Box<Subscription>,
    _update_subscription: Box<Subscription>,
}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<Partial>) -> Result<Self, DocumentError> {
        let doc = Arc::new(Doc::new());
        let text_ref = doc.get_or_insert_text(id.clone());

        let text_subscription = Self::setup_text_observer(&text_ref, stream_sink.clone());
        let update_subscription = Self::setup_update_observer(&doc, &id, stream_sink.clone())?;

        Ok(Self {
            id,
            doc,
            stream_sink,
            _text_subscription: Box::new(text_subscription),
            _update_subscription: Box::new(update_subscription),
        })
    }

    fn setup_text_observer(text_ref: &TextRef, stream_sink: StreamSink<Partial>) -> Subscription {
        text_ref.observe(move |txn, event| {
            for delta in event.delta(txn).iter() {
                let partial = match delta {
                    Delta::Inserted(value, _) => {
                        let text = match value {
                            Out::Any(a) => a.to_string(),
                            _ => {
                                error!("Unexpected Out type: {:?}", value);
                                continue;
                            }
                        };
                        Partial::Delta(SimpleDelta::Insert { text })
                    }
                    Delta::Deleted(delete_count) => Partial::Delta(SimpleDelta::Delete {
                        delete_count: *delete_count,
                    }),
                    Delta::Retain(retain_count, _) => Partial::Delta(SimpleDelta::Retain {
                        retain_count: *retain_count,
                    }),
                };

                if let Err(e) = stream_sink.add(partial) {
                    error!("Failed to send delta: {}", e);
                }
            }
        })
    }

    fn setup_update_observer(
        doc: &Arc<Doc>,
        id: &str,
        stream_sink: StreamSink<Partial>,
    ) -> Result<Subscription, DocumentError> {
        let id_clone = id.to_string();
        doc.observe_update_v1(move |txn, event| {
            info!("Update event received");

            // Send update
            if let Err(e) = stream_sink.add(Partial::Update(event.update.clone())) {
                error!("Failed to send update: {}", e);
            }

            // Send current text
            if let Some(text) = txn.get_text(id_clone.as_str()) {
                let text_string = text.get_string(txn);
                if let Err(e) = stream_sink.add(Partial::Text(text_string)) {
                    error!("Failed to send text: {}", e);
                }
            }
        })
        .map_err(|e| DocumentError::UpdateError {
            message: format!("Failed to setup update observer: {}", e),
        })
    }

    // Core document operations
    pub fn insert(&mut self, position: u32, text: &str) -> Result<(), DocumentError> {
        self.doc.get_or_insert_text(self.id.as_str()).insert(
            &mut self.doc.transact_mut(),
            position,
            text,
        );
        Ok(())
    }

    pub fn delete(&mut self, position: u32, delete_count: u32) -> Result<(), DocumentError> {
        self.doc.get_or_insert_text(self.id.as_str()).remove_range(
            &mut self.doc.transact_mut(),
            position,
            delete_count,
        );
        Ok(())
    }

    pub fn merge(&mut self, update: Vec<u8>) -> Result<(), DocumentError> {
        let update = Update::decode_v1(&update).map_err(|e| DocumentError::DecodeError {
            message: format!("Failed to decode update: {}", e),
        })?;
        let mut txn = self.doc.transact_mut();
        txn.apply_update(update)
            .map_err(|e| DocumentError::UpdateError {
                message: format!("Failed to apply update: {}", e),
            })
    }

    pub fn state_vector(&self) -> Vec<u8> {
        self.doc.transact().state_vector().encode_v1()
    }

    pub fn diff(&self, since: Vec<u8>) -> Result<Vec<u8>, DocumentError> {
        let since = StateVector::decode_v1(&since).map_err(|e| DocumentError::DecodeError {
            message: format!("Failed to decode state vector: {}", e),
        })?;
        Ok(self.doc.transact().encode_diff_v1(&since))
    }
}
