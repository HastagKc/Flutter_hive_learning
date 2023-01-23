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
        centerTitle: true,
        title: const Text("Create Notes"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        //function is need
        valueListenable: Boxes.getData().listenable(),
        builder: (context, Box box, child) {
          //<----------------//------------------
          // casting box data in list
          var data = box.values.toList().cast<NotesModel>();

          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No Notes  is aviabile at the moments",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            );
          } else {
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
                        Row(
                          children: [
                            Text(
                              data[index].title.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _updatesNotesDialog(
                                    data[index],
                                    data[index].title.toString(),
                                    data[index].Desc.toString());
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                // calling delete function
                                delete(data[index]);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
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
              },
            );
          }
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

// deleting data
  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

// reading data
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
                if (titleController.text != '' || descController.text != "") {
                  final data = NotesModel(
                      title: titleController.text, Desc: descController.text);
                  // calling boxes class and creating box as an referenital variable
                  final box = Boxes.getData();
                  box.add(data);
                  data.save();

                  titleController.clear();
                  descController.clear();

                  Navigator.pop(context);
                }
              },
              child: const Text("Add new notes"),
            ),
          ],
        );
      },
    );
  }

// updating data
  Future<void> _updatesNotesDialog(
      NotesModel notesModel, String title, String disc) async {
    titleController.text = title;
    descController.text = disc;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edits Notes"),
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
              onPressed: () async {
                notesModel.title = titleController.text.toString();
                notesModel.Desc = descController.text.toString();
                await notesModel.save();

                Navigator.pop(context);
              },
              child: const Text("Update notes"),
            ),
          ],
        );
      },
    );
  }
}
