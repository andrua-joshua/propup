

import 'package:flutter/material.dart';

///
///this is where the orking logic of the signup page will be done from
///
//ignore:camel_case_types
class signUpLogic{
  static String? pswd;
  static String? passwordValidate(String? txt) {
    int length = txt?.length ?? 0;
    if (length < 8) {
      return "password should be atleast 8 characters long";
    }
    pswd = txt;
    return null;
  }

  static String? passwordConfirmValidate(String? txt) {
    int length = txt?.length ?? 0;
    if (length < 8) {
      return "password should be atleast 8 characters long";
    }
    if(pswd != txt){ return "password doesn't much!";}
    return null;
  }

  static String? usernameValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter your username please";
    }

    return null;
  }

  static String? gmailValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter your Email please";
    }else {
      String suffix = "@gmail.com";
      int lng = txt?.length??0;
      String sub = txt?.substring((lng>10)?(lng-suffix.length):0)??"";

      if(sub!=suffix){
        return "please enter a valid gmail.";
      }
    }

    return null;
  }

  static void signUp(GlobalKey<FormState> ky, BuildContext context) {
    if (ky.currentState?.validate() ?? false) {
      //Navigator.pushNamed(context, RouteGenerator.homescreen);
    }
  }


}