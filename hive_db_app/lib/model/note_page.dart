import 'package:hive/hive.dart';

part 'note_page.g.dart';

@HiveType(typeId: 1)
class NotesScreen {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? discription;

  NotesScreen({required this.title, required this.discription});
}
