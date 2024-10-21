// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_recipe_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addNewRecipeViewmodelHash() =>
    r'99c472751bfeef5d2d49eeffc5bd4a8ff4e407ad';

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

abstract class _$AddNewRecipeViewmodel
    extends BuildlessAutoDisposeNotifier<RecipeModel?> {
  late final RecipeModel? recipe;

  RecipeModel? build({
    required RecipeModel? recipe,
  });
}

/// See also [AddNewRecipeViewmodel].
@ProviderFor(AddNewRecipeViewmodel)
const addNewRecipeViewmodelProvider = AddNewRecipeViewmodelFamily();

/// See also [AddNewRecipeViewmodel].
class AddNewRecipeViewmodelFamily extends Family<RecipeModel?> {
  /// See also [AddNewRecipeViewmodel].
  const AddNewRecipeViewmodelFamily();

  /// See also [AddNewRecipeViewmodel].
  AddNewRecipeViewmodelProvider call({
    required RecipeModel? recipe,
  }) {
    return AddNewRecipeViewmodelProvider(
      recipe: recipe,
    );
  }

  @override
  AddNewRecipeViewmodelProvider getProviderOverride(
    covariant AddNewRecipeViewmodelProvider provider,
  ) {
    return call(
      recipe: provider.recipe,
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
  String? get name => r'addNewRecipeViewmodelProvider';
}

/// See also [AddNewRecipeViewmodel].
class AddNewRecipeViewmodelProvider extends AutoDisposeNotifierProviderImpl<
    AddNewRecipeViewmodel, RecipeModel?> {
  /// See also [AddNewRecipeViewmodel].
  AddNewRecipeViewmodelProvider({
    required RecipeModel? recipe,
  }) : this._internal(
          () => AddNewRecipeViewmodel()..recipe = recipe,
          from: addNewRecipeViewmodelProvider,
          name: r'addNewRecipeViewmodelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addNewRecipeViewmodelHash,
          dependencies: AddNewRecipeViewmodelFamily._dependencies,
          allTransitiveDependencies:
              AddNewRecipeViewmodelFamily._allTransitiveDependencies,
          recipe: recipe,
        );

  AddNewRecipeViewmodelProvider._internal(
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
  RecipeModel? runNotifierBuild(
    covariant AddNewRecipeViewmodel notifier,
  ) {
    return notifier.build(
      recipe: recipe,
    );
  }

  @override
  Override overrideWith(AddNewRecipeViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AddNewRecipeViewmodelProvider._internal(
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
  AutoDisposeNotifierProviderElement<AddNewRecipeViewmodel, RecipeModel?>
      createElement() {
    return _AddNewRecipeViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddNewRecipeViewmodelProvider && other.recipe == recipe;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipe.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddNewRecipeViewmodelRef on AutoDisposeNotifierProviderRef<RecipeModel?> {
  /// The parameter `recipe` of this provider.
  RecipeModel? get recipe;
}

class _AddNewRecipeViewmodelProviderElement
    extends AutoDisposeNotifierProviderElement<AddNewRecipeViewmodel,
        RecipeModel?> with AddNewRecipeViewmodelRef {
  _AddNewRecipeViewmodelProviderElement(super.provider);

  @override
  RecipeModel? get recipe => (origin as AddNewRecipeViewmodelProvider).recipe;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
