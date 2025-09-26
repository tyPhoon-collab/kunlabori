import 'dart:convert';

import 'package:kunlabori/event_handler.dart';
import 'package:kunlabori/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class SocketUrl extends _$SocketUrl {
  @override
  String build() => 'ws://localhost:8080';

  void setUrl(String value) => state = value;
}

@Riverpod(keepAlive: true)
class Socket extends _$Socket {
  @override
  WebSocket build() {
    final uri = Uri.parse(ref.watch(socketUrlProvider));
    final webSocket = WebSocket(uri, timeout: const Duration(seconds: 5));
    ref.onDispose(webSocket.close);
    return webSocket;
  }

  void sendMessage(SendMessage message) {
    final jsonString = jsonEncode(message.toJson());
    state.send(jsonString);
  }
}

@Riverpod(keepAlive: true)
Stream<ReceiveMessage> messages(Ref ref) {
  final socket = ref.watch(socketProvider);
  return socket.messages
      .map((event) => jsonDecode(event as String))
      .map(
        (json) => ReceiveMessage.fromJson(json as Map<String, dynamic>),
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
void Function(SendMessage) _send(Ref ref) {
  void send(SendMessage message) {
    ref.read(socketProvider.notifier).sendMessage(message);
  }

  return send;
}
