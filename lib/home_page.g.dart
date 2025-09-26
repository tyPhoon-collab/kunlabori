// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollaboratorIndexes)
const collaboratorIndexesProvider = CollaboratorIndexesProvider._();

final class CollaboratorIndexesProvider
    extends $NotifierProvider<CollaboratorIndexes, Map<String, Selection>> {
  const CollaboratorIndexesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collaboratorIndexesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collaboratorIndexesHash();

  @$internal
  @override
  CollaboratorIndexes create() => CollaboratorIndexes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Selection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Selection>>(value),
    );
  }
}

String _$collaboratorIndexesHash() =>
    r'3d19ed6fb1f25cbb5772528f19a20214361d3483';

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
