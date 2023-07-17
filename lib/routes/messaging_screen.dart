import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/widgets/messaging_screen_widgets.dart';
import 'package:provider/provider.dart';

///
///the messaging screen
///
//ignore: camel_case_types
class messagingScreen extends StatelessWidget {
  const messagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String chatId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
          leadingWidth: 20,
          title: messagingTopWidget(
            chatId: chatId,
          )),
      body: SafeArea(
          child: Column(
        children: [
          ChangeNotifierProvider<fcmChatMessagesNotifiers>(
            create: (context) => fcmChatMessagesNotifiers(),
            builder: (context, child) {
              return Expanded(child: SingleChildScrollView(
                child: Consumer<fcmChatMessagesNotifiers>(
                    builder: (context, value, child) {
                  return Column(
                    children: List.generate(
                        fcmChatMessagesNotifiers()
                            .allChatMessages()[chatId]!
                            .length,
                        (index) => messageWidget(
                            chat: fcmChatMessagesNotifiers()
                                .allChatMessages()[chatId]![index])),
                  );
                }),
              ));
            },
          ),
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
