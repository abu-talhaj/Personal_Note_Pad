import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:personal_notes/note_model.dart';

class NoteController extends GetxController {
  final Box<NoteModel> box = Hive.box<NoteModel>("notes");

  void addNote(NoteModel note) {
    box.add(note);
    update();
  }

  void UpdateNote(int index, NoteModel note) {
    box.putAt(index, note);
    update();
  }

  void DeleteNote(int index) {
    box.deleteAt(index);
    update();
  }
}
