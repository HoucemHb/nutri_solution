// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/data/services/dio_client.dart';

import '../models/nutritionist_model.dart';

class NutritionistsResponse {
  List<NutritionistModel> nutritionists;
  int totalCount;
  NutritionistsResponse({
    required this.nutritionists,
    required this.totalCount,
  });
}

class NutritionistsService {
  static const String apiUrl = '${AppApi.baseUrl}/nutritionists';

  final Dio _dio;

  NutritionistsService() : _dio = DioClient(baseUrl: apiUrl).dio;

  Future<NutritionistsResponse> getAllNutritionists({
    int page = 1,
    int limit = 12,
    String? searchText,
    String? experience,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        if (searchText != null && searchText.trim().isNotEmpty)
          'searchText': searchText.trim(),
        if (experience != null) 'experience': experience,
      };

      final response = await _dio.get('', queryParameters: queryParameters);

      final List<dynamic> data = response.data['data'];
      final int totalNutritionistsCount = response.data['total'];
      print(data);
      final nutritionists =
          data.map((json) => NutritionistModel.fromMap(json)).toList();
      print('from nutritionists service: $nutritionists');
      return NutritionistsResponse(
          nutritionists: nutritionists, totalCount: totalNutritionistsCount);
    } catch (e) {
      throw Exception('Failed to load nutritionists: $e');
    }
  }

  Future<int> getNutritionistsCount() async {
    try {
      final response = await _dio.get('/count');
      return response.data['total'];
    } catch (e) {
      throw Exception('Failed to fetch nutritionists count: $e');
    }
  }

  Future<NutritionistModel> getNutritionistById(String id) async {
    try {
      final response = await _dio.get('/$id');
      return NutritionistModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to fetch nutritionist: $e');
    }
  }

  Future<List<NutritionistModel>> getBestNutritionists() async {
    try {
      final response = await _dio.get('/top');
      final List<dynamic> data = response.data;

      return data.map((json) => NutritionistModel.fromMap(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch top nutritionists: $e');
    }
  }

  Future<bool> deleteNutritionist(String id) async {
    try {
      final response = await _dio.delete('/$id');
      return response.data['count'] > 0;
    } catch (e) {
      throw Exception('Failed to delete nutritionist: $e');
    }
  }

  Future<NutritionistModel> addNutritionist(
      NutritionistModel nutritionist) async {
    try {
      final response = await _dio.post(
        '',
        data: nutritionist.toJson(),
      );
      return NutritionistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add nutritionist: $e');
    }
  }

  Future<NutritionistModel> updateNutritionist(
      String id, NutritionistModel nutritionist) async {
    try {
      final response = await _dio.patch(
        '/$id',
        data: nutritionist.toJson(),
      );
      return NutritionistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update nutritionist: $e');
    }
  }
}
