// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeDetailsViewmodelHash() =>
    r'32cd912a63d864153e60ff8a511bb965f5890c2b';

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

abstract class _$RecipeDetailsViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<RecipeModel> {
  late final int recipeID;

  FutureOr<RecipeModel> build({
    required int recipeID,
  });
}

/// See also [RecipeDetailsViewmodel].
@ProviderFor(RecipeDetailsViewmodel)
const recipeDetailsViewmodelProvider = RecipeDetailsViewmodelFamily();

/// See also [RecipeDetailsViewmodel].
class RecipeDetailsViewmodelFamily extends Family<AsyncValue<RecipeModel>> {
  /// See also [RecipeDetailsViewmodel].
  const RecipeDetailsViewmodelFamily();

  /// See also [RecipeDetailsViewmodel].
  RecipeDetailsViewmodelProvider call({
    required int recipeID,
  }) {
    return RecipeDetailsViewmodelProvider(
      recipeID: recipeID,
    );
  }

  @override
  RecipeDetailsViewmodelProvider getProviderOverride(
    covariant RecipeDetailsViewmodelProvider provider,
  ) {
    return call(
      recipeID: provider.recipeID,
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
  String? get name => r'recipeDetailsViewmodelProvider';
}

/// See also [RecipeDetailsViewmodel].
class RecipeDetailsViewmodelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeDetailsViewmodel,
        RecipeModel> {
  /// See also [RecipeDetailsViewmodel].
  RecipeDetailsViewmodelProvider({
    required int recipeID,
  }) : this._internal(
          () => RecipeDetailsViewmodel()..recipeID = recipeID,
          from: recipeDetailsViewmodelProvider,
          name: r'recipeDetailsViewmodelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeDetailsViewmodelHash,
          dependencies: RecipeDetailsViewmodelFamily._dependencies,
          allTransitiveDependencies:
              RecipeDetailsViewmodelFamily._allTransitiveDependencies,
          recipeID: recipeID,
        );

  RecipeDetailsViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeID,
  }) : super.internal();

  final int recipeID;

  @override
  FutureOr<RecipeModel> runNotifierBuild(
    covariant RecipeDetailsViewmodel notifier,
  ) {
    return notifier.build(
      recipeID: recipeID,
    );
  }

  @override
  Override overrideWith(RecipeDetailsViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDetailsViewmodelProvider._internal(
        () => create()..recipeID = recipeID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeID: recipeID,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecipeDetailsViewmodel, RecipeModel>
      createElement() {
    return _RecipeDetailsViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailsViewmodelProvider &&
        other.recipeID == recipeID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecipeDetailsViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<RecipeModel> {
  /// The parameter `recipeID` of this provider.
  int get recipeID;
}

class _RecipeDetailsViewmodelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeDetailsViewmodel,
        RecipeModel> with RecipeDetailsViewmodelRef {
  _RecipeDetailsViewmodelProviderElement(super.provider);

  @override
  int get recipeID => (origin as RecipeDetailsViewmodelProvider).recipeID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
