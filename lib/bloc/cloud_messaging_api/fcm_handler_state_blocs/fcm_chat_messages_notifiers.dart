import 'dart:convert';
import 'dart:io';
import 'dart:math';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';

//ignore:camel_case_types
class fcmChatMessagesNotifiers {
  final Map<String, List<chatMessage>> _allChatMessages = {};
  bool _newUpdate = false;

  ///creation of the singleton pattern
  fcmChatMessagesNotifiers._();
  static final fcmChatMessagesNotifiers _singleObj =
      fcmChatMessagesNotifiers._();
  factory fcmChatMessagesNotifiers() => _singleObj;

  Map<String, List<chatMessage>> allChatMessages() => _allChatMessages;

  void addChatMessage({required chatMessage message})async {
     (message.recieverID == FirebaseAuth.instance.currentUser?.uid)
    ?_allChatMessages.update(message.senderId, (value){
          value.add(message);
          return value;
          }, ifAbsent: () => [message],)
    : _allChatMessages.update(message.recieverID, (value){
          value.add(message);
          return value;
          }, ifAbsent: () => [message],);

    

    serializeChatsToJson();

    final fb = FirebaseFirestore.instance.collection("hint").doc("MNGTzwswNilWSzUnq06Z");

    await fb.update(
      {
        "val":Random().nextInt(633434)+1
      }
    );
    
    debugPrint("@Drillox {After serialization}::>>>>>>>>>> ");

    _newUpdate = true;
    //notifyListeners();
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


  Stream<Map<String, List<chatMessage>>> allChats()async*{

    while(true){
      if(_newUpdate){
        _newUpdate = false;
        yield _allChatMessages;
      }
    }  

  }


}
