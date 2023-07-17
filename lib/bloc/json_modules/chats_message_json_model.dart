/*

   allChats : [

    {
      "chat-id" : "chatgghiuyhuyjjiu",
      "chat" : {
        "senderID":"",
        "recieverID":"",
        "message":"",
        "head":990889776,
        "viewedStatus":false
      },
    }

    {
      "chat-id" : "ijipkp;kkl",
      "chat" : {
        "senderID":"",
        "recieverID":"",
        "message":"",
        "head":990889776,
        "viewedStatus":false
      },
    }

   ]



*/


import 'dart:convert';

//ignore:camel_case_types
class chat {
  final String _senderID;
  final String _recieverID;
  final String _message;
  final int _head;
  final bool _viewedStatus;

  chat._(
      {required String senderID,
      required String recieverID,
      required String message,
      required int head,
      required bool viewedStatus})
      : _senderID = senderID,
        _recieverID = recieverID,
        _message = message,
        _head = head,
        _viewedStatus = viewedStatus;

  factory chat.fromJson(Map<String, dynamic> json) => chat._(
      senderID: json['senderID'] as String,
      recieverID: json['recieverID'] as String,
      message: json['message'] as String,
      head: json['head'] as int,
      viewedStatus: json['viewedStatus'] as bool);

  Map<String, dynamic> toJson() => {
        "senderID": _senderID,
        "recieverID": _recieverID,
        "message": _message,
        "head": _head,
        "viewedStatus": _viewedStatus
      };
}

//ignore:camel_case_types
class chatTop {
  final String _chatId;
  final List<chat> _chats;

  chatTop._({required String chatId, required List<chat> cht})
      : _chatId = chatId,
        _chats = cht;

  factory chatTop.fromJson(Map<String, dynamic> json) {
    List<chat> cht = [];

    for (var element in (json['chats'] as List)) {
      cht.add(chat.fromJson(element));
    }


    return chatTop._(chatId: json['chatId'] as String, cht: cht);
  }

  Map<String, dynamic> toJson() {
    List<String> chts = [];

    for (var element in _chats) {
      chts.add(jsonEncode(element));
    }

    return {"chatId": _chatId, "chats": chts};
  }

  @override
  String toString(){
    return jsonEncode(this);
  }
}
