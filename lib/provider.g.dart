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
