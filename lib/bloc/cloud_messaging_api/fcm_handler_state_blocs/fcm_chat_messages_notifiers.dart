import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';

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
    ?_allChatMessages.putIfAbsent(message.senderId, () => [message])
    : _allChatMessages.putIfAbsent(message.recieverID, () => [message]);

    serializeChatsToJson();
    notifyListeners();
  }

  Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/drilloxhts.json');
  }

  //for serializing and saving the chats to the local storage
  void serializeChatsToJson() async {
    List<Map<String, dynamic>> allchts = [];

    _allChatMessages.forEach((key, value) {
      List<Map<String, dynamic>> chats = [];

      for (var element in value) {
        chats.add(element.toJson());
      }

      allchts.add({"chatId": key, "chats": chats});
    });

    //this being the string to be saved
    String jsonEncoded = jsonEncode(allchts);

    final file = await _localFile;
    await file.writeAsString(jsonEncoded);

  }

  void deserializeFromJson() async{
    
    final file = await _localFile;

    final source  = await file.readAsString();


    List<Map<String, dynamic>> allChats =
        jsonDecode(source) as List<Map<String, dynamic>>;

    for (Map<String, dynamic> element in allChats) {
      List<chatMessage> chats = [];

      for (var value in element['chats'] as List<Map<String, dynamic>>) {
        chats.add(chatMessage.fromJson(json: value));
      }

      _allChatMessages.addAll({element['chatId'] as String, chats}
          as Map<String, List<chatMessage>>);
    }
  }
}