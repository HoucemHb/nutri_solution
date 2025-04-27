// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/data/services/dio_client.dart';

import '../models/recipe_model.dart';

class RecipesResponse {
  List<RecipeModel> recipes;
  int totalCount;
  RecipesResponse({
    required this.recipes,
    required this.totalCount,
  });
}

class RecipesService {
  static const String apiUrl = '${AppApi.baseUrl}/recipes';

  final Dio _dio;

  RecipesService() : _dio = DioClient(baseUrl: apiUrl).dio;

  Future<RecipesResponse> getAllRecipes({
    int page = 1,
    int limit = 12,
    String? searchText,
    String? objectif,
    String? category,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        if (searchText != null && searchText.trim().isNotEmpty)
          'searchText': searchText.trim(),
        if (objectif != null) 'objectif': objectif,
        if (category != null) 'categorie': category,
      };

      final response = await _dio.get('', queryParameters: queryParameters);

      final List<dynamic> data = response.data['data'];
      final int totalRecipesCount = response.data['total'];
      print(data);
      final recipes = data.map((json) => RecipeModel.fromMap(json)).toList();
      print('from recipes service: $recipes');
      return RecipesResponse(recipes: recipes, totalCount: totalRecipesCount);
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  Future<int> getRecipesCount() async {
    try {
      final response = await _dio.get('/count');
      return response.data['total'];
    } catch (e) {
      throw Exception('Failed to fetch recipes count: $e');
    }
  }

  Future<RecipeModel> getRecipeById(String id) async {
    try {
      final response = await _dio.get('/$id');
      return RecipeModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to fetch recipe: $e');
    }
  }

  Future<bool> deleteRecipe(String id) async {
    try {
      final response = await _dio.delete('/$id');
      return response.data['count'] > 0;
    } catch (e) {
      throw Exception('Failed to delete recipe: $e');
    }
  }

  Future<RecipeModel> addRecipe(RecipeModel recipe) async {
    try {
      final response = await _dio.post(
        '',
        data: recipe.toJson(),
      );
      return RecipeModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add recipe: $e');
    }
  }

  Future<RecipeModel> updateRecipe(String id, RecipeModel recipe) async {
    try {
      final response = await _dio.patch(
        '/$id',
        data: recipe.toJson(),
      );
      return RecipeModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update recipe: $e');
    }
  }
}
