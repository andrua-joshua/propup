import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

//ignore:camel_case_types
class fcmIncomingMessagesHandler {
  fcmIncomingMessagesHandler._();
  static final fcmIncomingMessagesHandler _singleObj =
      fcmIncomingMessagesHandler._();
  factory fcmIncomingMessagesHandler.instance() => _singleObj;

  Future<void> captureMessages() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage(); //this to get the message that was sent when the application is in the terminated mode

    if (initialMessage != null) {
      _handlerOnInteraction(
          initialMessage); //to handle our message while the app is opened from the terminated mode
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
        _handlerOnInteraction); // for handling all the messages while the app is opened from the background mode

    FirebaseMessaging.onMessage.listen(
        _handler); //for handling messages while the app is in the foreground
  }

  void _handlerOnInteraction(RemoteMessage message2) async {
    debugPrint(
        ":::::::::::::>>>>> got the new interaction message ${jsonEncode(message2.data)}");

    //this is for handling the messages incase the application was in the terminated state

    final message =
        jsonDecode(jsonEncode(message2.data)) as Map<String, dynamic>;

    if (message['type'] == 'chat') {
      //to handle chat messages

      final chatMessage chat = _toChatMessage(
          message); //the object to be pushed to the chat message bloc
      fcmChatMessagesNotifiers().addChatMessage(message: chat);
    } else if (message['type'] == 'notification') {
      //to handle notification messages
      final notificationsMessage notification = _toNotificationMessage(message);

      await updateNotifications(notification);
      //librarshowTopSnackBar(Overlay.of(context), Text("hello world"));
    } else {
      //to handle all othe kinds of messages
    }
  }

  void _handler(RemoteMessage message2) async {
    debugPrint(
        ":::::::::::::>>>>> got the new incoming message ${jsonEncode(message2.data)}");

    RemoteNotification? notification = message2.notification;

    final message =
        jsonDecode(jsonEncode(message2.data)) as Map<String, dynamic>;

    debugPrint("notification: $notification");

    if (message['type'] == 'chat') {
      final chatMessage chat = _toChatMessage(
          message); //the object to be pushed to the chat message bloc

      fcmChatMessagesNotifiers().addChatMessage(message: chat);
    } else if (message['type'] == 'notification') {
      //to handle notification messages
      final notificationsMessage notification = _toNotificationMessage(message);

      await updateNotifications(notification);
    } else {
      //to handle all othe kinds of messages
    }
  }

  chatMessage _toChatMessage(Map<String, dynamic> message) {
    chatMessage chatmessage = chatMessage(
        senderId: message['senderID'] as String,
        recieverID: message['recieverID'] as String,
        message: message['message'] as String,
        head: DateTime.now().microsecondsSinceEpoch);

    return chatmessage;
  }

  notificationsMessage _toNotificationMessage(Map<String, dynamic> message) {
    notificationsMessage notificationsmessage = notificationsMessage(
        head: DateTime.now().microsecondsSinceEpoch,
        messageID: message['messageID'] as String,
        message: message['message'] as String,
        subType: message['subType'] as String);

    return notificationsmessage;
  }

  Future<void> updateNotifications(notificationsMessage notification) async {
    final auth = FirebaseAuth.instance.currentUser;
    final userRf =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    //updating the notification in the firebase
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(userRf);

      final notifications = secureSnap.get("notifications") as List;

      notifications.add({
        "messageId": notification.messageID,
        "subtype": notification.subType,
        "head": notification.head,
        "message": notification.message,
        "viewedStatus": notification.viewedStatus
      });

      transaction.update(userRf, {"notifications": notifications});
    });
  }
}
