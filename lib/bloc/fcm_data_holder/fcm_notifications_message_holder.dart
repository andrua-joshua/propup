import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';


//ignore:camel_case_types
class fcmNotificationsMessagesStorage {
  final List<notificationsMessage> _allNotificationMessages = [];

  fcmNotificationsMessagesStorage._();
  static final fcmNotificationsMessagesStorage _singleObj =
      fcmNotificationsMessagesStorage._();
  factory fcmNotificationsMessagesStorage() => _singleObj;

  List<notificationsMessage> get allNotificationMessages =>
      _allNotificationMessages;

  void addNotification(notificationsMessage notification) {
    _allNotificationMessages.add(notification);
  }
}
