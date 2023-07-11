import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propup/state_managers/following_state.dart';

//ignore:camel_case_types
class followsUpdateBloc {
  static final usersStore = FirebaseFirestore.instance.collection("users");
  static final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);

  static Future<void> follow({required String uid}) async{
    if (uid != "") {

      bool success = false;

      await FirebaseFirestore.instance.runTransaction((transaction) async {

        final secureSnap = await transaction.get(user); //good

        ///to update the current users database
        final bool isFollower =
            (secureSnap.get("followersList") as List).contains(uid); //good


        int friends = (secureSnap.get("friends") as int); //good

        int followings = secureSnap.get("following") as int; //good

        List friendsList = secureSnap.get("friendsList") as List;  //good

        List followingsList = secureSnap.get("followingList") as List; //good

        if (isFollower) {
          friendsList.add(uid);  //valid
          followingsList.add(uid); //valid
          ++friends;  //valid
        } else {
          followingsList.add(uid); //valid
        }

        transaction.update(secureSnap.reference, {
          "friends": friends, //valid
          "following": ++followings, //valid
          "followingsList": followingsList, //valid
          "friendsList": friendsList //valid
        });



        ///to update the followed user database
        ///
        final secureSnap2 = await transaction.get(usersStore.doc(uid)); //good

        final bool isFollowing =
            (secureSnap2.get("followingList") as List).contains(user.id); //good 

        int friends2 = (secureSnap2.get("friends") as int); //good

        int followers = (secureSnap2.get("followers") as int); //good

        List friendsList2 = secureSnap2.get("friendsList") as List; //good

        List followersList = secureSnap2.get("followersList") as List; //good

        if (isFollowing) {
          friendsList2.add(user.id);  //valid
          followersList.add(user.id);  //valid
          ++friends2;  //valid
        } else {
          followersList.add(user.id);  //valid
        }

        transaction.update(secureSnap2.reference, {
          "friends": friends2,   //valid
          "followers": ++followers, //valid
          "followersList": followersList, //valid
          "friendsList": friendsList  //valid
        });

        success = (secureSnap.get("followingList") as List).contains(uid);

      });

      followStateNotifier().editFollow(success);
    }
  }

  ///used for unfollowing a user
  static Future<void> unfollow({required String uid}) async{
    if (uid != "") {
      
      bool success = false;

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        
        final secureSnap = await transaction.get(user); //good
        

        ///to update the current users database
        final bool isFriend =
            (secureSnap.get("friendsList") as List).contains(uid);  //good

        int friends = secureSnap.get("friends") as int;  //good

        int followings = secureSnap.get("following") as int;  //good

        List friendsList = secureSnap.get("friendsList") as List;   //good

        List followingsList = secureSnap.get("followingList") as List;  //good

        if (isFriend) {
          friendsList.remove(uid);  //valid
          followingsList.remove(uid);  //valid
          --friends;  //valid
        } else {
          followingsList.remove(uid);  //valid
        }

        transaction.update(secureSnap.reference, {
          "friends": friends,   //valid
          "following": --followings,  //valid
          "followingsList": followingsList,  //valid
          "friendsList": friendsList  //valid
        });



        ///to update the unfollowed user database
        ///
        final secureSnap2 = await transaction.get(usersStore.doc(uid)); //good

        final bool isFriend2 =
            (secureSnap2.get("friendsList") as List).contains(user.id); //good

        int friends2 = secureSnap2.get("friends") as int;  //good

        int followers = secureSnap2.get("followers") as int;   //good

        List friendsList2 = secureSnap2.get("friendsList") as List;   //good

        List followersList = secureSnap.get("followersList") as List; //good

        if (isFriend2) {
          friendsList2.remove(user.id);  //valid
          followersList.remove(user.id);  //valid
          --friends2;   //valid
        } else {
          followersList.remove(user.id);  //valid
        }

        transaction.update(secureSnap2.reference, {
          "friends": friends2,  //valid
          "followers": --followers, //valid
          "followersList": followersList, //valid
          "friendsList": friendsList  //valid
        });

        success = !(secureSnap.get("followingList") as List).contains(uid);
      });

      followStateNotifier().editFollow(false);
    }
  }
}
