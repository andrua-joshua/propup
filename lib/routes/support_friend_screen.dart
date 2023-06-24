import 'package:flutter/material.dart';
import 'package:propup/widgets/support_screen_widgets.dart';

///
///this is where a friend able to support other friend
///
//ignore:camel_case_types
class supportFriendScreen extends StatelessWidget {
  const supportFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Leonard",
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
                    "Purpose of Funds",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  supportReasonWidget(
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
                  amountEntryWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  progressWidget(),
                  SizedBox(
                    height: 40,
                  ),
                  optionsRowWidget()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
