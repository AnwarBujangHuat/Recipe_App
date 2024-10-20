class RecipeTypeModel {
  final int id;
  final String name;

  RecipeTypeModel({
    required this.id,
    required this.name,
  });

  factory RecipeTypeModel.fromJson(Map<String, dynamic> json) {
    return RecipeTypeModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
