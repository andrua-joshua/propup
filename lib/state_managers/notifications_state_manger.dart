import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/state_managers/friends_state_manager.dart';

//ignore:camel_case_types
class notificaStateManager with ChangeNotifier {
  void listener() {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    user.snapshots().listen((event) async {
      debugPrint("@Drillox ::{In the current Notifications}::>>>");

      List notifications = event.get("notifications") as List;
      List<Map<String, dynamic>> notificationsHolder = [];
      if (notifications.length != friendsData().notifications.length) {
        for (var notif in notifications) {
          notificationsHolder.add(notif);
        }
        friendsData().notifications = notificationsHolder;
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> getNotifications() => friendsData().notifications;
}
