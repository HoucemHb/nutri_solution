abstract class HasLabel {
  String get label;
}

class AppUtils {
  static String getErrorMessage(dynamic error) {
    try {
      if (error is String) return error;
      if (error is Map<String, dynamic>) {
        return error['error']?['message'] ?? 'An error occurred';
      }
      if (error is Exception) {
        return error.toString();
      }
      return 'An unexpected error occurred';
    } catch (e) {
      return 'An error occurred';
    }
  }

  static T? convertToEnum<T extends HasLabel>(
      List<T> enumValues, String value) {
    try {
      return enumValues.firstWhere(
        (e) => e.label.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  static double getBMI(int weight, int height) {
    int weightKg = weight;
    double heightM = height / 100; // Convert height to meters
    double bmi = weightKg / (heightM * heightM);
    return bmi;
  }

  static String getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Healthy';
    } else {
      return 'Not Healthy';
    }
  }
}
