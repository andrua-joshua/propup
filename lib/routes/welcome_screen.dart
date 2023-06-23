import 'package:flutter/material.dart';
import 'package:propup/widgets/welcome_screen_widgets.dart';

///
///this will be responsible for the welcome screen of the application
///
//ignore:camel_case_types
class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/bg3.png"),
          //const Expanded(child:
          const salutationWidget(),
          //)
        ],
      )),
    ));
  }
}
