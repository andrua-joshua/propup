import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

///
///this is where the post tabs shall be created from
///
//ignore:camel_case_types
class postsTab extends StatelessWidget {
  const postsTab({super.key});

  final images = const <String>[
    "assets/images/pic1.jpg",
    "assets/images/pp.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final usersStore = FirebaseFirestore.instance.collection("users");

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5), child: postsTopWidget()),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: postsStore.snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView.builder(
                        itemCount: snap.data?.size,
                        itemBuilder: (contxt, index) {
                          return Padding(
                              padding: const EdgeInsets.all(10),
                              child: postsTabPostWidget(image: snap.data!.docs[index].id));
                        });
                  }

                  if(snap.hasError){
                    return const Center(child: Text("(*_*)", style: TextStyle(color:Colors.red),),);
                  }

                  return const Center(
                    //child: CircularProgressIndicator(),
                  );
                }))
      ],
    ));
  }
}
