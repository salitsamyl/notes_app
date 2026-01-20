import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/services/session_service.dart';

class NotesProvider extends ChangeNotifier {
  final String baseUrl = 'http://192.168.18.54:3000/notes';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<NotesModel> _notes = [];
  List<NotesModel> get notes => _notes;

  // Get notes by userID
  Future<void> getNotesByUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = await SessionService.getUserId();
      if (userId == null) throw Exception('User belum login');

      final response = await http.get(Uri.parse('$baseUrl?userId=$userId'));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _notes = data.map((e) => NotesModel.fromMap(e)).toList();
      } else {
        throw Exception('Gagal mengambil catatan');
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // add notes
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
        await getNotesByUser();
        return true;
      } else {
        _errorMessage = response.body;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // update notes
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    required String date,
    required int userId,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'content': content,
          'date': date,
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        await getNotesByUser();
      } else {
        throw Exception('Gagal update data');
      }
    } catch (e) {
      debugPrint("Error updateNote: $e");
    }
  }

  // delete notes
  Future<void> deleteNote(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        _notes.removeWhere((n) => n.id == id);
        notifyListeners();
      } else {
        throw Exception('Gagal hapus data');
      }
    } catch (e) {
      debugPrint("Error deleteNote: $e");
    }
  }
}
