import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/data/models/enums.dart';
import 'package:nutrisolutions_mobile/data/providers/recipes_provider.dart';
import 'package:nutrisolutions_mobile/features/recipes/providers/recipes_screen_notifier.dart';
import 'package:nutrisolutions_mobile/features/recipes/states/recipes_screen_state.dart';
import 'package:nutrisolutions_mobile/features/recipes/widgets/recipe_item.dart';

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
                      const EdgeInsets.only(right: 14.0, left: 14.0, top: 55.0),
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
            totalPages: (totalRecipes / recipesScreenState.limit).toInt(),
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
    final recipesScreenState = ref.watch(recipesScreenNotifierProvider);

    return Column(
      children: [
        // Search Field
        Row(
          children: [
            const Expanded(
              child: SearchField(),
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

class SearchField extends ConsumerWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GradientBorderWidget(
      child: SizedBox(
        height: 35,
        child: TextField(
          onChanged: (value) {
            ref
                .read(recipesScreenNotifierProvider.notifier)
                .updateSearchText(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class GoalFilter extends ConsumerWidget {
  const GoalFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesState = ref.watch(recipesScreenNotifierProvider);
    return _GradientBorderWidget(
      child: _CustomDropdown(
        options: GoalEnum.values.map((e) => e.label).toList(),
        selectedValue: recipesState.objectif,
        onChanged: (value) => ref
            .read(recipesScreenNotifierProvider.notifier)
            .updateObjectif(value),
      ),
    );
  }
}

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesState = ref.watch(recipesScreenNotifierProvider);
    return _GradientBorderWidget(
      child: _CustomDropdown(
        options: CategoryEnum.values.map((e) => e.label).toList(),
        selectedValue: recipesState.category,
        onChanged: (value) => ref
            .read(recipesScreenNotifierProvider.notifier)
            .updateCategory(value),
      ),
    );
  }
}

class _CustomDropdown extends ConsumerWidget {
  final List<String> options;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  const _CustomDropdown(
      {super.key,
      required this.options,
      required this.selectedValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 35,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: selectedValue,
            icon: const Icon(Icons.arrow_drop_down,
                color: AppColors.primaryColor),
            style: const TextStyle(color: AppColors.primaryColor),
            isExpanded: true,
            items: options.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(option),
                ),
              );
            }).toList(),
            onChanged: onChanged),
      ),
    );
  }
}

class _GradientBorderWidget extends StatelessWidget {
  final Widget child;
  const _GradientBorderWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(1.5), // Border thickness
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28), // slightly smaller
        ),
        child: child,
      ),
    );
  }
}

class PaginationWidget extends ConsumerWidget {
  final int totalPages;
  final void Function() onNextPressed;
  final void Function() onPreviousPressed;
  final int selectedPageIndex;

  const PaginationWidget({
    super.key,
    required this.totalPages,
    required this.onNextPressed,
    required this.onPreviousPressed,
    required this.selectedPageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Prev
        if (selectedPageIndex > 1)
          TextButton(
            onPressed: onPreviousPressed,
            child:
                Text('Previous', style: Theme.of(context).textTheme.labelSmall),
          ),

        // 1
        pageNumberButton(1),

        // 2
        if (selectedPageIndex <= 2 && totalPages > 1) pageNumberButton(2),

        // ...
        if (selectedPageIndex > 2)
          const Text(
            '...',
            style: TextStyle(color: AppColors.primaryColor),
          ),

        // 3
        if (selectedPageIndex <= 3 && totalPages > 2) pageNumberButton(3),

        // current page
        if (selectedPageIndex >= 4 &&
            selectedPageIndex <= totalPages - 3 &&
            totalPages > 3)
          pageNumberButton(selectedPageIndex, isCurrent: true),
        // selected + 1
        if (selectedPageIndex >= 3 &&
            selectedPageIndex <= totalPages - 4 &&
            totalPages > 3)
          pageNumberButton(selectedPageIndex + 1),

        // ...
        if (totalPages - selectedPageIndex >= 3 && totalPages > 5)
          const Text(
            '...',
            style: TextStyle(color: AppColors.primaryColor),
          ),

        // totalPages - 2
        if (selectedPageIndex > (totalPages - 3) && totalPages > 5)
          pageNumberButton(totalPages - 2),

        // totalPages - 1
        if (selectedPageIndex >= (totalPages - 2) && totalPages > 5)
          pageNumberButton(totalPages - 1),

        // totalPages
        if (totalPages > 3) pageNumberButton(totalPages),

        // Next
        if (selectedPageIndex < totalPages)
          TextButton(
            onPressed: onNextPressed,
            child: Text('Next', style: Theme.of(context).textTheme.labelSmall),
          ),
      ],
    );
  }

  Widget pageNumberButton(int pageNumber, {bool isCurrent = false}) {
    final bool isActive = selectedPageIndex == pageNumber || isCurrent;
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive ? AppColors.secondaryColor : AppColors.white),
      child: Center(
        child: Text(
          '$pageNumber',
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppColors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
