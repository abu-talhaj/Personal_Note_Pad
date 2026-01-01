import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:personal_notes/note_model.dart';
import 'package:share_plus/share_plus.dart';
import 'favourite_screen/favourite_controller.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NoteModel note;
  NoteDetailsScreen(this.note, {super.key});
  final FavouriteController favController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        title: Text(
          "Note Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            final isFav = favController.isFavourite(note);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.pink : Colors.white,
              ),
              onPressed: () {
                favController.toggleFavourite(note);

                Fluttertoast.showToast(
                  msg: isFav ? "Remove favourite" : "Added to favourite",
                );
              },
            );
          }),
          SizedBox(width: 15),
          InkWell(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: note.Content));
              Fluttertoast.showToast(msg: "Copied to clipboard");
            },
            child: Icon(Icons.copy, color: Colors.white),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () {
              Share.share(note.Content, subject: note.title);
            },
            child: Icon(Icons.share, color: Colors.white),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.purple, thickness: 2),
            Center(
              child: Text(
                note.title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Divider(color: Colors.purple, thickness: 2),
            SizedBox(height: 15.0),
            Text(
              note.Content,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 100.0),
            Divider(color: Colors.grey),
            Text(
              note.date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
