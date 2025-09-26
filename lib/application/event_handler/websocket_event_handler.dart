import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

final class WebsocketEventHandler {
  const WebsocketEventHandler({
    required Send send,
    required Sink sink,
  }) : _send = send,
       _sink = sink;

  final Send _send;
  final Sink _sink;

  void handle(String id, ReceiveMessage message) {
    final action = switch (message) {
      ReceiveMessageConnected(:final addr) => () {
        _send(
          SendMessage.join(bytes: rust_api.stateVector(id: id)),
        );
        _sink(ClientEvent.connected(addr: addr));
      },
      ReceiveMessageDisconnected(:final addr) => () {
        _sink(ClientEvent.disconnected(addr: addr));
      },
      ReceiveMessageUpdate(:final bytes) => () => rust_api.merge(
        id: id,
        update: bytes,
      ),
      ReceiveMessageSelection(:final start, :final end, :final addr) =>
        () => _sink(
          ClientEvent.selected(
            selection: Selection(start: start, end: end),
            addr: addr,
          ),
        ),
      ReceiveMessageUnselect(:final addr) => () {
        _sink(ClientEvent.unselected(addr: addr));
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
