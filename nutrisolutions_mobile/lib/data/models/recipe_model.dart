// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  RecipeModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? ingredients,
    String? imageUrl,
    int? calories,
    String? category,
    String? objectif,
    String? preparationTime,
    String? createdBy,
    DateTime? createdAt,
    int? protein,
    int? fat,
    int? carbohydrates,
    List<String>? instructions,
    List<String>? cookingNotes,
    List<ClientModel>? favoritedByClient,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      imageUrl: imageUrl ?? this.imageUrl,
      calories: calories ?? this.calories,
      category: category ?? this.category,
      objectif: objectif ?? this.objectif,
      preparationTime: preparationTime ?? this.preparationTime,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      instructions: instructions ?? this.instructions,
      cookingNotes: cookingNotes ?? this.cookingNotes,
      favoritedByClient: favoritedByClient ?? this.favoritedByClient,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'calories': calories,
      'category': category,
      'objectif': objectif,
      'preparationTime': preparationTime,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
      'instructions': instructions,
      'cookingNotes': cookingNotes,
      // 'favoritedByClient': favoritedByClient.map((x) => x?.toMap()).toList(),
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      ingredients: List<String>.from((map['ingredients'])),
      imageUrl: map['imageUrl'] as String,
      calories: map['calories'] as int,
      category: map['category'] as String,
      objectif: map['objectif'] as String,
      preparationTime: map['preparationTime'] as String,
      createdBy: map['createdBy'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      protein: map['protein'] as int,
      fat: map['fat'] as int,
      carbohydrates: map['carbohydrates'] as int,
      instructions: List<String>.from((map['instructions'])),
      cookingNotes: List<String>.from((map['cookingNotes'])),
      favoritedByClient: map['favoritedByClient'] != null
          ? List<ClientModel>.from(
              (map['favoritedByClient']).map<ClientModel?>(
                (x) => ClientModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) =>
      RecipeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecipeModel(id: $id, name: $name, description: $description, ingredients: $ingredients, imageUrl: $imageUrl, calories: $calories, category: $category, objectif: $objectif, preparationTime: $preparationTime, createdBy: $createdBy, createdAt: $createdAt, protein: $protein, fat: $fat, carbohydrates: $carbohydrates, instructions: $instructions, cookingNotes: $cookingNotes, favoritedByClient: $favoritedByClient)';
  }

  @override
  bool operator ==(covariant RecipeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.ingredients, ingredients) &&
        other.imageUrl == imageUrl &&
        other.calories == calories &&
        other.category == category &&
        other.objectif == objectif &&
        other.preparationTime == preparationTime &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.protein == protein &&
        other.fat == fat &&
        other.carbohydrates == carbohydrates &&
        listEquals(other.instructions, instructions) &&
        listEquals(other.cookingNotes, cookingNotes) &&
        listEquals(other.favoritedByClient, favoritedByClient);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        ingredients.hashCode ^
        imageUrl.hashCode ^
        calories.hashCode ^
        category.hashCode ^
        objectif.hashCode ^
        preparationTime.hashCode ^
        createdBy.hashCode ^
        createdAt.hashCode ^
        protein.hashCode ^
        fat.hashCode ^
        carbohydrates.hashCode ^
        instructions.hashCode ^
        cookingNotes.hashCode ^
        favoritedByClient.hashCode;
  }
}
