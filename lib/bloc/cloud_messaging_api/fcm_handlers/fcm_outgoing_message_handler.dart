import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
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

    try {
      final response = await FirebaseNotificationsHandler.sendNotification(
          cloudMessagingServerKey: server_key,
          title: "Propup chat",
          body: "New message from ${user.get("username").toString()}",
          fcmTokens: [
            token
          ],
          payload: <String, dynamic>{
            "type": "chat",
            "senderID": chatmessage.senderId,
            "message": chatmessage.message,
            "recieverID": chatmessage.recieverID
          });

      debugPrint("Send Result:  ${response.body}");
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

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = server.get("server_key");

    final followersTokens = <String>[];
    final followers = user.get("followersList") as List;
    for (var element in followers) {
      final follower = await FirebaseFirestore.instance
          .collection("users")
          .doc(element)
          .get();
      followersTokens.add(follower.get("token"));
    }

    try {
      final response = await FirebaseNotificationsHandler.sendNotification(
          cloudMessagingServerKey: server_key,
          title: "Propup notification",
          body: "${message.subType} request by ${user.get("username")}",
          fcmTokens: followersTokens,
          additionalHeaders: {
            "Content-Type": "application/json"
          },
          payload: <String, dynamic>{
            "type": "notification",
            "messageID": message.messageID,
            "message": message.message,
            "subType": message.subType
          });

      debugPrint("Send Result:  ${response.body}");
    } catch (e) {
      debugPrint("@Drillox {Exception} :: $e");
    }
  }

  Future<void> sendCompaignNotification(
      {required notificationsMessage message, required recieverId}) async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(recieverId)
        .get();

    final server = await FirebaseFirestore.instance
        .collection("tokens")
        .doc("IkULG3L9RgmOnpQkxmci")
        .get();
    // ignore: non_constant_identifier_names
    final server_key = server.get("server_key");

    try {
      final response = await FirebaseNotificationsHandler.sendNotification(
          cloudMessagingServerKey: server_key,
          title: "Propup compaigns",
          body: message.message,
          fcmTokens: [
            user.get("token") as String
          ],
          additionalHeaders: {
            "Content-Type": "application/json"
          },
          payload: {
            "type": "notification",
            "messageID": message.messageID,
            "message": message.message,
            "subType": message.subType
          });

      debugPrint("Send Result:  ${response.body}");
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
      // Dio dio = Dio();
      // String url = "https://fcm.googleapis.com/fcm/send";
      // final response = await dio.post(url,
      //     data: payload,
      //     options: Options(headers: {
      //       "Content-Type": "application/json",
      //       "Authorization": "key=$server_key"
      //     }));

      // debugPrint("Send Result:  ${response.data.toString()}");

      final response = await FirebaseNotificationsHandler.sendNotification(
          cloudMessagingServerKey: server_key,
          title: "Propup social",
          body: "${user.get("username")} started following you",
          fcmTokens: [
            userToken
          ],
          additionalHeaders: {
            "Content-Type": "application/json"
          },
          payload: {
            "type": "notification",
            "messageID": message.messageID,
            "message": message.message,
            "subType": message.subType
          });

      debugPrint("Send Result:  ${response.body}");
    } catch (e) {
      debugPrint("@Drillox {Exception} :: $e");
    }
  }
}
