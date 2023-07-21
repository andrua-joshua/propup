import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/support_screen_widgets.dart';
import 'package:propup/bloc/payments/loans_and_fundraises/donation.dart';

import '../widgets/lend_friend_widget.dart';

///
///this is where a friend able to support other friend
///
//ignore:camel_case_types
class supportFriendScreen extends StatelessWidget {
  final String donationId;
  const supportFriendScreen({required this.donationId, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: '0');

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("donations")
          .doc(donationId)
          .get(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(snap.data?.get("user"))
                        .get(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return Text(
                          snapShot.data?.get("username"),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        );
                      }

                      if (snapShot.hasError) {
                        return const Text(
                          "Error, check your network plz",
                          style: TextStyle(color: Colors.red),
                        );
                      }

                      return Container(
                        constraints: const BoxConstraints.expand(height: 30),
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 219, 219, 219),
                            borderRadius: BorderRadius.circular(10)),
                      );
                    })),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Friends since 2021"),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        const Text(
                          "Purpose of Funds",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        lendReasonWidget(message: snap.data?.get("purpose")),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Amount",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        amountEntryWidget(
                          controller: controller,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        progressWidget(
                          recieved: snap.data?.get("recieved") as int,
                          amount: snap.data?.get("amount") as int,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // optionsRowWidget(
                        //   donationId:donationId,
                        //   amount: int.parse(controller.text),
                        // )

                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 7, 25, 7),
                                    child: const Text(
                                      "Reject",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                "Processing..",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              content: FutureBuilder(
                                                  future: donations
                                                      .instance()
                                                      .donateToFriend(
                                                          donationId:
                                                              donationId,
                                                          amount: int.parse(
                                                              controller.text)),
                                                  builder: (context, snap) {
                                                    if (snap.hasData) {
                                                      return (snap.data == 1)
                                                          ? const Text(
                                                              "Funding succesful.",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            )
                                                          : (snap.data == 2)
                                                              ? const Text(
                                                                  "Fund compaign is closed.",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              : (snap.data == 0)
                                                                  ? const Text(
                                                                      "Your acount balance is low to make this funding, top-up your account and try again.",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    )
                                                                  : const Text(
                                                                      "Funding failed.\n",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    );
                                                    }

                                                    if (snap.hasError) {
                                                      return const Center(
                                                        child: Text(
                                                          "(*_*)\n Please Check your internet Connection and try again",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      );
                                                    }

                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }),
                                            ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 7, 25, 7),
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }

        if (snap.hasError) {
          return const Center(
            child: Text(
              "Error, check your network plz",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 219, 219),
              borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}
