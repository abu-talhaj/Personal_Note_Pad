import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_notes/favourite_screen/favorite_screen.dart';
import 'package:personal_notes/note_controller.dart';
import 'package:personal_notes/note_model.dart';
import 'package:personal_notes/note_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({super.key});

  NoteController noteController = Get.put(NoteController());

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> pages = [NoteScreen(), FavoriteScreen()];
  final TextEditingController titleClt = TextEditingController();
  final TextEditingController cntentClt = TextEditingController();
  final NoteController noteController = Get.find<NoteController>();

  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleClt.dispose();
    cntentClt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          viewDialouge();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_rounded),
            label: "notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favorites",
          ),
        ],
      ),
    );
  }

  viewDialouge() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Colors.purple,
              content: Column(
                children: [
                  TextField(
                    controller: titleClt,
                    style: TextStyle(color: Colors.white),
                    maxLength: 20,
                    decoration: InputDecoration(
                      hintText: 'Title name',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    controller: cntentClt,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('Save'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (titleClt.text.isNotEmpty &&
                            cntentClt.text.isNotEmpty) {
                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat(
                            'yyyy-MM-dd HH:mm:ss',
                          ).format(now);

                          NoteModel note = NoteModel(
                            date: formattedDate,
                            title: titleClt.text,
                            Content: cntentClt.text,
                          );
                          noteController.addNote(note);
                          titleClt.clear();
                          cntentClt.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
