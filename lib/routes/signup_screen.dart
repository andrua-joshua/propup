import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
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
      body:const  SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(
              //           context, RouteGenerator.registrationByPhone);
              //     },
              //     child: const Card(
              //         color: Colors.blue,
              //         elevation: 8,
              //         child: SizedBox(
              //           height: 50,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: [
              //               Icon(Icons.phone),
              //               Text(
              //                 "Register using phone",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 19,
              //                     fontWeight: FontWeight.bold),
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               )
              //             ],
              //           ),
              //         ))),
              // const Text("Or"),
              const Text(
                "Create your account",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              const signUpFormWidget(),
              const SizedBox(
                height: 15,
              ),
              const termsAndConditionsRowWidget(),
              const SizedBox(
                height: 20,
              ),
              const logInOptionRowWidget()
            ],
          ),
        ),
      )),
    );
  }
}
