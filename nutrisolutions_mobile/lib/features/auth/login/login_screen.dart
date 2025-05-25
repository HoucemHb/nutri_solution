import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/utils/show_toast.dart';
import 'package:nutrisolutions_mobile/data/providers/auth_provider.dart';
import 'package:nutrisolutions_mobile/features/auth/login/widgets/login_input_widgets.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';
import '../providers/login_form_notifier.dart';
import '../widgets/input_template_widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void showMyDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ResetPassPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormState = ref.watch(loginFormProvider);
    final loginFormNotifier = ref.read(loginFormProvider.notifier);

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
                    Text('Sign in',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(32),
                    const LoginEmailField(),
                    const Gap(20),
                    LoginPasswordField(
                      obscureText: loginFormState.obscurePassword,
                    ),
                    const Gap(12),
                    const RememberMe(),
                    const Gap(12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!loginFormNotifier.validateLoginForm()) {
                            AppToast.showErrorToast(
                                'Fill the required fields!');
                          } else {
                            final response =
                                await loginFormNotifier.submitLogin();
                            if (response != null) {
                              context.go('/');
                            } else {
                              AppToast.showErrorToast('Invalid Credentials!');
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/facebook-logo.png',
                            height: 60),
                        const Gap(20),
                        Image.asset('assets/images/apple-logo.png', height: 60),
                        const Gap(20),
                        Image.asset('assets/images/google-logo.png',
                            height: 60),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/signup');
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            showMyDialog(context, 'test');
                            // context.go('/reset-password');
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor,
                                ),
                          ),
                        ),
                      ],
                    )
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

class ResetPassPopup extends ConsumerWidget {
  const ResetPassPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPassState = ref.watch(resetFormProvider);
    final resetPassNotifier = ref.read(resetFormProvider.notifier);
    return AlertDialog(
      title: Text('Forgot Your Password?',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontSize: 22)),
      content: SizedBox(
        height: 100,
        width: double.infinity,
        child: TextInputTemplate(
          onChanged: (String value) {
            resetPassNotifier.updateEmailAddress(value);
          },
          hintText: 'example@gmail.com',
          labelText: 'Enter your email here',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final email = resetPassState.email;
            //api call
            if (email != null) {
              await ref
                  .read(authServiceProvider)
                  .resetPasswordRequest(resetPassState.email!);

              Navigator.of(context).pop();
              AppToast.showSuccessToast(
                  'Check your email! We sent you instructions to reset your password');
            } else {
              AppToast.showErrorToast('Please Enter Your Email');
            }
          },
          child:
              Text('Confirm', style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }
}

class RememberMe extends ConsumerWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(loginFormProvider).rememberMe;
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          side: const BorderSide(color: AppColors.hintText, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: rememberMe,
          onChanged: (value) {
            ref.read(loginFormProvider.notifier).updateRememberMe(value!);
          },
        ),
        Text(
          "Remember me?",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
