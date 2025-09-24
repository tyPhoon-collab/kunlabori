// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Socket)
const socketProvider = SocketProvider._();

final class SocketProvider extends $NotifierProvider<Socket, WebSocket> {
  const SocketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socketProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socketHash();

  @$internal
  @override
  Socket create() => Socket();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocket value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocket>(value),
    );
  }
}

String _$socketHash() => r'24352537f61bbdec0028a47db23ba4edee1fc97a';

abstract class _$Socket extends $Notifier<WebSocket> {
  WebSocket build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSocket, WebSocket>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WebSocket, WebSocket>,
              WebSocket,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(messages)
const messagesProvider = MessagesProvider._();

final class MessagesProvider
    extends $FunctionalProvider<AsyncValue<Message>, Message, Stream<Message>>
    with $FutureModifier<Message>, $StreamProvider<Message> {
  const MessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messagesHash();

  @$internal
  @override
  $StreamProviderElement<Message> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Message> create(Ref ref) {
    return messages(ref);
  }
}

String _$messagesHash() => r'c56fb0bde9fd433e0f0eeed089e65423e329cee2';

@ProviderFor(websocketEventHandler)
const websocketEventHandlerProvider = WebsocketEventHandlerProvider._();

final class WebsocketEventHandlerProvider
    extends
        $FunctionalProvider<
          WebsocketEventHandler,
          WebsocketEventHandler,
          WebsocketEventHandler
        >
    with $Provider<WebsocketEventHandler> {
  const WebsocketEventHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketEventHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketEventHandlerHash();

  @$internal
  @override
  $ProviderElement<WebsocketEventHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebsocketEventHandler create(Ref ref) {
    return websocketEventHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebsocketEventHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebsocketEventHandler>(value),
    );
  }
}

String _$websocketEventHandlerHash() =>
    r'f1f15eb1edfa5f5b9cba6f99d85627485bc06111';

@ProviderFor(partialEventHandler)
const partialEventHandlerProvider = PartialEventHandlerProvider._();

final class PartialEventHandlerProvider
    extends
        $FunctionalProvider<
          PartialEventHandler,
          PartialEventHandler,
          PartialEventHandler
        >
    with $Provider<PartialEventHandler> {
  const PartialEventHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partialEventHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partialEventHandlerHash();

  @$internal
  @override
  $ProviderElement<PartialEventHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PartialEventHandler create(Ref ref) {
    return partialEventHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PartialEventHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PartialEventHandler>(value),
    );
  }
}

String _$partialEventHandlerHash() =>
    r'2060fe4843a9a341e63089dc2a3d6ed61478d449';

@ProviderFor(_send)
const _sendProvider = _SendProvider._();

final class _SendProvider
    extends
        $FunctionalProvider<
          void Function(Message),
          void Function(Message),
          void Function(Message)
        >
    with $Provider<void Function(Message)> {
  const _SendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_sendProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_sendHash();

  @$internal
  @override
  $ProviderElement<void Function(Message)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(Message) create(Ref ref) {
    return _send(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(Message) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function(Message)>(value),
    );
  }
}

String _$_sendHash() => r'0028c753c8f90fd6f9bc46850e4c55c36f9953e8';
