import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_asia_recipe_app/src/apps/utils/utilities.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart';

part 'recipe_repository.g.dart';

@Riverpod(keepAlive: true)
RecipeRepository recipeRepository(ref) {
  return RecipeRepository(ref);
}

class RecipeRepository {
  RecipeRepository(this._ref);

  final Ref _ref;
  Database? _database;

  // Singleton pattern to return the initialized database
  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    } else {
      return await _initDB();
    }
  }

  // Initialize the database and return the instance
  Future<Database> _initDB() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'recipe_database.db');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE recipes('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'description TEXT, '
            'type TEXT, '
            'thumbnail TEXT, '
            'recipeTypeId INTEGER, '
            'ingredients TEXT, ' // Store ingredients as JSON string
            'steps TEXT' // Store steps as JSON string
            ')',
          );
        },
      );
      return _database!;
    } catch (e) {
      throw Exception("Database initialization failed");
    }
  }

  // Insert a recipe into the database
  Future<void> insertRecipe(RecipeModel recipe) async {
    final db = await _db;

    try {
      await db.insert(
        'recipes',
        {
          'id': recipe.id,
          'name': recipe.name,
          'description': recipe.description,
          'recipeTypeId': recipe.recipeTypeId,
          'thumbnail': recipe.thumbnail,
          'ingredients': jsonEncode(
              recipe.ingredients), // Convert List<Map> to JSON String
          'steps':
              jsonEncode(recipe.steps), // Convert List<String> to JSON String
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {}
  }

  // Update an existing recipe
  Future<void> updateRecipe(RecipeModel recipe) async {
    final db = await _db;
    try {
      await db.update(
        'recipes',
        recipe.toJson(),
        where: 'id = ?',
        whereArgs: [recipe.id],
      );
    } catch (e) {}
  }

  // Delete a recipe by ID
  Future<void> deleteRecipe(int id) async {
    final db = await _db;
    try {
      await db.delete(
        'recipes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {}
  }

  // Get all recipes from the database
  Future<List<RecipeModel>> getRecipesFromDB() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('recipes');

    return List.generate(maps.length, (i) {
      try {
        return RecipeModel.fromJson(maps[i]);
      } catch (e) {}
      return RecipeModel.fromJson(maps[i]);
    });
  }

  // Get all recipes either from DB or JSON (with fallback)
  Future<Either<Exception, List<RecipeModel>>> getAllRecipes() async {
    // Check the database first
    List<RecipeModel> recipesFromDB = await getRecipesFromDB();

    if (recipesFromDB.isNotEmpty) {
      return Right(recipesFromDB);
    }

    // If no data in DB, load from JSON and insert into DB
    try {
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/json/recipe.json');

      for (var element in jsonData['recipes'] as List) {
        var recipe = RecipeModel.fromJson(element as Map<String, dynamic>);
        await insertRecipe(recipe);
      }

      recipesFromDB = await getRecipesFromDB();
      return Right(recipesFromDB);
    } on Exception catch (e) {
      return Left(Exception('Error loading recipes: $e'));
    }
  }

  // Get specific recipe details from database or JSON
  Future<Either<Exception, RecipeModel>> getRecipeDetails({
    required int recipeID,
  }) async {
    List<RecipeModel> recipesFromDB = await getRecipesFromDB();
    for (var recipe in recipesFromDB) {
      if (recipe.id == recipeID) {
        return Right(recipe);
      }
    }

    // If not found in DB, fallback to JSON
    try {
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/json/recipe.json');

      for (var element in jsonData['recipes'] as List) {
        var recipe = RecipeModel.fromJson(element as Map<String, dynamic>);
        if (recipe.id == recipeID) {
          return Right(recipe);
        }
      }
    } on Exception catch (e) {
      return Left(Exception('Error fetching recipe details: $e'));
    }

    return Left(Exception('Recipe not found'));
  }
}
