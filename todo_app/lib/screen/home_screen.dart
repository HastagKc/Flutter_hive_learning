import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/screen/add_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoBox = Hive.box('BoxTodo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('TodoApp'),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box box, child) {
          if (box.isEmpty) {
            return const Center(
              child: Text("No todo task is available"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: box.length,
                    itemBuilder: ((context, index) {
                      TodoModel todo = box.getAt(index);
                      return Card(
                        color: (todo.isComplete)! ? Colors.green : Colors.red,
                        elevation: 5.0,
                        child: ListTile(
                          title: Text(
                            todo.task.toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              decoration: (todo.isComplete)!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isComplete,
                            onChanged: (value) {
                              TodoModel newTodo = TodoModel(
                                  task: todo.task, isComplete: value!);
                              box.putAt(index, newTodo);
                            },
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              box.deleteAt(index);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Todo Task is deleted sucessfully !"),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
