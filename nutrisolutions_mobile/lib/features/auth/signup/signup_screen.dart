import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/signup_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_form_step1.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_form_step2.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_form_step3.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_form_step4.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/stepper_widget.dart';
import '../providers/reset_form_notifier.dart';
import '../widgets/auth_label_widget.dart';
import '../widgets/input_template_widgets.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupFormProvider);
    final signupNotifier = ref.read(signupFormProvider.notifier);
    final steps = [
      'Account Information',
      'Profile Data',
      'Additional Information',
      'Profile Picture'
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFDF2E9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 34.0, left: 34.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Register',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(20),

                    const SignupStepper(),
                    const Gap(20),

                    SizedBox(
                      height: 350,
                      child: PageView(
                          controller: signupState.pageController,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (page) {
                            signupNotifier.updateCurrentStep(page);
                          },
                          children: const [
                            SignupFormStep1(),
                            SignupFormStep2(),
                            SignupFormStep3(),
                            SignupFormStep4(),
                          ]),
                    ),

                    //buttons
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: Row(
                        children: [
                          if (signupState.currentStep > 0)
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                      foregroundColor:
                                          const WidgetStatePropertyAll(
                                              AppColors.hintText),
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                              AppColors.white),
                                    ),
                                onPressed: () {
                                  signupNotifier.animateToPage(
                                      signupState.currentStep - 1);
                                },
                                child: const Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          if (signupState.currentStep < 4) const Spacer(),
                          if (signupState.currentStep < 3)
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if ((signupState.currentStep == 0 &&
                                            !signupNotifier
                                                .validateAccountInformation()) ||
                                        (signupState.currentStep == 1 &&
                                            !signupNotifier
                                                .validateProfileData())) {
                                      Fluttertoast.showToast(
                                        msg: "Fill the required fields!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        backgroundColor: AppColors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0,
                                      );
                                    } else {
                                      signupNotifier.animateToPage(
                                          signupState.currentStep + 1);
                                    }
                                  },
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (signupState.currentStep == 3)
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!signupNotifier
                                      .validateProfilePicture()) {
                                    //popup
                                  } else {
                                    //signup api
                                  }
                                },
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    if (signupState.currentStep == 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
