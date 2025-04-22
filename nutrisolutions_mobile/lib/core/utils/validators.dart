import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';

class AppValidators {
  static final Map<String, RegExp> passwordStrengthLevels = {
    'strong': RegExp(
        r'^(?=.*[A-Z])(?=.*[!@/#$&*])(?=.*[0-9])(?=(?:.*[a-z]){5,}).{8,}$'),
    'normal': RegExp(r'^(?=.*[A-Z]|(?=.*[!@#$&*/])|(?=.*[0-9])).{8,}$'),
  };
  static String validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required..';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email..';
    }
    return AppConstants.valid;
  }

  static String validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required..';
    }
    if (value.length < 6) {
      return 'Minimum length is 8..';
    }
    return AppConstants.valid;
  }

  static String validatePasswordStrength(String value) {
    if (passwordStrengthLevels['strong']!.hasMatch(value)) return 'Strong..';
    if (passwordStrengthLevels['normal']!.hasMatch(value)) return 'Normal..';
    return 'Weak..';
  }

  static String validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Required..';
    }
    if (password != confirmPassword) {
      return 'Mismatch..';
    }
    return AppConstants.valid;
  }
}
