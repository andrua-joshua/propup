import 'package:flutter/material.dart';
import 'package:propup/bloc/user_authentications/signup_logic.dart';
import 'package:propup/state_managers/passwords_notifier.dart';
import 'package:provider/provider.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the signUp screen
///shall be created from
///

///
///this is the signup form widget
//ignore:camel_case_types
class signUpFormWidget extends StatefulWidget {
  const signUpFormWidget({super.key});

  @override
  _signUpFormWidgetState createState() => _signUpFormWidgetState();
}

//ignore:camel_case_types
class _signUpFormWidgetState extends State<signUpFormWidget> {
  late final TextEditingController usernameController;
  late final TextEditingController gmailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();
    gmailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    gmailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewsignUpVisibility(),
      builder: (context, child) {
        return Form(
            key: _key,
            child: Column(
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
                    controller: gmailController,
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
                  "Password",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 223, 222, 222)),
                  padding: const EdgeInsets.all(2),
                  child: Consumer<viewsignUpVisibility>(
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: value.passVisible(),
                        validator: signUpLogic.passwordValidate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "password",
                            icon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  value.setPassVisibility(
                                      visibility:
                                          value.passVisible() ? false : true);
                                },
                                icon: Icon(
                                  value.passVisible()
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ))),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 223, 222, 222)),
                  padding: const EdgeInsets.all(2),
                  child: Consumer<viewsignUpVisibility>(
                      builder: (context, value, child) {
                    return TextFormField(
                      controller: passwordConfirmController,
                      obscureText: value.confirmPassVisible(),
                      validator: signUpLogic.passwordConfirmValidate,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "confirm password",
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                value.setConfirmPassVisibility(
                                    visibility: value.confirmPassVisible()
                                        ? false
                                        : true);
                              },
                              icon: Icon(value.confirmPassVisible()
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    );
                  }),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () => signUpLogic.signUp(
                        _key,
                        context,
                        gmailController.text,
                        passwordController.text,
                        usernameController.text),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: const Center(
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ))
              ],
            ));
      },
    );
  }
}

//ignore:camel_case_types
class termsAndConditionsRowWidget extends StatelessWidget {
  const termsAndConditionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (val) {}),
        const Expanded(
            child: Text(
          "By tapping \"register\" you accept our terms and conditons.",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ))
      ],
    );
  }
}

//ignore:camel_case_types
class logInOptionRowWidget extends StatelessWidget {
  const logInOptionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have account?",
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, RouteGenerator.loginscreen),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.orange),
            ))
      ],
    );
  }
}
