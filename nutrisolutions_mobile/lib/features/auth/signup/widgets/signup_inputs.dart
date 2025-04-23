import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/input_template_widgets.dart'
    show EmailTemplate, PasswordTemplate;

class SignupEmailField extends ConsumerWidget {
  const SignupEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);
    final signupFormState = ref.watch(signupFormProvider);

    return EmailTemplate(
        value: signupFormState.email,
        labelText: 'Email address',
        onChanged: signupNotifier.updateEmail,
        noteText: signupFormState.emailErrorMessage,
        isError: (signupFormState.emailErrorMessage != AppConstants.valid) &&
            (signupFormState.emailErrorMessage != null));
  }
}

class SignupPasswordField extends ConsumerWidget {
  final bool obscureText;
  const SignupPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);
    final signupFormState = ref.watch(signupFormProvider);

    return PasswordTemplate(
      value: signupFormState.password,
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: obscureText,
      onToggleVisibility: signupNotifier.togglePasswordVisibility,
      onChanged: signupNotifier.updatePassword,
      isError: (signupFormState.passwordErrorMessage != AppConstants.valid) &&
          (signupFormState.passwordErrorMessage != null),
      noteText: signupFormState.passwordErrorMessage != AppConstants.valid
          ? signupFormState.passwordErrorMessage
          : signupFormState.passwordStrengthLevel,
    );
  }
}

class SignupConfirmPasswordField extends ConsumerWidget {
  final bool obscureText;
  const SignupConfirmPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.read(signupFormProvider.notifier);
    final signupFormState = ref.watch(signupFormProvider);

    return PasswordTemplate(
        value: signupFormState.confirmPassword,
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        obscureText: obscureText,
        onToggleVisibility: signupNotifier.toggleConfirmPasswordVisibility,
        onChanged: signupNotifier.updateConfirmPassword,
        isError: (signupFormState.confirmPasswordErrorMessage !=
                AppConstants.valid) &&
            (signupFormState.confirmPasswordErrorMessage != null),
        noteText: signupFormState.confirmPasswordErrorMessage);
  }
}
