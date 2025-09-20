use std::{any::Any, error::Error};

use log::info;
use yrs::{
    types::Delta,
    updates::{decoder::Decode, encoder::Encode},
    Doc, Observable, Out, ReadTxn, StateVector, Subscription, Text, Transact, Update,
};

use crate::{api::model::SimpleDelta, frb_generated::StreamSink};

pub struct Document {
    pub id: String,
    doc: Doc,
    text_subscription: Subscription,
}

unsafe impl Send for Document {}
unsafe impl Sync for Document {}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<SimpleDelta>) -> Self {
        let doc = Doc::new();
        let text_ref = doc.get_or_insert_text(id.clone());

        let text_subscription = text_ref.observe({
            let stream_sink = stream_sink.clone();
            info!("Text changed");

            move |txn, event| {
                event.delta(txn).iter().for_each(|op| {
                    info!("Op: {:?}", op);
                    match op {
                        Delta::Inserted(value, _) => {
                            let text = match value {
                                Out::Any(a) => a.to_string(),
                                _ => panic!("Unexpected Out type"),
                            };
                            stream_sink.add(SimpleDelta::Insert { text }).unwrap();
                        }
                        Delta::Deleted(delete_count) => {
                            stream_sink
                                .add(SimpleDelta::Delete {
                                    delete_count: *delete_count,
                                })
                                .unwrap();
                        }
                        Delta::Retain(retain_count, _) => {
                            stream_sink
                                .add(SimpleDelta::Retain {
                                    retain_count: *retain_count,
                                })
                                .unwrap();
                        }
                    }
                });
            }
        });

        Self {
            id,
            doc,
            text_subscription,
        }
    }

    pub fn insert(&mut self, position: u32, text: &str) {
        let text_ref = self.doc.get_or_insert_text(self.id.clone());
        let mut txn = self.doc.transact_mut();
        text_ref.insert(&mut txn, position, text);
    }

    pub fn delete(&mut self, position: u32, delete_count: u32) {
        let text_ref = self.doc.get_or_insert_text(self.id.clone());
        let mut txn = self.doc.transact_mut();
        text_ref.remove_range(&mut txn, position, delete_count);
    }

    pub fn timestamp(&self) -> Vec<u8> {
        let txn = self.doc.transact();
        txn.state_vector().encode_v1()
    }

    pub fn state_vector(&self) -> Vec<u8> {
        let txn = self.doc.transact();
        txn.state_vector().encode_v1()
    }

    pub fn diff(&self, since: Vec<u8>) -> Vec<u8> {
        let since = StateVector::decode_v1(&since).unwrap();
        let txn = self.doc.transact();
        txn.encode_diff_v1(&since)
    }

    pub fn merge(&mut self, update: Vec<u8>) -> Result<(), Box<dyn Error>> {
        let update = Update::decode_v1(&update).unwrap();
        let mut txn = self.doc.transact_mut();
        txn.apply_update(update)?;
        Ok(())
    }
}
