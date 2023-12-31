import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/widgets/notifications_screen_widgets.dart';

///
///this is where all the notifications on the application shall be rendered
///
//ignore: camel_case_types
class notificationsScreen extends StatelessWidget {
  const notificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(auth?.uid)
            .snapshots(),
        builder: (context, snap) {
          int idx = 0;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 100,
                backgroundColor: const Color.fromARGB(255, 8, 92, 181),
                leading: IconButton(onPressed: ()=> Navigator.pop(context), 
                icon:const Icon(Icons.arrow_back, color: Colors.white,)),
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverList.builder(
                  itemCount: (snap.hasData)
                      ? (idx = (snap.data?.get("notifications") as List).length)
                      : 0,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(2),
                        child: customNotificationsListTileWidget(
                          callback: () {
                            String subtyp = (snap.data?.get("notifications")
                                as List)[idx - (index + 1)]['subtype'];

                            String id = (snap.data?.get("notifications")
                                as List)[idx - (index + 1)]['messageId'];

                            //snap.data?.reference.
                            updateNotifications((snap.data?.get("notifications")
                                as List)[idx - (index + 1)]['head']);

                            if (subtyp == 'Loan') {
                              debugPrint(
                                  "Here in the call back:::::::::::::>$id");
                              Navigator.pushNamed(
                                  context, RouteGenerator.lendfriendscreen,
                                  arguments: id);
                            } else if (subtyp == 'Donation') {
                              Navigator.pushNamed(
                                  context, RouteGenerator.supportscreen,
                                  arguments: id);
                            } else if (subtyp == 'loan-compaign') {
                              Map<String, dynamic> args = {
                                "isLoan": true,
                                "compaignId": id,
                                "isPublic":false
                              };

                              Navigator.pushNamed(context,
                                  RouteGenerator.compaignOverviewscreen,
                                  arguments: args);
                            } else if (subtyp == 'donation-compaign') {
                              Map<String, dynamic> args = {
                                "isLoan": false,
                                "compaignId": id
                              };

                              Navigator.pushNamed(context,
                                  RouteGenerator.compaignOverviewscreen,
                                  arguments: args);
                            } else if (subtyp == "New follower") {
                              
                              debugPrint('@Drillox {new follower}:::> $id');
                              RouteGenerator.user = id;
                              Navigator.pushNamed(
                                  context, RouteGenerator.friendprofilescreen);
                            }
                          },
                          subType: (snap.data?.get("notifications")
                              as List)[idx - (index + 1)]['subtype'],
                          notificationId: (snap.data?.get("notifications")
                              as List)[idx - (index + 1)]['messageId'],
                          head: (snap.data?.get("notifications")
                              as List)[idx - (index + 1)]['head'],
                          notificationMessage: (snap.data?.get("notifications")
                              as List)[idx - (index + 1)]['message'],
                          viewedStatus: (snap.data?.get("notifications")
                              as List)[idx - (index + 1)]['viewedStatus'],
                        ),
                      )),
            ],
          );
        },
      ),
    );
  }

  Future<void> updateNotifications(int head) async {
    final auth = FirebaseAuth.instance.currentUser;

    final userRf =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(userRf);

      final notificationsList = secureSnap.get("notifications") as List;

      Map<String, dynamic> theNotification = {};
      int index = 0;
      for (int i = 0; i < notificationsList.length; i++) {
        if (notificationsList[i]['head'] == head) {
          theNotification = notificationsList[i] as Map<String, dynamic>;
          notificationsList.removeAt(i);
          index = i;
          break;
        }
      }

      theNotification['viewedStatus'] = true;

      notificationsList.insert(index, theNotification);

      transaction.update(userRf, {"notifications": notificationsList});
    });
  }
}
