import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
//import 'package:path';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/json_modules/chats_message_json_model.dart';

//ignore:camel_case_types
class fcmChatMessagesNotifiers with ChangeNotifier {
  final Map<String, List<chatMessage>> _allChatMessages = {};

  ///creation of the singleton pattern
  fcmChatMessagesNotifiers._();
  static final fcmChatMessagesNotifiers _singleObj =
      fcmChatMessagesNotifiers._();
  factory fcmChatMessagesNotifiers() => _singleObj;

  Map<String, List<chatMessage>> allChatMessages() => _allChatMessages;

  void addChatMessage({required chatMessage message}) {
    (message.recieverID == FirebaseAuth.instance.currentUser?.uid)
        ? _allChatMessages.putIfAbsent(message.senderId, () => [message])
        : _allChatMessages.putIfAbsent(message.recieverID, () => [message]);

    notifyListeners();
  }

  //for seializing and saving the chats to the local storage
  void serializeChatsToJson() async{

    //jsonEncode(_allChatMessages);

    
    
  }
}
