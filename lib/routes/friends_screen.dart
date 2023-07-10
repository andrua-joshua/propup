import 'package:flutter/material.dart';
import 'package:propup/widgets/friends_screen_widgets.dart';

///
///this class is where all the friend list will be shown
///
//ignore: camel_case_types
class friendScreen extends StatelessWidget {
  const friendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Friends",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            bottom: const TabBar(tabs: [
              Text(
                "followers",
                style: TextStyle(),
              ),
              Text(
                "friends",
                style: TextStyle(),
              ),
              Text(
                "following",
                style: TextStyle(),
              ),
            ]),
          ),
          body: const Padding(
              padding: EdgeInsets.all(10), child: TabBarView(children: [
                followersWidget(),
                friendsWidget(),
                followingWidget()
              ])),
        ));
  }
}
