import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the login screen  custome widgets shall be defined
///

//ignore:camel_case_types
class userNameWidget extends StatefulWidget {
  const userNameWidget({super.key});

  @override
  _userNameWidgetState createState() => _userNameWidgetState();
}

class _userNameWidgetState extends State<userNameWidget> {
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 60),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 229, 228, 228)),
      child: Row(
        children: [
          const Icon(Icons.account_circle),
          Expanded(
              child: TextField(
            maxLines: 1,
            controller: usernameController,
          ))
        ],
      ),
    );
  }
}

//ignore:camel_case_types
class userPasswordWidget extends StatefulWidget {
  const userPasswordWidget({super.key});

  @override
  _userPasswordWidget createState() => _userPasswordWidget();
}

class _userPasswordWidget extends State<userPasswordWidget> {
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext copntext) {
    return Container(
      constraints: const BoxConstraints.expand(height: 60),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 229, 228, 228)),
      child: Row(
        children: [
          const Icon(Icons.lock),
          Expanded(
              child: TextField(
            controller: passwordController,
            maxLines: 1,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.visibility_off))
        ],
      ),
    );
  }
}

//ignore:camel_case_types
class signInButtonWidget extends StatelessWidget {
  const signInButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, RouteGenerator.homescreen),
      child: Container(
        constraints: const BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            "SIGN IN",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),
      ),
    );
  }
}
