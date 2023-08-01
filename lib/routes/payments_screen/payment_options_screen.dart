import 'package:flutter/material.dart';
import 'package:propup/widgets/payment_widgets_screen.dart';

///
///for the payment options screen
///
//ignore:camel_case_typpes
class paymentOptionsScreen extends StatelessWidget {
  const paymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 92, 181),
        leading: IconButton(onPressed: ()=> Navigator.pop(context), 
        icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          "Transactions",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: const SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: optionsWidget())],
      )),
    );
  }
}
