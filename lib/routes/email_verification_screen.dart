import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/user_authentications/user_repository.dart';
import 'package:propup/routes.dart';

//ignore:camel_case_types
class emailVerificationScreen extends StatefulWidget {
  const emailVerificationScreen({super.key});

  @override
  _emailVerificationScreenState createState() =>
      _emailVerificationScreenState();
}

//ignore:camel_case_types
class _emailVerificationScreenState extends State<emailVerificationScreen> {
  late final TextEditingController _controller;
  final GlobalKey _key = GlobalKey<FormState>();

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
    String gmail = FirebaseAuth.instance.currentUser?.email ?? "";
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 236, 234, 234)),
              child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Text("Enter the code that was sent on: " + gmail),
                      Card(
                          elevation: 6,
                          color: Colors.white,
                          child: TextFormField(
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          )),
                      TextButton(
                          onPressed: () async {
                            try {
                              await EmailUser.validateUser(_controller.text)
                                  .then((value) {
                                if (FirebaseAuth
                                        .instance.currentUser?.emailVerified ??
                                    false) {
                                  Navigator.pushNamed(
                                      context, RouteGenerator.homescreen);
                                }
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-action-code') {
                                setState(() {
                                  _controller.text = "";
                                });
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(4),
                              child: const Text(
                                "Verify",
                                style: TextStyle(color: Colors.black),
                              )))
                    ],
                  )),
            ),
          ))
        ],
      )),
    );
  }
}
