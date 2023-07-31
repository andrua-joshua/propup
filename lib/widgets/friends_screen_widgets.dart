import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/state_managers/following_state.dart';
import 'package:propup/state_managers/friends_state_manager.dart';

import 'add_friends_screen_widgets.dart';

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
                        bool v = (snap.data?.get("followersList") as List)
                            .contains(currentUser.id);
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
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                      snap.data?.get("profilePic"),
                                      maxHeight: 220,
                                      maxWidth: 220)),
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
    justStatic.index = 0;
    debugPrint("@Drillox ::{}::> Followers");

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snapx) {
          if (snapx.hasData) {
            return ListView.builder(
                        itemCount: friendsData().followers.length,
                        itemBuilder: (context, pos) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: possibleFriendWidget(
                                  currentUser: snapx.data,
                                  user: friendsData().followers[pos].id,
                                  name: friendsData().followers[pos].get("username") ?? "",
                                  image:
                                      "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                                  description: friendsData().followers[pos]
                                      .get("description")
                                      .toString()),
                            ));
                 
          }
          //(snap.data?.get("followersList") as List)[index]
          if (snapx.hasError) {
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

    justStatic.index = 2;
    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snapx) {
          if (snapx.hasData) {
            return StreamBuilder(
              stream: friendsData().followingSnap(),
              builder: (context, followingSnap){
                if(followingSnap.hasData){
                  return ListView.builder(
                        itemCount: followingSnap.data?.length,
                        itemBuilder: (context, pos) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: possibleFriendWidget(
                                  currentUser: snapx.data,
                                  user: followingSnap.data![pos].id,
                                  name: followingSnap.data![pos].get("username") ?? "",
                                  image:
                                      "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                                  description: followingSnap.data![pos]
                                      .get("description")
                                      .toString()),
                            ));
                }
                if(followingSnap.hasError){
                  return const Center(child: Text("Check your network pliz"),);
                }
                return Container();
              });
                 
          }
          //(snap.data?.get("followersList") as List)[index]
          if (snapx.hasError) {
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

    justStatic.index = 1;

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snapx) {
          if (snapx.hasData) {
            return ListView.builder(
                        itemCount: friendsData().friends.length,
                        itemBuilder: (context, pos) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: possibleFriendWidget(
                                  currentUser: snapx.data,
                                  user: friendsData().friends[pos].id,
                                  name: friendsData().friends[pos].get("username") ?? "",
                                  image:
                                      "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                                  description: friendsData().friends[pos]
                                      .get("description")
                                      .toString()),
                            ));
                 
          }
          //(snap.data?.get("followersList") as List)[index]
          if (snapx.hasError) {
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

//for searching throu all the friends or followers in friends screen
class searchFriendsDeleget extends SearchDelegate {
  final int index;
  final DocumentSnapshot? currentUser;

  searchFriendsDeleget({
    required this.currentUser,
    required this.index,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getResult(queryUser: query, index: index),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data?.length ?? 0,
                itemBuilder: (context, pos) => Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: possibleFriendWidget(
                          currentUser: currentUser,
                          user: snap.data![pos].id,
                          name: snap.data![pos].get("username") ?? "",
                          image:
                              "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                          description:
                              snap.data![pos].get("description").toString()),
                    ));
          }
          if (snap.hasError) {
            return const Center(
              child: Text("check your network"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debugPrint("@Drillox: CurrentIndex:>> $index");
    return FutureBuilder(
        future: getResult(queryUser: query, index: index),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data?.length ?? 0,
                itemBuilder: (context, pos) => Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: possibleFriendWidget(
                          currentUser: currentUser,
                          user: snap.data![pos].id,
                          name: snap.data![pos].get("username") ?? "",
                          image:
                              "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
                          description:
                              snap.data![pos].get("description").toString()),
                    ));
          }
          if (snap.hasError) {
            return const Center(
              child: Text("check your network"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<List<DocumentSnapshot>> getResult(
      {required String queryUser, required int index}) async {
    final auth = FirebaseAuth.instance.currentUser;
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth?.uid)
        .get();

    if (index == 0) {
      if (user != null) {
        final followers = user.get("followersList") as List;
        final followersIds = <DocumentSnapshot>[];
        for (var followerId in followers) {
          final follower = await FirebaseFirestore.instance
              .collection("users")
              .doc(followerId)
              .get();
          final followerName = follower.get("username") as String;

          if (followerName.toLowerCase().contains(queryUser.toLowerCase())) {
            followersIds.add(follower);
          }
        }
        return followersIds;
      }
    } else if (index == 1) {
      if (user != null) {
        final friends = user.get("friendsList") as List;
        final friendsIds = <DocumentSnapshot>[];
        for (var friendId in friends) {
          final friend = await FirebaseFirestore.instance
              .collection("users")
              .doc(friendId)
              .get();
          final friendName = friend.get("username") as String;

          if (friendName.toLowerCase().contains(queryUser.toLowerCase())) {
            friendsIds.add(friend);
          }
        }
        return friendsIds;
      }
    } else if (index == 2) {
      if (user != null) {
        final followingList = user.get("followingList") as List;
        final followingsIds = <DocumentSnapshot>[];
        for (var followingId in followingList) {
          final follower = await FirebaseFirestore.instance
              .collection("users")
              .doc(followingId)
              .get();
          final followerName = follower.get("username") as String;

          if (followerName.toLowerCase().contains(queryUser.toLowerCase())) {
            followingsIds.add(follower);
          }
        }
        return followingsIds;
      }
    } else if (index == 3) {
      if (user != null) {
        final followingList = user.get("followingList") as List;
        final allUsers =
            await FirebaseFirestore.instance.collection("users").get();

        final otherUsers = allUsers.docs.where((element) {
          bool val = followingList.contains(element.id) ? false : true;

          bool v2 = val
              ? element.id != user.id
                  ? true
                  : false
              : false;

          //v2 ? saveList.add(element) : null;

          return v2;
        }).toList();

        final otherUsersIds = <DocumentSnapshot>[];
        for (var otherUser in otherUsers) {
          final otherUserName = otherUser.get("username") as String;

          if (otherUserName.toLowerCase().contains(queryUser.toLowerCase())) {
            otherUsersIds.add(otherUser);
          }
        }
        return otherUsersIds;
      }
    }

    return [];
  }
}
