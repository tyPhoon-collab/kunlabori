use std::sync::Arc;

use log::{debug, error};
use yrs::{
    types::Delta,
    updates::{decoder::Decode, encoder::Encode},
    Assoc, Doc, GetString, IndexedSequence, Observable, Out, ReadTxn, StateVector, StickyIndex,
    Subscription, Text, TextRef, Transact, Update,
};

use crate::{
    api::model::{Partial, SimpleDelta},
    domain::error::DocumentError,
    frb_generated::StreamSink,
};

// Origin keys used for tagging transactions
const ORIGIN_LOCAL: &str = "local";
const ORIGIN_REMOTE: &str = "remote";

pub struct Document {
    pub id: String,
    doc: Arc<Doc>,
    text_ref: Arc<TextRef>,
    stream_sink: StreamSink<Partial>,
    index: Option<StickyIndex>,
    _text_subscription: Box<Subscription>,
    _update_subscription: Box<Subscription>,
}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<Partial>) -> Result<Self, DocumentError> {
        let doc = Arc::new(Doc::new());
        let text_ref = Arc::new(doc.get_or_insert_text(id.clone()));

        let text_subscription = Self::setup_text_observer(&text_ref, stream_sink.clone());
        let update_subscription =
            Self::setup_update_observer(&doc, id.clone(), stream_sink.clone())?;

        Ok(Self {
            id,
            doc,
            text_ref,
            stream_sink,
            index: None,
            _text_subscription: Box::new(text_subscription),
            _update_subscription: Box::new(update_subscription),
        })
    }

    fn setup_text_observer(text_ref: &TextRef, stream_sink: StreamSink<Partial>) -> Subscription {
        text_ref.observe(move |txn, event| {
            debug!("Text event received");
            let remote = matches!(txn.origin(), Some(o) if o.as_ref() == ORIGIN_REMOTE.as_bytes());
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
                        Partial::Delta(SimpleDelta::Insert { text, remote })
                    }
                    Delta::Deleted(count) => Partial::Delta(SimpleDelta::Delete {
                        count: *count,
                        remote,
                    }),
                    Delta::Retain(count, _) => Partial::Delta(SimpleDelta::Retain {
                        count: *count,
                        remote,
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
        id: String,
        stream_sink: StreamSink<Partial>,
    ) -> Result<Subscription, DocumentError> {
        doc.observe_update_v1(move |txn, event| {
            debug!("Update event received");

            // Send update
            if let Err(e) = stream_sink.add(Partial::Update(event.update.clone())) {
                error!("Failed to send update: {}", e);
            }

            // Send current text
            if let Some(text) = txn.get_text(id.as_str()) {
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
        self.text_ref.insert(
            &mut self.doc.transact_mut_with(ORIGIN_LOCAL),
            position,
            text,
        );
        Ok(())
    }

    pub fn delete(&mut self, position: u32, delete_count: u32) -> Result<(), DocumentError> {
        self.text_ref.remove_range(
            &mut self.doc.transact_mut_with(ORIGIN_LOCAL),
            position,
            delete_count,
        );
        Ok(())
    }

    pub fn merge(&mut self, update: Vec<u8>) -> Result<(), DocumentError> {
        let update = Update::decode_v1(&update).map_err(|e| DocumentError::DecodeError {
            message: format!("Failed to decode update: {}", e),
        })?;
        let mut txn = self.doc.transact_mut_with(ORIGIN_REMOTE);
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

    pub fn set_index(&mut self, position: u32) {
        if let Some(index) = self.text_ref.sticky_index(
            &mut self.doc.transact_mut_with(ORIGIN_LOCAL),
            position,
            Assoc::Before,
        ) {
            self.index = Some(index);
        }
    }

    pub fn index(&self) -> Option<u32> {
        self.index
            .as_ref()
            .and_then(|s| s.get_offset(&self.doc.transact()))
            .map(|offset| offset.index)
    }
}
