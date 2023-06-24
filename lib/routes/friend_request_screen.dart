import 'package:flutter/material.dart';
import 'package:propup/widgets/friend_request_widgets.dart';

///
///this is where friend request is declared
///
//ignore: camel_case_types
class friendRequestScreen extends StatelessWidget {
  const friendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 120,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
                Text(
                  "Tracy Zoe",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                friendLocationWidget(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Love is like the wind, you can't see it but you can feel it.",
                  style: TextStyle(color: Colors.black, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                requestOptionsRowWidget(),
                SizedBox(
                  height: 30,
                ),
                friendDetailsRowWidget()
              ],
            )),
      )),
    );
  }
}
