import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/payments/paymen_gateway.dart';
import 'package:propup/routes.dart';

///
///this where all the custom widgets of the payment screen tree shall be created from
///

//ignore: camel_case_types
class optionsWidget extends StatelessWidget {
  const optionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteGenerator.depositOptionscreen),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 219, 218, 218)),
              child: const Text(
                "Deposit",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteGenerator.withdrawOptionscreen),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 219, 218, 218)),
              child: const Text(
                "WithDraw",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )),
      ],
    );
  }
}

///
///the depositing form
//ignore: camel_case_types
class depositFormWidget extends StatefulWidget {
  final bool isWithdraw;
  const depositFormWidget({this.isWithdraw = false, super.key});

  @override
  _depositFormWidgetState createState() => _depositFormWidgetState();
}

//ignore:camel_case_types
class _depositFormWidgetState extends State<depositFormWidget> {
  late final TextEditingController _amountController;
  late final TextEditingController _contactController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _contactController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Amount (UGX)",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 240, 238, 238)),
              padding: const EdgeInsets.all(3),
              child: TextFormField(
                controller: _amountController,
                maxLength: 7,
                maxLines: 1,
                validator: amountValidate,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "Enter amount"),
              ),
            ),
            const Text(
              "Min:10000 And Max 4,000,000",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Mobile Money number",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 240, 238, 238)),
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                controller: _contactController,
                maxLength: 10,
                maxLines: 1,
                validator: phoneValidate,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    counterText: "",
                    prefixIcon: Icon(Icons.contact_emergency),
                    border: InputBorder.none,
                    hintText: "Enter contact"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  // ignore: unrelated_type_equality_checks
                  if (_key.currentState?.validate()??false) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Transaction result"),
                            content: FutureBuilder<String>(
                              future: (!widget.isWithdraw)
                                  ? paymentGateWay.instance().depositToWallet(
                                      amount: int.parse(_amountController.text),
                                      reason: "Supporting each other",
                                      phone: _contactController.text)
                                  : paymentGateWay
                                      .instance()
                                      .withDrawFromWallet(
                                          amount:
                                              int.parse(_amountController.text),
                                          reason: "Supporting each other",
                                          phone: _contactController.text),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    (snapshot.data == '1')
                                        ? "Transaction successful"
                                        : "Transaction failed",
                                    style: TextStyle(
                                        color: (snapshot.data == '1')
                                            ? Colors.green
                                            : Colors.red),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      "^(*_*)^\nError ${snapshot.error}",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            actions: [],
                          );
                        });
                  }
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    widget.isWithdraw ? "CONFIRM WITHDRAW" : "CONFIRM DEPOSIT",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ))
          ],
        ));
  }

  String? amountValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter amount please";
    } else {
      try {
        int amount = int.parse(txt ?? "");
        if (amount < 10000 && widget.isWithdraw) {
          return "min withdraw amount is 10000";
        }
      } catch (e) {
        return "Enter valid amount";
      }
    }

    return null;
  }

  String? phoneValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter contact please eg.0754734525";
    } else {
      if (txt?.length != 10) {
        return "Enter a valid 10 digit phone";
      }
    }
    return null;
  }
}
