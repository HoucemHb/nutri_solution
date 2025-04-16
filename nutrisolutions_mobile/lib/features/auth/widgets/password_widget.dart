import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';

import '../providers/login_form_notifier.dart';

class PasswordTemplate extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final void Function(String)? onChanged;

  const PasswordTemplate({
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthInput(
      hintText: hintText,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: onToggleVisibility,
      ),
      onChanged: onChanged,
    );
  }
}

class OldPasswordField extends ConsumerWidget {
  final bool obscureText;
  const OldPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordNotifier = ref.read(resetFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Enter your old password',
      obscureText: obscureText,
      onToggleVisibility: resetPasswordNotifier.toggleOldPasswordVisibility,
      onChanged: resetPasswordNotifier.updateOldPassword,
    );
  }
}

class NewPasswordField extends ConsumerWidget {
  final bool obscureText;
  const NewPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordNotifier = ref.read(resetFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Enter new password',
      obscureText: obscureText,
      onToggleVisibility: resetPasswordNotifier.toggleNewPasswordVisibility,
      onChanged: resetPasswordNotifier.updateNewPassword,
    );
  }
}

class ConfirmPasswordField extends ConsumerWidget {
  final bool obscureText;
  const ConfirmPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordNotifier = ref.read(resetFormProvider.notifier);

    return PasswordTemplate(
      hintText: 'Enter Confirm password',
      obscureText: obscureText,
      onToggleVisibility: resetPasswordNotifier.toggleConfirmPasswordVisibility,
      onChanged: resetPasswordNotifier.updateConfirmPassword,
    );
  }
}

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

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginFormProvider.notifier);
    return AuthInput(
        hintText: 'Enter your email',
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          loginNotifier.updateEmail(value);
        });
  }
}

class AuthInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const AuthInput({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: AppColors.hintText,
            width: 0.5,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
