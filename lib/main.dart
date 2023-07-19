import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_api_init.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_incoming_messages_handler.dart';
import 'package:propup/routes.dart';

import 'bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//debugPrint("@Drillox-result ::> just starting the test");
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await fcmIncomingMessagesHandler.instance().captureMessages();

  await requestPermissions();
  fcmApiInit
      .instance()
      .fcmToken()
      .then((value) => debugPrint("::::token ::> $value"));

  fcmChatMessagesNotifiers().deserializeFromJson();
  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);
}

// Lisitnening to the background messages
// ignore: unused_element
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if ((jsonDecode(message.data['data']) as Map<String, dynamic>)['type'] ==
      'chat') {
    //to handle chat messages

    final chatMessage chat = _toChatMessage(
        message); //the object to be pushed to the chat message bloc
    fcmChatMessagesNotifiers().addChatMessage(message: chat);
  } else if ((jsonDecode(message.data['data'])
          as Map<String, dynamic>)['type'] ==
      'notification') {
    //to handle notification messages
    final notificationsMessage notification = _toNotificationMessage(message);

    await updateNotifications(notification);
  } else {
    //to handle all othe kinds of messages
  }
  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> updateNotifications(notificationsMessage notification) async {
  final auth = FirebaseAuth.instance.currentUser;
  final userRf = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

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

chatMessage _toChatMessage(RemoteMessage message) {
  chatMessage chatmessage = chatMessage(
      senderId: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['senderID'] as String,
      recieverID: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['recieverID'] as String,
      message: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['message'] as String,
      head: DateTime.now().microsecondsSinceEpoch);

  return chatmessage;
}

notificationsMessage _toNotificationMessage(RemoteMessage message) {
  notificationsMessage notificationsmessage = notificationsMessage(
      head: DateTime.now().microsecondsSinceEpoch,
      messageID: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['messageID'] as String,
      message: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['message'] as String,
      subType: (jsonDecode(message.data['data'])
          as Map<String, dynamic>)['subType'] as String);

  return notificationsmessage;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteGenerator.welcomescreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: const friendsProfileScreen(name: "Anonymous"),
    );
  }
}
