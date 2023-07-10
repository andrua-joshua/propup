import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propup/bloc/posts_update_and_retrival.dart';
import 'package:propup/routes.dart';
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
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final auth = FirebaseAuth.instance;
    final storageRf = FirebaseStorage.instance.ref();

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: postsStore.snapshots(),
            builder: (context, snap) {
              return CustomScrollView(
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
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: StreamBuilder(
                            stream: usersStore
                                .doc(auth.currentUser?.uid)
                                .snapshots(),
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
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
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
                      height: 20,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 150),
                    delegate: SliverChildListDelegate((snap.hasData)
                        ? List.generate(
                            snap.data?.docs
                                    .where((element) =>
                                        element.get("owner") ==
                                        auth.currentUser?.uid)
                                    .length ??
                                0,
                            (index) => FutureBuilder<String>(
                                future: storageRf
                                    .child("posts/" + snap.data!.docs[index].id)
                                    .getDownloadURL(),
                                builder: (context, value) {
                                  if (value.hasData) {
                                    return GestureDetector(
                                      onTap: (){
                                        RouteGenerator.src = snap.data!.docs[index].id;

                                        Navigator.pushNamed(context, RouteGenerator.personalPostsReviewscreen);
                                      },
                                        child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  value.data ?? ""))),
                                    ));
                                  }
                                  if (value.hasError) {
                                    return const Text(
                                      "(*_*)",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }

                                  return const Center(
                                      child: CircularProgressIndicator());
                                }))
                        : (snap.hasError)
                            ? [
                                const Text(
                                  "Error retriving photos",
                                  style: TextStyle(color: Colors.redAccent),
                                )
                              ]
                            : [
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              ]),
                  )
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {
          postsUpdateAndRetrival.addPost().then((value) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("upload progress"),
                    content: StreamBuilder(
                        stream: value.snapshotEvents,
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return const Text(
                              "error connecting",
                              style: TextStyle(color: Colors.red),
                            );
                          }

                          if (((snap.data?.bytesTransferred ?? 0) /
                                  (snap.data?.totalBytes ?? 1)) ==
                              1) {
                            postsStore
                                .     doc(postsUpdateAndRetrival.post_Name)
                                .set({
                              "owner": postsUpdateAndRetrival.user?.uid,
                              "likes": 0
                            });
                            Navigator.pop(context);
                          }

                          return SizedBox(
                              height: 200,
                              width: 200,
                              child: Center(
                                  child: CircularProgressIndicator(
                                value: (snap.data?.bytesTransferred ?? 0) /
                                    (snap.data?.totalBytes ?? 1),
                                color: Colors.lightGreen,
                                backgroundColor: Colors.grey,
                              )));
                        }),
                  );
                });
          });
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          padding: const EdgeInsets.all(3),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
