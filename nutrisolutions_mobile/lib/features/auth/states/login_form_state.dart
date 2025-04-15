class LoginFormState {
  final String email;
  final String password;
  final bool isLoading;
  final bool obscurePassword;
  final String? errorMessage;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.obscurePassword = true,
    this.errorMessage,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
    String? errorMessage,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage: errorMessage,
    );
  }
}