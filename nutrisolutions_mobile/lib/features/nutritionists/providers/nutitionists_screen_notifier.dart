import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/nutritionists_screen_state.dart';

class NutritionistsScreenNotifier
    extends StateNotifier<NutritionistsScreenState> {
  NutritionistsScreenNotifier() : super(NutritionistsScreenState());

  void updateSearchText(String newText) {
    state = state.copyWith(searchText: newText);
  }

  void updatePage(int newPage) {
    state = state.copyWith(page: newPage);
  }

  void updateLimit(int newLimit) {
    state = state.copyWith(limit: newLimit);
  }

  void updateExperienceYears(String? newExperienceYears) {
    state = state.copyWith(experienceYears: newExperienceYears);
  }

  void toggleFilters() {
    state = state.copyWith(areFiltersOpen: !state.areFiltersOpen);
  }
}

final nutritionistScreenNotifierProvider = StateNotifierProvider.autoDispose<
    NutritionistsScreenNotifier, NutritionistsScreenState>((ref) {
  return NutritionistsScreenNotifier();
});
