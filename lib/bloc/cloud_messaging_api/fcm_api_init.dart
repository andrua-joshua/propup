import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

//ignore:camel_case_types
class fcmApiInit {
  fcmApiInit._(); //a private constructor for creating a singleton pattern
  static final _singleObj = fcmApiInit._();
  factory fcmApiInit.instance() => _singleObj;

  Future<String> fcmToken() async =>
      await FirebaseMessaging.instance.getToken() ?? "";

  ///used for creating a device group
  Future<String> fcmCreateGroup({required String name}) async {
    String result = "";

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = await server.get("server_key") as String;

    FormData payload = FormData.fromMap({
      "operation": "create",
      "notification_key_name": name,
      "registration_ids": []
    });

    try {
      Dio dio = Dio();
      String url = "https://fcm.googleapis.com/fcm/notification";
      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $server_key",
            "project_id": "735495916641"
          }));

      Map<String, dynamic> data = jsonDecode(response.data);

      final String key = data['notification_key'] as String;

      result = key;
    } catch (e) {
      debugPrint("@Drillox {exception creating Group} ::> $e");
    }

    return result;
  }

  ///used for subscrbing from a device group
  Future<String> fcmSubscribeToGroup({required String ownerID}) async {
    String value = "";

    final owner =
        await FirebaseFirestore.instance.collection("users").doc(ownerID).get();
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = await server.get("server_key") as String;

    // ignore: non_constant_identifier_names
    final String group_key = owner.get("group_key")
        as String; //the group key of the current user that we are subscribing to
    // ignore: non_constant_identifier_names
    final String group_name = owner.get("username")
        as String; //the group of the user that we are currently subscribing to

    final String keyToAdd = user.get("token")
        as String; //the key of the current user trying to subscribe

    FormData payload = FormData.fromMap({
      "operation": "add",
      "notification_key_name": group_name,
      "notification_key": group_key,
      "registration_ids": [keyToAdd]
    });

    try {
      String url = "https://fcm.googleapis.com/fcm/notification";
      Dio dio = Dio();

      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $server_key",
            "project_id": "735495916641"
          }));

      Map<String, dynamic> data = jsonDecode(response.data);

      value = data["notification_key"] as String;
    } catch (e) {
      debugPrint("@Drillox {Exceptions:: Error subscribing}");
    }

    return value;
  }

  ///used for unsubscrbing from a device group
  Future<String> fcmUnSubscribeToGroup({required String ownerID}) async {
    String value = "";

    final owner =
        await FirebaseFirestore.instance.collection("users").doc(ownerID).get();
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = await server.get("server_key") as String;

    // ignore: non_constant_identifier_names
    final String group_key = owner.get("group_key")
        as String; //the group key of the current user that we are subscribing to
    // ignore: non_constant_identifier_names
    final String group_name = owner.get("username")
        as String; //the group of the user that we are currently subscribing to

    final String keyToRemove = user.get("token")
        as String; //the key of the current user trying to subscribe

    FormData payload = FormData.fromMap({
      "operation": "remove",
      "notification_key_name": group_name,
      "notification_key": group_key,
      "registration_ids": [keyToRemove]
    });

    try {
      String url = "https://fcm.googleapis.com/fcm/notification";
      Dio dio = Dio();

      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $server_key",
            "project_id": "735495916641"
          }));

      Map<String, dynamic> data = jsonDecode(response.data);

      value = data["notification_key"] as String;
    } catch (e) {
      debugPrint("@Drillox {Exceptions:: Error subscribing}");
    }

    return value;
  }
}
