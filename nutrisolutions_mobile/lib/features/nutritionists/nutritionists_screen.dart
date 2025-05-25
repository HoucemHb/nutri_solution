import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import '../../data/models/enums.dart';
import '../../data/providers/nutritionists_provider.dart';
import '../../shared/list_filter_widgets.dart';
import 'providers/nutitionists_screen_notifier.dart';
import 'widgets/nutritionist_item.dart';

class NutritionistsScreen extends ConsumerWidget {
  const NutritionistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int totalNutritionists = 0;
    final nutritionistsScreenState =
        ref.watch(nutritionistScreenNotifierProvider);
    final nutritionistsAsync =
        ref.watch(allNutritionistsFutureProvider(NutritionistsQueryParams(
      searchText: nutritionistsScreenState.searchText,
      page: nutritionistsScreenState.page,
      limit: nutritionistsScreenState.limit,
      experienceYears: nutritionistsScreenState.experienceYears != 'Tous'
          ? nutritionistsScreenState.experienceYears
          : null,
    )));
    print('Rebuilding');

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text('Our Nutritionists',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 30)),
          const Gap(10),
          const MySearchAndFilters(),
          nutritionistsAsync.when(
            data: (nutritionistsResponse) {
              final nutritionists = nutritionistsResponse.nutritionists;
              print('Total count nutri: ${nutritionistsResponse.totalCount}');
              if (totalNutritionists == 0) {
                totalNutritionists = nutritionistsResponse.totalCount;
                print('Total count nutri: $totalNutritionists');
              }
              return Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.only(right: 7.0, left: 7.0, top: 55.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 70.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: nutritionists.length,
                  itemBuilder: (context, index) {
                    return NutritionistItem(nutritionist: nutritionists[index]);
                  },
                ),
              );
            },
            loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => Center(child: Text('Erreur: $error')),
          ),
          PaginationWidget(
            totalPages: (totalNutritionists / nutritionistsScreenState.limit)
                .ceil(), // Calculate total pages based on the limit
            selectedPageIndex: nutritionistsScreenState.page,
            onNextPressed: () => ref
                .read(nutritionistScreenNotifierProvider.notifier)
                .updatePage(nutritionistsScreenState.page + 1),
            onPreviousPressed: () => ref
                .read(nutritionistScreenNotifierProvider.notifier)
                .updatePage(nutritionistsScreenState.page - 1),
          )
        ],
      ),
    ));
  }
}

class MySearchAndFilters extends ConsumerWidget {
  const MySearchAndFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Search Field
        Row(
          children: [
            Expanded(
                child: SearchField(
              onChanged: (value) => ref
                  .read(nutritionistScreenNotifierProvider.notifier)
                  .updateSearchText(value),
            )),
            const Gap(10),
            GestureDetector(
              child:
                  const Icon(Icons.filter_list, color: AppColors.primaryColor),
              onTap: () {
                ref
                    .read(nutritionistScreenNotifierProvider.notifier)
                    .toggleFilters();
                // Your filter action here
              },
            )
          ],
        ),
        const Filters()
        // First Dropdown
      ],
    );
  }
}

class Filters extends ConsumerWidget {
  const Filters({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesScreenState = ref.watch(nutritionistScreenNotifierProvider);

    return AnimatedContainer(
      height: recipesScreenState.areFiltersOpen ? 70 : 0,
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      duration: const Duration(milliseconds: 200),
      child: const Center(
        child: ExperienceYearsFilter(),
      ),
    );
  }
}
