use std::any::Any;

use log::info;
use yrs::{Doc, GetString, Observable, Subscription, Text, Transact};

use crate::frb_generated::StreamSink;

pub struct Document {
    pub id: String,
    doc: Doc,
    update_subscription: Subscription,
    text_subscription: Subscription,
}

unsafe impl Send for Document {}
unsafe impl Sync for Document {}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<String>) -> Self {
        let doc = Doc::new();
        let text_ref = doc.get_or_insert_text(id.clone());

        let update_subscription = doc
            .observe_update_v1({
                let stream_sink = stream_sink.clone();
                let text_ref = doc.get_or_insert_text(id.clone());

                let id = id.clone();
                move |txn, _update| {
                    let text = text_ref.get_string(txn);
                    info!("Document updated: id={} text={}", id, text);
                    stream_sink.add(text).unwrap();
                }
            })
            .unwrap();

        let text_subscription = text_ref.observe({
            let stream_sink = stream_sink.clone();
            let text_ref = doc.get_or_insert_text(id.clone());

            move |txn, _event| {
                info!("Text changed");
                let text = text_ref.get_string(txn);
                stream_sink.add(text).unwrap();
            }
        });

        Self {
            id,
            doc,
            update_subscription,
            text_subscription,
        }
    }

    pub fn insert(&mut self, position: u32, text: &str) -> Result<(), Box<dyn Any>> {
        let text_ref = self.doc.get_or_insert_text(self.id.clone());
        let mut txn = self.doc.transact_mut();
        text_ref.insert(&mut txn, position, text);

        Ok(())
    }

    pub fn delete(&mut self, position: u32, delete_count: u32) -> Result<(), Box<dyn Any>> {
        let text_ref = self.doc.get_or_insert_text(self.id.clone());
        let mut txn = self.doc.transact_mut();
        text_ref.remove_range(&mut txn, position, delete_count);

        Ok(())
    }

    pub fn get(&self) -> Result<String, Box<dyn std::error::Error>> {
        let text_ref = self.doc.get_or_insert_text(self.id.clone());
        let txn = self.doc.transact();
        let text = text_ref.get_string(&txn);

        Ok(text)
    }
}
