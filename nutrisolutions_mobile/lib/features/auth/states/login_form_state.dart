// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nutrisolutions_mobile/data/models/client_model.dart';

class LoginFormState {
  final String email;
  final String password;
  final bool isLoading;
  final bool obscurePassword;
  final bool rememberMe;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.obscurePassword = true,
    this.rememberMe = false,
    this.emailErrorMessage,
    this.passwordErrorMessage,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
    bool? rememberMe,
    String? emailErrorMessage,
    String? passwordErrorMessage,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
    );
  }

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'isLoading': isLoading,
      'obscurePassword': obscurePassword,
      'rememberMe': rememberMe,
      'emailErrorMessage': emailErrorMessage,
      'passwordErrorMessage': passwordErrorMessage,
    };
  }

  factory LoginFormState.fromMap(Map<String, dynamic> map) {
    return LoginFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      isLoading: map['isLoading'] as bool,
      obscurePassword: map['obscurePassword'] as bool,
      rememberMe: map['rememberMe'] as bool,
      emailErrorMessage: map['emailErrorMessage'] != null
          ? map['emailErrorMessage'] as String
          : null,
      passwordErrorMessage: map['passwordErrorMessage'] != null
          ? map['passwordErrorMessage'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginFormState.fromJson(String source) =>
      LoginFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginFormState(email: $email, password: $password, isLoading: $isLoading, obscurePassword: $obscurePassword, rememberMe: $rememberMe, emailErrorMessage: $emailErrorMessage, passwordErrorMessage: $passwordErrorMessage)';
  }

  @override
  bool operator ==(covariant LoginFormState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.isLoading == isLoading &&
        other.obscurePassword == obscurePassword &&
        other.rememberMe == rememberMe &&
        other.emailErrorMessage == emailErrorMessage &&
        other.passwordErrorMessage == passwordErrorMessage;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        isLoading.hashCode ^
        obscurePassword.hashCode ^
        rememberMe.hashCode ^
        emailErrorMessage.hashCode ^
        passwordErrorMessage.hashCode;
  }
}
