import 'package:flutter/material.dart';
import 'package:propup/widgets/add_friends_screen_widgets.dart';

///
///this is for the add friends screen for seaching and adding new friends
///
//ignore:camel_case_types
class addFriendsScreen extends StatelessWidget {
  const addFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Friends",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Text(
            //     "Discover",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16),
            //   ),
            // ),
            Center(child: searchFriendWidget()),
            possibleFriendsWidget()
          ],
        ),
      )),
    );
  }
}
