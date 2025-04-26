import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/shared/nutri_box.dart';

import '../../../data/models/recipe_model.dart';

class RecipeItem extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeItem({
    required this.recipe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.go('/recipes/${recipe.id}');
        context.go('/recipes/1');

      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          NutriBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  recipe.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 14),
                ),
                const Gap(4),
                Text(
                  recipe.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.brown,
                      ),
                ),
                const Gap(4),
                Text(
                  '${recipe.calories} calories',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                recipe.imageUrl,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
