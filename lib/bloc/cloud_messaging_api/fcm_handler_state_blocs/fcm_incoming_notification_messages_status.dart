import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';
import 'package:propup/bloc/fcm_data_holder/fcm_chat_messages_chats_holder.dart';
import 'package:propup/bloc/fcm_data_holder/fcm_notifications_message_holder.dart';

enum Message{
  incomming, outgoing
}

//ignore:camel_case_types
class fcmNotificationMessageBloc extends Bloc<notificationsMessage,int>{

  fcmNotificationMessageBloc._() : super(0);
  static final _singleObj = fcmNotificationMessageBloc._();
  factory fcmNotificationMessageBloc() => _singleObj;

  @override
  Stream<int> mapEventToState(notificationsMessage event) async*{

    fcmNotificationsMessagesStorage().addNotification(event);

    yield state;
    
  }

}