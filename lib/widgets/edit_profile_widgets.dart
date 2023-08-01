import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/user_data_update.dart';
import 'package:propup/routes.dart';
import 'package:propup/bloc/posts_update_and_retrival.dart';

///
///this is where all the custom widgets of the edit profile screen will be created from
///

//ignore:camel_case_types
class profilePicRowWidget extends StatelessWidget {
  const profilePicRowWidget({super.key});

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          profilePicWidget(),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            "Enter your name and add an optional profile picture",
            style: TextStyle(color: Colors.grey),
          ))
        ],
      );
}

//ignore:camel_case_types
class profilePicWidget extends StatelessWidget {
  const profilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return Column(
      children: [
        Card(
            elevation: 6,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: Center(
                child: StreamBuilder(
                  stream: user.snapshots(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(snap.data
                                ?.get("profilePic") ??"",maxHeight: 140, maxWidth: 140 ),
                      );
                    }

                    return const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey,
                    );
                  },
                ),
              ),
            )),
        TextButton(
            onPressed: () {
              //---------------------

              postsUpdateAndRetrival.addPost().then((value) async {
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
                                final user = FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(
                                        FirebaseAuth.instance.currentUser?.uid);

                                snap.data?.ref.getDownloadURL().then((url) =>
                                    user.update({"profilePic": url}).then(
                                        (value) => Navigator.pop(context)));
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

              //-----------------------------
            },
            child: const Text(
              "Change profile picture",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ))
      ],
    );
  }
}

///
///this is for the full name entry
//ignore:camel_case_types
class fullNameRowWidget extends StatelessWidget {
  final firstNameController;
  final lastNameController;

  const fullNameRowWidget(
      {required this.firstNameController,
      required this.lastNameController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
              color: Colors.white,
              elevation: 7,
              child: Container(
                width: 0.45 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextFormField(
                    controller: firstNameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                        hintText: "First name",
                        suffixIcon: Icon(Icons.cancel_rounded)),
                  ),
                ),
              )),
          Card(
              color: Colors.white,
              elevation: 7,
              child: Container(
                width: 0.45 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextFormField(
                    controller: lastNameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                        hintText: "Last name",
                        suffixIcon: Icon(Icons.cancel_rounded)),
                  ),
                ),
              ))
        ],
      );
    });
  }
}

///
///for entering the distric or loaction of the user
///
//ignore:camel_case_types
class locationRowWidget extends StatelessWidget {
  final TextEditingController controller;
  const locationRowWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);
    user.get().then((value) => controller.text = value.get("location"));
    return Card(
      elevation: 6,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextFormField(
              controller: controller,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "District",
              )),
        ),
      ),
    );
  }
}

///
///for entering the distric or loaction of the user
///
//ignore:camel_case_types
class aboutRowWidget extends StatelessWidget {
  final TextEditingController controller;
  const aboutRowWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);
    user.get().then((value) => controller.text = value.get("description"));
    return Card(
      elevation: 6,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextFormField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Description",
              )),
        ),
      ),
    );
  }
}

//ignore:camel_case_types
class saveBtnWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String location;
  final String description;
  const saveBtnWidget(
      {required this.firstName,
      required this.lastName,
      required this.description,
      required this.location,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: TextButton(
          onPressed: () => userDataUpdate.editMyAccount(
              firstName: firstName,
              lastName: lastName,
              location: location,
              description: description),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}

//ignore:camel_case_types
class mySummaryWidget extends StatelessWidget {
  const mySummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usersStore = FirebaseFirestore.instance.collection("users");
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
        stream: usersStore.doc(user?.uid).snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return const Text(
              "Error retriving info",
              style: TextStyle(color: Colors.red),
            );
          }
          if (snap.hasData) {
            if (snap.data != null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${snap.data?.get("followers")}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const Text(
                          "followers",
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${snap.data?.get("friends")}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const Text(
                          "friends",
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${snap.data?.get("following")}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const Text(
                          "following",
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}

///
///editing options row
///
//ignore:camel_case_types
class editOptionsWidget extends StatelessWidget {
  const editOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 48, 66)),
          child: TextButton(
              onPressed: () => Navigator.pushNamed(
                  context, RouteGenerator.editprofilescreen),
              child: const Text(
                "Edit profile",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 48, 66)),
          child: TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteGenerator.addFriendsscreen),
              child: const Text(
                "Add friends",
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }
}
