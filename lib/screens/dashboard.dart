import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();

  // mengambil data di dalam API
  Future.microtask(() {
      Provider.of<NotesProvider>(context, listen: false).getNotesByUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
        child: Text("Dashboard",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
        backgroundColor: Colors.purple.shade100,),

        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "/create");
            if (result == true) {
              await Provider.of<NotesProvider>(context, listen: false).getNotesByUser();

              // menambahkan alert ketika menambahkan notes
              showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Berhasil'),
                content:Text('Catatan berhasil ditambahkan'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
            setState(() {});
            }
          },

          backgroundColor: Colors.purple.shade100,
          child: Icon(Icons.add, color: Colors.white),
        ),

        body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: provider.notes.length,
          itemBuilder: (context, index) {
            final note = provider.notes[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/detail", arguments: note);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade100.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        note.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}