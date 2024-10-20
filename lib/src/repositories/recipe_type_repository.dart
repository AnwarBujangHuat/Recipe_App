import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_asia_recipe_app/src/apps/utils/utilities.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_type_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'recipe_type_repository.g.dart';

@Riverpod(keepAlive: true)
RecipeTypeRepository recipeTypeRepository(ref) {
  return RecipeTypeRepository(ref);
}

class RecipeTypeRepository {
  RecipeTypeRepository(this._ref);

  final Ref _ref;
  final List<RecipeTypeModel> typeList = [];
  Future<Either<Exception, List<RecipeTypeModel>>> getAllRecipeTypes() async {
    //return recipe directly when not empty
    if (typeList.isNotEmpty) return Right(typeList);
    try {
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/json/recipe_types.json');

      for (var element in jsonData['recipeTypes'] as List) {
        typeList.add(RecipeTypeModel.fromJson(element as Map<String, dynamic>));
      }

      return Right(typeList);
    } on Exception catch (e) {
      return Left(Exception(e));
    }
  }
}
