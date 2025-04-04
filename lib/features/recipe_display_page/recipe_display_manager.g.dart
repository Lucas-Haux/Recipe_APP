// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_display_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeDisplayManagerHash() =>
    r'310f5ef91fc08aa506a9058d9486c3ab57b4e867';

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
  late final dynamic database;
  late final int id;

  FutureOr<Recipe> build(
    dynamic database,
    int id,
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
    dynamic database,
    int id,
  ) {
    return RecipeDisplayManagerProvider(
      database,
      id,
    );
  }

  @override
  RecipeDisplayManagerProvider getProviderOverride(
    covariant RecipeDisplayManagerProvider provider,
  ) {
    return call(
      provider.database,
      provider.id,
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
    dynamic database,
    int id,
  ) : this._internal(
          () => RecipeDisplayManager()
            ..database = database
            ..id = id,
          from: recipeDisplayManagerProvider,
          name: r'recipeDisplayManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeDisplayManagerHash,
          dependencies: RecipeDisplayManagerFamily._dependencies,
          allTransitiveDependencies:
              RecipeDisplayManagerFamily._allTransitiveDependencies,
          database: database,
          id: id,
        );

  RecipeDisplayManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.database,
    required this.id,
  }) : super.internal();

  final dynamic database;
  final int id;

  @override
  FutureOr<Recipe> runNotifierBuild(
    covariant RecipeDisplayManager notifier,
  ) {
    return notifier.build(
      database,
      id,
    );
  }

  @override
  Override overrideWith(RecipeDisplayManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDisplayManagerProvider._internal(
        () => create()
          ..database = database
          ..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        database: database,
        id: id,
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
        other.database == database &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, database.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDisplayManagerRef on AutoDisposeAsyncNotifierProviderRef<Recipe> {
  /// The parameter `database` of this provider.
  dynamic get database;

  /// The parameter `id` of this provider.
  int get id;
}

class _RecipeDisplayManagerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeDisplayManager,
        Recipe> with RecipeDisplayManagerRef {
  _RecipeDisplayManagerProviderElement(super.provider);

  @override
  dynamic get database => (origin as RecipeDisplayManagerProvider).database;
  @override
  int get id => (origin as RecipeDisplayManagerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
