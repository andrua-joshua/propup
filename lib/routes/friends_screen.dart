import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/state_managers/following_state.dart';
import 'package:propup/widgets/friends_screen_widgets.dart';

///
///this class is where all the friend list will be shown
///
//ignore: camel_case_types
class friendScreen extends StatelessWidget {
  const friendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Friends",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              FutureBuilder(
                  future: user.get(),
                  builder: (context, snap) {
                    return IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: searchFriendsDeleget(
                                currentUser: snap.data,
                                  index: justStatic.index));
                        },
                        icon: const Icon(Icons.search));
                  }),
                  IconButton(onPressed: ()=>Navigator.pushNamed(context, RouteGenerator.addFriendsscreen), 
                  icon: const Icon(Icons.group_add))
            ],
            bottom: const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: [
              Text(
                "Followers",
                style: TextStyle(),
              ),
              Text(
                "Friends",
                style: TextStyle(),
              ),
              Text(
                "Following",
                style: TextStyle(),
              ),
            ]),
          ),
          body: const Padding(
              padding: EdgeInsets.only(top: 10, left: 2, right: 2),
              child: TabBarView(children: [
                followersWidget(),
                friendsWidget(),
                followingWidget()
              ])),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () =>
          //       Navigator.pushNamed(context, RouteGenerator.addFriendsscreen),
          //   child: const Icon(Icons.add),
          // ),
        ));
  }
}
