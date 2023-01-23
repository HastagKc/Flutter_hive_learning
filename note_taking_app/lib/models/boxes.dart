import 'package:hive/hive.dart';
import 'package:note_taking_app/models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box('Notes');
}
