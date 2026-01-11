import 'package:flutter/material.dart';
import 'package:notes_app/screens/dashboard.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: LoginPage(), 
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}