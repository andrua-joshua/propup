import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/user_authentications/user_repository.dart';
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

  static String? emailValidate(String? txt) {
    if (txt?.isEmpty ?? true) {
      return "enter your Email please";
    } else {
      String suffix = "@gmail.com";
      int lng = txt?.length ?? 0;
      String sub = txt?.substring((lng > 10) ? (lng - suffix.length) : 0) ?? "";

      if (sub != suffix) {
        return "please enter a valid gmail.";
      }
    }

    return null;
  }

  static void login(GlobalKey<FormState> ky, BuildContext context, String email,
      String password) {
    if (ky.currentState?.validate() ?? false) {
      try {
        final provider = EmailUser(email: email, password: password);
        final user = provider.signIn();
        user.then((value) {
          if (value.user?.emailVerified ?? false) {
            Navigator.pushNamed(context, RouteGenerator.homescreen);
          } else {
            value.user?.sendEmailVerification().then((value) =>
                Navigator.pushNamed(context, RouteGenerator.emailVerificationscreen));
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ///task in case of week password
        }
        if (e.code == 'email-alread-in-use') {
          ///task in case of week password
        }
      } catch (e) {
        ///task in case something different is wrong
      }
    }
  }
}
