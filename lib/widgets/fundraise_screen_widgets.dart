import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// all the custom widgets of the fundraise screen declared here
///

//ignore: camel_case_types
class transactionDataWidget extends StatelessWidget {
  final String type;
  final int date;
  final int amount;
  const transactionDataWidget({
    required this.type,
    required this.amount,
    required this.date,
    super.key});

  @override
  Widget build(BuildContext context) {
    bool add = false;

    switch(type){
      case 'Donation':
        add = false;
        break;
      case 'Lent':
        add = false;
        break;
      case 'loan-recieved':
        add = true;
        break;
      case 'donation-recieved':
        add = true;
        break;
      case 'Withdraw':
        add = false;
        break;
      case 'Deposit':
        add = true;
        break;
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        add
            ? Text(
                "+ Ugx $amount",
                style: const TextStyle(color: Colors.green, fontSize: 19),
              )
            : Text(
                "- Ugx $amount",
                style: const TextStyle(color: Colors.red, fontSize: 19),
              ),
        Text(
          DateFormat("MM-dd-yyyy").format(DateTime.fromMicrosecondsSinceEpoch(date)),
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

///
///this will be used for entering the purpose of the fundraising
///
//ignore: camel_case_types
class purposeWidget extends StatelessWidget {
  final TextEditingController controller;
  const purposeWidget({required this.controller  ,super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 240, 240),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          maxLines: 5,
          controller: controller,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "Enter purpose of funds"),
        ));
  }
}

///
///this will be used for entering the amount to fund
///
//ignore: camel_case_types
class amountWidget extends StatelessWidget {
  final TextEditingController controller;
  const amountWidget({ required this.controller ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 240, 240),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          maxLines: 1,
          keyboardType: TextInputType.number,
          maxLength: 9,
          controller: controller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            counterText: "",
            hintText: "Enter Amount",
            border: InputBorder.none,
          ),
        ));
  }
}
