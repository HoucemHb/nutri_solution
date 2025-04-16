import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/signup_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_form_step1.dart';
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
          physics:
              const NeverScrollableScrollPhysics(), // Prevent manual scrolling
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 34.0, vertical: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Register',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(20),
                    Stepper(
                      steps: List.generate(
                          4,
                          (index) => Step(
                                title: Text(steps[index]),
                                content: Text('$index'),
                                isActive: signupState.currentStep == index,
                                state: signupState.currentStep > index
                                    ? StepState.complete
                                    : StepState.indexed,
                              )),
                      type: StepperType.horizontal,
                      connectorColor:
                          WidgetStateProperty.all(AppColors.hintText),
                      currentStep: signupState.currentStep,
                      onStepTapped: (index) {
                        ref
                            .read(signupFormProvider.notifier)
                            .updateCurrentStep(index);
                      },
                    ),

                    PageView(
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (page) {
                          signupNotifier.updateCurrentStep(page);
                        },
                        children: const [
                          SignupFormStep1(),
                          // SignupFormStep2(),
                          // SignupFormStep3(),
                          // SignupFormStep4()
                        ]),

                    //buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (signupState.currentStep > 0)
                          SizedBox(
                            width: double.infinity,
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
                              onPressed: () {},
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        if (signupState.currentStep < 3)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        if (signupState.currentStep == 3)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Confirm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(16),
                    if (signupState.currentStep == 0)
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.hintText,
                        ),
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
