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
        .doc(chatmessage.senderId)
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
        "title": "New Chat"
      },
      "data": <String, dynamic>{
        "type": "chat",
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

  Future<void> sendNotificationMessage(
      {required notificationsMessage message}) async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    final token = user.get("token"); //should be changed to the device group's token

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    final server_key = server.get("server_key");

    //creating the payload
    FormData payload = FormData.fromMap(<String, dynamic>{
      "notification": <String, dynamic>{
        "body": "New message from ${user.get("username").toString()}",
        "title": "New Chat"
      },
      "data": <String, dynamic>{
        "type": "notification",
        "messageID": message.messageID,
        "message": message.message,
        "subType":message.subType
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
}
