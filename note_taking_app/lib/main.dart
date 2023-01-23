import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_taking_app/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

// register hive
  Hive.registerAdapter(NotesModelAdapter());
  // open Box
  await Hive.openBox<NotesModel>('Notes');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Notes app",
      home: HomeScreen(),
    );
  }
}
