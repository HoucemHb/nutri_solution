import 'dart:convert';

class LoginFormState {
  final String email;
  final String password;
  final bool isLoading;
  final bool obscurePassword;
  final bool rememberMe;
  final String? errorMessage;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.obscurePassword = true,
    this.rememberMe = false,
    this.errorMessage,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
    bool? rememberMe,
    String? errorMessage,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'isLoading': isLoading,
      'obscurePassword': obscurePassword,
      'rememberMe': rememberMe,
      'errorMessage': errorMessage,
    };
  }

  factory LoginFormState.fromMap(Map<String, dynamic> map) {
    return LoginFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      isLoading: map['isLoading'] as bool,
      obscurePassword: map['obscurePassword'] as bool,
      rememberMe: map['rememberMe'] as bool,
      errorMessage: map['errorMessage'] != null ? map['errorMessage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginFormState.fromJson(String source) => LoginFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginFormState(email: $email, password: $password, isLoading: $isLoading, obscurePassword: $obscurePassword, rememberMe: $rememberMe, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(covariant LoginFormState other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.isLoading == isLoading &&
      other.obscurePassword == obscurePassword &&
      other.rememberMe == rememberMe &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      isLoading.hashCode ^
      obscurePassword.hashCode ^
      rememberMe.hashCode ^
      errorMessage.hashCode;
  }
}
