import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/user_authentications/signup_logic.dart';

//ignore:camel_case_types
class registrationByPhoneScreen extends StatefulWidget {
  const registrationByPhoneScreen({super.key});

  @override
  _registrationByPhoneScreenState createState() =>
      _registrationByPhoneScreenState();
}

class _registrationByPhoneScreenState extends State<registrationByPhoneScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(key: _key,
        child: Padding(
          padding: const EdgeInsets.all(15) ,child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                  "Choose User Name",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 223, 222, 222)),
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: usernameController,
                    validator: signUpLogic.usernameValidate,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter username",
                        icon: Icon(Icons.account_circle)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 223, 222, 222)),
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: emailController,
                    validator: signUpLogic.gmailValidate,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        icon: Icon(Icons.email)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Phone",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 223, 222, 222)),
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    //validator: signUpLogic,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Phone",
                        
                        icon: Icon(Icons.email)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    TextButton(
                  onPressed:(){
                    
                  } ,
                  child: Card(
                    elevation: 8,
                    color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text("Register", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                  ))
                  ]),
                )
          ],
        ))
        ),
      )),
    );
  }
}
