import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  String? task;

  @HiveField(1)
  bool? isComplete;

  TodoModel({required this.task, required this.isComplete});
}
