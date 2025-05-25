import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/core/utils/show_toast.dart';
import 'package:nutrisolutions_mobile/data/providers/auth_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/client_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/recipes_provider.dart';
import 'package:nutrisolutions_mobile/features/recipes/widgets/instructions_list.dart';
import 'package:nutrisolutions_mobile/shared/nutri_box.dart';
import 'widgets/checklist.dart';
import 'widgets/detail_item.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  final String recipeId;
  const RecipeDetailsScreen({required this.recipeId, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeByIdProvider(recipeId));

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: recipeAsync.when(
          data: (recipe) {
            final items = [
              {
                'image': 'assets/images/doctor.png',
                'content':
                    'Dr. ${recipe.createdBy.isNotEmpty ? recipe.createdBy : 'Unknown'}',
              },
              {
                'image': 'assets/images/goal.png',
                'content': recipe.objectif.isNotEmpty
                    ? recipe.objectif
                    : 'No objective provided',
              },
              {
                'image': 'assets/images/chef.png',
                'content': recipe.category.isNotEmpty
                    ? recipe.category
                    : 'Uncategorized',
              },
              {
                'image': 'assets/images/meal.png',
                'content': recipe.preparationTime.isNotEmpty
                    ? recipe.preparationTime
                    : 'N/A',
              },
              {
                'image': 'assets/images/proteins.png',
                'content': '${recipe.protein} grammes',
              },
              {
                'image': 'assets/images/lipid.png',
                'content': '${recipe.fat} grammes',
              },
              {
                'image': 'assets/images/carbohydrate.png',
                'content': '${recipe.carbohydrates} grammes',
              },
              {
                'image': 'assets/images/calories.png',
                'content': '${recipe.calories} calories',
              },
            ];
            return Column(
              children: [
                Text(
                  'Manger sain, c\'est prendre soin de soi avec chaque bouchée',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const Gap(120),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    NutriBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 90.0,
                                bottom: 80.0,
                                left: 12.0,
                                right: 12.0),
                            child: Column(
                              children: [
                                Text(
                                  recipe.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: AppColors.brown,
                                      ),
                                ),
                                const Gap(10),
                                SizedBox(
                                  height: 200,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        right: 14.0, left: 14.0),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 4,
                                    ),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = items[index];
                                      return DetailItem(
                                        imageUrl: item['image']!,
                                        text: item['content']!,
                                      );
                                    },
                                  ),
                                ),
                                const Gap(10),
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        final clientId = (await ref
                                                .read(authServiceProvider)
                                                .getUserId()) ??
                                            '';

                                        // Get current favorite recipe IDs
                                        final favoriteIds = await ref
                                            .read(clientServiceProvider)
                                            .getFavoriteRecipeIds(clientId);

                                        if (favoriteIds.contains(recipeId)) {
                                          AppToast.showSuccessToast(
                                              'Recipe already in favorites.');
                                          return;
                                        }

                                        // Add to favorites if not already present
                                        await ref
                                            .read(clientServiceProvider)
                                            .addRecipeToFavorite(
                                                clientId, recipeId);
                                        AppToast.showSuccessToast(
                                            'Recipe added to favorites successfully!');
                                      } catch (e) {
                                        print(e);
                                        AppToast.showErrorToast(
                                            'Failed to add to favorites: $e');
                                      }
                                    },
                                    child: const Text(
                                      'Add to favorites',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  recipe.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(10),
                                const Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: AppColors.secondaryColor),
                                const Gap(10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Ingredients',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColors.brown,
                                        ),
                                  ),
                                ),
                                const Gap(10),
                                ChecklistWidget(
                                  ingredients: recipe.ingredients,
                                ),
                                const Gap(10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Instructions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColors.brown,
                                        ),
                                  ),
                                ),
                                const Gap(10),
                                InstructionsList(
                                    instructions: recipe.instructions),
                                const Gap(10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cooking Notes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColors.brown,
                                        ),
                                  ),
                                ),
                                const Gap(10),
                                InstructionsList(
                                    instructions: recipe.cookingNotes),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: -100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          AppApi.baseUrl + recipe.imageUrl,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Text('Erreur: $error'),
          ),
        ),
      ),
    ));
  }
}
