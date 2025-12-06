import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_notes/favourite_screen/favourite_controller.dart';
import 'package:personal_notes/favourite_screen/favourite_details_screen.dart';
import 'package:personal_notes/note_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavouriteController favController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (favController.favouriteNotes.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: Colors.black),
                Text("No favourite yet!!"),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: favController.favouriteNotes.length,
          itemBuilder: (context, index) {
            final not = favController.favouriteNotes[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(not.title, maxLines: 1),
                subtitle: Text(
                  not.Content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () {
                    favController.toggleFavourite(not);
                  },
                  icon: Icon(Icons.favorite, color: Colors.redAccent),
                ),
                onTap: () {
                  Get.to(() => FavouriteDetailsScreen(not));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
