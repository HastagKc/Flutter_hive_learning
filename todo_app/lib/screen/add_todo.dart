import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/model/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController taskController = TextEditingController();

// creating an instance of the box
  final todoBox = Hive.box('BoxTodo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(201, 99, 26, 148),
      appBar: (AppBar()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                // changing the colore of the text in textfield

                style: const TextStyle(color: Colors.white),
                controller: taskController,
                decoration: const InputDecoration(
                  label: Text("Enter Task"),
                  hintText: "Task",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (taskController.text != '') {
                            TodoModel newTodo = TodoModel(
                                task: taskController.text, isComplete: false);
                            todoBox.add(newTodo);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Add Task",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
