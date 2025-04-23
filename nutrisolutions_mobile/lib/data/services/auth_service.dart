import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/data/models/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_utils.dart';

class AuthService {
  final String _baseUrl = '${AppApi.baseUrl}/auth';

  Future<ClientModel?> login({String email = '', String password = ''}) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = json['accessToken'];
      final user = ClientModel.fromJson(json['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.tokenLocalStorage, token);
      await prefs.setString(AppConstants.payloadIdKey, user.id ?? '');
      await prefs.setString(AppConstants.nameLocalStorage, user.name);

      return user;
    }
    return null;
  }

  Future<void> signup(ClientModel user) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(
      url,
      body: user.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(AppUtils.getErrorMessage(response.body));
    } else {
      login(
        email: user.email,
        password: user.password,
      );
    }
  }

  Future<void> resetPasswordRequest(String email) async {
    final url = Uri.parse('$_baseUrl/request-password-reset');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Erreur lors de la requête');
    }
  }

  Future<void> resetPassword(
      String token, String oldPassword, String newPassword) async {
    final url = Uri.parse('$_baseUrl/reset-password');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Erreur inconnue');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isAuthenticated) ?? false;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.payloadIdKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.nameLocalStorage);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenLocalStorage);
  }
}
