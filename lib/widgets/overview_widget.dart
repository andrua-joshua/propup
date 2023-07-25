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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(isLoan ? "loans" : "donations")
            .doc(compaignId)
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            int amount = snap.data?.get("amount") as int;
            int recieved = snap.data?.get("recieved") as int;
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
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 211, 211),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: Text(isLoan ? "Loan" : "Fund",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        const SizedBox(
          width: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 211, 211),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: Text(isOpen ? "open" : "closed",
                style: TextStyle(
                  color: isOpen ? Colors.blue : Colors.grey,
                ))),
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
        Text(
          purpose,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
        ),
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
          color: const Color.fromARGB(255, 192, 191, 191),
          borderRadius: BorderRadius.circular(10)),
      //padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          LayoutBuilder(builder: (context, dimensions) {
            return Container(
              width: dimensions.maxWidth,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(5),
              child: Column(
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
                    height: 3,
                  ),
                  Text(
                    isLoan ? "Loan" : "Fundraise",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Ugx $amount",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(10),
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
                        const SizedBox(
                          width: 10,
                        ),
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
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      const Text("Recieved",
                          style: TextStyle(color: Colors.black)),
                      Text("Ugx $recieved")
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      const Text("Debit",
                          style: TextStyle(color: Colors.black)),
                      Text(
                        (isLoan && isClosed)
                            ? "Ugx -${amount - paidback}"
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
                Container(
                  decoration: BoxDecoration(
                      color: (isLoan && isClosed) ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    "pay back",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          )
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
                onTap: () => Navigator.pushNamed(
                    context, RouteGenerator.friendprofilescreen,
                    arguments: supporter),
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        "data:image/jpeg;base64,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"),
                  ),
                ),
                title: Text(
                  snap.data?.get("username"),
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: Text(
                  perc,
                  style: const TextStyle(color: Colors.green),
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
