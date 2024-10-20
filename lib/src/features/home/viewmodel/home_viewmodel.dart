import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:fort_asia_recipe_app/src/repositories/recipe_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  List<RecipeModel> _cachedList = [];
  List<RecipeModel> _filteredList = [];
  String _searchQuery = '';
  @override
  Future<List<RecipeModel>> build() async {
    state = const AsyncLoading();

    final result = await ref.read(recipeRepositoryProvider).getAllRecipes();

    return result.fold(
      (error) => throw Exception(error),
      (data) {
        _cachedList = data;
        return _cachedList;
      },
    );
  }

  void filterByType({required Set<int> type}) {
    List<RecipeModel> filteredList = [];
    for (var recipe in _cachedList) {
      if (type.contains(recipe.recipeTypeId)) {
        filteredList.add(recipe);
      }
    }
    _filteredList = filteredList;
    filterBySearchKey(query: _searchQuery);
  }

  void filterBySearchKey({required String query}) {
    _searchQuery = query;
    List<RecipeModel> filteredList = [];

    for (var recipe in _filteredList) {
      if (recipe.toJson().entries.toString().toLowerCase().contains(query)) {
        filteredList.add(recipe);
      }
    }
    state = AsyncData(filteredList);
  }
}
