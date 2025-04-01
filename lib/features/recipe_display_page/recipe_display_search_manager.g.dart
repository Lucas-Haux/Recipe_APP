// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_display_search_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeDisplayManagerHash() =>
    r'4613b31f8f2e044dc02679184807e8093f9c9278';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$RecipeDisplayManager
    extends BuildlessAutoDisposeAsyncNotifier<Recipe> {
  late final String route;
  late final int recipeId;

  FutureOr<Recipe> build(
    String route,
    int recipeId,
  );
}

/// See also [RecipeDisplayManager].
@ProviderFor(RecipeDisplayManager)
const recipeDisplayManagerProvider = RecipeDisplayManagerFamily();

/// See also [RecipeDisplayManager].
class RecipeDisplayManagerFamily extends Family<AsyncValue<Recipe>> {
  /// See also [RecipeDisplayManager].
  const RecipeDisplayManagerFamily();

  /// See also [RecipeDisplayManager].
  RecipeDisplayManagerProvider call(
    String route,
    int recipeId,
  ) {
    return RecipeDisplayManagerProvider(
      route,
      recipeId,
    );
  }

  @override
  RecipeDisplayManagerProvider getProviderOverride(
    covariant RecipeDisplayManagerProvider provider,
  ) {
    return call(
      provider.route,
      provider.recipeId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeDisplayManagerProvider';
}

/// See also [RecipeDisplayManager].
class RecipeDisplayManagerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeDisplayManager, Recipe> {
  /// See also [RecipeDisplayManager].
  RecipeDisplayManagerProvider(
    String route,
    int recipeId,
  ) : this._internal(
          () => RecipeDisplayManager()
            ..route = route
            ..recipeId = recipeId,
          from: recipeDisplayManagerProvider,
          name: r'recipeDisplayManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeDisplayManagerHash,
          dependencies: RecipeDisplayManagerFamily._dependencies,
          allTransitiveDependencies:
              RecipeDisplayManagerFamily._allTransitiveDependencies,
          route: route,
          recipeId: recipeId,
        );

  RecipeDisplayManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.route,
    required this.recipeId,
  }) : super.internal();

  final String route;
  final int recipeId;

  @override
  FutureOr<Recipe> runNotifierBuild(
    covariant RecipeDisplayManager notifier,
  ) {
    return notifier.build(
      route,
      recipeId,
    );
  }

  @override
  Override overrideWith(RecipeDisplayManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDisplayManagerProvider._internal(
        () => create()
          ..route = route
          ..recipeId = recipeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        route: route,
        recipeId: recipeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecipeDisplayManager, Recipe>
      createElement() {
    return _RecipeDisplayManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDisplayManagerProvider &&
        other.route == route &&
        other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, route.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDisplayManagerRef on AutoDisposeAsyncNotifierProviderRef<Recipe> {
  /// The parameter `route` of this provider.
  String get route;

  /// The parameter `recipeId` of this provider.
  int get recipeId;
}

class _RecipeDisplayManagerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeDisplayManager,
        Recipe> with RecipeDisplayManagerRef {
  _RecipeDisplayManagerProviderElement(super.provider);

  @override
  String get route => (origin as RecipeDisplayManagerProvider).route;
  @override
  int get recipeId => (origin as RecipeDisplayManagerProvider).recipeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
