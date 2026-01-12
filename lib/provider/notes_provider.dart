import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/notes_model.dart';


class NotesProvider extends ChangeNotifier {
  List<NotesModel> notes = [];

  Future<void> getNotesByUser(int userId) async {
    final response = await http.get(
      Uri.parse("http://192.168.0.167:4000/notes/notes?userId=$userId"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      notes = data.map((e) => NotesModel.fromMap(e)).toList();
      notifyListeners();
    } else {
      print("Failled : ${response.statusCode}");
    }
  }
}
