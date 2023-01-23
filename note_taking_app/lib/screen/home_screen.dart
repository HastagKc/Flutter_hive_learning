import 'package:flutter/material.dart';
import 'package:note_taking_app/models/boxes.dart';
import 'package:note_taking_app/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        //function is need
        valueListenable: Boxes.getData().listenable(),
        builder: (context, Box box, child) {
          //<----------------//------------------
          // casting box data in list
          var data = box.values.toList().cast<NotesModel>();

          return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          data[index].Desc.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNotesDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showNotesDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    hintText: "Enter Discription ",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final data = NotesModel(
                    title: titleController.text, Desc: descController.text);
                // calling boxes class and creating box as an referenital variable
                final box = Boxes.getData();
                box.add(data);
                data.save();

                titleController.clear();
                descController.clear();
              },
              child: const Text("Add new notes"),
            ),
          ],
        );
      },
    );
  }
}
