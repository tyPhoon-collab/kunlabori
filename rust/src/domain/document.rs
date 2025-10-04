use std::sync::Arc;

use log::{debug, error};
use yrs::{
    types::Delta,
    undo::UndoManager,
    updates::{decoder::Decode, encoder::Encode},
    Assoc, Doc, GetString, IndexedSequence, Observable, Out, ReadTxn, StateVector, StickyIndex,
    Subscription, Text, TextRef, Transact, Update,
};

use crate::{
    api::model::{Partial, SimpleDelta},
    domain::{document_config, error::DocumentError},
    frb_generated::StreamSink,
};

// Origin keys used for tagging transactions
const ORIGIN_REMOTE: &str = "remote";

pub struct Document {
    pub id: String,
    doc: Arc<Doc>,
    text_ref: TextRef,
    undo_manager: UndoManager<()>,
    start: Option<StickyIndex>,
    end: Option<StickyIndex>,
    _stream_sink: StreamSink<Partial>,
    _text_subscription: Box<Subscription>,
    _update_subscription: Box<Subscription>,
}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<Partial>) -> Result<Self, DocumentError> {
        let doc: Arc<Doc> = Arc::new(Doc::with_options(document_config::default_doc_options()));
        let text_ref = doc.get_or_insert_text(id.clone());

        let mut undo_manager = UndoManager::<()>::with_scope_and_options(
            &doc,
            &text_ref,
            document_config::default_undo_options(),
        );
        undo_manager.include_origin(doc.client_id());

        let text_subscription = Self::setup_text_observer(&text_ref, stream_sink.clone());
        let update_subscription =
            Self::setup_update_observer(&doc, id.clone(), stream_sink.clone())?;

        Ok(Self {
            id,
            doc,
            text_ref,
            undo_manager,
            start: None,
            end: None,
            _stream_sink: stream_sink,
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

            if let Err(e) = stream_sink.add(Partial::Update(event.update.clone())) {
                error!("Failed to send update: {}", e);
            }

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
            &mut self.doc.transact_mut_with(self.doc.client_id()),
            position,
            text,
        );
        Ok(())
    }

    pub fn delete(&mut self, position: u32, delete_count: u32) -> Result<(), DocumentError> {
        self.text_ref.remove_range(
            &mut self.doc.transact_mut_with(self.doc.client_id()),
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

    pub fn undo(&mut self) -> Result<(), DocumentError> {
        self.undo_manager.undo_blocking();
        Ok(())
    }

    pub fn redo(&mut self) -> Result<(), DocumentError> {
        self.undo_manager.redo_blocking();
        Ok(())
    }

    pub fn set_selection(&mut self, start: u32, end: u32) {
        let mut txn = self.doc.transact_mut_with(self.doc.client_id());
        self.start = self.text_ref.sticky_index(&mut txn, start, Assoc::Before);
        self.end = self.text_ref.sticky_index(&mut txn, end, Assoc::After);
    }

    pub fn selection(&self) -> (Option<u32>, Option<u32>) {
        let txn = self.doc.transact();

        let start = self.start.as_ref().and_then(|idx| idx.get_offset(&txn));
        let end = self.end.as_ref().and_then(|idx| idx.get_offset(&txn));

        let start_index = start.map(|s| s.index);
        let end_index = end.map(|e| e.index);

        (start_index, end_index)
    }

    pub fn update_stream_sink(
        &mut self,
        stream_sink: StreamSink<Partial>,
    ) -> Result<(), DocumentError> {
        // Create new subscriptions with new stream_sink
        let text_subscription = Self::setup_text_observer(&self.text_ref, stream_sink.clone());
        let update_subscription =
            Self::setup_update_observer(&self.doc, self.id.clone(), stream_sink.clone())?;

        stream_sink
            .add(Partial::Text(
                self.text_ref.get_string(&self.doc.transact()),
            ))
            .unwrap();

        // Replace old subscriptions (they will be dropped automatically)
        self._text_subscription = Box::new(text_subscription);
        self._update_subscription = Box::new(update_subscription);
        self._stream_sink = stream_sink;

        Ok(())
    }
}
