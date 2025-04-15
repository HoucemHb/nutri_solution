import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/login_form_state.dart';

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  void updateEmail(String value) {
    state = state.copyWith(email: value, errorMessage: null);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, errorMessage: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<void> submitLogin() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Fake delay to simulate API call
    await Future.delayed(Duration(seconds: 2));

    if (state.email == "test@example.com" && state.password == "123456") {
      // success
      state = state.copyWith(isLoading: false);
    } else {
      // failure
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Invalid credentials",
      );
    }
  }
}

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});
