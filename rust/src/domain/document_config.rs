use yrs::{doc::Options as DocOptions, undo::Options as UndoOptions, OffsetKind};

#[cfg(target_family = "wasm")]
use std::collections::HashSet;
#[cfg(target_family = "wasm")]
use std::sync::Arc;

/// Creates default document options with UTF-16 offset kind
pub fn default_doc_options() -> DocOptions {
    DocOptions {
        offset_kind: OffsetKind::Utf16,
        ..DocOptions::default()
    }
}

/// Creates default undo manager options
/// This function works on both wasm and non-wasm targets
pub fn default_undo_options() -> UndoOptions {
    #[cfg(not(target_family = "wasm"))]
    {
        UndoOptions::default()
    }

    #[cfg(target_family = "wasm")]
    {
        use yrs::sync::{time::Clock, time::Timestamp};

        // Custom clock implementation for WASM using js_sys
        struct WasmClock;

        impl Clock for WasmClock {
            fn now(&self) -> Timestamp {
                js_sys::Date::now() as Timestamp
            }
        }

        UndoOptions {
            capture_timeout_millis: 500,
            tracked_origins: HashSet::new(),
            capture_transaction: None,
            timestamp: Arc::new(WasmClock),
        }
    }
}
