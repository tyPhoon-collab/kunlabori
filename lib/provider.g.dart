// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SocketUrl)
const socketUrlProvider = SocketUrlProvider._();

final class SocketUrlProvider extends $NotifierProvider<SocketUrl, String> {
  const SocketUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socketUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socketUrlHash();

  @$internal
  @override
  SocketUrl create() => SocketUrl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$socketUrlHash() => r'14d4b8ac770e8caeb28ce3eae09cc773af992174';

abstract class _$SocketUrl extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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

String _$socketHash() => r'0ad852803903e2044e42a890abd1b30d19f46c72';

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
    extends
        $FunctionalProvider<
          AsyncValue<ReceiveMessage>,
          ReceiveMessage,
          Stream<ReceiveMessage>
        >
    with $FutureModifier<ReceiveMessage>, $StreamProvider<ReceiveMessage> {
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
  $StreamProviderElement<ReceiveMessage> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ReceiveMessage> create(Ref ref) {
    return messages(ref);
  }
}

String _$messagesHash() => r'f492123b77c3b12ae4c126f1dd22c7860fdc2a75';

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
          void Function(SendMessage),
          void Function(SendMessage),
          void Function(SendMessage)
        >
    with $Provider<void Function(SendMessage)> {
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
  $ProviderElement<void Function(SendMessage)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(SendMessage) create(Ref ref) {
    return _send(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(SendMessage) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function(SendMessage)>(value),
    );
  }
}

String _$_sendHash() => r'80e71107a83786b34d827006d98578ff200c06a8';
