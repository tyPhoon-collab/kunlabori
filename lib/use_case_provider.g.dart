// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentUseCase)
const documentUseCaseProvider = DocumentUseCaseFamily._();

final class DocumentUseCaseProvider
    extends
        $FunctionalProvider<DocumentUseCase, DocumentUseCase, DocumentUseCase>
    with $Provider<DocumentUseCase> {
  const DocumentUseCaseProvider._({
    required DocumentUseCaseFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'documentUseCaseProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentUseCaseHash();

  @override
  String toString() {
    return r'documentUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DocumentUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentUseCase create(Ref ref) {
    final argument = this.argument as String;
    return documentUseCase(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentUseCase>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentUseCaseHash() => r'12285ad3370a8a931160b825d8f38ce6c6f61a7d';

final class DocumentUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<DocumentUseCase, String> {
  const DocumentUseCaseFamily._()
    : super(
        retry: null,
        name: r'documentUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DocumentUseCaseProvider call(String id) =>
      DocumentUseCaseProvider._(argument: id, from: this);

  @override
  String toString() => r'documentUseCaseProvider';
}
