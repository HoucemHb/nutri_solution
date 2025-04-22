import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/features/auth/login/widgets/login_input_widgets.dart';
import 'package:nutrisolutions_mobile/features/auth/reset%20pass/widgets/reset_pass_input_widgets.dart';
import '../providers/reset_form_notifier.dart';
import '../widgets/auth_label_widget.dart';
import '../widgets/input_template_widgets.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordState = ref.watch(resetFormProvider);
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
                    Text('Reset Password',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(32),
                    OldPasswordField(
                        obscureText: resetPasswordState.obscureOldPassword),
                    const Gap(20),
                    NewPasswordField(
                        obscureText: resetPasswordState.obscureNewPassword),
                    const Gap(20),
                    ConfirmPasswordField(
                        obscureText: resetPasswordState.obscureConfirmPassword),
                    const Gap(40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const Gap(16),
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
