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
    final TextEditingController controller = TextEditingController();

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
                backgroundColor:  const Color.fromARGB(255, 8, 92, 181),
                leading: IconButton(onPressed: ()=> Navigator.pop(context), 
                icon: const Icon(Icons.arrow_back, color: Colors.white,)),
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
                              color: Colors.white,
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
                          "Amount to Fund",
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
                          donationId: snap.data?.id ?? "",
                        ),
                        compaignsTextualProgress(
                            compaignId: donationId, isLoan: false),
                        const SizedBox(
                          height: 40,
                        ),
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
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                                          actionsPadding: const EdgeInsets.only(bottom: 10),
                                          //titlePadding: const EdgeInsets.only(top: 4,left: 5),
                                          //contentPadding: const EdgeInsets.symmetric(horizontal:10),
                                              actions: [
                                                Center(child:GestureDetector(
                                                    onTap: () {
                                                      for (int i = 0; i < 3;i++) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("Ok", style: TextStyle(color: Colors.white),)))
                                                ],
                                              title: const Center(child:Text(
                                                "Processing..",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
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
                                                          ? SizedBox(
                                                            height: 65,
                                                            child:Column(
                                                              children: [
                                                                const Text(
                                                                  "Funding succesful.",
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                      color: Colors
                                                                          .green),
                                                                ),
                                                                SizedBox(height: 4,),
                                                                compaignsTextualProgress(
                                                                    compaignId:
                                                                        donationId,
                                                                    isLoan:
                                                                        false),
                                                                        // const Expanded(child: SizedBox()),
                                                                        // const SizedBox(height: 3,),
                                                                        // const Divider(
                                                                        //   thickness: 1,
                                                                        //   color: Colors.grey,
                                                                        // )
                                                              ],
                                                            ))
                                                          : (snap.data == 2)
                                                              ? const Text(
                                                                  "Fund compaign is closed.",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              : (snap.data == 0)
                                                                  ? const Text(
                                                                      "Your acount balance is low to make this funding, top-up your account and try again.",
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    )
                                                                  : const Text(
                                                                      "Funding failed.",
                                                                      textAlign: TextAlign.center,
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
