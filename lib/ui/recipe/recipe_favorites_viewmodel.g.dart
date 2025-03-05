// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_favorites_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeFavoritesViewmodelHash() =>
    r'dfeab4e21983945684acfa607bf4faeea7aebc06';

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

abstract class _$RecipeFavoritesViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<bool?> {
  late final RecipeModel? recipe;

  FutureOr<bool?> build(
    RecipeModel? recipe,
  );
}

/// See also [RecipeFavoritesViewmodel].
@ProviderFor(RecipeFavoritesViewmodel)
const recipeFavoritesViewmodelProvider = RecipeFavoritesViewmodelFamily();

/// See also [RecipeFavoritesViewmodel].
class RecipeFavoritesViewmodelFamily extends Family<AsyncValue<bool?>> {
  /// See also [RecipeFavoritesViewmodel].
  const RecipeFavoritesViewmodelFamily();

  /// See also [RecipeFavoritesViewmodel].
  RecipeFavoritesViewmodelProvider call(
    RecipeModel? recipe,
  ) {
    return RecipeFavoritesViewmodelProvider(
      recipe,
    );
  }

  @override
  RecipeFavoritesViewmodelProvider getProviderOverride(
    covariant RecipeFavoritesViewmodelProvider provider,
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
  String? get name => r'recipeFavoritesViewmodelProvider';
}

/// See also [RecipeFavoritesViewmodel].
class RecipeFavoritesViewmodelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeFavoritesViewmodel,
        bool?> {
  /// See also [RecipeFavoritesViewmodel].
  RecipeFavoritesViewmodelProvider(
    RecipeModel? recipe,
  ) : this._internal(
          () => RecipeFavoritesViewmodel()..recipe = recipe,
          from: recipeFavoritesViewmodelProvider,
          name: r'recipeFavoritesViewmodelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeFavoritesViewmodelHash,
          dependencies: RecipeFavoritesViewmodelFamily._dependencies,
          allTransitiveDependencies:
              RecipeFavoritesViewmodelFamily._allTransitiveDependencies,
          recipe: recipe,
        );

  RecipeFavoritesViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipe,
  }) : super.internal();

  final RecipeModel? recipe;

  @override
  FutureOr<bool?> runNotifierBuild(
    covariant RecipeFavoritesViewmodel notifier,
  ) {
    return notifier.build(
      recipe,
    );
  }

  @override
  Override overrideWith(RecipeFavoritesViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeFavoritesViewmodelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<RecipeFavoritesViewmodel, bool?>
      createElement() {
    return _RecipeFavoritesViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeFavoritesViewmodelProvider && other.recipe == recipe;
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
mixin RecipeFavoritesViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<bool?> {
  /// The parameter `recipe` of this provider.
  RecipeModel? get recipe;
}

class _RecipeFavoritesViewmodelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeFavoritesViewmodel,
        bool?> with RecipeFavoritesViewmodelRef {
  _RecipeFavoritesViewmodelProviderElement(super.provider);

  @override
  RecipeModel? get recipe =>
      (origin as RecipeFavoritesViewmodelProvider).recipe;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
