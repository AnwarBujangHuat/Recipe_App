import 'dart:math';

import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_new_recipe_viewmodel.g.dart';

@riverpod
class AddNewRecipeViewmodel extends _$AddNewRecipeViewmodel {
  @override
  RecipeModel? build({required RecipeModel? recipe}) {
    return recipe ??
        RecipeModel(
          id: Random().nextInt(100000), // default ID
          name: '',
          recipeTypeId: 1,
          description: '',
          thumbnail: '',
          ingredients: [],
          steps: [],
        );
  }

  void editTitle(String newTitle) {
    state = RecipeModel(
      id: state!.id,
      name: newTitle.isEmpty ? state!.name : newTitle,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: state!.ingredients,
      steps: state!.steps,
    );
  }

  void editDescription(String newDescription) {
    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: newDescription.isEmpty ? state!.description : newDescription,
      thumbnail: state!.thumbnail,
      ingredients: state!.ingredients,
      steps: state!.steps,
    );
  }

  void addNewIngredient({required IngredientModel ingredient}) {
    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: [...state!.ingredients, ingredient],
      steps: state!.steps,
    );
  }

  void editIngredient(int index, IngredientModel updatedIngredient) {
    final updatedIngredients = [...state!.ingredients];
    if (index >= 0 && index < updatedIngredients.length) {
      updatedIngredients[index] = updatedIngredient;
    }

    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: updatedIngredients,
      steps: state!.steps,
    );
  }

  void removeIngredient(int index) {
    final updatedIngredients = [...state!.ingredients];
    if (index >= 0 && index < updatedIngredients.length) {
      updatedIngredients.removeAt(index);
    }

    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: updatedIngredients,
      steps: state!.steps,
    );
  }

  void addNewStep({required String step}) {
    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: state!.ingredients,
      steps: [...state!.steps, step],
    );
  }

  void editStep(int index, String updatedStep) {
    final updatedSteps = [...state!.steps];
    if (index >= 0 && index < updatedSteps.length) {
      updatedSteps[index] = updatedStep;
    }

    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: state!.ingredients,
      steps: updatedSteps,
    );
  }

  void removeStep(int index) {
    final updatedSteps = [...state!.steps];
    if (index >= 0 && index < updatedSteps.length) {
      updatedSteps.removeAt(index);
    }

    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: state!.thumbnail,
      ingredients: state!.ingredients,
      steps: updatedSteps,
    );
  }

  void editThumbnail(String newThumbnailUrl) {
    state = RecipeModel(
      id: state!.id,
      name: state!.name,
      recipeTypeId: state!.recipeTypeId,
      description: state!.description,
      thumbnail: newThumbnailUrl.isEmpty ? state!.thumbnail : newThumbnailUrl,
      ingredients: state!.ingredients,
      steps: state!.steps,
    );
  }
}
