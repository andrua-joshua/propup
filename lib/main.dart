import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_api_init.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_incoming_messages_handler.dart';
import 'package:propup/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//debugPrint("@Drillox-result ::> just starting the test");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 // await Firebase.initializeApp();
  await fcmIncomingMessagesHandler.instance().captureMessages();

  await requestPermissions();
  fcmApiInit
      .instance()
      .fcmToken()
      .then((value) => debugPrint("::::token ::> $value"));

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
  debugPrint("Handling a background message: ${message.messageId}");
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
