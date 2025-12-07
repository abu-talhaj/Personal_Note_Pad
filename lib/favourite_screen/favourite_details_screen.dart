import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:personal_notes/note_model.dart';
import 'package:share_plus/share_plus.dart';

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
        backgroundColor: Colors.purple,
        title: Text(
          "Note Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
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
            Divider(color: Colors.purple),
            Center(
              child: Text(
                note.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(color: Colors.purple),
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
