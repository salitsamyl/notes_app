import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:provider/provider.dart';
import '../provider/notes_provider.dart';

class DetailPage extends StatefulWidget {
  final NotesModel note;

  const DetailPage({super.key, required this.note});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late NotesModel currentNote;

  @override
  void initState() {
    super.initState();
    currentNote = widget.note;
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Hapus Catatan'),
        content: Text('Yakin ingin menghapus catatan ini?'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await Provider.of<NotesProvider>(
                context,
                listen: false,
              ).deleteNote(currentNote.id!);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Catatan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade100,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentNote.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(currentNote.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Tanggal: ${currentNote.date}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade100,
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () async {
          final updatedNote = await Navigator.pushNamed(
            context,
            '/edit',
            arguments: currentNote,
          );

          if (updatedNote != null && updatedNote is NotesModel) {
            setState(() {
              currentNote = updatedNote;
            });

            // 🔔 ALERT DIALOG BERHASIL UPDATE
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Berhasil"),
                content: Text("Catatan berhasil diperbarui."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
