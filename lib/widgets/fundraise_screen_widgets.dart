import 'package:flutter/material.dart';

///
/// all the custom widgets of the fundraise screen declared here
///

//ignore: camel_case_types
class transactionDataWidget extends StatelessWidget {
  final bool isBorrowed;
  const transactionDataWidget({required this.isBorrowed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isBorrowed
            ? const Text(
                "+\$352.5",
                style: TextStyle(color: Colors.green, fontSize: 19),
              )
            : const Text(
                "-\$58.9",
                style: TextStyle(color: Colors.red, fontSize: 19),
              ),
        const Text(
          "July 14, 2022",
          style: TextStyle(color: Colors.grey),
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
