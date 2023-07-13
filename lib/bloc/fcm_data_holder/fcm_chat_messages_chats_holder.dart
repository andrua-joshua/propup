import '../cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';


//ignore:camel_case_types
class fcmChatMessagesStorage{
  final List<chatMessage> _allChatMessages = [];

  fcmChatMessagesStorage._();
  static final _singleObj = fcmChatMessagesStorage._();
  factory fcmChatMessagesStorage( )=>_singleObj;


  List<chatMessage> get allChatMessages => _allChatMessages;

  void addChat(chatMessage message){
    _allChatMessages.add(message);
  }

}