import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/lend_friend_widget.dart';

///
///this is where the code for implementing the lending a friends widget shall be
///created from
///
//ignore:camel_case_types
class lendFriendScreen extends StatelessWidget {
  final String loanId;
  const lendFriendScreen({required this.loanId, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    debugPrint("***********************>> $loanId");
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("loans").doc(loanId).get(),
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
                          "Purpose of Loan",
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
                        lendAmountEntryWidget(
                          controller: controller,
                          paybackTime: snap.data?.get("paybackTime") as int,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        lendProgressWidget(
                          recieved: snap.data?.get("recieved") as int,
                          amount: snap.data?.get("amount") as int,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        lendOptionsRowWidget(
                          loanId: loanId,
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
