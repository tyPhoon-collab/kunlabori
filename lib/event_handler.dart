import 'package:flutter/material.dart';
import 'package:kunlabori/message.dart';
import 'package:kunlabori/src/rust/api/interface.dart';
import 'package:kunlabori/src/rust/api/model.dart';

final class WebsocketEventHandler {
  const WebsocketEventHandler(this._send);

  final void Function(Message message) _send;

  void handle(String id, Message message) {
    final action = switch (message) {
      MessageConnected(:final addr) => () {
        debugPrint('Connected to $addr');
        _send(
          Message.join(bytes: stateVector(id: id)),
        );
      },
      MessageUpdate(:final bytes) => () => merge(
        id: id,
        update: bytes,
      ),
      MessageRead(:final bytes, :final from) => () => _send(
        Message.init(
          bytes: diff(id: id, since: bytes),
          to: from,
        ),
      ),
      MessageInit(:final bytes) => () => merge(
        id: id,
        update: bytes,
      ),
      _ => () {},
    };
    action();
  }
}

final class PartialEventHandler {
  const PartialEventHandler(this._send);

  final void Function(Message message) _send;

  void handle(
    String id,
    Partial partial, {
    required void Function(String text) onText,
  }) {
    final action = switch (partial) {
      Partial_Delta() => () {},
      Partial_Update(:final field0) => () => _send(
        Message.update(bytes: field0),
      ),
      Partial_Text(:final field0) => () => onText(field0),
    };
    action();
  }
}
