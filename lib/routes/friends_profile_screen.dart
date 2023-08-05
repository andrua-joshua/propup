import 'package:cached_network_image/cached_network_image.dart';
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
      body: StreamBuilder(
              stream: postsStore.snapshots(),
              builder: (context, snap) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      pinned: true,
                      backgroundColor: const Color.fromARGB(255, 8, 92, 181),
                      leading: IconButton(onPressed: ()=> Navigator.pop(context), 
                      icon: const Icon(Icons.arrow_back, color: Colors.white,) ),
                      title: const Text(
                        "User's Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate.fixed([
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: Center(
                            child:  (snap.hasData)?StreamBuilder(
                                stream: user.snapshots(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: CachedNetworkImageProvider(snapShot.data
                                                ?.get("profilePic") ,maxHeight:360,maxWidth:360));
                                  }

                                  return const CircleAvatar(radius: 80, backgroundColor: Colors.blueGrey,);
                                }):null),
                      ),
                      Center(
                          child: snap.hasData? StreamBuilder(
                              stream: user.snapshots(),
                              builder: (context, snapd) {
                                return snapd.hasData
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
                              }):null),
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
                                        snapx.hasData
                                            ? snapx.data?.get("description")
                                            : snapx.hasError
                                                ? "there was an Error"
                                                : "",
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
                          child: transfersWidget(
                            user: user,
                          )),
                      Center(
                          child: addFriendBtnWidget(
                        uid: userID,
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      // const Center(
                      //     child: Text(
                      //   "Photos",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.bold),
                      // )),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Divider(
                            thickness: 1,
                          )),
                    ])),
                    
                    ///-----------


                  ],
                );
              }),
    );
  }
}
