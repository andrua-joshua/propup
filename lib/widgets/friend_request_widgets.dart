import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///
///this is where all the friend request screen custom widgets shall be created from
///

//ignore:camel_case_types
class friendLocationWidget extends StatelessWidget {
  const friendLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usersStore = FirebaseFirestore.instance.collection("users");
    final user = FirebaseAuth.instance.currentUser;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on),
        StreamBuilder(
            stream: usersStore.doc(user?.uid).snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return const Text(
                  "Error retriving info",
                  style: TextStyle(color: Colors.redAccent),
                );
              }
              if (snap.hasData) {
                if (snap.data != null) {
                  return Text(
                    snap.data?.get("location"),
                    style: const TextStyle(color: Colors.grey, fontSize: 22),
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            })
      ],
    );
  }
}

///
///options towards the request
//ignore: camel_case_types
class requestOptionsRowWidget extends StatelessWidget {
  const requestOptionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
              child: const Text(
                "Reject",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )),
        TextButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
              child: const Text(
                "Accept",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ))
      ],
    );
  }
}

///
///the friend details row here
//ignore: camel_case_types
class friendDetailsRowWidget extends StatelessWidget {
  const friendDetailsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customColumnWidget(mainData: "1.6k", subData: "Friends"),
        customColumnWidget(mainData: "\$489", subData: "Recieved"),
        customColumnWidget(mainData: "\$3.7k", subData: "Donated")
      ],
    );
  }
}

///
///this for holding two values in a column
//ignore: camel_case_types
class customColumnWidget extends StatelessWidget {
  final String mainData;
  final String subData;
  const customColumnWidget(
      {required this.mainData, required this.subData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mainData,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Text(
          subData,
          style: const TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
