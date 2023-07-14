import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_api_init.dart';
import 'package:propup/bloc/user_authentications/user_repository.dart';
import 'package:propup/routes.dart';

///
///this is where the orking logic of the signup page will be done from
///
//ignore:camel_case_types
class signUpLogic {
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
    if (pswd != txt) {
      return "password doesn't much!";
    }
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

  static void signUp(
    GlobalKey<FormState> ky,
    BuildContext context,
    String email,
    String password,
    String username,
  ) {
    if (ky.currentState?.validate() ?? false) {
      try {
        final provider = EmailUser(email: email, password: password);
        final user = provider.register();
        user.then((value) async {
          if (value.user != null) {
            if (value.user?.emailVerified ?? false) {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(value.user?.uid)
                  .set({
                "username": username,
                "email": email,
                "location": "",
                "description": "",
                "followers": 0,
                "friends": 0,
                "following": 0,
                "donated": 0,
                "recieved": 0,
                "followersList": [],
                "followingList": [],
                "friendsList": [],
                "token": "",
                "group_key": "",
                "account_balance":0.01
              });

              final user = await FirebaseFirestore.instance
                  .collection("users")
                  .doc(value.user?.uid)
                  .get();

              final userRf = FirebaseFirestore.instance
                  .collection("users")
                  .doc(value.user?.uid);

              // ignore: non_constant_identifier_names
              final String group_key = await fcmApiInit

                  ///for the group that will be used for notifing the followers
                  .instance()
                  .fcmCreateGroup(name: user.get("username"));

              userRf.update({"group_key": group_key});

              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, RouteGenerator.homescreen);
            } else {
              value.user?.sendEmailVerification().then((value) async {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .set({
                  "username": username,
                  "email": email,
                  "location": "",
                  "description": "",
                  "followers": 0,
                  "friends": 0,
                  "following": 0,
                  "donated": 0,
                  "recieved": 0,
                  "followersList": [],
                  "followingList": [],
                  "friendsList": [],
                  "token": "",
                  "group_key": "",
                  "account_balance":0.01
                });

                final user = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get();

                final userRf = FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser
                        ?.uid); //for get the currently registering user

                // ignore: non_constant_identifier_names
                final String group_key = await fcmApiInit
                    .instance()
                    .fcmCreateGroup(name: user.get("username"));

                userRf.update({"group_key": group_key});

                // ignore: use_build_context_synchronously
                Navigator.pushNamed(
                    context, RouteGenerator.emailVerificationscreen);
              });
            }
          }
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Error: ${e.code}",
          style: const TextStyle(color: Colors.redAccent),
        )));
        if (e.code == 'weak-password') {
          ///task in case of week password
        }
        if (e.code == 'email-alread-in-use') {
          ///task in case of week password
        }
      } catch (e) {
        ///task in case something different is wrong
      }

      //Navigator.pushNamed(context, RouteGenerator.homescreen);
    }
  }
}
