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
      child: Column(children: [
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bg4.png"),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  loginFormWidget(),
                  //optionsRowWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  signUpOptionsRowWidget(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ))),
        Container(
          margin: const EdgeInsets.fromLTRB(100, 0, 100, 10),
          constraints: const BoxConstraints.expand(height: 3),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
        )
      ]),
    ));
  }
}
