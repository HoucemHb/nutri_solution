import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../data/models/enums.dart';
import '../features/nutritionists/providers/nutitionists_screen_notifier.dart';
import '../features/recipes/providers/recipes_screen_notifier.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  const CustomDropdown(
      {super.key,
      required this.options,
      required this.selectedValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _GradientBorderWidget(
        child: SizedBox(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.9,
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
    ));
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

class PaginationWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
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

class SearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchField({
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _GradientBorderWidget(
      child: SizedBox(
        height: 35,
        child: TextField(
          onChanged: onChanged,
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

class ExperienceYearsFilter extends ConsumerWidget {
  const ExperienceYearsFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nutritionistsState = ref.watch(nutritionistScreenNotifierProvider);
    return CustomDropdown(
      options: ExperienceEnum.values.map((e) => e.label).toList(),
      selectedValue: nutritionistsState.experienceYears,
      onChanged: (value) => ref
          .read(nutritionistScreenNotifierProvider.notifier)
          .updateExperienceYears(value),
    );
  }
}

class GoalFilter extends ConsumerWidget {
  const GoalFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesState = ref.watch(recipesScreenNotifierProvider);
    return CustomDropdown(
      options: GoalEnum.values.map((e) => e.label).toList(),
      selectedValue: recipesState.objectif,
      onChanged: (value) => ref
          .read(recipesScreenNotifierProvider.notifier)
          .updateObjectif(value),
    );
  }
}

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesState = ref.watch(recipesScreenNotifierProvider);
    return CustomDropdown(
      options: CategoryEnum.values.map((e) => e.label).toList(),
      selectedValue: recipesState.category,
      onChanged: (value) => ref
          .read(recipesScreenNotifierProvider.notifier)
          .updateCategory(value),
    );
  }
}
