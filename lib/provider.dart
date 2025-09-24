import 'dart:convert';

import 'package:kunlabori/event_handler.dart';
import 'package:kunlabori/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class Socket extends _$Socket {
  @override
  WebSocket build() {
    final uri = Uri.parse('ws://localhost:8080');
    return WebSocket(uri, timeout: const Duration(seconds: 5));
  }

  void sendMessage(Message message) {
    final jsonString = jsonEncode(message.toJson());
    state.send(jsonString);
  }
}

@Riverpod(keepAlive: true)
Stream<Message> messages(Ref ref) {
  final socket = ref.watch(socketProvider);
  return socket.messages
      .map((event) => jsonDecode(event as String))
      .map(
        (json) => Message.fromJson(json as Map<String, dynamic>),
      );
}

@Riverpod(keepAlive: true)
WebsocketEventHandler websocketEventHandler(Ref ref) {
  return WebsocketEventHandler(ref.watch(_sendProvider));
}

@Riverpod(keepAlive: true)
PartialEventHandler partialEventHandler(Ref ref) {
  return PartialEventHandler(ref.watch(_sendProvider));
}

@Riverpod(keepAlive: true)
void Function(Message) _send(Ref ref) {
  void send(Message message) {
    ref.read(socketProvider.notifier).sendMessage(message);
  }

  return send;
}
