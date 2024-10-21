import 'dart:convert';

class RecipeModel {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final int recipeTypeId;
  final List<IngredientModel> ingredients;
  final List<String> steps;

  RecipeModel({
    required this.id,
    required this.name,
    required this.recipeTypeId,
    required this.description,
    required this.thumbnail,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      recipeTypeId: json['recipeTypeId'],
      ingredients: (json['ingredients'] is String)
          ? List<IngredientModel>.from(jsonDecode(json['ingredients'])
              .map((i) => IngredientModel.fromJson(i)))
          : (json['ingredients'] as List)
              .map((i) => IngredientModel.fromJson(i))
              .toList(),
      steps: (json['steps'] is String)
          ? List<String>.from(jsonDecode(json['steps']))
          : List<String>.from(json['steps'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'description': description,
      'recipeTypeId': recipeTypeId,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'steps': steps,
    };
  }
}

class IngredientModel {
  final String name;
  final String quantity;

  IngredientModel({
    required this.name,
    required this.quantity,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
