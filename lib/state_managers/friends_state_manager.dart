import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//ignore:camel_case_types
class friendsData {
  List<DocumentSnapshot> followers = [];
  List<DocumentSnapshot> friends = [];
  List<DocumentSnapshot> following = [];
  List<DocumentSnapshot> unAttached = [];

  friendsData._();
  static final _singleObj = friendsData._();
  factory friendsData() => _singleObj;
  //friendsData.all();

  Future<void> initFriends() async {
    final auth = FirebaseAuth.instance.currentUser;
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth?.uid)
        .get();

    debugPrint("@@Drillox ::> " + user.id);

    //this is for the followers list initilization
    final Followers = user.get("followersList") as List;
    final allFollowers = <DocumentSnapshot>[];
    for (var followerId in Followers) {
      final follower = await FirebaseFirestore.instance
          .collection("users")
          .doc(followerId)
          .get();

      allFollowers.add(follower);
    }
    followers = allFollowers;

    //this is for the friends list initialization
    final Friends = user.get("friendsList") as List;
    final allFriends = <DocumentSnapshot>[];
    for (var friendId in Friends) {
      final friend = await FirebaseFirestore.instance
          .collection("users")
          .doc(friendId)
          .get();
      allFriends.add(friend);
    }
    friends = allFriends;

    //this is for the initisation ofthe following list initialization
    final followingList = user.get("followingList") as List;
    final allFollowing = <DocumentSnapshot>[];
    for (var followingId in followingList) {
      final follower = await FirebaseFirestore.instance
          .collection("users")
          .doc(followingId)
          .get();
      allFollowing.add(follower);
    }
    following = allFollowing;

    //this is for the initilisation of the unattached list
    final followingList2 = user.get("followingList") as List;
    final allUsers = await FirebaseFirestore.instance.collection("users").get();

    final otherUsers = allUsers.docs.where((element) {
      bool val = followingList2.contains(element.id) ? false : true;

      bool v2 = val
          ? element.id != user.id
              ? true
              : false
          : false;

      return v2;
    }).toList();
    final AllUnattached = <DocumentSnapshot>[];
    for (var otherUser in otherUsers) {
      AllUnattached.add(otherUser);
    }
    unAttached = AllUnattached;
  }

  Stream<void> listener() async* {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    user.snapshots().listen((event) async {
      await friendsData().initFriends();
    });
    await for (final doc in user.snapshots()) {
      await friendsData().initFriends();
      yield "";
    }
  }

  Stream<List<DocumentSnapshot>> followingSnap() async* {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    await for (var element in user.snapshots()) {
      final followingList = element.get("followingList") as List;
      final allFollowing = <DocumentSnapshot>[];
      for (var followingId in followingList) {
        final follower = await FirebaseFirestore.instance
            .collection("users")
            .doc(followingId)
            .get();
        allFollowing.add(follower);
      }
      yield allFollowing;
    }
  }
}
//class Streamer {}
