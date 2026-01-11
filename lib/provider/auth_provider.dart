import 'package:flutter/material.dart';
import 'package:notes_app/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  // LOGIN
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final success = await AuthService.login(
      email: email,
      password: password,
    );

    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;

    if (!success) {
      errorMessage = 'Email atau password anda salah';
    }

    notifyListeners();
    return success;
  }

  // REGISTER
  Future<bool> register(
    String username,
    String name,
    String email,
    String password,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final success = await AuthService.register(
      username: username,
      name: name,
      email: email,
      password: password,
    );

    await Future.delayed(const Duration(seconds: 1));

    isLoading = false;

    if (!success) {
      errorMessage = 'Registrasi gagal, coba lagi!';
    }

    notifyListeners();
    return success;
  }
}
