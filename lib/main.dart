import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_notes/bottom_nav_bar_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_notes/favourite_screen/favourite_controller.dart';
import 'package:personal_notes/note_controller.dart';
import 'package:personal_notes/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>("notes");

  await Hive.openBox<NoteModel>("favourites");

  Get.put(NoteController());
  Get.put(FavouriteController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBarScreen(),
    );
  }
}
