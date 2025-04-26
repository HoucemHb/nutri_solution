import 'package:nutrisolutions_mobile/data/models/client_model.dart';

class RecipeModel {
  final String? id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String imageUrl;
  final int calories;
  final String category;
  final String objectif;
  final String preparationTime;
  final String createdBy;
  final DateTime createdAt;
  final int protein;
  final int fat;
  final int carbohydrates;
  final List<String> instructions;
  final List<String> cookingNotes;
  final List<ClientModel>? favoritedByClient;

  RecipeModel({
    this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.calories,
    required this.category,
    required this.objectif,
    required this.preparationTime,
    required this.createdBy,
    required this.createdAt,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.instructions,
    required this.cookingNotes,
    this.favoritedByClient,
  });
}