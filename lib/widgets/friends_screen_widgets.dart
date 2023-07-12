import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/state_managers/following_state.dart';

///
///this is where all the custom widgets of the friends screen are to be defined
///
//ignore:camel_case_types
class friendsTitleWidget extends StatelessWidget {
  const friendsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          "My Friends (580)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 68, 221, 255)),
          padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
          child: const Text(
            "Add friends",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}

///
///custom widget for holding all the friends in the friends screen grid
///
//ignore: camel_case_types
class gridDataWidget extends StatelessWidget {
  final String user;
  const gridDataWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final fuser = FirebaseFirestore.instance.collection("users").doc(user);
    final currentUser = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return StreamBuilder(
        stream: fuser.snapshots(),
        builder: (context, snap) {
          return Card(
              elevation: 10,
              //color: Colors.white,
              child: snap.hasData
                  ? GestureDetector(
                      onTap: () { 
                        RouteGenerator.user = user;
                        bool v =(snap.data?.get("followersList") as List).contains(currentUser.id);
                        followStateNotifier().editFollow(v);
                        Navigator.pushNamed(
                            context, RouteGenerator.friendprofilescreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg")),
                            ), // for holding the profile pic

                            const SizedBox(
                              height: 10,
                            ),
                            statusWidget(
                              name: snap.data?.get("username"),
                              online: true,
                            ),
                            Text(
                              snap.data?.get("description"),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    )
                  : snap.hasError
                      ? const Center(
                          child: Text(
                          "(*_*)",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ))
                      : const Center(
                          child: CircularProgressIndicator(),
                        ));
        });
  }
}

///
///for holding the name and the online status
///
//ignore: camel_case_types
class statusWidget extends StatelessWidget {
  final String name;
  final bool isOnline;
  const statusWidget({required this.name, bool online = false, super.key})
      : isOnline = online;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? Colors.green : Colors.grey),
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}

//ignore:camel_case_types
class followersWidget extends StatelessWidget {
  const followersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200),
                itemCount:
                    (snap.data?.get("followersList") as List<String>).length,
                itemBuilder: (context, index) => gridDataWidget(
                      user: (snap.data?.get("followersList")
                          as List<String>)[index],
                    ));
          }

          if (snap.hasError) {
            return const Center(
              child: Text(
                "(*_*)\n Error retriving data\ncheck your network and try again",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

//ignore:camel_case_types
class followingWidget extends StatelessWidget {
  const followingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200),
                itemCount:
                    (snap.data?.get("followingList") as List<String>).length,
                itemBuilder: (context, index) => gridDataWidget(
                      user: (snap.data?.get("followingList")
                          as List<String>)[index],
                    ));
          }

          if (snap.hasError) {
            return const Center(
              child: Text(
                "(*_*)\n Error retriving data\ncheck your network and try again",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

//ignore:camel_case_types
class friendsWidget extends StatelessWidget {
  const friendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200),
                itemCount:
                    (snap.data?.get("friendsList") as List<String>).length,
                itemBuilder: (context, index) => gridDataWidget(
                      user: (snap.data?.get("friendsList")
                          as List<String>)[index],
                    ));
          }

          if (snap.hasError) {
            return const Center(
              child: Text(
                "(*_*)\n Error retriving data\ncheck your network and try again",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
