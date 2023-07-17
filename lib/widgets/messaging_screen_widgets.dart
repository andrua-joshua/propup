import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_outgoing_message_handler.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/routes.dart';

///
///all widgets
///

//ignore:camel_case_types
class messagingTopWidget extends StatelessWidget {
  final String chatId;
  const messagingTopWidget({required this.chatId, super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance.collection("users").doc(chatId);

    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, snap) {
          return ListTile(
            horizontalTitleGap: 10,
            onTap: () => Navigator.pushNamed(
                context, RouteGenerator.friendprofilescreen),
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromARGB(255, 207, 206, 206),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(""),
              ),
            ),
            title: snap.hasData
                ? Text(
                    snap.data?.get("username"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                : snap.hasError
                    ? const Text(
                        "(*^*)",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    : Container(
                        constraints: const BoxConstraints.expand(),
                        color: const Color.fromARGB(255, 218, 217, 217),
                      ),
          );
        });
  }
}

///
///this is for the typing and sending of the messages
///
//ignore:camel_case_types
class sendingWidget extends StatefulWidget {
  final String chatId;
  const sendingWidget({required this.chatId, super.key});

  @override
  _sendingWidgetState createState() => _sendingWidgetState();
}

//ignore:camel_case_types
class _sendingWidgetState extends State<sendingWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: const EdgeInsets.all(3),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              //maxLines: 5,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "enter message"),
            )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {
                  String id = FirebaseAuth.instance.currentUser?.uid ?? "";

                  chatMessage msg = chatMessage(
                      senderId: id,
                      recieverID: widget.chatId,
                      message: _controller.text,
                      head: DateTime.now().microsecondsSinceEpoch);

                  fcmChatMessagesNotifiers().addChatMessage(message: msg);
                  fcmOutgoingMessages
                      .instance()
                      .sendChatMessage(chatmessage: msg);

                  _controller.text = '';
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///class to represent a single chat message
//ignore:camel_case_types
class messageWidget extends StatelessWidget {
  final chatMessage chat;
  const messageWidget({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (chat.senderId == FirebaseAuth.instance.currentUser?.uid)
              ? Colors.black12
              : Colors.green,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
            topLeft: (chat.senderId == FirebaseAuth.instance.currentUser?.uid)
                ? Radius.zero
                : const Radius.circular(10),
            topRight: (chat.senderId == FirebaseAuth.instance.currentUser?.uid)
                ? const Radius.circular(10)
                : Radius.zero,
          )),
      padding: const EdgeInsets.all(10),
      child: Text(
        chat.message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
