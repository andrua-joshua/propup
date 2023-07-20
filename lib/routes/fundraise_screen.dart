import 'package:flutter/material.dart';
import 'package:propup/bloc/payments/loans_and_fundraises/donation.dart';
import 'package:propup/widgets/fundraise_screen_widgets.dart';

///this is where the fundraise route is created from
///
//ignore: camel_case_types
class fundRaiseScreen extends StatelessWidget {
  const fundRaiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _purposeController = TextEditingController();

    final TextEditingController _amountController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(20),
              child: purposeWidget(
                controller: _purposeController,
              ),
            ),
            const Text(
              "Amount",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: amountWidget(controller: _amountController),
            ),
            TextButton(
                onPressed: () {
                  debugPrint(":::::::@Drilloxc");
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              "Processing..",
                              style: TextStyle(color: Colors.black),
                            ),
                            content: FutureBuilder(
                                future: donations.instance().requestDonation(
                                    amount: int.parse(_amountController.text),
                                    purpose: _purposeController.text),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return (snap.data ?? false)
                                        ? const Text(
                                            "FundRaise request succesful.",
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        : const Text(
                                            "FundRaise request failed.\n Make sure that you dont have running fundraises.",
                                            style: TextStyle(color: Colors.red),
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

              debugPrint(":::::::@Drillox xcvcv");
                 // Navigator.pop(context);
                },
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
