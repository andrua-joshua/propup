import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/overview_widget.dart';

class overviewScreen extends StatelessWidget {
  const overviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Compaigns",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/support.png"),
                                fit: BoxFit.fill)),
                      ),
                      const Text(
                        "All Compaigns",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 211, 211, 211),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(auth?.uid)
                                  .snapshots(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  int idx = 0;
                                  List.generate(
                                      (idx =
                                          (snap.data?.get("donations") as List)
                                              .length),
                                      (index) => customCompaignWidget(
                                          compaignId:
                                              (snap.data?.get("donations")
                                                  as List)[idx - (index + 1)],
                                          isLoan: false));
                                }
                                if (snap.hasError) {}

                                return Container(
                                  constraints:
                                      const BoxConstraints.expand(height: 35),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(5),
                                );
                              })
                        ]),
                      ),

                      const SizedBox(height: 10,),

                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 211, 211, 211),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(auth?.uid)
                                  .snapshots(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  int idx = 0;
                                  List.generate(
                                      (idx =
                                          (snap.data?.get("loans") as List)
                                              .length),
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                        child:customCompaignWidget(
                                          compaignId:
                                              (snap.data?.get("loans")
                                                  as List)[idx - (index + 1)],
                                          isLoan: true)));
                                }
                                if (snap.hasError) {}

                                return Container(
                                  constraints:
                                      const BoxConstraints.expand(height: 35),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(5),
                                );
                              })
                        ]),
                      )
                    ],
                  )))),
    );
  }
}
