import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propup/widgets/edit_profile_widgets.dart';
import 'package:propup/widgets/friend_request_widgets.dart';
import 'package:propup/widgets/friends_profile_screen_widgets.dart';

//ignore:camel_case_types
class myProfileScreen extends StatelessWidget {
  const myProfileScreen({super.key});

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final usersStore = FirebaseFirestore.instance.collection("users");
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              centerTitle: true,
              pinned: true,
              title: Text(
                "My profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 90,
                backgroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser?.photoURL ??
                    "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg"),
              )),
              Center(
                  child: StreamBuilder(
                stream: usersStore.doc(auth.currentUser?.uid).snapshots(),
                builder: (context, snap) {
                  if (snap.hasError) {
                    return const Text(
                      "Error retriving data",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  if (snap.hasData) {
                    if (snap.data != null) {
                      return Text(
                        snap.data?.get("username"),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
              const friendLocationWidget(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: StreamBuilder(
                      stream: usersStore.doc(auth.currentUser?.uid).snapshots(),
                      builder: (context, snap) {
                        if (snap.hasError) {
                          return const Text(
                            "Error retriving info",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        if (snap.hasData) {
                          if (snap.data != null) {
                            return Text(
                              snap.data?.get("description"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 19),
                              textAlign: TextAlign.center,
                            );
                          }
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
              const SizedBox(
                height: 30,
              ),
              // requestOptionsRowWidget(),
              const mySummaryWidget(),
              const SizedBox(
                height: 10,
              ),
              const editOptionsWidget(),

              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "Photos",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(
                    thickness: 1,
                  )),
            ])),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 150),
              delegate: SliverChildListDelegate.fixed(List.generate(
                  images.length,
                  (index) => Container(
                        decoration: BoxDecoration(
                            //color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(images[index]))),
                      ))),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () async{
          final imagePicker = ImagePicker();
          final imageFile = await imagePicker.pickImage(
            source: ImageSource.gallery);

            final file = File(imageFile!.path);
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.add, color: Colors.black,),
        ),
      ),
    );
  }
}
