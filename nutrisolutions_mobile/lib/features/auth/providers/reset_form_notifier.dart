import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/utils/validators.dart';

import '../states/reset_form_state.dart';

class ResetFormNotifier extends StateNotifier<ResetFormState> {
  ResetFormNotifier() : super(const ResetFormState());

  void updateEmailAddress(String email) {
    state = state.copyWith(email: email);
  }

  void updateOldPassword(String value) {
    state = state.copyWith(oldPassword: value);
  }

  void updateNewPassword(String value) {
    state = state.copyWith(newPassword: value);
    final validationResult = AppValidators.validatePassword(value);
    final passwordStrengthLevel = AppValidators.validatePasswordStrength(value);
    state = state.copyWith(
        newPasswordErrorMessage: validationResult,
        newPasswordStrengthLevel: passwordStrengthLevel);
  }

  void toggleOldPasswordVisibility() {
    state = state.copyWith(obscureOldPassword: !state.obscureOldPassword);
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
  }

  void toggleConfirmPasswordVisibility() {
    state =
        state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
    final validationResult =
        AppValidators.validateConfirmPassword(state.newPassword, value);
    state = state.copyWith(confirmPasswordErrorMessage: validationResult);
  }

  Future<void> submitReset() async {
    // Add validation logic if needed
    if (state.newPassword != state.confirmPassword) {
      throw Exception("New password and confirm password do not match");
    }

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Reset state after successful submission
    state = const ResetFormState(
      oldPassword: '',
      newPassword: '',
      confirmPassword: '',
    );
  }
}

final resetFormProvider =
    StateNotifierProvider<ResetFormNotifier, ResetFormState>((ref) {
  return ResetFormNotifier();
});
