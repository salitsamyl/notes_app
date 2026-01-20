import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:provider/provider.dart';
import '../provider/notes_provider.dart';

class EditPage extends StatefulWidget {
  final NotesModel note;

  const EditPage({super.key, required this.note});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  void _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Warning'),
          content: Text('Judul dan isi tidak boleh kosong'),
        ),
      );
      return;
    }

    await Provider.of<NotesProvider>(context, listen: false).updateNote(
      id: widget.note.id!,
      title: title,
      content: content,
      date: widget.note.date,
      userId: widget.note.userId,
    );

    widget.note.title = title;
    widget.note.content = content;

    Navigator.pop(context, widget.note);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Catatan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade100,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade100,
        onPressed: _save,
        child: Icon(Icons.save),
      ),
    );
  }
}
