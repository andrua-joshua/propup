import 'package:flutter/material.dart';
import 'package:propup/widgets/login_screen_widgets.dart';

///this will be used for loging in to the platform
//ignore:camel_case_types
class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/bg4.png"),
          const userNameWidget(),
          const SizedBox(
            height: 30,
          ),
          const userPasswordWidget(),
          const SizedBox(
            height: 30,
          ),
          const signInButtonWidget()
        ],
      )),
    ));
  }
}
