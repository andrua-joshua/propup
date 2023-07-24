import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/friends_profile_screen_widgets.dart';

import '../routes.dart';

///
///the ui for viewing a friends profile
///
//ignore:camel_case_types
class friendsProfileScreen extends StatelessWidget {
  final String userID;

  const friendsProfileScreen({required this.userID, super.key});


  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance.collection("users").doc(userID);
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final storageRf = FirebaseStorage.instance.ref("posts");

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
                        "User's Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate.fixed([
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        child: Center(
                            child: CircleAvatar(
                                radius: 90,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg"))),
                      ),
                      Center(
                          child: StreamBuilder(
                              stream: user.snapshots(),
                              builder: (context, snapd) {
                                return snap.hasData
                                    ? Text(
                                        snapd.data?.get("username"),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : snapd.hasError
                                        ? const Text(
                                            "(*_*)",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const LinearProgressIndicator();
                              })),
                      locationWidget(user: user),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: StreamBuilder(
                              stream: user.snapshots(),
                              builder: (context, snapx) {
                                return snap.hasData
                                    ? Text(
                                        snapx.hasData? snapx.data?.get("description")
                                        :snapx.hasError?"there was an Error":""
                                        ,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      )
                                    : snapx.hasError
                                        ? const Text(
                                            "(*_*)",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const LinearProgressIndicator();
                              })),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: friendSummaryWidget(user: user)),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Divider(
                            thickness: 1,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                          child: transfersWidget(user: user,)),
                      Center(child: addFriendBtnWidget(uid: userID,)),
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
                                          element.get("owner") == userID)
                                      .length ??
                                  0,
                              (index) => FutureBuilder<String>(
                                  future: storageRf
                                      .child(
                                          "posts/" + snap.data!.docs[index].id)
                                      .getDownloadURL(),
                                  builder: (context, value) {
                                    if (value.hasData) {
                                      return GestureDetector(
                                          onTap: () {
                                            RouteGenerator.src =
                                                snap.data!.docs[index].id;

                                            Navigator.pushNamed(
                                                context,
                                                RouteGenerator
                                                    .personalPostsReviewscreen);
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
              })),
    );
  }
}
