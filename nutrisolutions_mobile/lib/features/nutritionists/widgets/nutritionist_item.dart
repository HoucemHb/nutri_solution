import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/data/models/nutritionist_model.dart';
import 'package:nutrisolutions_mobile/shared/nutri_box.dart';

class NutritionistItem extends StatelessWidget {
  final NutritionistModel nutritionist;
  const NutritionistItem({
    required this.nutritionist,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/nutritionists/${nutritionist.id}');
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          NutriBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Text(nutritionist.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall),
                const Spacer(),
                Text(
                  '${nutritionist.patientsNumber}+ Patients',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.brown,
                      ),
                ),
                const Gap(4),
                Text(
                  '${nutritionist.experienceYears}+ Exp. Years',
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
            child: ClipOval(
              child: Image.network(
                AppApi.baseUrl + nutritionist.profilePictureUrl,
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
