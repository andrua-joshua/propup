import 'package:firebase_messaging/firebase_messaging.dart';

//ignore:camel_case_types
class fcmApiInit {
  fcmApiInit._(); //a private constructor for creating a singleton pattern
  static final _singleObj = fcmApiInit._();
  factory fcmApiInit.instance() => _singleObj;

  Future<String> fcmToken() async =>
      await FirebaseMessaging.instance.getToken() ?? "";

      
}
