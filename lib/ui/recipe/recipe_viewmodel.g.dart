// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeViewmodelHash() => r'9b75037c37b3d753dce5d913d4332443dcd507bf';

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

abstract class _$RecipeViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<RecipeModel> {
  late final int recipeListIndex;

  FutureOr<RecipeModel> build(
    int recipeListIndex,
  );
}

/// See also [RecipeViewmodel].
@ProviderFor(RecipeViewmodel)
const recipeViewmodelProvider = RecipeViewmodelFamily();

/// See also [RecipeViewmodel].
class RecipeViewmodelFamily extends Family<AsyncValue<RecipeModel>> {
  /// See also [RecipeViewmodel].
  const RecipeViewmodelFamily();

  /// See also [RecipeViewmodel].
  RecipeViewmodelProvider call(
    int recipeListIndex,
  ) {
    return RecipeViewmodelProvider(
      recipeListIndex,
    );
  }

  @override
  RecipeViewmodelProvider getProviderOverride(
    covariant RecipeViewmodelProvider provider,
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
  String? get name => r'recipeViewmodelProvider';
}

/// See also [RecipeViewmodel].
class RecipeViewmodelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeViewmodel, RecipeModel> {
  /// See also [RecipeViewmodel].
  RecipeViewmodelProvider(
    int recipeListIndex,
  ) : this._internal(
          () => RecipeViewmodel()..recipeListIndex = recipeListIndex,
          from: recipeViewmodelProvider,
          name: r'recipeViewmodelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeViewmodelHash,
          dependencies: RecipeViewmodelFamily._dependencies,
          allTransitiveDependencies:
              RecipeViewmodelFamily._allTransitiveDependencies,
          recipeListIndex: recipeListIndex,
        );

  RecipeViewmodelProvider._internal(
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
  FutureOr<RecipeModel> runNotifierBuild(
    covariant RecipeViewmodel notifier,
  ) {
    return notifier.build(
      recipeListIndex,
    );
  }

  @override
  Override overrideWith(RecipeViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeViewmodelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<RecipeViewmodel, RecipeModel>
      createElement() {
    return _RecipeViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeViewmodelProvider &&
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
mixin RecipeViewmodelRef on AutoDisposeAsyncNotifierProviderRef<RecipeModel> {
  /// The parameter `recipeListIndex` of this provider.
  int get recipeListIndex;
}

class _RecipeViewmodelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeViewmodel,
        RecipeModel> with RecipeViewmodelRef {
  _RecipeViewmodelProviderElement(super.provider);

  @override
  int get recipeListIndex =>
      (origin as RecipeViewmodelProvider).recipeListIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
