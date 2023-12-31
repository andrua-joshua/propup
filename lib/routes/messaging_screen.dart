import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/widgets/messaging_screen_widgets.dart';
import 'package:provider/provider.dart';

///
///the messaging screen
///
//ignore: camel_case_types
class messagingScreen extends StatelessWidget {
  final String chatId;
  const messagingScreen({required this.chatId, super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 20,
          title: messagingTopWidget(
            chatId: chatId,
          )),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            controller: _scrollController,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("hint").snapshots(),
                builder: (
                  context,
                  value,
                ) {
                  if (value.hasData) {
                    var scrollPosition = _scrollController.position;

                      _scrollController.animateTo(
                        scrollPosition.maxScrollExtent+100,
                        duration: const Duration(milliseconds: 50),
                        curve: Curves.easeOut,);

                    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20) ,child:Column(
                      children: List.generate(
                          fcmChatMessagesNotifiers()
                                  .allChatMessages()[chatId]
                                  ?.length ??
                              0,
                          (index) => messageWidget(
                              chat: fcmChatMessagesNotifiers()
                                  .allChatMessages()[chatId]![index])),
                    ));
                  }
                  if (value.hasError) {
                    return const Center(
                      child: Text(
                        "(*_*)\n check your internet connection.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  return Container(
                    constraints: const BoxConstraints.expand(height: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 204, 202, 202)),
                  );
                }),
          )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: sendingWidget(
                chatId: chatId,
              ))
        ],
      )),
    );
  }
}
