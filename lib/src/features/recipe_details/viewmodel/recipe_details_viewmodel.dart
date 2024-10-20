import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:fort_asia_recipe_app/src/repositories/recipe_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_details_viewmodel.g.dart';

@riverpod
class RecipeDetailsViewmodel extends _$RecipeDetailsViewmodel {
  @override
  Future<RecipeModel> build({required int recipeID}) async {
    state = const AsyncLoading();

    final result = await ref
        .read(recipeRepositoryProvider)
        .getRecipeDetails(recipeID: recipeID);

    return result.fold(
      (error) => throw Exception(error),
      (data) {
        return data;
      },
    );
  }
}
