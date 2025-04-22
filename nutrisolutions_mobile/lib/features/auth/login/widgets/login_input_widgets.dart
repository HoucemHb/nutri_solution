import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/login_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/input_template_widgets.dart';

class LoginPasswordField extends ConsumerWidget {
  final bool obscureText;
  const LoginPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginFormProvider.notifier);
    final loginFormState = ref.watch(loginFormProvider);

    return PasswordTemplate(
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: obscureText,
      onToggleVisibility: loginNotifier.togglePasswordVisibility,
      onChanged: loginNotifier.updatePassword,
      isError: (loginFormState.passwordErrorMessage != AppConstants.valid) &&
          (loginFormState.passwordErrorMessage != null),
      noteText: loginFormState.passwordErrorMessage,
    );
  }
}

class LoginEmailField extends ConsumerWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginFormProvider.notifier);
    final loginFormState = ref.watch(loginFormProvider);
    return EmailTemplate(
        labelText: 'Email address',
        onChanged: (value) {
          loginNotifier.updateEmail(value);
        },
        noteText: loginFormState.emailErrorMessage,
        isError: (loginFormState.emailErrorMessage != AppConstants.valid) &&
            (loginFormState.emailErrorMessage != null));
  }
}
