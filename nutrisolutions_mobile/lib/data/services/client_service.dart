import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import '../models/client_model.dart';

class ClientService {
  final Dio _dio = Dio();
  final String apiUrl = '${AppApi.baseUrl}/clients';

  // Select patient using a stream controller
  final _selectPatient = StateProvider<ClientModel?>((ref) => null);

  void selectPatient(WidgetRef ref, ClientModel patient) {
    ref.read(_selectPatient.notifier).state = patient;
  }

  Future<List<ClientModel>> getAllClients() async {
    final response = await _dio.get(apiUrl);
    return (response.data as List)
        .map((json) => ClientModel.fromJson(json))
        .toList();
  }

  Future<int> getClientsCount() async {
    final response = await _dio.get('$apiUrl/count');
    return response.data['total'] as int;
  }

  Future<ClientModel> getClientById(String id) async {
    final response = await _dio.get('$apiUrl/$id');
    return ClientModel.fromJson(response.data);
  }

  Future<void> deleteClient(String id) async {
    await _dio.delete('$apiUrl/$id');
  }

  Future<ClientModel> updateClient(String id, ClientModel client) async {
    final response = await _dio.patch('$apiUrl/$id', data: client.toJson());
    return ClientModel.fromJson(response.data);
  }

  Future<ClientModel> addRecipeToFavorite(
      String clientId, String recipeId) async {
    final response = await _dio.post(
      '$apiUrl/$clientId/favorites',
      data: {"recipeId": recipeId},
    );
    return ClientModel.fromJson(response.data);
  }

  Future<List<String>> getFavoriteRecipeIds(String clientId) async {
    final response = await _dio.get('$apiUrl/$clientId/favorites');

    print('Status code: ${response.statusCode}');
    print('Data: ${response.data}');
    // Assuming response.data is a list of recipe objects or just IDs
    // Adjust accordingly based on your API response shape
    final favorites = response.data as List<dynamic>;
    return favorites.map((item) => item['id'] as String).toList();
  }

  // Future<SlotModel> getAppointment(String clientId, String nutritionistId, {int appointmentNumber = 0}) async {
  //   final response = await _dio.get(
  //     '$apiUrl/$clientId/appointments/$nutritionistId',
  //     queryParameters: appointmentNumber > 0 ? {'appointmentNumber': appointmentNumber} : null,
  //   );
  //   return SlotModel.fromJson(response.data);
  // }

  // Future<SlotModel?> getLastReservedSlot(String clientId) async {
  //   final response = await _dio.get('$apiUrl/$clientId/last-reserved-slot');
  //   if (response.data == null) return null;
  //   return SlotModel.fromJson(response.data);
  // }
}
