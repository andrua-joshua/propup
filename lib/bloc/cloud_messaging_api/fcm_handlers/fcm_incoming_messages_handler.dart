import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';

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

  void _handlerOnInteraction(RemoteMessage message) {
    debugPrint(
        ":::::::::::::>>>>> got the new interaction message ${message.data}");
    //this is for handling the messages incase the application was in the terminated state
  }

  void _handler(RemoteMessage message) {
    debugPrint(
        ":::::::::::::>>>>> got the new incoming message ${message.data}");

        RemoteNotification? notification = message.notification;
    //AndroidNotification? android = message.notification?.android;

    debugPrint("notification: $notification");

    if (message.data['type'] == 'chat') {
      //to handle chat messages

      final chatMessage chat = _toChatMessage(
          message); //the object to be pushed to the chat message bloc
      fcmChatMessagesNotifiers().addChatMessage(message: chat);
    } else if (message.data['type'] == 'notification') {
      //to handle notification messages
      final notificationsMessage notification = _toNotificationMessage(
          message); //the object to be pushed to the notification message bloc

      //fcmNotificationMessageBloc().add(notification);
    } else {
      //to handle all othe kinds of messages
    }
  }

  chatMessage _toChatMessage(RemoteMessage message) {
    chatMessage chatmessage = chatMessage(
        senderId: message.data['senderID'] as String,
        recieverID: message.data['recieverID'] as String,
        message: message.data['message'] as String,
        head: DateTime.now().microsecondsSinceEpoch);

    return chatmessage;
  }

  notificationsMessage _toNotificationMessage(RemoteMessage message) {
    notificationsMessage notificationsmessage = notificationsMessage(
        head: DateTime.now().microsecondsSinceEpoch,
        messageID: message.data['messageID'] as String,
        message: message.data['message'] as String,
        subType: message.data['subType'] as String);

    return notificationsmessage;
  }
}
