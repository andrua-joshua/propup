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
      appBar: AppBar(),
      body: const SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child:Text("Check your email to varify it"))
          ))
        ],
      )),
    );
  }
}
