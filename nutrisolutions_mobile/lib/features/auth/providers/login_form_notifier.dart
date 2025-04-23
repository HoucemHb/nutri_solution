import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/utils/validators.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/client_model.dart';
import '../../../data/providers/auth_provider.dart';
import '../states/login_form_state.dart';

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Ref ref;
  LoginFormNotifier(this.ref) : super(const LoginFormState());

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

  Future<ClientModel?> submitLogin() async {
    state = state.copyWith(isLoading: true);

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.login(
        email: state.email,
        password: state.password,
      );
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e, stacktrace) {

      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  bool validateLoginForm() {
    return ((state.emailErrorMessage == AppConstants.valid) &&
        (state.passwordErrorMessage == AppConstants.valid));
  }
}

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier(ref);
});
