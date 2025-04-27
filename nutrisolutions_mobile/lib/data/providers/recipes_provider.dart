// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nutrisolutions_mobile/data/models/recipe_model.dart';

import '../services/recipes_service.dart';

// Create a Provider for RecipesService
final recipesServiceProvider = Provider<RecipesService>((ref) {
  return RecipesService();
});

final allRecipesFutureProvider =
    FutureProvider.family<RecipesResponse, RecipesQueryParams>(
  (ref, params) async {
    final recipesService = ref.read(recipesServiceProvider);
    final recipesResponse = await recipesService.getAllRecipes(
      page: params.page,
      limit: params.limit,
      searchText: params.searchText,
      objectif: params.objectif,
      category: params.category,
    );
    return recipesResponse;
  },
);

final recipeByIdProvider = FutureProvider.family<RecipeModel, String>(
  (ref, id) async {
    final recipesService = ref.read(recipesServiceProvider);
    final recipe = await recipesService.getRecipeById(id);
    return recipe;
  },
);

class RecipesQueryParams {
  final int page;
  final int limit;
  final String? searchText;
  final String? objectif;
  final String? category;

  const RecipesQueryParams({
    this.page = 1,
    this.limit = 9,
    this.searchText,
    this.objectif,
    this.category,
  });

  @override
  bool operator ==(covariant RecipesQueryParams other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        other.limit == limit &&
        other.searchText == searchText &&
        other.objectif == objectif &&
        other.category == category;
  }

  @override
  int get hashCode {
    return page.hashCode ^
        limit.hashCode ^
        searchText.hashCode ^
        objectif.hashCode ^
        category.hashCode;
  }
}
