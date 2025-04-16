import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/input_template_widgets.dart'
    show EmailTemplate, PasswordTemplate;

class SignupEmailField extends ConsumerWidget {
  const SignupEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);

    return EmailTemplate(
      onChanged: signupNotifier.updatePassword,
    );
  }
}

class SignupPasswordField extends ConsumerWidget {
  final bool obscureText;
  const SignupPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Enter your password',
      obscureText: obscureText,
      onToggleVisibility: signupNotifier.togglePasswordVisibility,
      onChanged: signupNotifier.updatePassword,
    );
  }
}

class SignupConfirmPasswordField extends ConsumerWidget {
  final bool obscureText;
  const SignupConfirmPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Confirm your password',
      obscureText: obscureText,
      onToggleVisibility: signupNotifier.toggleConfirmPasswordVisibility,
      onChanged: signupNotifier.updateConfirmPassword,
    );
  }
}
