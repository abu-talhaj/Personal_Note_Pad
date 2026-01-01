import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        return ListView.separated(
          itemCount: favController.favouriteNotes.length,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              color: Colors.brown[100],
              indent: 16,
              endIndent: 16,
            );
          },
          itemBuilder: (context, index) {
            final not = favController.favouriteNotes[index];
            return ListTile(
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
                  Fluttertoast.showToast(
                    msg: "remove favourite note successful",
                  );
                },
                icon: Icon(Icons.favorite, color: Colors.brown),
              ),
              onTap: () {
                Get.to(() => FavouriteDetailsScreen(not));
              },
            );
          },
        );
      }),
    );
  }
}
