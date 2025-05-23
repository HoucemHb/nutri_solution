import 'package:dio/dio.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/data/models/slot_model.dart';
import 'package:nutrisolutions_mobile/data/services/dio_client.dart';

class PlanningService {
  static const String apiUrl = '${AppApi.baseUrl}/planning';

  final Dio _dio;

  PlanningService() : _dio = DioClient(baseUrl: apiUrl).dio;

  Future<List<SlotModel>> getUnavailableSlotsByNutritionist(
      String nutritionistId) async {
    try {
      final response = await _dio.get('/$nutritionistId');
      final data = response.data as List;
      return data.map((json) => SlotModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch slots: $e');
    }
  }

  Future<SlotModel> addSlot(CreateSlotModelDto slot) async {
    try {
      final response = await _dio.post('', data: slot.toJson());
      return SlotModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add slot: $e');
    }
  }

  Future<SlotModel> addNote(String slotId, List<String> notes) async {
    try {
      final response = await _dio.patch('/$slotId', data: {'notes': notes});
      return SlotModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<void> cancelSlotReservation(String id) async {
    try {
      final response = await _dio.delete('/$id');
    } catch (e) {
      throw Exception('Failed to cancel reservation: $e');
    }
  }

  Future<SlotModel> addRating(String slotId, double rating) async {
    try {
      final response = await _dio.patch('/$slotId', data: {'rating': rating});
      return SlotModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add rating: $e');
    }
  }
}

class CreateSlotModelDto {
  final DateTime date;
  final String day;
  final String time;
  final bool isReservation;
  final String nutritionistId;
  final String? clientId;
  final String? id;

  CreateSlotModelDto({
    required this.date,
    required this.day,
    required this.time,
    required this.isReservation,
    required this.nutritionistId,
    this.clientId,
    this.id,
  });

  factory CreateSlotModelDto.fromJson(Map<String, dynamic> json) {
    return CreateSlotModelDto(
      date: DateTime.parse(json['date']),
      day: json['day'],
      time: json['time'],
      isReservation: json['isReservation'],
      nutritionistId: json['nutritionistId'],
      clientId: json['clientId'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'day': day,
      'time': time,
      'isReservation': isReservation,
      'nutritionistId': nutritionistId,
      if (clientId != null) 'clientId': clientId,
      if (id != null) 'id': id,
    };
  }
}
