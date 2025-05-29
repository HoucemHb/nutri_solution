import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../providers/signup_form_notifier.dart';

class SignupStepper extends ConsumerWidget {
  const SignupStepper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    final currentStep = signupFormState.currentStep;
    final steps = [
      'Account \nInformation',
      'Profile \nData',
      'Additional \nInformation',
      'Profile \nPicture'
    ];
    return Stack(
      children: [
        const Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Divider(thickness: 1, height: 1, color: AppColors.hintText)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    // The padding value will be the border width
                    decoration: BoxDecoration(
                      color: currentStep == index
                          ? AppColors.secondaryColor
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 1, // Border width
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: currentStep == index
                              ? AppColors.white
                              : AppColors.hintText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Text(steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: currentStep == index
                            ? AppColors.secondaryColor
                            : AppColors.hintText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
