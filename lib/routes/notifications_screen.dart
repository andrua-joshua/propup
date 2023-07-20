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
        stream: FirebaseFirestore.instance.collection("users").doc(auth?.uid).snapshots(),
        builder: (context, snap){
          int idx = 0;

          return CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Notifications",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
          SliverList.builder(
              itemCount: (idx = (snap.data?.get("notifications") as List).length),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: customNotificationsListTileWidget(
                      callback: (){
                        String subtyp = (snap.data?.get("notifications") as List)[idx -(index+1)]['subType'];

                        if(subtyp =='Loan'){
                          Navigator.pushNamed(
                            context, RouteGenerator.lendfriendscreen,
                            arguments: (snap.data?.get("notifications") as List)[idx -(index+1)]['messageId'] 
                            );
                        }else if(subtyp =='Donation'){
                          Navigator.pushNamed(
                            context, RouteGenerator.supportscreen,
                            arguments: (snap.data?.get("notifications") as List)[idx -(index+1)]['messageId'] 
                            );
                        } 

                      },
                      subType: (snap.data?.get("notifications") as List)[idx -(index+1)]['subType'],
                      notificationId: (snap.data?.get("notifications") as List)[idx -(index+1)]['messageId'],
                      head: (snap.data?.get("notifications") as List)[idx -(index+1)]['head'],
                    ),
                  ))
        ],
      );
        },
      ),
    );
  }
}
