import 'package:flutter/material.dart';
import 'package:propup/widgets/lpend_friend_widget.dart';

///
///this is where the code for implementing the lending a friends widget shall be
///created from
///
//ignore:camel_case_types
class lendFriendScreen extends StatelessWidget {
  const lendFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Derulous Nertalia',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Friends since 2021"),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Text(
                    "Purpose of Loan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  lendReasonWidget(
                      message: "Hello friends, i urgently need your help."
                              "My daughter is os sick an di don't have money at the moment." +
                          "Please help me and accept my request, thank you"),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Amount",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  lendAmountEntryWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  lendProgressWidget(),
                  SizedBox(
                    height: 40,
                  ),
                  lendOptionsRowWidget()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
