import 'dart:io';

import 'package:flutter/material.dart';
import 'package:propup/routes/home_screen/tabs/chatsTab.dart';
import 'package:propup/routes/home_screen/tabs/home_tab.dart';
import 'package:propup/state_managers/home_tabs_state.dart';
import 'package:provider/provider.dart';

///propup-715a1
///this class is where the home screen page shall be placed
///
//ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPop() async {
      return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Exit application"),
                content: const Text("Do you want Exit"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Exit")),
                ],
              )));
    }

    return ChangeNotifierProvider<homeTabsChange>(
      create: (context) => homeTabsChange(),
      builder: (context, child) => WillPopScope(
        onWillPop: _willPop,
        child: Scaffold(
          body: Consumer<homeTabsChange>(builder: (context, value, child) {
            // if(value.currentIndex == 0){
            //   return const postsTab();}
            if (value.currentIndex == 21) {
              return const chatTab();
            }
            return const homeTab();
          }),
          bottomNavigationBar: Consumer<homeTabsChange>(
            builder: (context, value, child) => BottomNavigationBar(
                onTap: (val) => value.ChangeIndex(val),
                currentIndex: value.currentIndex,
                items: const [
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.photo_album),
                  //   label: "Posts"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_rounded), label: "Chat"),
                ]),
          ),
        ),
      ),
    );
  }
}
