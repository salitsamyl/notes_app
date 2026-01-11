import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes_app/models/user_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.1.12:3000/users';

  static Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?email=$email&password=$password'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.isNotEmpty;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
