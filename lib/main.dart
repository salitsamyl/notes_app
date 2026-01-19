import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/notes_provider.dart';
import 'screens/addnote.dart';
import 'services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // sementara 
 await SessionService.saveUserId(2);

 
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotesProvider())],
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
      initialRoute: '/create',

      routes: {'/create': (_) => const AddNotePage()},
    );
  }
}
