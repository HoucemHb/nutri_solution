import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/data/models/nutritionist_model.dart';
import '../services/nutritionists_service.dart';

// Create a Provider for RecipesService
final nutritionistsServiceProvider = Provider<NutritionistsService>((ref) {
  return NutritionistsService();
});

final allNutritionistsFutureProvider = FutureProvider.autoDispose
    .family<NutritionistsResponse, NutritionistsQueryParams>(
  (ref, params) async {
    final nutritionistsService = ref.read(nutritionistsServiceProvider);
    final nutritionistsResponse =
        await nutritionistsService.getAllNutritionists(
      page: params.page,
      limit: params.limit,
      searchText: params.searchText,
      experience: params.experienceYears,
    );
    return nutritionistsResponse;
  },
);

final bestNutritionistsProvider =
    FutureProvider.autoDispose<List<NutritionistModel>>((ref) async {
  final service = ref.read(nutritionistsServiceProvider);
  return service.getBestNutritionists();
});

final nutritionistByIdProvider =
    FutureProvider.autoDispose.family<NutritionistModel, String>(
  (ref, id) async {
    final nutritionistsService = ref.read(nutritionistsServiceProvider);
    final nutritionist = await nutritionistsService.getNutritionistById(id);
    return nutritionist;
  },
);

class NutritionistsQueryParams {
  final int page;
  final int limit;
  final String? searchText;
  final String? experienceYears;

  const NutritionistsQueryParams({
    this.page = 1,
    this.limit = 9,
    this.searchText,
    this.experienceYears,
  });

  @override
  bool operator ==(covariant NutritionistsQueryParams other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        other.limit == limit &&
        other.searchText == searchText &&
        other.experienceYears == experienceYears;
  }

  @override
  int get hashCode {
    return page.hashCode ^
        limit.hashCode ^
        searchText.hashCode ^
        experienceYears.hashCode;
  }
}
