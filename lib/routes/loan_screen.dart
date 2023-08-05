import 'package:flutter/material.dart';
import 'package:propup/bloc/payments/loans_and_fundraises/loans.dart';
import 'package:propup/widgets/loan_screen_widgets.dart';
import 'package:provider/provider.dart';

import '../state_managers/compaign_publi.dart';

///
///this class will be responsible for the loan page
///
//ignore:camel_case_types
class loanScreen extends StatelessWidget {
  const loanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _purposeController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();
    bool isPublic = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 92, 181),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "LOAN",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              "PURPOSE OF FUNDS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: loanPurposeWidget(
                controller: _purposeController,
              ),
            ),
            const Text(
              "AMOUNT",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: loanAmountWidget(
                controller: _amountController,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "Return Date (4% interest rate)",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: returnDateWidget(
                dateController: _dateController,
              ),
            ),
            ChangeNotifierProvider<loanCompaign>(
              create: (context) => loanCompaign(),
              builder: (context, child) {
                return SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<loanCompaign>(builder: (_, value, child) {
                        isPublic = value.currentState;
                        return Checkbox(
                            value: value.currentState,
                            onChanged: (state) =>
                                value.currentStateSet(state ?? false));
                      }),
                      const Text("public compaign", style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                );
              },
            ),
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
                                future: loans.instance().requestLoan(
                                    amount: int.parse(_amountController.text),
                                    interestRate: 5,
                                    isPublic: isPublic,
                                    paybackTime:
                                        DateTime.parse(_dateController.text),
                                    purpose: _purposeController.text),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return (snap.data ?? false)
                                        ? const Text(
                                            "Loan request succesful.",
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        : const Text(
                                            "Loan request failed.\n Make sure that you dont have running loans.",
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

                  //Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "INVITE FRIENDS",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )))
          ],
        ),
      )),
    );
  }
}
