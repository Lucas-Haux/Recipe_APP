// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_display_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeDisplayManagerHash() =>
    r'b1cb967cb40a64e76e8839bbbb447ed5722b5972';

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
  late final int recipeListIndex;

  FutureOr<Recipe> build(
    int recipeListIndex,
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
    int recipeListIndex,
  ) {
    return RecipeDisplayManagerProvider(
      recipeListIndex,
    );
  }

  @override
  RecipeDisplayManagerProvider getProviderOverride(
    covariant RecipeDisplayManagerProvider provider,
  ) {
    return call(
      provider.recipeListIndex,
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
    int recipeListIndex,
  ) : this._internal(
          () => RecipeDisplayManager()..recipeListIndex = recipeListIndex,
          from: recipeDisplayManagerProvider,
          name: r'recipeDisplayManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeDisplayManagerHash,
          dependencies: RecipeDisplayManagerFamily._dependencies,
          allTransitiveDependencies:
              RecipeDisplayManagerFamily._allTransitiveDependencies,
          recipeListIndex: recipeListIndex,
        );

  RecipeDisplayManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeListIndex,
  }) : super.internal();

  final int recipeListIndex;

  @override
  FutureOr<Recipe> runNotifierBuild(
    covariant RecipeDisplayManager notifier,
  ) {
    return notifier.build(
      recipeListIndex,
    );
  }

  @override
  Override overrideWith(RecipeDisplayManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDisplayManagerProvider._internal(
        () => create()..recipeListIndex = recipeListIndex,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeListIndex: recipeListIndex,
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
        other.recipeListIndex == recipeListIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeListIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDisplayManagerRef on AutoDisposeAsyncNotifierProviderRef<Recipe> {
  /// The parameter `recipeListIndex` of this provider.
  int get recipeListIndex;
}

class _RecipeDisplayManagerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeDisplayManager,
        Recipe> with RecipeDisplayManagerRef {
  _RecipeDisplayManagerProviderElement(super.provider);

  @override
  int get recipeListIndex =>
      (origin as RecipeDisplayManagerProvider).recipeListIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
