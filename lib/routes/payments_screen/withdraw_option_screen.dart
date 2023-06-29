

import 'package:flutter/material.dart';
import 'package:propup/widgets/payment_widgets_screen.dart';

///
///this is for the withdraw option
///
//ignore:camel_case_types
class withdrawOptionScreen extends StatelessWidget {
  const withdrawOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Withdraw Money",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: depositFormWidget(isWithdraw: true,),
                )
            ],
          ),
        )),
    );
  }
}
