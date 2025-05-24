import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/data/models/nutritionist_model.dart';
import 'package:nutrisolutions_mobile/data/providers/nutritionists_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/recipes_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/water_tracker_provider.dart';
import 'package:nutrisolutions_mobile/features/home/water%20tracker/water_tracker_state.dart';
import 'package:nutrisolutions_mobile/features/nutritionists/widgets/nutritionist_item.dart';
import 'package:nutrisolutions_mobile/features/recipes/widgets/recipe_item.dart';
import 'package:nutrisolutions_mobile/shared/nutri_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WaterTracking(),
          RecentRecipes(),
          TopNutritionist(),
        ],
      ),
    );
  }
}

class WaterTracking extends ConsumerWidget {
  const WaterTracking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterState = ref.watch(waterTrackingProvider);
    final notifier = ref.read(waterTrackingProvider.notifier);
    String mapStatusToSvg(WaterTrackingStatus status) {
      switch (status) {
        case WaterTrackingStatus.veryHappy:
          return 'very-happy';
        case WaterTrackingStatus.happy:
          return 'happy';
        case WaterTrackingStatus.neutral:
          return 'neutral';
        case WaterTrackingStatus.sad:
          return 'sad';
        case WaterTrackingStatus.verySad:
          return 'very-sad';
      }
    }

    return NutriBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suivi de l\'Hydratation - ${waterState.currentTime}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Expanded(
                  child: SvgPicture.asset(
                'assets/images/${mapStatusToSvg(waterState.status)}.svg',
                height: 50,
                width: 50,
              )),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 7; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.fillNextCup(),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/cup.svg',
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            height: (i + 1 <= waterState.filledCups) ? 70 : 0,
                            child: SvgPicture.asset(
                              'assets/images/cup-water.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopNutritionist extends ConsumerWidget {
  const TopNutritionist({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bestNutritionistsAsync = ref.watch(bestNutritionistsProvider);

    return NutriBox(
        child: SizedBox(
      height: 280,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.push('/nutritionists');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Les Nutritionnistes les plus populaires',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 15, color: AppColors.primaryColor),
              ],
            ),
          ),
          bestNutritionistsAsync.when(
            data: (nutritionists) {
              if (nutritionists.isEmpty) {
                return const Text('Aucun nutritionniste trouvé.');
              }
              return Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 14.0, top: 50),
                itemCount: nutritionists.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 0.7,
                    child: NutritionistItem(nutritionist: nutritionists[index]),
                  );
                },
              ));
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    ));
  }
}

class RecentRecipes extends ConsumerWidget {
  const RecentRecipes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentRecipesAsync = ref.watch(recentRecipesProvider);

    return NutriBox(
        child: SizedBox(
      height: 280,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.push('/recipes');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Les Recettes les plus récentes',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 15, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
          recentRecipesAsync.when(
            data: (recipes) {
              if (recipes.isEmpty) {
                return const Text('Aucune recette trouvée.');
              }
              return Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 14.0, top: 50),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 0.7,
                    child: RecipeItem(recipe: recipes[index]),
                  );
                },
              ));
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    ));
  }
}
