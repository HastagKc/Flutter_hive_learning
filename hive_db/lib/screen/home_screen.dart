import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var boxName = Hive.box('testBox');
  String? name;

  createContent() async {
    await boxName.put('Name', "Krishna");
    setState(() {
      name = boxName.get('Name');
    });
  }

  getContent() async {
    setState(() {
      name = boxName.get('Name');
    });
  }

  updateContent() async {
    await boxName.put('Name', "Dikamber");

    setState(() {
      name = boxName.get('Name');
    });
  }

  deleteContent() async {
    await boxName.delete('Name');
    setState(() {
      name = boxName.get('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testBox'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name.toString(),
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: createContent,
              child: const Text("Create"),
            ),
            ElevatedButton(
              onPressed: getContent,
              child: const Text("Read"),
            ),
            ElevatedButton(
              onPressed: updateContent,
              child: const Text("Update"),
            ),
            ElevatedButton(
              onPressed: deleteContent,
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
