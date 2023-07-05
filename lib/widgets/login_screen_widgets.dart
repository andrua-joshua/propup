import 'package:flutter/material.dart';
import 'package:propup/bloc/user_authentications/login_logic.dart';
import 'package:propup/routes.dart';

///
///this is where all the login screen  custome widgets shall be defined
///

//ignore:camel_case_types
class signInButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> key1;
  final String email;
  final String password;
  const signInButtonWidget({required this.key1, required this.email, required this.password, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => loginLogic.login(key1, context, email, password),
      child: Container(
        constraints: const BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            "SIGN IN",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
      ),
    );
  }
}

///
///this is for the login form
///
//ignore:camel_case_types
class loginFormWidget extends StatefulWidget {
  const loginFormWidget({super.key});

  @override
  _loginFormWidgetState createState() => _loginFormWidgetState();
}

//igonre: camel_case_types
class _loginFormWidgetState extends State<loginFormWidget> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: key,
        child: Column(
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Thanks you for chosing Prop-up platform. The family you chose.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 235, 235),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(2),
                child: Center(
                    child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter email",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: loginLogic.emailValidate,
                ))),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 235, 235),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(2),
                child: Center(
                    child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      hintText: "password",
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_off),
                      )),
                  obscureText: true,
                  validator: loginLogic.passwordValidate,
                ))),
            const SizedBox(
              height: 30,
            ),
            signInButtonWidget(
              key1: key,
              email: emailController.text,
              password: passwordController.text,
            )
          ],
        ));
  }
}

//ignore:camel_case_types
class optionsRowWidget extends StatelessWidget {
  const optionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (val) {},
              ),
              const Text(
                "Keep Sign In",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot password?",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}

//ignore:camel_case_types
class signUpOptionsRowWidget extends StatelessWidget {
  const signUpOptionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: ()=> Navigator.pushNamed(context, RouteGenerator.signupscreen),
            child: const Text(
              "Sign Up",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
