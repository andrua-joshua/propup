import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';

///
///for sending messages to other users

//ignore:camel_case_types
class fcmOutgoingMessages {
  fcmOutgoingMessages._();
  static final fcmOutgoingMessages _singleObj = fcmOutgoingMessages._();
  factory fcmOutgoingMessages.instance() => _singleObj;

  Future<void> sendChatMessage({required chatMessage chatmessage}) async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    final reciever = await FirebaseFirestore.instance
        .collection("users")
        .doc(chatmessage.recieverID)
        .get();
    final token = reciever.get("token") as String; //reciever's fcm token

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = server.get("server_key") as String;

    //creating the payload
    FormData payload = FormData.fromMap(<String, dynamic>{
      "notification": <String, dynamic>{
        "body": "New message from ${user.get("username").toString()}",
        "title": "Propup Chat"
      },
      "data": <String, dynamic>{
        "type": "chat",
        "recieverID":chatmessage.recieverID,
        "senderID": chatmessage.senderId,
        "message": chatmessage.message
      },
      "to": token
    });

    if (token.isEmpty) {
      //what to do incase the token is empty
    }

    try {
      Dio dio = Dio();
      String url = "https://fcm.googleapis.com/fcm/send";
      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "key=$server_key"
          }));

      debugPrint("Send Result:  ${response.data.toString()}");
    } catch (e) {
      debugPrint("@Drillox {Exception} :: $e");
    }
  }

  //used for sending notification messages {loans, fundraises} to people following the current user
  Future<void> sendNotificationMessage(
      {required notificationsMessage message}) async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    final token =
        user.get("group_key"); //should be changed to the device group's token

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = server.get("server_key");

    ///-----
    ///"New message from ${user.get("username") as String}"
    ///

    //creating the payload
    FormData payload = FormData.fromMap(<String, dynamic>{
      "notification": <String, dynamic>{
        "body": "${message.subType} request by ${user.get("username")}",
        "title": "Propup Notification"
      },
      "data": <String, dynamic>{
        "type": "notification",
        "messageID": message.messageID,
        "message": message.message,
        "subType": message.subType
      },
      "token": token
    });

    if (token.isEmpty) {
      //what to do incase the token is empty
    }

    try {
      Dio dio = Dio();
      String url = "https://fcm.googleapis.com/fcm/send";
      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "key=$server_key"
          }));

      debugPrint("Send Result:  ${response.data.toString()}");
    } catch (e) {
      debugPrint("@Drillox {Exception} :: $e");
    }
  }

  //used for sending the follow notifications to the user being followed (the one passed in the arguments)
  Future<void> sendFollowNotification(
      {required String userId, required notificationsMessage message}) async {
    final user =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    final userToken = user.get("token") as String;

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = server.get("server_key");

    //creating the payload
    FormData payload = FormData.fromMap(<String, dynamic>{
      "notification": <String, dynamic>{
        "body": "${user.get("username") as String} started following you",
        "title": "Propup Notification"
      },
      "data": <String, dynamic>{
        "type": "notification",
        "messageID": message.messageID,
        "message": message.message,
        "subType": message.subType
      },
      "to": userToken
    });

    if (userToken.isEmpty) {
      //what to do just incase the user token is empty
    }

    try {
      Dio dio = Dio();
      String url = "https://fcm.googleapis.com/fcm/send";
      final response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "key=$server_key"
          }));

      debugPrint("Send Result:  ${response.data.toString()}");
    } catch (e) {
      debugPrint("@Drillox {Exception} :: $e");
    }
  }
}
