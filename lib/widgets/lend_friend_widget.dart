import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propup/bloc/payments/loans_and_fundraises/loans.dart';

///
///this is where all the custom widgets of the lend friend screen shall be shown
///
//ignore:camel_case_types
class lendReasonWidget extends StatelessWidget {
  final String message;
  const lendReasonWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 236, 236),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            message,
            style: const TextStyle(color: Colors.grey),
          ),
        ));
  }
}

///
///this is for the amount entry
///
//ignore:camel_case_types
class lendAmountEntryWidget extends StatelessWidget {
  final TextEditingController controller;
  final int paybackTime;
  const lendAmountEntryWidget(
      {required this.controller, required this.paybackTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 216, 216),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 9,
            maxLines: 1,
            controller: controller,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: "ENTER AMOUNT",
                semanticCounterText: ""),
          )),
      Text(
        "Returned on ${DateFormat("yyyy-MM-dd").format(DateTime.fromMicrosecondsSinceEpoch(paybackTime))} with 5% profits",
        style: const TextStyle(color: Colors.grey),
      )
    ]);
  }
}

//ignore:camel_case_types
class lendProgressWidget extends StatelessWidget {
  final String loanId;

  const lendProgressWidget({required this.loanId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 30),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 233, 232, 232)),
      margin: const EdgeInsets.fromLTRB(30, 5, 30, 30),
      child: LayoutBuilder(builder: (context, dimensions) {
        double width = dimensions.maxWidth;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("loans")
              .doc(loanId)
              .snapshots(),
          builder: (context, snap) {
            final int recieved = snap.data?.get("recieved") as int;
            final int amount = snap.data?.get("amount") as int;

            if (snap.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints:
                        BoxConstraints.expand(width: width * recieved / amount),
                    color: Colors.green,
                    child: Center(
                        child: Text(
                      "${((recieved / amount) * 100).round()}%",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              );
            }

            if (snap.hasError) {
              return const Text(
                "There was an error loading progress",
                style: TextStyle(color: Colors.red),
              );
            }

            return const LinearProgressIndicator(
              minHeight: 30,
            );
          },
        );
      }),
    );
  }
}

// ignore: camel_case_types
class compaignsTextualProgress extends StatelessWidget {
  final String compaignId;
  final bool isLoan;

  const compaignsTextualProgress(
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
          final int recieved = snap.data?.get("recieved") as int;
          final int amount = snap.data?.get("amount") as int;

          return Text(
            "$recieved/$amount collected so-far.",
            style: const TextStyle(color: Colors.green),
          );
        }

        if (snap.hasError) {
          return const Text(
            "There was error loading the progress",
            style: TextStyle(color: Colors.red),
          );
        }

        return Container(
          constraints: const BoxConstraints.expand(height: 30),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}

///
///these will be used for either accepting or rejecting to support
///
//ignore:camel_case_types
class lendOptionsRowWidget extends StatelessWidget {
  final String loanId;
  final int amount;
  const lendOptionsRowWidget(
      {required this.amount, required this.loanId, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text(
                          "Processing..",
                          style: TextStyle(color: Colors.black),
                        ),
                        content: FutureBuilder(
                            future: loans
                                .instance()
                                .lendFriend(loanId: loanId, amount: amount),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return (snap.data == 1)
                                    ? const Text(
                                        "Lend succesful.",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : (snap.data == 2)
                                        ? const Text(
                                            "Loan is closed.",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : (snap.data == 0)
                                            ? const Text(
                                                "Your acount balance is low to lend this amount, top-up your account and try again.",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : const Text(
                                                "Lending failed.\n Make sure that you dont have running loans.",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              );
                              }

                              if (snap.hasError) {
                                return const Center(
                                  child: Text(
                                    "(*_*)\n Please Check your internet Connection and try again",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }

                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      ));
            },
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
