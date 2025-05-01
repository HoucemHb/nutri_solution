import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/features/recipes/states/recipes_screen_state.dart';

class RecipesScreenNotifier extends StateNotifier<RecipesScreenState> {
  RecipesScreenNotifier() : super(RecipesScreenState());

  void updateSearchText(String newText) {
    state = state.copyWith(searchText: newText);
  }

  void updatePage(int newPage) {
    state = state.copyWith(page: newPage);
  }

  void updateCategory(String? newCategory) {
    state = state.copyWith(category: newCategory);
  }

  void updateObjectif(String? newObjectif) {
    state = state.copyWith(objectif: newObjectif);
  }

  void toggleFilters() {
    state = state.copyWith(areFiltersOpen: !state.areFiltersOpen);
  }
}

final recipesScreenNotifierProvider = StateNotifierProvider.autoDispose<
    RecipesScreenNotifier, RecipesScreenState>((ref) {
  return RecipesScreenNotifier();
});
