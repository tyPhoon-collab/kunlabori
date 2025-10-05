import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kunlabori/application/controller/document_controller.dart';
import 'package:kunlabori/application/controller/selection_controller.dart';
import 'package:kunlabori/application/event_handler/partial_event_handler.dart';
import 'package:kunlabori/application/event_handler/websocket_event_handler.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class SocketUrl extends _$SocketUrl {
  @override
  String build() => kReleaseMode
      ? 'https://neighbouring-kass-typhoon-07a541cd.koyeb.app/'
      : 'ws://localhost:8080';

  //
  // ignore: use_setters_to_change_properties
  void setUrl(String value) => state = value;
}

@Riverpod(keepAlive: true)
class SelectedFont extends _$SelectedFont {
  @override
  String build() => 'MPLUSRounded1c';

  //
  // ignore: use_setters_to_change_properties
  void setFont(String fontFamily) => state = fontFamily;
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
  return WebsocketEventHandler(
    send: ref.watch(_sendProvider),
    sink: ref.watch(_sinkProvider),
  );
}

@Riverpod(keepAlive: true)
PartialEventHandler partialEventHandler(Ref ref, String id) {
  return PartialEventHandler(
    id: id,
    send: ref.watch(_sendProvider),
    sink: ref.watch(_sinkProvider),
    selectionController: ref.watch(selectionControllerProvider(id)),
  );
}

@Riverpod(keepAlive: true)
DocumentController documentController(Ref ref, String id) {
  return DocumentController(ref, id: id);
}

@Riverpod(keepAlive: true)
Raw<SelectionController> selectionController(Ref ref, String id) {
  return SelectionController(
    id: id,
    send: ref.watch(_sendProvider),
  );
}

@Riverpod(keepAlive: true)
class Event extends _$Event {
  @override
  ClientEvent build() => const ClientEventInit();

  //
  // ignore: use_setters_to_change_properties
  void add(ClientEvent event) => state = event;
}

typedef Send = void Function(SendMessage message);
typedef Sink = void Function(ClientEvent event);

@Riverpod(keepAlive: true)
Send _send(Ref ref) {
  void send(SendMessage message) {
    ref.read(socketProvider.notifier).sendMessage(message);
  }

  return send;
}

@Riverpod(keepAlive: true)
Sink _sink(Ref ref) {
  void sink(ClientEvent event) {
    ref.read(eventProvider.notifier).add(event);
  }

  return sink;
}
