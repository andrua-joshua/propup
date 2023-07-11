import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

import '../state_managers/following_state.dart';

//ignore:camel_case_types
class searchFriendWidget extends StatelessWidget {
  const searchFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return SizedBox(
        height: 30,
        width: 0.7 * width,
        child: const SearchBar(leading: Icon(Icons.search), hintText: "Search"),
      );
    });
  }
}

//ignore: camel_case_types
class possibleFriendsWidget extends StatelessWidget {
  const possibleFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final currentUser =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    final allUsers = FirebaseFirestore.instance.collection("users");
    List saveList = [];

    return StreamBuilder(
      stream: currentUser.snapshots(),
      builder: (context, snap) {
        if (snap.hasData) {
          return StreamBuilder(
              stream: allUsers.snapshots(),
              builder: (context, snapd) {
                return Column(
                  children: List.generate(
                      snapd.data?.docs
                              .where((element) {
                                bool val =
                                    (snap.data?.get("followingList") as List)
                                            .contains(element.id)
                                        ? false
                                        : true;

                                bool v2 = val
                                    ? element.id != snap.data?.id
                                        ? true
                                        : false
                                    : false;

                                v2 ? saveList.add(element) : null;

                                return v2;
                              })
                              .toList()
                              .length ??
                          0,
                      (index) => Padding(
                            padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                            child: possibleFriendWidget(
                              user: saveList[index].id,
                                name: saveList[index].get("username") ?? "",
                                image:
                                    "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                                description: saveList[index]
                                    .get("description")
                                    .toString()),
                          )),
                );
              });
        }

        if (snap.hasError) {
          return const Text(
            "(*_*)\n there was an error.\n Please check your network and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          );
        }

        return const Center(
          child: Icon(Icons.watch_outlined),
        );
      },
    );
  }
}

//ignore:camel_case_types
class possibleFriendWidget extends StatelessWidget {
  final String image;
  final String name;
  final String user;
  final String description;
  const possibleFriendWidget(
      {required this.description,
      required this.name,
      required this.user,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        RouteGenerator.user = user;
        followStateNotifier().editFollow(false);
        Navigator.pushNamed(context, RouteGenerator.friendprofilescreen);
      },
      leading: CircleAvatar(
          radius: 35,
          child: Center(
              child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 35,
            backgroundImage: NetworkImage(image),
          ))),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
