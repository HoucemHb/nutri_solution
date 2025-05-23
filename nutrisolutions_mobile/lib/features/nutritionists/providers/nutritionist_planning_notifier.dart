import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/data/models/slot_model.dart';

class SlotNotifier extends StateNotifier<List<SlotModel>> {
  SlotNotifier() : super([]);

  void addSlot(SlotModel slot) {
    state = [...state, slot];
  }

  List<SlotModel> get slots => state;
}

final slotProvider =
    StateNotifierProvider<SlotNotifier, List<SlotModel>>((ref) {
  return SlotNotifier();
});
