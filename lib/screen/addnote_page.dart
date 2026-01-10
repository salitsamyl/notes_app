import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/model/notes_model.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() async {
    final note = NotesModel(
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now().toString().substring(0, 10),
      userId: 1, 
    );

    await Provider.of<NoteProvider>(context, listen: false)
        .addNote(note);

    _titleController.clear();
    _contentController.clear();
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
        title: Center(
          child: Text('Add Note', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.purple.shade100,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),
            TextField(
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
          onPressed: (_saveNote),
          backgroundColor: Colors.purple.shade100,
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}