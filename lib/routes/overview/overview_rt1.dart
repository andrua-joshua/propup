import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/overview_widget.dart';

class compaignOverviewScreen extends StatelessWidget {
  final Map args;
  const compaignOverviewScreen({required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoan = args['isLoan'] as bool;
    final String compaignId = args['compaignId'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Compaign OverView",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(isLoan ? "loans" : "donations")
                  .doc(compaignId)
                  .snapshots(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Column(
                    children: [
                      compaignOverviewTopWidget(
                          amount: snap.data?.get("amount"),
                          isClosed: snap.data?.get("closed"),
                          isLoan: isLoan,
                          paidback: isLoan ? snap.data?.get("paidback") : 0,
                          purpose: snap.data?.get("purpose"),
                          recieved: snap.data?.get("recieved")),
                      const SizedBox(
                        height: 20,
                      ),
                      LayoutBuilder(builder: (context, dimensions) {
                        int idx = 0;

                        final List all = snap.data
                            ?.get(isLoan ? "lenders" : "donars") as List;
                        final Map<String, int> filtered = {};

                        for (var element in all) {
                          filtered.update(element[isLoan ? 'lender' : 'donar'],
                              (value) => (value + (element['amount'] as int)),
                              ifAbsent: () => element['amount']);
                        }

                        final keys = filtered.keys.toList();

                        return Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: List.generate(
                                (idx = keys.length),
                                (index) => customListTileWidget(
                                    supporter: keys[index],
                                    perc:
                                        "${((filtered[keys[index]] as int) / (snap.data?.get("amount") as int) * 100).toStringAsFixed(0)}%")),
                          ),
                        );
                      })
                    ],
                  );
                }
                if (snap.hasError) {}

                return const Center(child: CircularProgressIndicator());
              }),
        ),
      )),
    );
  }
}
