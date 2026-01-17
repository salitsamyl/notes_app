import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/notes_provider.dart';
import 'screen/addnote.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddNotePage() 
    );
  }
}