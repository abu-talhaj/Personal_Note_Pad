import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:personal_notes/note_controller.dart';
import 'package:personal_notes/note_details_screen.dart';
import 'package:personal_notes/note_model.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  final NoteController noteController = Get.find<NoteController>();
  final TextEditingController titleClt = TextEditingController();
  final TextEditingController cntentClt = TextEditingController();

  // final Box box = Hive.box("notes");
  final Box<NoteModel> box = Hive.box<NoteModel>("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.purpleAccent,
        title: Center(
          child: Text(
            "My Notes",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return GetBuilder<NoteController>(
            builder: (_) {
              return box.keys.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.note), Text("Empty notes")],
                      ),
                    )
                  : ListView.separated(
                      // itemCount: box.length,
                      itemCount: box.keys.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.brown[50],
                          indent: 20,
                          endIndent: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        final note = value.getAt(index) as NoteModel?;
                        if (note == null) {
                          return SizedBox.shrink();
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text((index + 1).toString()),
                          ),
                          title: Text(note.title.toString()),
                          subtitle: Text(note.Content.toString()),
                          trailing: SizedBox(
                            width: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    viewDialouge(context, index);
                                  },
                                  child: Icon(Icons.edit, color: Colors.purple),
                                ),
                                InkWell(
                                  onTap: () {
                                    noteController.DeleteNote(index);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.to(() => NoteDetailsScreen(note));
                          },
                        );
                      },
                    );
            },
          );
        },
      ),
    );
  }

  viewDialouge(context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: titleClt,
                    decoration: InputDecoration(hintText: 'Title name'),
                  ),
                  TextField(
                    controller: cntentClt,
                    decoration: InputDecoration(hintText: ' Description'),
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
                      ),
                    ),
                    TextButton(
                      child: Text('upDate'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
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
                          noteController.UpdateNote(index, note);
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
