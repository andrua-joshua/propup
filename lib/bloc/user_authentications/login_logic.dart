import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_api_init.dart';
import 'package:propup/bloc/user_authentications/user_repository.dart';
import 'package:propup/routes.dart';
import 'package:propup/state_managers/friends_state_manager.dart';

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
      String password) async {
    if (ky.currentState?.validate() ?? false) {
      try {
        final provider = EmailUser(email: email, password: password);
        final user = provider.signIn();

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 17, 17, 17),
              content: SizedBox(
                  height: 45,
                  child: Center(
                    child: FutureBuilder(future: user.then((value) async {
                      if (value.user?.emailVerified ?? false) {
                        debugPrint(">>>>>>>>>>>><><><><Got something ---->");
                        final currentAccount = FirebaseFirestore.instance
                            .collection("users")
                            .doc(value.user?.uid);

                        await currentAccount.get().then((value2) {
                          currentAccount.update({
                            "verified": true,
                          });
                        });

                        final token = await fcmApiInit.instance().fcmToken();
                        final doc = FirebaseFirestore.instance
                            .collection("users")
                            .doc(value.user?.uid);

                        await doc.update({"token": token});

                        friendsData().listener();
                        friendsData().initFriends();
                        //.then((value) =>
                        // ignore: use_build_context_synchronously
                        //Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, RouteGenerator.homescreen); //);
                      } else {
                        await value.user?.sendEmailVerification().then(
                            (value) => Navigator.pushNamed(context,
                                RouteGenerator.emailVerificationscreen));
                      }
                    }), builder: (context, snap) {
                      if (snap.hasError) {
                        if (snap.data == null &&
                            FirebaseAuth.instance.currentUser == null) {
                          return Text(
                            "Error: ${(snap.error as FirebaseAuthException).code.replaceAll('-', " ")}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        }
                      }
                      return const CircularProgressIndicator();
                    }),
                  )),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        debugPrint("Firebase exception {{{{{{{{}}}}}}}}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              "Error: " + e.code,
              style: const TextStyle(color: Colors.redAccent),
            )));
      } catch (e) {
        ///task in case something different is wrong
        debugPrint("Firebase exception {{{{{{{{}}}}}}}}<<<>>>>>>>>>>>>>");
      }
    }
  }
}
