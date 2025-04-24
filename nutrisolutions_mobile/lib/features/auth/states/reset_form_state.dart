// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetFormState {
  final String? email;
  final String oldPassword;
  final String? newPasswordErrorMessage;
  final String? confirmPasswordErrorMessage;
  final String? newPasswordStrengthLevel;
  final String newPassword;
  final String confirmPassword;
  final bool obscureConfirmPassword;
  final bool obscureNewPassword;
  final bool obscureOldPassword;
  final bool isLoading;

  const ResetFormState(
      {this.email,
      this.oldPassword = '',
      this.newPassword = '',
      this.confirmPassword = '',
      this.newPasswordErrorMessage,
      this.newPasswordStrengthLevel,
      this.confirmPasswordErrorMessage,
      this.obscureConfirmPassword = true,
      this.obscureNewPassword = true,
      this.obscureOldPassword = true,
      this.isLoading = false});

  ResetFormState copyWith(
      {String? email,
      String? oldPassword,
      String? newPassword,
      String? confirmPassword,
      String? oldPasswordErrorMessage,
      String? newPasswordErrorMessage,
      String? newPasswordStrengthLevel,
      String? confirmPasswordErrorMessage,
      bool? obscureConfirmPassword,
      bool? obscureNewPassword,
      bool? obscureOldPassword,
      bool? isLoading}) {
    return ResetFormState(
        email: email ?? this.email,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        newPasswordErrorMessage:
            newPasswordErrorMessage ?? this.newPasswordErrorMessage,
        newPasswordStrengthLevel:
            newPasswordStrengthLevel ?? this.newPasswordStrengthLevel,
        confirmPasswordErrorMessage:
            confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
        obscureConfirmPassword:
            obscureConfirmPassword ?? this.obscureConfirmPassword,
        obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
        obscureOldPassword: obscureOldPassword ?? this.obscureOldPassword,
        isLoading: isLoading ?? this.isLoading);
  }

  Map<String, dynamic> toMap() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
      'obscureConfirmPassword': obscureConfirmPassword,
      'obscureNewPassword': obscureNewPassword,
      'obscureOldPassword': obscureOldPassword,
    };
  }

  factory ResetFormState.fromMap(Map<String, dynamic> map) {
    return ResetFormState(
      oldPassword: map['oldPassword'] as String? ?? '',
      newPassword: map['newPassword'] as String? ?? '',
      confirmPassword: map['confirmPassword'] as String? ?? '',
      obscureConfirmPassword: map['obscureConfirmPassword'] as bool? ?? true,
      obscureNewPassword: map['obscureNewPassword'] as bool? ?? true,
      obscureOldPassword: map['obscureOldPassword'] as bool? ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetFormState.fromJson(String source) =>
      ResetFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResetFormState(oldPassword: $oldPassword, newPassword: $newPassword, confirmPassword: $confirmPassword, obscureConfirmPassword: $obscureConfirmPassword, obscureNewPassword: $obscureNewPassword, obscureOldPassword: $obscureOldPassword)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResetFormState &&
        other.oldPassword == oldPassword &&
        other.newPassword == newPassword &&
        other.confirmPassword == confirmPassword &&
        other.obscureConfirmPassword == obscureConfirmPassword &&
        other.obscureNewPassword == obscureNewPassword &&
        other.obscureOldPassword == obscureOldPassword;
  }

  @override
  int get hashCode {
    return oldPassword.hashCode ^
        newPassword.hashCode ^
        confirmPassword.hashCode ^
        obscureConfirmPassword.hashCode ^
        obscureNewPassword.hashCode ^
        obscureOldPassword.hashCode;
  }
}
