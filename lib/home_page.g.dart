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
    extends
        $NotifierProvider<_CollaboratorIndexes, Map<String, RemoteSelection>> {
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
  Override overrideWithValue(Map<String, RemoteSelection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, RemoteSelection>>(value),
    );
  }
}

String _$_collaboratorIndexesHash() =>
    r'695c4484be0b71ea348cd6b59b6bd250f61126ab';

abstract class _$CollaboratorIndexes
    extends $Notifier<Map<String, RemoteSelection>> {
  Map<String, RemoteSelection> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<Map<String, RemoteSelection>, Map<String, RemoteSelection>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, RemoteSelection>,
                Map<String, RemoteSelection>
              >,
              Map<String, RemoteSelection>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
