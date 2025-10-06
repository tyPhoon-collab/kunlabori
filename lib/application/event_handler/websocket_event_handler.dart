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

  void handle(
    String id,
    ReceiveMessage message, {
    // for SendMessage.init
    required Map<String, Selection> Function() getSelections,
  }) {
    final action = switch (message) {
      ReceiveMessageWelcome(:final peerId) => () {
        // Welcomeメッセージを受け取ったらJoinメッセージを送る
        _send(
          SendMessage.join(bytes: rust_api.stateVector(id: id)),
        );
        _sink(ClientEvent.welcome(peerId: peerId));
      },
      ReceiveMessageConnected(:final peerId) => () {
        _sink(ClientEvent.connected(peerId: peerId));
      },
      ReceiveMessageDisconnected(:final peerId) => () {
        _sink(ClientEvent.disconnected(peerId: peerId));
      },
      ReceiveMessageUpdate(:final bytes) => () => rust_api.merge(
        id: id,
        update: bytes,
      ),
      ReceiveMessageSelection(:final start, :final end, :final peerId) =>
        () => _sink(
          ClientEvent.selected(
            selection: Selection(start: start, end: end),
            peerId: peerId,
          ),
        ),
      ReceiveMessageUnselect(:final peerId) => () {
        _sink(ClientEvent.unselected(peerId: peerId));
      },
      ReceiveMessageRead(:final bytes, :final from) => () {
        final selections = getSelections();
        _send(
          SendMessage.init(
            bytes: rust_api.diff(id: id, since: bytes),
            selections: selections,
            to: from,
          ),
        );
      },
      ReceiveMessageInit(:final bytes, :final selections) => () {
        rust_api.merge(
          id: id,
          update: bytes,
        );
        selections.forEach((peerId, selection) {
          _sink(
            ClientEvent.selected(
              selection: selection,
              peerId: peerId,
            ),
          );
        });
      },
    };
    action();
  }
}
