class Notes {
  int? id;
  String title;
  String content;
  String date;
  int userId;

  Notes ({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'userId': userId,
    };
  }
}
