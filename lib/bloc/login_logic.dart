import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the login and register logics shall be placed
///

//ignore: camel_case_types
class loginLogic {
  static String? passwordValidate(String? txt) {
    int length = txt?.length ?? 0;
    if (length < 8) {
      return "password should be atleast 8 characters long";
    }
    return null;
  }

  static String? usernameValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter your username please";
    }

    return null;
  }

  static void login(GlobalKey<FormState> ky, BuildContext context) {
    if (ky.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, RouteGenerator.homescreen);
    }
  }
}
