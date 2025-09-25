import 'package:flutter/material.dart';
import 'package:kunlabori/message.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

typedef Send = void Function(SendMessage message);
typedef RemoteSelection = ({int offset, int length, String addr});
typedef OnSelection = void Function(RemoteSelection selection);
typedef OnUnselected = void Function(String addr);
typedef OnDisconnected = void Function(String addr);

final class WebsocketEventHandler {
  const WebsocketEventHandler(this._send);

  final Send _send;

  void handle(
    String id,
    ReceiveMessage message, {
    required OnSelection onSelection,
    required OnUnselected onUnselected,
    required OnDisconnected onDisconnected,
  }) {
    final action = switch (message) {
      ReceiveMessageConnected(:final addr) => () {
        debugPrint('Connected to $addr');
        _send(
          SendMessage.join(bytes: rust_api.stateVector(id: id)),
        );
      },
      ReceiveMessageDisconnected(:final addr) => () {
        debugPrint('Disconnected from $addr');
        onDisconnected(addr);
      },
      ReceiveMessageUpdate(:final bytes) => () => rust_api.merge(
        id: id,
        update: bytes,
      ),
      ReceiveMessageSelection(:final offset, :final length, :final addr) =>
        () => onSelection(
          (offset: offset, length: length, addr: addr),
        ),
      ReceiveMessageUnselect(:final addr) => () {
        onUnselected(addr);
      },
      ReceiveMessageRead(:final bytes, :final from) => () => _send(
        SendMessage.init(
          bytes: rust_api.diff(id: id, since: bytes),
          to: from,
        ),
      ),
      ReceiveMessageInit(:final bytes) => () => rust_api.merge(
        id: id,
        update: bytes,
      ),
    };
    action();
  }
}

final class PartialEventHandler {
  PartialEventHandler(this._send);

  final Send _send;
  ({int offset, int length})? _selection;

  int? get offset => _selection?.offset;
  int? get length => _selection?.length;

  void setSelection(String id, {required int offset, required int length}) {
    _selection = (offset: offset, length: length);
    rust_api.setIndex(id: id, position: offset);
    _send(SendMessage.selection(offset: offset, length: length));
  }

  void setLength(String id, int length) {
    if (_selection case final selection? when selection.length != length) {
      _selection = (offset: selection.offset, length: length);
      _send(SendMessage.selection(offset: selection.offset, length: length));
    }
  }

  void handle(
    String id,
    Partial partial, {
    required void Function(String text) onText,
  }) {
    final action = switch (partial) {
      Partial_Delta() => () {},
      Partial_Update(:final field0) => () {
        _send(SendMessage.update(bytes: field0));
        final i = rust_api.index(id: id);
        if (_selection case final selection? when selection.offset != i) {
          if (i == null) {
            _selection = null;
            _send(
              SendMessage.unselect(
                offset: selection.offset,
                length: selection.length,
              ),
            );
          } else {
            _selection = (offset: i, length: _selection!.length);
            _send(
              SendMessage.selection(
                offset: _selection!.offset,
                length: _selection!.length,
              ),
            );
          }
        }
      },
      Partial_Text(:final field0) => () => onText(field0),
    };
    action();
  }
}
