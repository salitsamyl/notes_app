import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/user_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.1.16:3000/users';

  // REGISTER
  static Future<bool> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final check = await http.get(Uri.parse('$baseUrl?email=$email'));

      if (check.statusCode != 200) {
        throw Exception('SERVER_ERROR');
      }

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
      throw Exception('NETWORK_ERROR');
    }
  }

  // LOGIN 
  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'email': email,
          'password': password,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        if (data.isEmpty) return null;

        return UserModel.fromMap(data.first);
      }

      return null;
    } catch (e) {
      print('LOGIN ERROR: $e');
      throw Exception('NETWORK_ERROR');
    }
  }
}