
///
///This will be used for the modeling of the notifiation Specifi messages
///
//ignore:camel_case_types
class notificationsMessage {
  final int _head; //the Epoc time in which it arrived
  final String
      _messageID; //the id of detailed message object {loans, fundraises, follower}
  final String _message; //the actual message
  final String
      _subType; //this is for differentiating between the {loans, fund raises, follows}
  final bool
      _viewedStatus; //to check whether the norification message was already viewed or not

  const notificationsMessage(
      {required int head,
      required String messageID,
      required String message,
      required String subType,
      bool viewedStatus = false})
      : _head = head,
        _messageID = messageID,
        _message = message,
        _subType = subType,
        _viewedStatus = viewedStatus;


    int get head => _head;
    String get messageID => _messageID;
    String get message => _message;
    String get subType => _subType;
    bool get viewedStatus => _viewedStatus;
}
