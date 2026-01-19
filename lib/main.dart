import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/addnote.dart';
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
        '/create' : (_) => AddNotePage()
      },
    );
  }
}