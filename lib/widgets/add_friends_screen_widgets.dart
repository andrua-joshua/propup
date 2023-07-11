import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

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

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
  ];

  final names = const <String>[
    "Mugisha Moses",
    "Anthony Rock",
    "Tom Cruisce",
    "John dush",
    "Natalia Joyce",
    "Mugisha Moses",
    "Anthony Rock",
    "Tom Cruisce",
    "John dush",
    "Natalia Joyce",
  ];
  
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
          return Column(
            children: List.generate(
                possibleFriends(
                  coll: allUsers, snap: snap.data, saveList: saveList),
                (index) => Padding(
                      padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                      child: possibleFriendWidget(
                        name: (saveList[index] as QueryDocumentSnapshot).get("username").toString(),
                        image: "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                        description: (saveList[index] as QueryDocumentSnapshot).get("description").toString(),
                      ),
                    )),
          );
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

  int possibleFriends(
      {required CollectionReference coll, required DocumentSnapshot? snap, required List saveList}) {

    coll.snapshots().where((event) {
      bool val = false;
      saveList = event.docs.where((element) {
        val = (snap?.get("followingList") as List).contains(element.id);
        return val?false:true;
      }).toList();

      return val;
    });

    return saveList.length;
  }
}

//ignore:camel_case_types
class possibleFriendWidget extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  const possibleFriendWidget(
      {required this.description,
      required this.name,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      //Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
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
