import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///this is where all the loan  screen custome widgets will be decalred
///

///
///this will be used for entering the purpose of the loan
///
//ignore: camel_case_types
class loanPurposeWidget extends StatelessWidget {
  final TextEditingController controller;
  const loanPurposeWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 240, 240),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          textAlign: TextAlign.center,
          maxLines: 4,
          controller: controller,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "Enter purpose"),
        ));
  }
}

///
///this will be used for entering the amount to fund
///
//ignore: camel_case_types
class loanAmountWidget extends StatelessWidget {
  final TextEditingController controller;
  const loanAmountWidget({required this.controller, super.key});

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
              border: InputBorder.none,
              hintText: "Enter amount",
              counterText: ""),
        ));
  }
}

///
///this is for entering the loan ureturn date
///
//ignore: camel_case_types
class returnDateWidget extends StatefulWidget {
  final TextEditingController dateController;
  const returnDateWidget({required this.dateController, super.key});

  @override
  _returnDateWidgetState createState() => _returnDateWidgetState();
}

//ignore: camel_case_types
class _returnDateWidgetState extends State<returnDateWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(height: 35),
        decoration:
            const BoxDecoration(color: Color.fromARGB(118, 241, 240, 240)),
        child: TextFormField(
          controller: widget.dateController,
          decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              border: InputBorder.none,
              hintText: "Enter Date"),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("yyyy-MM-dd").format(pickedDate);

              setState(() {
                widget.dateController.text = formattedDate;
              });
            }
          },
        ));
  }
}
