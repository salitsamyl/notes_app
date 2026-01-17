import 'package:flutter/material.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:notes_app/model/user_model.dart';
import 'package:notes_app/services/session_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  // LOGIN
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      UserModel? user = await AuthService.login(
        email: email,
        password: password,
      );

      if (user == null) {
        errorMessage = 'Email atau password salah';
        return false;
      }

      // SIMPAN USER ID KE SESSION
      await SessionService.saveUserId(user.id!);

      return true;
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

    try {
      final success = await AuthService.register(
        username: username,
        name: name,
        email: email,
        password: password,
      );

      if (!success) {
        errorMessage = 'Email sudah terdaftar';
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

  //LOGOUT
  Future<void> logout() async {
    await SessionService.clearSession();
    notifyListeners();
  }
}
