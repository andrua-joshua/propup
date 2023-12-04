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

  static void signUp(GlobalKey<FormState> ky, BuildContext context,
      String email, String password, String username,
      {bool isPhone = false, String phone = ''}) async {
    if (ky.currentState?.validate() ?? false) {
      try {
        if (isPhone) {
          final auth = FirebaseAuth.instance;
          auth.verifyPhoneNumber(
              phoneNumber: phone,
              timeout: const Duration(minutes: 1),
              verificationCompleted: (credentials) {
                auth.signInWithCredential(credentials).then((value) async {
                  final token = await fcmApiInit.instance().fcmToken();

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
                    "token": token,
                    "group_key": "",
                    "account_balance": 0,
                    "donations": [],
                    "loans": [],
                    "notifications": [],
                    "transactions": [],
                    "profilePic":
                        "https://cdn.vectorstock.com/i/preview-1x/43/94/default-avatar-photo-placeholder-icon-grey-vector-38594394.jpg"
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
                });
              },
              verificationFailed: (error) {},
              codeSent: (verificationId, forceResendingToken) {
                ///------------------
                //show dialog to take input from the user
                final TextEditingController _codeController =
                    TextEditingController();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          title: const Text("Enter SMS Code"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: _codeController,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Done"),
                              onPressed: () {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                final smsCode = _codeController.text.trim();

                               final  _credential = PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);
                                auth
                                    .signInWithCredential(_credential)
                                    .then((result) async{

                                  Navigator.pushNamed(context, RouteGenerator.homescreen);
                                }).catchError((e) {
                                  print("::::::::::::::@Drilllox $e");
                                });
                              },
                            )
                          ],
                        ));

                ///---------------------
              },
              codeAutoRetrievalTimeout: (str) {});
        } else {
          final provider = EmailUser(email: email, password: password);
          final user = provider.register();

          await user.then((value) async {
            if (value.user != null) {
              if (value.user?.emailVerified ?? false) {
                final token = await fcmApiInit.instance().fcmToken();

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
                  "token": token,
                  "group_key": "",
                  "account_balance": 0,
                  "donations": [],
                  "loans": [],
                  "notifications": [],
                  "transactions": [],
                  "verified":true,
                  "profilePic":
                      "https://cdn.vectorstock.com/i/preview-1x/43/94/default-avatar-photo-placeholder-icon-grey-vector-38594394.jpg"
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
                  "account_balance": 0,
                  "donations": [],
                  "loans": [],
                  "notifications": [],
                  "transactions": [],
                  "verified":false,
                  "profilePic":
                      "https://cdn.vectorstock.com/i/preview-1x/43/94/default-avatar-photo-placeholder-icon-grey-vector-38594394.jpg"
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
                await value.user?.sendEmailVerification().then(
                            (value) => Navigator.pushNamed(context,
                                RouteGenerator.emailVerificationscreen));

                ///------------
                ///    /\
                ///   /--\
                ///
              }
            }
          });
        }
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
