///
///This is a model of the chatmessage notifications with read only rights after object creatation
///
//ignore:camel_case_types
class chatMessage {

  final int _head;                  //the Epoc time in which it arrived
  final String _senderID; //the id of the user who sent the message
  final String _recieverID; //the id of the user to recieve the message
  final String _message; //the actual message
  final bool
      _viewedStatus; //to check whether the message was already viewed or not

  const chatMessage(
      {required String senderId,
      required String recieverID,
      required String message,
      required int head,
      bool viewedStatus = false})
      : _senderID = senderId,
      _recieverID =recieverID,
        _message = message,
        _head =head,
        _viewedStatus = viewedStatus;


  int get head => _head;
  String get senderId => _senderID;
  String get recieverID => _recieverID;
  String get message => _message;
  bool get viewedStatus => _viewedStatus;
  
}
