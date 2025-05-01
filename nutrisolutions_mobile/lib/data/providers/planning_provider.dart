import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/planning_service.dart';
import '../models/slot_model.dart';

// Service instance provider
final planningServiceProvider =
    Provider<PlanningService>((ref) => PlanningService());

// Get unavailable slots by nutritionist
final unavailableSlotsProvider =
    FutureProvider.family<List<SlotModel>, String>((ref, nutritionistId) async {
  final service = ref.read(planningServiceProvider);
  return service.getUnavailableSlotsByNutritionist(nutritionistId);
});

// Add a new slot
final addSlotProvider = FutureProvider.autoDispose
    .family<SlotModel, CreateSlotModelDto>((ref, slot) async {
  final service = ref.read(planningServiceProvider);
  return service.addSlot(slot);
});

// Cancel slot reservation
final cancelSlotReservationProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, slotId) async {
  final service = ref.read(planningServiceProvider);
  return service.cancelSlotReservation(slotId);
});

// Add a rating to a slot
final addRatingProvider = FutureProvider.autoDispose
    .family<SlotModel, Map<String, dynamic>>((ref, data) async {
  final service = ref.read(planningServiceProvider);
  return service.addRating(data['slotId'], data['rating']);
});
