import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

///
///this will be for defining all the cutom widgets of the overview screen
///

class customCompaignWidget extends StatelessWidget {
  final String compaignId;
  final bool isLoan;
  const customCompaignWidget(
      {required this.compaignId, required this.isLoan, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(">>>>{Amount}::::::::::::>>> $compaignId");
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(isLoan ? "loans" : "donations")
            .doc(compaignId)
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            int amount = snap.data?.get("amount") as int;
            int recieved = snap.data?.get("recieved") as int;
            debugPrint(">>>>{Amount}::: $amount");
            return GestureDetector(
                onTap: () {
                  Map<String, dynamic> args = {
                    "isLoan": isLoan,
                    "compaignId": compaignId
                  };

                  Navigator.pushNamed(
                      context, RouteGenerator.compaignOverviewscreen,
                      arguments: args);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      topRowWidget(
                          purpose: snap.data?.get("purpose"),
                          isLoan: isLoan,
                          isOpen: (snap.data?.get("closed") as bool)
                              ? false
                              : true),
                      LinearProgressIndicator(
                        value: recieved / amount,
                      )
                    ],
                  ),
                ));
          }

          if (snap.hasError) {
            return const Text(
              "There was an error, check your internet connect pliz",
              style: TextStyle(color: Colors.red),
            );
          }

          return Container(
            constraints: const BoxConstraints.expand(height: 35),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 224, 224),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(5),
          );
        });
  }
}

//ignore:camel_case_types
class minorLoanAndClosedWidget extends StatelessWidget {
  final bool isOpen;
  final bool isLoan;
  const minorLoanAndClosedWidget(
      {required this.isOpen, required this.isLoan, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container(
        //     decoration: BoxDecoration(
        //         color: const Color.fromARGB(255, 211, 211, 211),
        //         borderRadius: BorderRadius.circular(10)),
        //     padding: const EdgeInsets.all(3),
        //     child: Text(isLoan ? "Loan" : "FundRaise",
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 12))),
        // const SizedBox(
        //   width: 10,
        // ),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 211, 211),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(3),
            child: Text(isOpen ? "open" : "closed",
                style: TextStyle(
                    color: isOpen ? Colors.blue : Colors.grey, fontSize: 12))),
      ],
    );
  }
}

//ignore:camel_case_types
class topRowWidget extends StatelessWidget {
  final String purpose;
  final bool isOpen;
  final bool isLoan;
  const topRowWidget(
      {required this.purpose,
      required this.isLoan,
      required this.isOpen,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          purpose,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
        )),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          child: Column(
            children: [
              minorLoanAndClosedWidget(isOpen: isOpen, isLoan: isLoan),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )
      ],
    );
  }
}

//ignore:camel_case_types
class compaignOverviewTopWidget extends StatelessWidget {
  final int amount;
  final int recieved;
  final int paidback;
  final String purpose;
  final bool isLoan;
  final bool isClosed;

  const compaignOverviewTopWidget(
      {required this.amount,
      required this.isClosed,
      required this.isLoan,
      required this.paidback,
      required this.purpose,
      required this.recieved,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 216, 216, 216),
          borderRadius: BorderRadius.circular(20)),
      //padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          LayoutBuilder(builder: (context, dimensions) {
            return Container(
              width: dimensions.maxWidth,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          isClosed ? "closed" : "open",
                          style: TextStyle(
                              color: isClosed ? Colors.grey : Colors.green),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    height: 1,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        isLoan ? "Loan" : "Fundraise",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Ugx $amount",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "${((recieved / amount) * 100).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                purpose,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                color: Colors.white,
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          const Text("Recieved",
                              style: TextStyle(color: Color.fromARGB(255, 255, 34, 218))),
                          Text("Ugx $recieved",
                              style: TextStyle(color: Colors.blue))
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          const Text("Loan balance",
                              style: TextStyle(color: Colors.green)),
                          Text(
                            (isLoan && isClosed)
                                ? "Ugx ${amount - paidback}"
                                : "Ugx 0",
                            style: TextStyle(
                                color: (isLoan && isClosed)
                                    ? Colors.red
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),

                    ////////----////////
                    ///
                    
                    Container(
                      decoration: BoxDecoration(
                          color:
                              (isLoan && isClosed) ? Colors.blue : const Color.fromARGB(255, 185, 184, 184),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "pay back",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

//ignore:camel_case_types
class customListTileWidget extends StatelessWidget {
  final String supporter;
  final String perc;
  const customListTileWidget(
      {required this.supporter, required this.perc, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection("users").doc(supporter).get(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  RouteGenerator.user = supporter;
                  Navigator.pushNamed(
                      context, RouteGenerator.friendprofilescreen,
                      arguments: supporter);
                },
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(snap.data?.get("profilePic")),
                  ),
                ),
                title: Text(
                  snap.data?.get("username"),
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: Text(
                  perc,
                  style: const TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              )
            ],
          );
        }

        return Container(
          constraints: const BoxConstraints.expand(height: 30),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 219, 219, 219)),
        );
      },
    );
  }
}
