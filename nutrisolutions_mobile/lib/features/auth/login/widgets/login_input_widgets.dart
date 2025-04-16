import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/login_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/input_template_widgets.dart';

class LoginPasswordField extends ConsumerWidget {
  final bool obscureText;
  const LoginPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Enter your password',
      obscureText: obscureText,
      onToggleVisibility: loginNotifier.togglePasswordVisibility,
      onChanged: loginNotifier.updatePassword,
    );
  }
}

class LoginEmailField extends ConsumerWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginFormProvider.notifier);
    return EmailTemplate(onChanged: (value) {
      loginNotifier.updateEmail(value);
    });
  }
}
