import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/utils/validators.dart';

import '../states/login_form_state.dart';

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  void updateEmail(String value) {
    state = state.copyWith(email: value);
    final validationResult = AppValidators.validateEmail(value);
    state = state.copyWith(emailErrorMessage: validationResult);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
    final validationResult = AppValidators.validatePassword(value);

    state = state.copyWith(
      passwordErrorMessage: validationResult,
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void updateRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  Future<void> submitLogin() async {
    state = state.copyWith(isLoading: true);

    // Fake delay to simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (state.email == "test@example.com" && state.password == "123456") {
      // success
      state = state.copyWith(isLoading: false);
    } else {
      // failure
      state = state.copyWith(
        isLoading: false,
        // errorMessage: "Invalid credentials",
      );
    }
  }
}

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});
