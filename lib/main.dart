import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/add_note.dart';
import 'package:notes_app/screens/detail.dart'; 
import 'package:notes_app/screens/edit.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/auth_provider.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/register.dart';
import 'package:notes_app/screens/dashboard.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/dashboard': (_) => Dashboard(),
        '/create': (_) => const AddNotePage(),
      },

      onGenerateRoute: (settings) {
        // detail
        if (settings.name == '/detail') {
          final note = settings.arguments as NotesModel;
          return MaterialPageRoute(
            builder: (_) => DetailPage(note: note),
          );
        }

        // edit
        if (settings.name == '/edit') {
          final note = settings.arguments as NotesModel;
          return MaterialPageRoute(
            builder: (_) => EditPage(note: note),
          );
        }
        return null;
      },
    );
  }
}