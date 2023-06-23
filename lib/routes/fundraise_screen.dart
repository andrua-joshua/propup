import 'package:flutter/material.dart';
import 'package:propup/widgets/fundraise_screen_widgets.dart';

///this is where the fundraise route is created from
///
//ignore: camel_case_types
class fundRaiseScreen extends StatelessWidget {
  const fundRaiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FUND RAISE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.foundation,
              size: 40,
            ),
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
              child: purposeWidget(),
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
              child: amountWidget(),
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
      ),
    );
  }
}
