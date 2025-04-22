import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/input_template_widgets.dart';

class OldPasswordField extends ConsumerWidget {
  final bool obscureText;
  const OldPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordNotifier = ref.read(resetFormProvider.notifier);

    return PasswordTemplate(
      labelText: 'Old Password',
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
    final resetFormState = ref.watch(resetFormProvider);

    return PasswordTemplate(
      labelText: 'New Password',
      hintText: 'Enter new password',
      obscureText: obscureText,
      onToggleVisibility: resetPasswordNotifier.toggleNewPasswordVisibility,
      onChanged: resetPasswordNotifier.updateNewPassword,
      isError: (resetFormState.newPasswordErrorMessage != AppConstants.valid) &&
          (resetFormState.newPasswordErrorMessage != null),
      noteText: resetFormState.newPasswordErrorMessage != AppConstants.valid
          ? resetFormState.newPasswordErrorMessage
          : resetFormState.newPasswordStrengthLevel,
    );
  }
}

class ConfirmPasswordField extends ConsumerWidget {
  final bool obscureText;
  const ConfirmPasswordField({required this.obscureText, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordNotifier = ref.read(resetFormProvider.notifier);
    final resetFormState = ref.watch(resetFormProvider);

    return PasswordTemplate(
        labelText: 'Confirm Password',
        hintText: 'Enter Confirm password',
        obscureText: obscureText,
        onToggleVisibility:
            resetPasswordNotifier.toggleConfirmPasswordVisibility,
        onChanged: resetPasswordNotifier.updateConfirmPassword,
        isError: (resetFormState.confirmPasswordErrorMessage !=
                AppConstants.valid) &&
            (resetFormState.confirmPasswordErrorMessage != null),
        noteText: resetFormState.confirmPasswordErrorMessage);
  }
}
