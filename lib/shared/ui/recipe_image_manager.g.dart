// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_image_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeImageManagerHash() =>
    r'cb7bb192c3d0833e8874cb368f626afde18c2c07';

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

abstract class _$RecipeImageManager
    extends BuildlessAutoDisposeAsyncNotifier<bool?> {
  late final Recipe? recipe;

  FutureOr<bool?> build(
    Recipe? recipe,
  );
}

/// See also [RecipeImageManager].
@ProviderFor(RecipeImageManager)
const recipeImageManagerProvider = RecipeImageManagerFamily();

/// See also [RecipeImageManager].
class RecipeImageManagerFamily extends Family<AsyncValue<bool?>> {
  /// See also [RecipeImageManager].
  const RecipeImageManagerFamily();

  /// See also [RecipeImageManager].
  RecipeImageManagerProvider call(
    Recipe? recipe,
  ) {
    return RecipeImageManagerProvider(
      recipe,
    );
  }

  @override
  RecipeImageManagerProvider getProviderOverride(
    covariant RecipeImageManagerProvider provider,
  ) {
    return call(
      provider.recipe,
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
  String? get name => r'recipeImageManagerProvider';
}

/// See also [RecipeImageManager].
class RecipeImageManagerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeImageManager, bool?> {
  /// See also [RecipeImageManager].
  RecipeImageManagerProvider(
    Recipe? recipe,
  ) : this._internal(
          () => RecipeImageManager()..recipe = recipe,
          from: recipeImageManagerProvider,
          name: r'recipeImageManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeImageManagerHash,
          dependencies: RecipeImageManagerFamily._dependencies,
          allTransitiveDependencies:
              RecipeImageManagerFamily._allTransitiveDependencies,
          recipe: recipe,
        );

  RecipeImageManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipe,
  }) : super.internal();

  final Recipe? recipe;

  @override
  FutureOr<bool?> runNotifierBuild(
    covariant RecipeImageManager notifier,
  ) {
    return notifier.build(
      recipe,
    );
  }

  @override
  Override overrideWith(RecipeImageManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeImageManagerProvider._internal(
        () => create()..recipe = recipe,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipe: recipe,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecipeImageManager, bool?>
      createElement() {
    return _RecipeImageManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeImageManagerProvider && other.recipe == recipe;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipe.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeImageManagerRef on AutoDisposeAsyncNotifierProviderRef<bool?> {
  /// The parameter `recipe` of this provider.
  Recipe? get recipe;
}

class _RecipeImageManagerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeImageManager, bool?>
    with RecipeImageManagerRef {
  _RecipeImageManagerProviderElement(super.provider);

  @override
  Recipe? get recipe => (origin as RecipeImageManagerProvider).recipe;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
