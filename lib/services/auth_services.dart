import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:3000/users';

  // REGISTER
  static Future<bool> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    try {

      // Cek email
      final check = await http.get(Uri.parse('$baseUrl?email=$email'));

      final List data = jsonDecode(check.body);
      if (data.isNotEmpty) {
        return false; 
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  // LOGIN
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
      throw Exception('NETWORK_ERROR');
    }
  }
}
