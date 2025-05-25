import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/data/models/enums.dart';
import 'package:nutrisolutions_mobile/data/providers/recipes_provider.dart';
import 'package:nutrisolutions_mobile/features/recipes/providers/recipes_screen_notifier.dart';
import 'package:nutrisolutions_mobile/features/recipes/widgets/recipe_item.dart';

import '../../shared/list_filter_widgets.dart';

class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int totalRecipes = 0;
    final recipesScreenState = ref.watch(recipesScreenNotifierProvider);
    final recipesAsync = ref.watch(allRecipesFutureProvider(RecipesQueryParams(
      searchText: recipesScreenState.searchText,
      page: recipesScreenState.page,
      limit: recipesScreenState.limit,
      category: recipesScreenState.category != 'Tous'
          ? recipesScreenState.category
          : null,
      objectif: recipesScreenState.objectif != 'Tous'
          ? recipesScreenState.objectif
          : null,
    )));
    print('Rebuilding');

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text('Our Recipes',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 30)),
          const Gap(10),
          const MySearchAndFilters(),
          recipesAsync.when(
            data: (recipesResponse) {
              final recipes = recipesResponse.recipes;
              if (totalRecipes == 0) totalRecipes = recipesResponse.totalCount;
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
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return RecipeItem(recipe: recipes[index]);
                  },
                ),
              );
            },
            loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => Center(child: Text('Erreur: $error')),
          ),
          PaginationWidget(
            totalPages: (totalRecipes / recipesScreenState.limit).ceil(),
            selectedPageIndex: recipesScreenState.page,
            onNextPressed: () => ref
                .read(recipesScreenNotifierProvider.notifier)
                .updatePage(recipesScreenState.page + 1),
            onPreviousPressed: () => ref
                .read(recipesScreenNotifierProvider.notifier)
                .updatePage(recipesScreenState.page - 1),
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
                    .read(recipesScreenNotifierProvider.notifier)
                    .updateSearchText(value),
              ),
            ),
            const Gap(10),
            GestureDetector(
              child:
                  const Icon(Icons.filter_list, color: AppColors.primaryColor),
              onTap: () {
                ref
                    .read(recipesScreenNotifierProvider.notifier)
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
    final recipesScreenState = ref.watch(recipesScreenNotifierProvider);
    return AnimatedContainer(
      height: recipesScreenState.areFiltersOpen ? 70 : 0,
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      duration: const Duration(milliseconds: 200),
      child: const Row(
        children: [
          Expanded(child: CategoryFilter()),
          Gap(8),
          // Second Dropdown
          Expanded(child: GoalFilter()),
        ],
      ),
    );
  }
}
