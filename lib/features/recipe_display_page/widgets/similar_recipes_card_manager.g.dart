// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_recipes_card_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$similarRecipesCardManagerHash() =>
    r'8722728175a648f9df5eb77b41864d4de23530a6';

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

abstract class _$SimilarRecipesCardManager
    extends BuildlessAutoDisposeNotifier<AsyncValue<List<SimilarRecipe>?>> {
  late final dynamic database;
  late final Recipe recipe;

  AsyncValue<List<SimilarRecipe>?> build(
    dynamic database,
    Recipe recipe,
  );
}

/// See also [SimilarRecipesCardManager].
@ProviderFor(SimilarRecipesCardManager)
const similarRecipesCardManagerProvider = SimilarRecipesCardManagerFamily();

/// See also [SimilarRecipesCardManager].
class SimilarRecipesCardManagerFamily
    extends Family<AsyncValue<List<SimilarRecipe>?>> {
  /// See also [SimilarRecipesCardManager].
  const SimilarRecipesCardManagerFamily();

  /// See also [SimilarRecipesCardManager].
  SimilarRecipesCardManagerProvider call(
    dynamic database,
    Recipe recipe,
  ) {
    return SimilarRecipesCardManagerProvider(
      database,
      recipe,
    );
  }

  @override
  SimilarRecipesCardManagerProvider getProviderOverride(
    covariant SimilarRecipesCardManagerProvider provider,
  ) {
    return call(
      provider.database,
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
  String? get name => r'similarRecipesCardManagerProvider';
}

/// See also [SimilarRecipesCardManager].
class SimilarRecipesCardManagerProvider extends AutoDisposeNotifierProviderImpl<
    SimilarRecipesCardManager, AsyncValue<List<SimilarRecipe>?>> {
  /// See also [SimilarRecipesCardManager].
  SimilarRecipesCardManagerProvider(
    dynamic database,
    Recipe recipe,
  ) : this._internal(
          () => SimilarRecipesCardManager()
            ..database = database
            ..recipe = recipe,
          from: similarRecipesCardManagerProvider,
          name: r'similarRecipesCardManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$similarRecipesCardManagerHash,
          dependencies: SimilarRecipesCardManagerFamily._dependencies,
          allTransitiveDependencies:
              SimilarRecipesCardManagerFamily._allTransitiveDependencies,
          database: database,
          recipe: recipe,
        );

  SimilarRecipesCardManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.database,
    required this.recipe,
  }) : super.internal();

  final dynamic database;
  final Recipe recipe;

  @override
  AsyncValue<List<SimilarRecipe>?> runNotifierBuild(
    covariant SimilarRecipesCardManager notifier,
  ) {
    return notifier.build(
      database,
      recipe,
    );
  }

  @override
  Override overrideWith(SimilarRecipesCardManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: SimilarRecipesCardManagerProvider._internal(
        () => create()
          ..database = database
          ..recipe = recipe,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        database: database,
        recipe: recipe,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SimilarRecipesCardManager,
      AsyncValue<List<SimilarRecipe>?>> createElement() {
    return _SimilarRecipesCardManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarRecipesCardManagerProvider &&
        other.database == database &&
        other.recipe == recipe;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, database.hashCode);
    hash = _SystemHash.combine(hash, recipe.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SimilarRecipesCardManagerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<List<SimilarRecipe>?>> {
  /// The parameter `database` of this provider.
  dynamic get database;

  /// The parameter `recipe` of this provider.
  Recipe get recipe;
}

class _SimilarRecipesCardManagerProviderElement
    extends AutoDisposeNotifierProviderElement<SimilarRecipesCardManager,
        AsyncValue<List<SimilarRecipe>?>> with SimilarRecipesCardManagerRef {
  _SimilarRecipesCardManagerProviderElement(super.provider);

  @override
  dynamic get database =>
      (origin as SimilarRecipesCardManagerProvider).database;
  @override
  Recipe get recipe => (origin as SimilarRecipesCardManagerProvider).recipe;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
