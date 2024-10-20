import 'package:fort_asia_recipe_app/src/model/recipe_type_model.dart';
import 'package:fort_asia_recipe_app/src/repositories/recipe_type_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_types_viewmodel.g.dart';

@riverpod
class RecipeTypeViewmodel extends _$RecipeTypeViewmodel {
  @override
  Future<List<RecipeTypeModel>> build() async {
    state = const AsyncLoading();

    final result =
        await ref.read(recipeTypeRepositoryProvider).getAllRecipeTypes();

    return result.fold(
      (error) => throw Exception(error),
      (data) => data,
    );
  }
}
