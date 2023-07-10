import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propup/state_managers/following_state.dart';

//ignore:camel_case_types
class followsUpdateBloc {
  static final usersStore = FirebaseFirestore.instance.collection("users");
  static final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);

  static void follow({required String uid}) {
    if (uid != "") {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final secureSnap = await transaction.get(user);
        final secureSnap2 = await transaction.get(usersStore.doc(uid));

        ///to update the current users database
        final bool isFollower =
            (secureSnap.get("followersList") as List).contains(uid);
        int friends = (secureSnap.get("friends") as int);
        int followings = (secureSnap.get("following") as int);

        List friendsList = secureSnap.get("friendsList") as List;
        List followingsList = secureSnap.get("followingsList") as List;

        if (isFollower) {
          friendsList.add(uid);
          followingsList.add(uid);
          ++friends;
        } else {
          followingsList.add(uid);
        }

        transaction.update(secureSnap.reference, {
          "friends": friends,
          "following": ++followings,
          "followingsList": followingsList,
          "friendsList": friendsList
        });

        ///to update the followed user database
        final bool isFollowing =
            (secureSnap2.get("followingsList") as List).contains(uid);
        int friends2 = (secureSnap2.get("friends") as int);
        int followers = (secureSnap2.get("followers") as int);

        List friendsList2 = secureSnap2.get("friendsList") as List;
        List followersList = secureSnap.get("followersList") as List;

        if (isFollowing) {
          friendsList2.add(uid);
          followersList.add(uid);
          ++friends2;
        } else {
          followersList.add(uid);
        }

        transaction.update(secureSnap2.reference, {
          "friends": friends2,
          "following": ++followers,
          "followingsList": followersList,
          "friendsList": friendsList
        });
      });

      followStateNotifier().editFollow(true);
    }
  }

  ///used for unfollowing a user
  static void unfollow({required String uid}) {
    if (uid != "") {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final secureSnap = await transaction.get(user);
        final secureSnap2 = await transaction.get(usersStore.doc(uid));

        ///to update the current users database
        final bool isFriend =
            (secureSnap.get("friendsList") as List).contains(uid);
        int friends = (secureSnap.get("friends") as int);
        int followings = (secureSnap.get("following") as int);

        List friendsList = secureSnap.get("friendsList") as List;
        List followingsList = secureSnap.get("followingsList") as List;

        if (isFriend) {
          friendsList.remove(uid);
          followingsList.remove(uid);
          --friends;
        } else {
          followingsList.remove(uid);
        }

        transaction.update(secureSnap.reference, {
          "friends": friends,
          "following": --followings,
          "followingsList": followingsList,
          "friendsList": friendsList
        });

        ///to update the unfollowed user database
        final bool isFriend2 =
            (secureSnap2.get("friendsList") as List).contains(uid);
        int friends2 = (secureSnap2.get("friends") as int);
        int followers = (secureSnap2.get("followers") as int);

        List friendsList2 = secureSnap2.get("friendsList") as List;
        List followersList = secureSnap.get("followersList") as List;

        if (isFriend2) {
          friendsList2.remove(uid);
          followersList.remove(uid);
          --friends2;
        } else {
          followersList.remove(uid);
        }

        transaction.update(secureSnap2.reference, {
          "friends": friends2,
          "following": --followers,
          "followingsList": followersList,
          "friendsList": friendsList
        });
      });

      followStateNotifier().editFollow(false);
    }
  }
}
