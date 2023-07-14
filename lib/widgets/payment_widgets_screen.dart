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
  final GlobalKey _key = GlobalKey<FormState>();

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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "Enter amount"),
              ),
            ),
            const Text(
              "Min:500 And Max 4,000,000",
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
                onTap: (){
                  final userRf = FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser?.uid);

                  // ignore: unrelated_type_equality_checks
                  if (_amountController != "" &&
                      _contactController.text != "") {
                    (!widget.isWithdraw)
                        ? paymentGateWay
                            .instance()
                            .depositToWallet(
                                amount: double.parse(_amountController.text),
                                reason: "Supporting each other",
                                phone: _contactController.text)
                            .then((value) async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Transaction result"),
                                    content: Text(
                                        (value == '1')
                                            ? "Transaction successful"
                                            : "Transaction failed",
                                        style: TextStyle(
                                            color: (value == '1')
                                                ? Colors.green
                                                : Colors.red)),
                                  );
                                });

                          })
                        : paymentGateWay
                            .instance()
                            .withDrawFromWallet(
                                amount: double.parse(_amountController.text),
                                reason: "Supporting each other",
                                phone: _contactController.text)
                            .then((value) async {
                              
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Transaction result"),
                                    content: Text(
                                        (value == '1')
                                            ? "Transaction successful"
                                            : "Transaction failed",
                                        style: TextStyle(
                                            color: (value == '1')
                                                ? Colors.green
                                                : Colors.red)),
                                  );
                                });
                                
                          }); //end of the transaction
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
}
