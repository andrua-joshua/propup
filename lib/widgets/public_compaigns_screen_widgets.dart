import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class publicCompaignWidget extends StatelessWidget {
  final bool isLoans;
  const publicCompaignWidget({required this.isLoans, super.key});

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseFirestore.instance.collection("users").doc
    final fundRaisesCompaigns = FirebaseFirestore.instance
        .collection("public-compaigns")
        .doc("CzMnBYOmkuIcS1FX0B4Y");
    // final loanCompaigns = FirebaseFirestore.instance
    //     .collection("public-compaigns")
    //     .doc("O8DnKgq2bN8QcKJifrca");

    // final snapshots = isLoans? loanCompaigns.snapshots()
    //     : fundRaisesCompaigns.snapshots();

    // FirebaseFirestore.instance.collection("loans").doc("").get();
    return StreamBuilder<DocumentSnapshot>(
        stream: fundRaisesCompaigns.snapshots(), //snapshots,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data != null) {
              var selectedLists = [];
              debugPrint(":::::@DRillox :{chkng}::::>>>> ${snap.data}");
              return ListView.builder(
                  itemCount: isLoans
                      ? (selectedLists = (snap.data?.get("loans") as List))
                          .length
                      : (selectedLists = (snap.data?.get("fundraises") as List))
                          .length,
                  itemBuilder: (context, index) {
                    var clearList = selectedLists.reversed.toList();
                    return FutureBuilder(
                        future: isLoans
                            ? FirebaseFirestore.instance
                                .collection("loans")
                                .doc(clearList[index])
                                .get()
                            : FirebaseFirestore.instance
                                .collection("donations")
                                .doc(clearList[index])
                                .get(),
                        builder: (context, snapx) {
                          if (snapx.hasData) {
                            return customListWidget(
                              isLoan: false,
                                compaignId: snapx.data?.id ?? "",
                                ownerId: snapx.data?.get("user"),
                                amount: snapx.data?.get("amount"),
                                recieved: snapx.data?.get("recieved"));
                          }
                          if (snapx.hasError) {}
                          return const Center();
                        });
                  });
            }
          }

          if (snap.hasError) {
            return const Center(
              child: Text("Check your network"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class publicLoansCompaignWidget extends StatelessWidget {
  final bool isLoans;
  const publicLoansCompaignWidget({required this.isLoans, super.key});

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseFirestore.instance.collection("users").doc
    // final fundRaisesCompaigns = FirebaseFirestore.instance
    //     .collection("public-compaigns")
    //     .doc("CzMnBYOmkuIcS1FX0B4Y");
    final loanCompaigns = FirebaseFirestore.instance
        .collection("public-compaigns")
        .doc("O8DnKgq2bN8QcKJifrca");

    // final snapshots = isLoans? loanCompaigns.snapshots()
    //     : fundRaisesCompaigns.snapshots();

    // FirebaseFirestore.instance.collection("loans").doc("").get();
    return StreamBuilder<DocumentSnapshot>(
        stream: loanCompaigns.snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data != null) {
              var selectedLists = [];
              debugPrint(":::::@DRillox :{chkng}::::>>>> ${snap.data}");
              return ListView.builder(
                  itemCount: isLoans
                      ? (selectedLists = (snap.data?.get("loans") as List))
                          .length
                      : (selectedLists = (snap.data?.get("fundraises") as List))
                          .length,
                  itemBuilder: (context, index) {
                    var clearList = selectedLists.reversed.toList();
                    return FutureBuilder(
                        future: isLoans
                            ? FirebaseFirestore.instance
                                .collection("loans")
                                .doc(clearList[index])
                                .get()
                            : FirebaseFirestore.instance
                                .collection("donations")
                                .doc(clearList[index])
                                .get(),
                        builder: (context, snapx) {
                          if (snapx.hasData) {
                            return customListWidget(
                                compaignId: clearList[index],
                                isLoan: true,
                                ownerId: snapx.data?.get("user"),
                                amount: snapx.data?.get("amount"),
                                recieved: snapx.data?.get("recieved"));
                          }
                          if (snapx.hasError) {}
                          return const Center();
                        });
                  });
            }
          }

          if (snap.hasError) {
            return const Center(
              child: Text("Check your network"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class customListWidget extends StatelessWidget {
  final String ownerId;
  final int amount;
  final int recieved;
  final String compaignId;
  final bool isLoan;

  const customListWidget(
      {required this.ownerId,
      required this.amount,
      required this.isLoan,
      required this.compaignId,
      required this.recieved,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Map<String, dynamic> args = {
            "isLoan": isLoan,
            "compaignId": compaignId,
            "isPublic": true
          };
          debugPrint(":::::::@Drillox :{the id}::::> $compaignId");

          Navigator.pushNamed(context, RouteGenerator.compaignOverviewscreen,
              arguments: args);
        },
        child: Card(
            elevation: 8,
            child: Container(
              height: 55,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(ownerId)
                                .snapshots(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                if (snap.data != null) {
                                  return Text(
                                    snap.data?.get("username"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              }
                              if (snap.hasError) {
                                return const Text("Unknown.");
                              }
                              return const Text("Loading..");
                            }),
                        Text(
                          "${((recieved / amount) * 100).round()}%",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  LinearProgressIndicator(
                    value: recieved / amount,
                  )
                ],
              ),
            )));
  }
}
