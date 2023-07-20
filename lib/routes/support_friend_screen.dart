import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/support_screen_widgets.dart';

import '../widgets/lend_friend_widget.dart';

///
///this is where a friend able to support other friend
///
//ignore:camel_case_types
class supportFriendScreen extends StatelessWidget {
  final String donationId;
  const supportFriendScreen({
    required this.donationId,
    super.key});

  @override
  Widget build(BuildContext context) {

   final TextEditingController controller 
    = TextEditingController();

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("loans").doc(donationId).get(),
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
                        lendReasonWidget(
                            message: snap.data?.get("purpose")),
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
                        optionsRowWidget(
                          donationId:donationId,
                          amount: int.parse(controller.text),
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
