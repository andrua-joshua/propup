import 'package:flutter/material.dart';
import 'package:propup/widgets/messaging_screen_widgets.dart';

///
///the messaging screen
///
//ignore: camel_case_types
class messagingScreen extends StatelessWidget {
  const messagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
          title: const messagingTopWidget(
              name: "Nicolus mark", image: "assets/images/pp2.jpg")),

              body:const SafeArea(
                child: Column(
                  children: [
                    Expanded(child:Center(child: Text("no message yet", style: TextStyle(color: Colors.grey),),),),
                    Padding(padding: EdgeInsets.all(10) , child:sendingWidget())
                  ],
                )),
    );
  }
}
