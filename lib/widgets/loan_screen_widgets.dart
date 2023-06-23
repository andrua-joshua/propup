import 'package:flutter/material.dart';

///
///this is where all the loan  screen custome widgets will be decalred
///

///
///this will be used for entering the purpose of the loan
///
//ignore: camel_case_types
class loanPurposeWidget extends StatefulWidget {
  const loanPurposeWidget({super.key});

  @override
  _loanPurposeWidgetState createState() => _loanPurposeWidgetState();
}

class _loanPurposeWidgetState extends State<loanPurposeWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 241, 240, 240)),
        child: TextField(
          maxLines: 5,
          controller: _controller,
        ));
  }
}

///
///this will be used for entering the amount to fund
///
//ignore: camel_case_types
class loanAmountWidget extends StatefulWidget {
  const loanAmountWidget({super.key});

  @override
  _loanAmountWidgetState createState() => _loanAmountWidgetState();
}

class _loanAmountWidgetState extends State<loanAmountWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 241, 240, 240)),
        child: TextField(
          maxLines: 1,
          keyboardType: TextInputType.number,
          maxLength: 9,
          controller: controller,
        ));
  }
}

///
///this is for entering the loan ureturn date
///
//ignore: camel_case_types
class returnDateWidget extends StatefulWidget {
  const returnDateWidget({super.key});

  @override
  _returnDateWidgetState createState() => _returnDateWidgetState();
}

//ignore: camel_case_types
class _returnDateWidgetState extends State<returnDateWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
            const BoxDecoration(color: Color.fromARGB(255, 241, 240, 240)),
        child: TextField(
          maxLines: 1,
          keyboardType: TextInputType.datetime,
          controller: _controller,
        )
    );
  }
}
