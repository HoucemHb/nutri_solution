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

static T? convertToEnum<T extends HasLabel>(List<T> enumValues, String value) {
  try {
    return enumValues.firstWhere(
      (e) => e.label.toLowerCase() == value.toLowerCase(),
    );
  } catch (_) {
    return null;
  }
}

}
