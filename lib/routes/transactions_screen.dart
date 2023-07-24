import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propup/widgets/fundraise_screen_widgets.dart';

///
///this is where the transaction screen widget  will be defined
///
//ignore: camel_case_types
class transactionsScreen extends StatelessWidget {
  const transactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    return Scaffold(
      body: StreamBuilder(
          stream: user.snapshots(),
          builder: (context, snap) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  centerTitle: true,
                  expandedHeight: 120,
                  collapsedHeight: 80,
                  title: const Text(
                    "Transactions",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      DateFormat("MMMM-dd-yyyy").format(DateTime.now()),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                ),
                SliverList.builder(
                    itemCount: (snap.hasData)
                        ? (snap.data?.get("transactions") as List).length
                        : 0,
                    itemBuilder: (context, index) => ListTile(
                          leading: Card(
                              elevation: 7,
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(7),
                                child: const Icon(
                                  Icons.fingerprint_sharp,
                                  color: Colors.grey,
                                ),
                              )),
                          title: Text(
                            ((snap.data?.get("transactions") as List)[index]
                                        ['type'] ==
                                    'donation-recieved')
                                ? "Recieved funds"
                                : ((snap.data?.get("transactions")
                                            as List)[index]['type'] ==
                                        'loan-recieved')
                                    ? "Recieved Loan"
                                    : (snap.data?.get("transactions")
                                        as List)[index]['type'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            (snap.data?.get("transactions") as List)[index]
                                ['message'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: transactionDataWidget(
                            date: (snap.data?.get("transactions")
                                as List)[index]['date'] as int,
                            type: (snap.data?.get("transactions")
                                as List)[index]['type'] as String,
                            amount: (snap.data?.get("transactions")
                                as List)[index]['amount'] as int,
                          ),
                        ))
              ],
            );
          }),
    );
  }
}
