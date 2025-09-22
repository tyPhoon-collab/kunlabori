// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(socket)
const socketProvider = SocketProvider._();

final class SocketProvider
    extends $FunctionalProvider<WebSocket, WebSocket, WebSocket>
    with $Provider<WebSocket> {
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
  $ProviderElement<WebSocket> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocket create(Ref ref) {
    return socket(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocket value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocket>(value),
    );
  }
}

String _$socketHash() => r'b81d745aae57ec73a21dd8a62a0bbd2867d7aff4';
