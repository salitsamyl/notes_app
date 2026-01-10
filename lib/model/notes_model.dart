import 'dart:convert';

import 'package:flutter/widgets.dart';

class NotesModel {
  int? id;
  String title;
  String content;
  String date;
  int userId;
  NotesModel({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
  });

  NotesModel copyWith({
    ValueGetter<int?>? id,
    String? title,
    String? content,
    String? date,
    int? userId,
  }) {
    return NotesModel(
      id: id != null ? id() : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'userId': userId,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) => NotesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotesModel(id: $id, title: $title, content: $content, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotesModel &&
      other.id == id &&
      other.title == title &&
      other.content == content &&
      other.date == date &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      date.hashCode ^
      userId.hashCode;
  }
}
  