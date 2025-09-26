// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_CollaboratorIndexes)
const _collaboratorIndexesProvider = _CollaboratorIndexesProvider._();

final class _CollaboratorIndexesProvider
    extends $NotifierProvider<_CollaboratorIndexes, Map<String, Selection>> {
  const _CollaboratorIndexesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_collaboratorIndexesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_collaboratorIndexesHash();

  @$internal
  @override
  _CollaboratorIndexes create() => _CollaboratorIndexes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Selection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Selection>>(value),
    );
  }
}

String _$_collaboratorIndexesHash() =>
    r'7d8d0e5ffb8d7512ab55d307062c38fe27bd1e8b';

abstract class _$CollaboratorIndexes extends $Notifier<Map<String, Selection>> {
  Map<String, Selection> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<Map<String, Selection>, Map<String, Selection>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, Selection>, Map<String, Selection>>,
              Map<String, Selection>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
