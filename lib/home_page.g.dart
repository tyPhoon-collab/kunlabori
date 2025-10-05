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
    r'2ebe98dfebc6279aaef7de502e40c96b8844b315';

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

@ProviderFor(_IsActionViewActive)
const _isActionViewActiveProvider = _IsActionViewActiveProvider._();

final class _IsActionViewActiveProvider
    extends $NotifierProvider<_IsActionViewActive, bool> {
  const _IsActionViewActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_isActionViewActiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_isActionViewActiveHash();

  @$internal
  @override
  _IsActionViewActive create() => _IsActionViewActive();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$_isActionViewActiveHash() =>
    r'523101802e82fd99411f3be615a3f0829f2cd914';

abstract class _$IsActionViewActive extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FontSize)
const fontSizeProvider = FontSizeProvider._();

final class FontSizeProvider extends $NotifierProvider<FontSize, double> {
  const FontSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fontSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fontSizeHash();

  @$internal
  @override
  FontSize create() => FontSize();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$fontSizeHash() => r'8fa8191fa568fecc3c4b8fabb53c5b687c5d52c2';

abstract class _$FontSize extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
