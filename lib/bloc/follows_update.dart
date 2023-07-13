import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:propup/routes/transactions_screen.dart';
import 'package:propup/state_managers/following_state.dart';

//ignore:camel_case_types
class followsUpdateBloc {
  // ignore: slash_for_doc_comments
  /**
   
    static final usersStore = FirebaseFirestore.instance.collection("users");
    static final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);
   
   */

  static Future<bool> drilloxFollow({required String uid}) async {
    final usersStore = FirebaseFirestore.instance.collection("users");
    final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);

    bool success = false;

    if (uid != "") {
      //to check whether the uid isnt empty

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final secureSnap =
            await transaction.get(user); //for holding the current user
        final secureSnap2 =
            await transaction.get(usersStore.doc(uid)); //for the followed user

        bool wasAdded = false;

        //for the current user's updating

        final bool isFollowing = (secureSnap.get("followersList") as List).contains(
            uid); //to check whether the user to be followed is currently following us

        List followingList = secureSnap.get("followingList") as List;
        List friendsList = secureSnap.get("friendsList") as List;

        int following = secureSnap.get("following") as int;
        int friends = secureSnap.get("friends") as int;

        ///
        /// if is following us:
        ///    if !infriendsList    //-to check whether the user already a friend
        ///       friendsList.add
        ///       ++friends
        /// then adding the user to the ones that we are currently following
        ///
        /// if !infollowingList
        ///    followingList.add
        ///     ++following
        ///
        /// update currentUser
        ///   "friendsList"=friendsList
        ///   "followingList"=followingList
        ///   "following"=following
        ///   "friends"=friends
        ///

        if (isFollowing) {
          if (!friendsList.contains(uid)) {
            friendsList.add(uid);
            friends = friendsList.length;
            wasAdded = true;
          }
        }

        if (!followingList.contains(uid)) {
          followingList.add(uid);
          following = followingList.length;
          success = true;
        }

        transaction.update(secureSnap.reference, {
          "friendsList": friendsList,
          "followingList": followingList,
          "friends": friends,
          "following": following
        });

        //this will be for updating the user that we are currently following
        final bool isBothFollowing =
            (secureSnap.get("followingList") as List).contains(uid) &&
                (secureSnap2.get("followingList") as List)
                    .contains(secureSnap.id) &&
                wasAdded;

        List friendsList2 = secureSnap2.get("friendsList") as List;
        List followersList2 = secureSnap2.get("followersList") as List;

        int friends2 = secureSnap2.get("friends") as int;
        int followers2 = secureSnap2.get("followers") as int;

        ///
        /// if isBothFollowing:
        ///    if !infriendsList
        ///       friendsList2.add
        ///       ++friends2
        ///
        /// if !inFollowersList:
        ///     followersList2.add
        ///     ++followers2
        ///
        ///
        /// update User Data secureSnap2:
        ///   "friendsList2"=friendsList2
        ///   "followersList"=followersList,
        ///   "friends"=friends
        ///   "followers"=followers
        ///

        if (wasAdded) {
          if (!friendsList2.contains(secureSnap.id)) {
            friendsList2.add(secureSnap.id);
            friends2 = friendsList2.length;
          }
        }

        if (!followersList2.contains(secureSnap.id)) {
          followersList2.add(secureSnap.id);
          followers2 = followersList2.length;

          bool successTemp = success;
          success = successTemp && true;
        }

        transaction.update(secureSnap2.reference, {
          "friendsList": friendsList2,
          "followersList": followersList2,
          "friends": friends2,
          "followers": followers2
        });
      });
    }

    return success;
  }

  // ignore: slash_for_doc_comments
  /**
   
    static final usersStore = FirebaseFirestore.instance.collection("users");
    static final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);
   
   */

  static Future<bool> drilloxUnfollow({required String uid}) async {
    final usersStore = FirebaseFirestore.instance.collection("users");
    final user = usersStore.doc(FirebaseAuth.instance.currentUser?.uid);

    bool success = false;

    if (uid != "") {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        //defining our two users involved
        final secureSnap = await transaction.get(user);
        final secureSnap2 = await transaction.get(usersStore.doc(uid));

        bool wasFriend = false;

        //first or currentuser update
        final isFriend = (secureSnap.get("friendsList") as List).contains(uid);

        List friendsList = secureSnap.get("friendsList") as List;
        List followingList = secureSnap.get("followingList") as List;

        int friends = secureSnap.get("friends") as int;
        int following = secureSnap.get("following") as int;

        ///
        ///if isFriend of us:
        ///  if infriendsList
        ///     friendlist.remove
        ///     --friends
        ///
        /// if inFollowingList
        ///     followingList.remove
        ///      --following
        ///
        /// --update our database state
        ///
        /// secureSnap.update
        ///   "friends"=friends,
        ///   "following"= following,
        ///   "followingList"= followingList
        ///   "friendsList"= friendsList
        ///

        if (isFriend) {
          if (friendsList.contains(uid)) {
            friendsList.remove(uid);
            friends = friendsList.length;
            wasFriend = true;
          }
        }

        if (followingList.contains(uid)) {
          success = followingList.remove(uid);
          following = followingList.length;
        }

        transaction.update(secureSnap.reference, {
          "friends": friends,
          "following": following,
          "friendsList": friendsList,
          "followingList": followingList
        }); //end of updating Securenap

        //---for updating of the user that we are currently trying to unfollow

        List friendsList2 = secureSnap2.get("friendsList") as List;
        List followersList2 = secureSnap2.get("followersList") as List;

        int friends2 = secureSnap2.get("friends") as int;
        int followers2 = secureSnap2.get("followers") as int;

        ///
        /// if wasFriends :
        ///    if(inFriendsList2)
        ///       friendsList2.remove
        ///       --friends2
        ///
        /// if inFollowersList2
        ///     followersList2.remove
        ///     --followers2
        ///
        /// --update the user state
        ///
        /// secureSnap2.update
        ///     "followers"=followers
        ///     "friends"=friends,
        ///     "followersList"=followersList,
        ///     "friendsList"=friendsList
        ///

        if (wasFriend) {
          if (friendsList2.contains(secureSnap.id)) {
            friendsList2.remove(secureSnap.id);
            friends2 = friendsList2.length;
          }
        }

        if (followersList2.contains(secureSnap.id)) {
          followersList2.remove(secureSnap.id);
          followers2 = followersList2.length;
        }

        transaction.update(secureSnap2.reference, {
          "followers": followers2,
          "friends": friends2,
          "followersList": followersList2,
          "friendsList": friendsList2
        });
      }); //end of run transaction method
    }

    return success;
  }
}
