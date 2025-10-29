import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_notes/note_model.dart';

class FavouriteDetailsScreen extends StatelessWidget {
  FavouriteDetailsScreen(this.note);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Get.back,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        title: Text(
          "Favourite note details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              note.Content,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              note.date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
