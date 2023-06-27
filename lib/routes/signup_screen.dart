import 'package:flutter/material.dart';
import 'package:propup/widgets/signup_screen_widgets.dart';

///
///this is where all the sign in screen design code is
///
//ignore: camel_case_types
class signUpScreen extends StatelessWidget {
  const signUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Create your account",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 15,),
              signUpFormWidget(),
              SizedBox(height: 15,),
              termsAndConditionsRowWidget(),
              SizedBox(height: 20,),
              logInOptionRowWidget()
            ],
          ),
        ),
      )),
    );
  }
}
