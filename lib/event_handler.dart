import 'package:kunlabori/message.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

typedef Send = void Function(SendMessage message);
typedef RemoteSelection = ({int start, int end, String addr});
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
      ReceiveMessageSelection(:final start, :final end, :final addr) =>
        () => onSelection?.call((start: start, end: end, addr: addr)),
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

final class Selection {
  const Selection({
    required this.start,
    required this.end,
  });

  const Selection.same(int index) : start = index, end = index;

  final int start;
  final int end;
}

final class PartialEventHandler {
  PartialEventHandler(this._send);

  final Send _send;
  Selection? _selection;

  int? get start => _selection?.start;
  int? get end => _selection?.end;
  int? get length =>
      (_selection != null) ? _selection!.end - _selection!.start : null;

  void setSelection(String id, Selection selection) {
    _selection = selection;
    rust_api.setSelection(id: id, start: selection.start, end: selection.end);
    _send(SendMessage.selection(start: selection.start, end: selection.end));
  }

  void handle(
    String id,
    Partial partial, {
    void Function(SimpleDelta delta)? onDelta,
    void Function(String text)? onText,
    void Function(Selection selection)? onSelection,
  }) {
    final action = switch (partial) {
      Partial_Delta(:final field0) => () => onDelta?.call(field0),
      Partial_Text(:final field0) => () => onText?.call(field0),
      Partial_Update(:final field0) => () {
        _send(SendMessage.update(bytes: field0));
        final stickySelection = rust_api.selection(id: id);
        final start = stickySelection?.$1;
        final end = stickySelection?.$2;

        if (_selection case final selection?
            when selection.start != start || selection.end != end) {
          if (stickySelection == null) {
            _selection = null;
            _send(const SendMessage.unselect());
          } else {
            _send(
              SendMessage.selection(
                start: start!,
                end: end!,
              ),
            );
            onSelection?.call(Selection(start: start, end: end));
          }
        }
      },
    };
    action();
  }
}
