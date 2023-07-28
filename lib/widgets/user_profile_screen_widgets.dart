import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///This is where all the user profile screen custom widgets will be defimed
///

//ignore:camel_case_types
class profileImageWidget extends StatelessWidget {
  const profileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 72,
                  backgroundImage:
                      CachedNetworkImageProvider(snap.data?.get("profilePic"),maxHeight: 264, maxWidth: 264)),
            );
          }
          if (snap.hasError) {
            return const CircleAvatar();
          }
          return const CircleAvatar(
            radius: 40,
          );
        });
  }
}

///
///this for the declaration of the users details
///
//ignore: camel_case_types
class userInfoWidget extends StatelessWidget {
  const userInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        children: [
          userDataTileWidget(
              icon: Icons.account_box_outlined,
              title: "Account Info",
              callback: () =>
                  Navigator.pushNamed(context, RouteGenerator.myProfilescreen)),
          userDataTileWidget(
            icon: Icons.account_balance,
            title: "Payments",
            callback: () => Navigator.pushNamed(
                context, RouteGenerator.paymentOptionsscreen),
          ),
          userDataTileWidget(
            icon: Icons.settings,
            title: "Settings",
            callback: () {},
          ),
          userDataTileWidget(
            icon: Icons.help_center,
            title: "Help Center",
            callback: () {},
          ),
          userDataTileWidget(
            icon: Icons.contact_mail,
            title: "Contact Us",
            callback: () {},
          ),
          userDataTileWidget(
            icon: Icons.share,
            title: "Share App",
            callback: () {},
          ),
          userDataTileWidget(
            icon: Icons.star_rate,
            title: "Rate App",
            callback: () {},
          ),
          userDataTileWidget(
            icon: Icons.logout,
            title: "Logout",
            callback: () async {
              String? id = FirebaseAuth.instance.currentUser?.uid;
              final user =
                  FirebaseFirestore.instance.collection("users").doc(id);

              await FirebaseAuth.instance.signOut().then((value) async {
                user.update({"token": ""});
                Navigator.pushNamed(context, RouteGenerator.welcomescreen);
              });
            },
          )
        ],
      ),
    );
  }
}

///
///this is for the user data listing
///
//ignore:camel_case_types
class userDataTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() callback;
  const userDataTileWidget(
      {required this.icon,
      required this.callback,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
}
