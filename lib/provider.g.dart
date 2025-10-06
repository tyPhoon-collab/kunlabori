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

String _$socketUrlHash() => r'd1166380e3dd8dc9bafdeec112fd6a35b92c4afa';

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

@ProviderFor(SelectedFont)
const selectedFontProvider = SelectedFontProvider._();

final class SelectedFontProvider
    extends $NotifierProvider<SelectedFont, String> {
  const SelectedFontProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFontProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFontHash();

  @$internal
  @override
  SelectedFont create() => SelectedFont();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$selectedFontHash() => r'd7b3462b6a2ad18df2be60feb1ab8a8d3616bec0';

abstract class _$SelectedFont extends $Notifier<String> {
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
    r'da282ece055fbb2aba739c7189010c0e24645248';

@ProviderFor(partialEventHandler)
const partialEventHandlerProvider = PartialEventHandlerFamily._();

final class PartialEventHandlerProvider
    extends
        $FunctionalProvider<
          PartialEventHandler,
          PartialEventHandler,
          PartialEventHandler
        >
    with $Provider<PartialEventHandler> {
  const PartialEventHandlerProvider._({
    required PartialEventHandlerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'partialEventHandlerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$partialEventHandlerHash();

  @override
  String toString() {
    return r'partialEventHandlerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<PartialEventHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PartialEventHandler create(Ref ref) {
    final argument = this.argument as String;
    return partialEventHandler(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PartialEventHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PartialEventHandler>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PartialEventHandlerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$partialEventHandlerHash() =>
    r'a5c9aa519194fffbf17c5e68503f9246ec956956';

final class PartialEventHandlerFamily extends $Family
    with $FunctionalFamilyOverride<PartialEventHandler, String> {
  const PartialEventHandlerFamily._()
    : super(
        retry: null,
        name: r'partialEventHandlerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PartialEventHandlerProvider call(String id) =>
      PartialEventHandlerProvider._(argument: id, from: this);

  @override
  String toString() => r'partialEventHandlerProvider';
}

@ProviderFor(documentController)
const documentControllerProvider = DocumentControllerFamily._();

final class DocumentControllerProvider
    extends
        $FunctionalProvider<
          DocumentController,
          DocumentController,
          DocumentController
        >
    with $Provider<DocumentController> {
  const DocumentControllerProvider._({
    required DocumentControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'documentControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentControllerHash();

  @override
  String toString() {
    return r'documentControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DocumentController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DocumentController create(Ref ref) {
    final argument = this.argument as String;
    return documentController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentController>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentControllerHash() =>
    r'c9c05e08205f8651870fb082225ecaf1fce5dfb6';

final class DocumentControllerFamily extends $Family
    with $FunctionalFamilyOverride<DocumentController, String> {
  const DocumentControllerFamily._()
    : super(
        retry: null,
        name: r'documentControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DocumentControllerProvider call(String id) =>
      DocumentControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'documentControllerProvider';
}

@ProviderFor(selectionController)
const selectionControllerProvider = SelectionControllerFamily._();

final class SelectionControllerProvider
    extends
        $FunctionalProvider<
          Raw<SelectionController>,
          Raw<SelectionController>,
          Raw<SelectionController>
        >
    with $Provider<Raw<SelectionController>> {
  const SelectionControllerProvider._({
    required SelectionControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectionControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectionControllerHash();

  @override
  String toString() {
    return r'selectionControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Raw<SelectionController>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Raw<SelectionController> create(Ref ref) {
    final argument = this.argument as String;
    return selectionController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<SelectionController> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<SelectionController>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectionControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectionControllerHash() =>
    r'b9438c2a6edc0a54826ab7636e9ca35a5a876aaa';

final class SelectionControllerFamily extends $Family
    with $FunctionalFamilyOverride<Raw<SelectionController>, String> {
  const SelectionControllerFamily._()
    : super(
        retry: null,
        name: r'selectionControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SelectionControllerProvider call(String id) =>
      SelectionControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'selectionControllerProvider';
}

@ProviderFor(Event)
const eventProvider = EventProvider._();

final class EventProvider extends $NotifierProvider<Event, ClientEvent> {
  const EventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventHash();

  @$internal
  @override
  Event create() => Event();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientEvent value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientEvent>(value),
    );
  }
}

String _$eventHash() => r'2dfe02d19e2c1781f0f9c877c34fbd9f7a2c9626';

abstract class _$Event extends $Notifier<ClientEvent> {
  ClientEvent build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ClientEvent, ClientEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientEvent, ClientEvent>,
              ClientEvent,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_send)
const _sendProvider = _SendProvider._();

final class _SendProvider extends $FunctionalProvider<Send, Send, Send>
    with $Provider<Send> {
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
  $ProviderElement<Send> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Send create(Ref ref) {
    return _send(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Send value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Send>(value),
    );
  }
}

String _$_sendHash() => r'fefba1300d67bdceb60931750ded869ed755e65f';

@ProviderFor(_sink)
const _sinkProvider = _SinkProvider._();

final class _SinkProvider extends $FunctionalProvider<Sink, Sink, Sink>
    with $Provider<Sink> {
  const _SinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_sinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_sinkHash();

  @$internal
  @override
  $ProviderElement<Sink> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Sink create(Ref ref) {
    return _sink(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Sink value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Sink>(value),
    );
  }
}

String _$_sinkHash() => r'6118cfce8d6d127289c358223a2da275c29ef29e';
