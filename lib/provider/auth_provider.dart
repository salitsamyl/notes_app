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

  try {
    final success = await AuthService.login(
      email: email,
      password: password,
    );

    if (!success) {
      errorMessage = 'Email atau password anda salah';
    }

    return success; 
  } catch (e) {
    errorMessage = 'Tidak dapat terhubung ke server';
    return false;
  } finally {
    isLoading = false;
    notifyListeners();
  }
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

    isLoading = false;

    if (!success) {
      errorMessage = 'Email yang Anda masukkan sudah terdaftar';
    }

    notifyListeners();
    return success;
  }
}
