import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/state_managers/compaignsStateNotifier.dart';
import 'package:propup/widgets/overview_widget.dart';
import 'package:provider/provider.dart';

class overviewScreen extends StatelessWidget {
  const overviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Compaigns",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ChangeNotifierProvider(
                    create: (context)=> compaignsStateNotifier(),
                    builder: (context, child){
                      return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        decoration: const BoxDecoration(),
                        child: Image.asset("assets/images/support.png"),
                      ),
                      const Text(
                        "All Compaigns",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<compaignsStateNotifier>(
                          builder: (context, value, child) {
                        return SegmentedButton<int>(
                          showSelectedIcon: false,
                          segments: const [
                            ButtonSegment(label: Text("FundRaises"), value: 0),
                            ButtonSegment(label: Text("Loans"), value: 1),
                          ],
                          selected: {value.currentSelected},
                          onSelectionChanged: (selections) {
                            value.changeSelected(index: selections.first);
                          },
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      
                      Consumer<compaignsStateNotifier>(
                        builder: (context, value ,child){
                          return (value.currentSelected ==0)?
                          Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 211, 211, 211),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(5),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(auth?.uid)
                                .snapshots(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                int idx = (snap.data?.get("donations") as List)
                                    .length;
                                debugPrint(">>>>>>>>{@Drillox}::>> $idx");
                                return Column(
                                    children: List.generate(
                                        idx,
                                        (index) => Padding(
                                            padding: EdgeInsets.all(5),
                                            child: customCompaignWidget(
                                                compaignId: (snap.data
                                                        ?.get("donations")
                                                    as List)[idx - (index + 1)],
                                                isLoan: false))));
                              }
                              if (snap.hasError) {
                                return const Center(
                                  child: Text(
                                    "Error loading",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              return Container(
                                constraints:
                                    const BoxConstraints.expand(height: 35),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 224, 224, 224),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.all(5),
                              );
                            }),
                      ):
                      Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 211, 211, 211),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(5),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(auth?.uid)
                                  .snapshots(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  int idx = 0;
                                  return Column(
                                      children: List.generate(
                                          (idx =
                                              (snap.data?.get("loans") as List)
                                                  .length),
                                          (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              child: customCompaignWidget(
                                                  compaignId: (snap.data
                                                              ?.get("loans")
                                                          as List)[
                                                      idx - (index + 1)],
                                                  isLoan: true))));
                                }
                                if (snap.hasError) {}

                                return Container(
                                  constraints:
                                      const BoxConstraints.expand(height: 35),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(5),
                                );
                              }));
                        })
                    ],
                  );
                    },))),
    ));
  }
}
