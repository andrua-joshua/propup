import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

///
///this is for the chat screen
//ignore:camel_case_types
class chatTab extends StatelessWidget {
  const chatTab({super.key});

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pp2.jpg",
    "assets/images/pp.jpg"
  ];

  final names = const <String>[
    "Jacob kerf",
    "Putin merlach",
    "Linux Tsavoal",
    "michle Micheal",
    "Olivinga Johnstone",
    "Justin napple",
    "Anonymous #(*^*)#"
  ];

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
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context,index){
                return chatUserWidget(
                  message: "all message is same for now", name: names[index],
                   image: images[index]);
            }))
      ],
    ));
  }
}
