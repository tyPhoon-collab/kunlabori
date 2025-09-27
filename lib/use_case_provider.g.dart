// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentUseCase)
const documentUseCaseProvider = DocumentUseCaseProvider._();

final class DocumentUseCaseProvider
    extends
        $FunctionalProvider<DocumentUseCase, DocumentUseCase, DocumentUseCase>
    with $Provider<DocumentUseCase> {
  const DocumentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentUseCaseHash();

  @$internal
  @override
  $ProviderElement<DocumentUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentUseCase create(Ref ref) {
    return documentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentUseCase>(value),
    );
  }
}

String _$documentUseCaseHash() => r'033282b715acacfbb9671c86e6b96c8a123459a0';
