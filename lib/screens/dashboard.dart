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
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
        child: Text("Dashboard",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
        backgroundColor: Colors.purple.shade100,),

        body: ListView(),
    );
  }
}