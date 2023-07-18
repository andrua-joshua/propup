import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handler_state_blocs/fcm_chat_messages_notifiers.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_chat_message_model.dart';
import 'package:propup/widgets/home_screen_widgets.dart';
import 'package:provider/provider.dart';

///
///this is for the chat screen
//ignore:camel_case_types
class chatTab extends StatelessWidget {
  const chatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Column(
          children: [
            const Text("Messages",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const chatSearchWidget(),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("hint").snapshots(),
                builder: (context, value) {
              List<chatMessage> allchats = [];
              List<int> allChatsByDate = [];

              fcmChatMessagesNotifiers().allChatMessages().forEach((key, value2) {
                for (int i = 0; i < value2.length; i++) {
                  allchats.add(value2[i]);
                  allChatsByDate.add(value2[i].head);
                }
              });

              //allSortedChats = allChatsByDate.sort();
              allChatsByDate.sort();
              final it = allChatsByDate.reversed;

              return Expanded(
                  child: ListView.builder(
                      itemCount: it.length,
                      itemBuilder: (context, index) {
                        int vl = it.elementAt(index);

                        chatMessage msg = allchats
                            .where((chat) {
                              return chat.head == vl;
                            })
                            .toList()
                            .first;

                        var user = FirebaseFirestore.instance
                            .collection("users")
                            .doc(msg.senderId)
                            .get();
                        //user.then((val){});

                        return FutureBuilder(
                          future: user,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return chatUserWidget(
                                  message: msg.message,
                                  name: snap.data?.get("username"),
                                  image: "image here");
                            }
                            if (snap.hasError) {
                              return const Center(
                                child: Text(
                                  "(*_*)",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        );
                      }));
            })
          ],
        ));
     
  }
}
