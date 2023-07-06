import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userDataUpdate {
  static void editMyAccount(
      {required String firstName,
      required String lastName,
      required String location,
      required String description}) async {
    final user = FirebaseAuth.instance.currentUser;
    final usersStore = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    final fire = FirebaseFirestore.instance;

    if (firstName!="") {
      fire.runTransaction((transaction) async {
        final secureSnap = await transaction.get(usersStore.reference);

        transaction.update(
            secureSnap.reference, {"username": firstName + "" + lastName});
      });
    }
    if (location!="") {
      fire.runTransaction((transaction) async {
        final secureSnap = await transaction.get(usersStore.reference);

        transaction.update(
            secureSnap.reference, {"location": location});
      });
    }
    if (description!="") { 
      fire.runTransaction((transaction) async {
        final secureSnap = await transaction.get(usersStore.reference);

        transaction.update(
            secureSnap.reference, {"description": description});
      });
    }
  }
}
