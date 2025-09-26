import 'package:kunlabori/message.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

typedef Send = void Function(SendMessage message);
typedef RemoteSelection = ({int offset, int length, String addr});
typedef OnSelection = void Function(RemoteSelection selection);
typedef OnUnselected = void Function(String addr);
typedef OnConnected = void Function(String addr);
typedef OnDisconnected = void Function(String addr);

final class WebsocketEventHandler {
  const WebsocketEventHandler(this._send);

  final Send _send;

  void handle(
    String id,
    ReceiveMessage message, {
    OnSelection? onSelection,
    OnUnselected? onUnselected,
    OnConnected? onConnected,
    OnDisconnected? onDisconnected,
  }) {
    final action = switch (message) {
      ReceiveMessageConnected(:final addr) => () {
        _send(
          SendMessage.join(bytes: rust_api.stateVector(id: id)),
        );
        onConnected?.call(addr);
      },
      ReceiveMessageDisconnected(:final addr) => () {
        onDisconnected?.call(addr);
      },
      ReceiveMessageUpdate(:final bytes) => () => rust_api.merge(
        id: id,
        update: bytes,
      ),
      ReceiveMessageSelection(:final offset, :final length, :final addr) =>
        () => onSelection?.call(
          (offset: offset, length: length, addr: addr),
        ),
      ReceiveMessageUnselect(:final addr) => () {
        onUnselected?.call(addr);
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

  void handle(
    String id,
    Partial partial, {
    void Function(SimpleDelta delta)? onDelta,
    void Function(String text)? onText,
  }) {
    final action = switch (partial) {
      Partial_Delta(:final field0) => () => onDelta?.call(field0),
      Partial_Text(:final field0) => () => onText?.call(field0),
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
    };
    action();
  }
}
