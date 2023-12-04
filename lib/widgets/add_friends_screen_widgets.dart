import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/widgets/friends_screen_widgets.dart';

import '../state_managers/following_state.dart';

//ignore:camel_case_types
class searchFriendWidget extends StatelessWidget {
  const searchFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return SizedBox(
        width: 0.95 * width,
        child: FutureBuilder(
            future: user.get(),
            builder: (context, snap) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 241, 241, 241)),
                  margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                  child: TextFormField(
                    onTap: () => showSearch(
                        context: context,
                        delegate: searchFriendsDeleget(
                            index: 3, currentUser: snap.data)),
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Search",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ));
            }),
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
        saveList = [];
        if (snap.hasData) {
          return StreamBuilder(
              stream: allUsers.snapshots(),
              builder: (context, snapd) {
                debugPrint("Helloooooooooo");
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

                                bool val2 = element.get("verified") as bool;
                                //bool val2 = true;
                                v2 && val2 ? saveList.add(element) : null;
                                debugPrint("@Hello:: > $element");
                                return v2 && val2;
                              })
                              .toList()
                              .length ??
                          0,
                      (index) => Padding(
                            padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                            child: possibleFriendWidget(
                                currentUser: snap.data,
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
  final DocumentSnapshot? currentUser;
  const possibleFriendWidget(
      {required this.description,
      required this.name,
      required this.user,
      required this.image,
      required this.currentUser,
      super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("@Drillox :{Current user}:::>> $user");
    final fuser = FirebaseFirestore.instance.collection("users").doc(user);
    debugPrint("@Drillox :{Current user}:::>> $user");
    return ListTile(
      onTap: () {
        bool val = false;

        val = (currentUser?.get("followingList") as List).contains(user);

        RouteGenerator.user = user;
        followStateNotifier().editFollow(val);
        Navigator.pushNamed(context, RouteGenerator.friendprofilescreen);
      },
      leading: FutureBuilder(
          future: fuser.get(),
          builder: (context, snap) {
            if (snap.hasData) {
              return CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Center(
                      child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 26,
                    backgroundImage: CachedNetworkImageProvider(
                        snap.data?.get("profilePic"),
                        maxHeight: 104,
                        maxWidth: 104),
                  )));
            }

            return const CircleAvatar();
          }),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
