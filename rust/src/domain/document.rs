use automerge::{transaction::Transactable, ObjId, ObjType, ReadDoc};

use crate::frb_generated::StreamSink;

pub struct Document {
    pub id: String,
    obj_id: ObjId,
    doc: automerge::AutoCommit,
    stream_sink: StreamSink<String>,
}

impl Document {
    pub fn new(id: String, stream_sink: StreamSink<String>) -> Self {
        let mut doc = automerge::AutoCommit::new();
        let obj_id = doc
            .put_object(automerge::ROOT, "text", ObjType::Text)
            .unwrap();
        Self {
            id,
            obj_id,
            doc,
            stream_sink,
        }
    }

    pub fn edit(
        &mut self,
        position: usize,
        delete_count: isize,
        text: &str,
    ) -> Result<(), automerge::AutomergeError> {
        self.doc
            .splice_text(&self.obj_id, position, delete_count, text)?;

        let text = self.doc.text(&self.obj_id)?;
        self.stream_sink.add(text).unwrap();

        Ok(())
    }

    pub fn get(&self) -> Result<String, automerge::AutomergeError> {
        let text = self.doc.text(&self.obj_id)?;

        Ok(text)
    }
}
