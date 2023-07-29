import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_outgoing_message_handler.dart';
import 'package:propup/bloc/follows_update.dart';
import 'package:provider/provider.dart';

import '../bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';
import '../state_managers/following_state.dart';

///
///this is where all the custom widgets of the friends screen will be defined
///

///the one for holding the location
//ignore: camel_case_types
class locationWidget extends StatelessWidget {
  final DocumentReference user;
  const locationWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.place,
          color: Colors.grey,
        ),
        StreamBuilder(
            stream: user.snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Text(
                  snap.data?.get("location"),
                  style: const TextStyle(color: Colors.grey, fontSize: 22),
                );
              }
              if (snap.hasError) {
                return const Text(
                  "(*_*)",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                );
              }

              return Center(child: Container());
            })
      ],
    );
  }
}

///
///this is for expression of moodes towards the friend
///
//ignore: camel_case_types
class expressionsWidget extends StatelessWidget {
  const expressionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.purple),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_down,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "1.6k",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "FRIENDS",
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.green),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

///
///this is to show the recieved and donated catch
///
//ignore: camel_case_types
class transfersWidget extends StatelessWidget {
  final DocumentReference user;
  const transfersWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    snap.hasData
                        ? Text(snap.data?.get("recieved").toString() ?? "0",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 26,
                                fontWeight: FontWeight.bold))
                        : snap.hasError
                            ? const Text(
                                "(*_*)",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    const Text(
                      "Recieved",
                      style: TextStyle(color: Colors.purple, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    snap.hasData
                        ? Text(snap.data?.get("donated").toString() ?? "0",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 26,
                                fontWeight: FontWeight.bold))
                        : snap.hasError
                            ? const Text(
                                "(*_*)",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    const Text(
                      "Donated",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

///
///summary of the friend
///
//ignore:camel_case_types
class friendSummaryWidget extends StatelessWidget {
  final DocumentReference user;
  const friendSummaryWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    snap.hasData
                        ? Text(snap.data?.get("followers").toString() ?? "0",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : snap.hasError
                            ? const Text(
                                "(*_*)",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    const Text(
                      "followers",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       snap.hasData
              //           ? Text(snap.data?.get("friends").toString() ?? "0",
              //               style: const TextStyle(
              //                   color: Color.fromARGB(255, 9, 14, 17),
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold))
              //           : snap.hasError
              //               ? const Text(
              //                   "(*_*)",
              //                   style: TextStyle(
              //                       color: Colors.red,
              //                       fontWeight: FontWeight.bold),
              //                 )
              //               : const Center(
              //                   child: CircularProgressIndicator(),
              //                 ),
              //       const Text(
              //         "friends",
              //         style: TextStyle(),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    snap.hasData
                        ? Text(snap.data?.get("following").toString() ?? "0",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 14, 17),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : snap.hasError
                            ? const Text(
                                "(*_*)",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    const Text(
                      "following",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

///
///this is for the add friend btn
//ignore:camel_case_types
class addFriendBtnWidget extends StatelessWidget {
  final String uid;
  const addFriendBtnWidget({required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
      create: (context) => followStateNotifier2(),
      builder: (context, child) {
        return Container(
          width: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 38, 65),
              borderRadius: BorderRadius.circular(10)),
          child: Consumer<followStateNotifier2>(builder: (context, val, child) {
            return TextButton(
                onPressed: () {
                  if (val.followingCurrentUser2) {
                    val.editFollow2(false);
                    followsUpdateBloc.drilloxUnfollow(uid: uid);
                    //.then((value) => val.editFollow2(value ? false : true));
                  } else {
                    val.editFollow2(true);
                    followsUpdateBloc
                        .drilloxFollow(uid: uid)
                        //.then((value) => val.editFollow2(value))
                        .then((value) async {
                      final auth = FirebaseAuth.instance.currentUser;
                      final user = await FirebaseFirestore.instance
                          .collection("users")
                          .doc(auth?.uid)
                          .get();
                      final notificaton = notificationsMessage(
                          head: DateTime.now().microsecondsSinceEpoch,
                          messageID: currentUser?.uid??"",
                          message:
                              "${user.get("username")} started following you.",
                          subType: "New follower");

                      await fcmOutgoingMessages
                          .instance()
                          .sendNotificationMessage(message: notificaton);
                    });
                  }
                },
                child: Text(
                  val.followingCurrentUser2 ? "Unfollow" : "Follow",
                  style: const TextStyle(color: Colors.white),
                ));
          }),
        );
      },
    );
  }
}

///
///this is for showning the images in the user or friends profile
//ignore:camel_case_types
class friendPostWidget extends StatelessWidget {
  final String image;
  const friendPostWidget({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return FutureBuilder<ImageDescriptor>(
          future: rootBundle
              .load(image)
              .then((value) => value.buffer.asUint8List())
              .then((value) => ImmutableBuffer.fromUint8List(value))
              .then((value) => ImageDescriptor.encoded(value)),
          builder: (context, snap) {
            if (snap.hasError) {
              return const Center(
                child: Text("there occurred some error"),
              );
            }
            if (snap.hasData == false) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            int h = 0;
            int w = 0;

            if (snap.hasData) {
              h = snap.data?.height ?? 1;
              w = snap.data?.width ?? 1;
            }
            return Container(
              constraints: BoxConstraints.expand(height: width / (w / h)),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 224, 221, 221)),
              padding: const EdgeInsets.fromLTRB(3, 6, 3, 5),
            );
          });
    });
  }
}

///
///this is for the showing of all the images
///
//ignore: camel_case_types
class friendPostsWidget extends StatelessWidget {
  const friendPostsWidget({super.key});

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 10),
      children: List.generate(
          images.length, (index) => friendPostWidget(image: images[index])),
    );
  }
}
