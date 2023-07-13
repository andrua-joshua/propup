


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/fcm_data_holder/fcm_chat_messages_chats_holder.dart';

enum Message{
  incomming, outgoing
}

//ignore:camel_case_types
class fcmChatMessageBloc extends Bloc<chatMessage,int>{

  fcmChatMessageBloc._() : super(0);
  static final _singleObj = fcmChatMessageBloc._();
  factory fcmChatMessageBloc() => _singleObj;

  @override
  Stream<int> mapEventToState(chatMessage event) async*{

    fcmChatMessagesStorage().addChat(event);

    yield state;
    
  }

}