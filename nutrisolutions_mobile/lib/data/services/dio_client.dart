import 'package:dio/dio.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;

  // Constructor accepts baseUrl and creates Dio with the provided baseUrl
  DioClient({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the token from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString(
            AppConstants.tokenLocalStorage); // Retrieve the stored token

        if (token != null) {
          options.headers['Authorization'] =
              'Bearer $token'; // Add token to request header
        }
        return handler.next(options); // Continue with the request
      },
      onError: (DioException error, handler) {
        return handler.next(error); // Continue with the error
      },
      onResponse: (response, handler) {
        return handler.next(response); // Continue with the response
      },
    ));
  }

  Dio get dio => _dio;
}
