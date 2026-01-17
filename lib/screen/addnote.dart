import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/services/session_service.dart';


class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // ALERT DIALOG
  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // simpan note 
  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    // validasi 
    if (title.isEmpty || content.isEmpty) {
      _showAlert('Warning', 'Judul dan isi tidak boleh kosong');
      return;
    }

    final userId = await SessionService.getUserId();

    final note = NotesModel(
      title: title,
      content: content,
      date: DateTime.now().toString().substring(0, 10),
      userId: userId!, 
    );

    await Provider.of<NotesProvider>(context, listen: false)
        .addNote(note);

    _titleController.clear();
    _contentController.clear();

    Navigator.pop(context, true);

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
        title: const Center(
          child: Text(
            'Add Note',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 15),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: FloatingActionButton(
          onPressed: _saveNote,
          backgroundColor: Colors.purple.shade100,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
