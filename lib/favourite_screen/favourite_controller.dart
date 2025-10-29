import 'package:get/get.dart';
import 'package:personal_notes/note_model.dart';
import 'package:hive/hive.dart';

class FavouriteController extends GetxController {
  final Box<NoteModel> favBox = Hive.box<NoteModel>("favourites");
  var favouriteNotes = <NoteModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadFavourites();
  }

  void loadFavourites() {
    favouriteNotes.value = favBox.values.toList();
  }

  void toggleFavourite(NoteModel note) {
    if (isFavourite(note)) {
      final index = favBox.values.toList().indexWhere(
        (n) => n.title == note.title && n.Content == note.Content,
      );
      if (index != -1) {
        favBox.deleteAt(index);
        favouriteNotes.removeAt(index);
      }
    } else {
      favBox.add(note);
      favouriteNotes.add(note);
    }
    favouriteNotes.refresh();
    update();
  }

  bool isFavourite(NoteModel note) {
    return favouriteNotes.any(
      (n) => n.title == note.title && n.Content == note.Content,
    );
  }
}
