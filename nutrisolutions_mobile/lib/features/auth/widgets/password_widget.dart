import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';

import '../providers/login_form_notifier.dart';

class PasswordField extends ConsumerWidget {
  final String hintText;
  const PasswordField({required this.hintText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginFormProvider);
    final obscurePassword = loginState.obscurePassword;
    final loginNotifier = ref.read(loginFormProvider.notifier);
    return AuthInput(
        hintText: hintText,
        obscureText: obscurePassword,
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            loginNotifier.togglePasswordVisibility();
          },
        ),
        onChanged: (value) {
          loginNotifier.updatePassword(value);
        });
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
