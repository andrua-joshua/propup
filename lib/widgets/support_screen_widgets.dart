import 'package:flutter/material.dart';

///
///this is where all the custom widgets of the support screen shall be shown
///
//ignore:camel_case_types
class supportReasonWidget extends StatelessWidget {
  final String message;
  const supportReasonWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 237, 236, 236)),
          child: Text(
            message,
            style: const TextStyle(color: Colors.grey),
          ),
        ));
  }
}

///
///this is for the amount entry
///
//ignore:camel_case_types
class amountEntryWidget extends StatefulWidget {
  const amountEntryWidget({super.key});
  @override
  _amountEntryWidgetState createState() => _amountEntryWidgetState();
}

//ignore:camel_case_types
class _amountEntryWidgetState extends State<amountEntryWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        color: const Color.fromARGB(255, 218, 216, 216),
        child: TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 9,
          maxLines: 1,
          controller: _controller,
          decoration: const InputDecoration(
              counterText: "",
              hintText: "ENTER AMOUNT",
              semanticCounterText: ""),
        ));
  }
}

//ignore:camel_case_types
class progressWidget extends StatelessWidget {
  const progressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 30),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 233, 232, 232)),
      margin: const EdgeInsets.fromLTRB(30, 5, 30, 30),
      child: LayoutBuilder(builder: (context, dimensions) {
        double width = dimensions.maxWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints.expand(width: width * 0.7),
              color: Colors.green,
              child: const Center(
                  child: Text(
                "70%",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        );
      }),
    );
  }
}

///
///these will be used for either accepting or rejecting to support
///
//ignore:camel_case_types
class optionsRowWidget extends StatelessWidget {
  const optionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
              child: const Text(
                "Reject",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )),
        TextButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
              child: const Text(
                "Accept",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ))
      ],
    );
  }
}
