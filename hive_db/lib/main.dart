import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationSupportDirectory();
  Hive.init(directory.path);
  var box = await Hive.openBox('testBox');

  box.put('name', 'David');

  print('Name: ${box.get('name')}');
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
      title: "Hive Db",
      home: HomeScreen(),
    );
  }
}
