import 'package:flutter/material.dart';
import 'package:propup/widgets/loan_screen_widgets.dart';

///
///this class will be responsible for the loan page
///
//ignore:camel_case_types
class loanScreen extends StatelessWidget {
  const loanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "LOAN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Purpose of funds",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: loanPurposeWidget(),
            ),
            const Text(
              "Amount",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: loanAmountWidget(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Return Date (1% interest rate)",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: returnDateWidget(),
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "Invite friends",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    )))
          ],
        ),
      )),
    );
  }
}
