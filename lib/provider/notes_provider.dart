import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/notes_model.dart';

class NoteProvider extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.3:3000/notes'; 

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addNote(NotesModel note) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(note.toMap()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        _errorMessage = 'Gagal menambahkan note';
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan koneksi';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}