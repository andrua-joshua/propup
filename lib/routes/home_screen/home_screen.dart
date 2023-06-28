import 'package:flutter/material.dart';
import 'package:propup/routes/home_screen/tabs/home_tab.dart';
import 'package:propup/routes/home_screen/tabs/postsTab.dart';
import 'package:propup/state_managers/home_tabs_state.dart';
import 'package:provider/provider.dart';

///
///this class is where the home screen page shall be placed
///
//ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<homeTabsChange>(
      create: (context)=>homeTabsChange(),
      builder: (context, child)=>Scaffold(
        body: Consumer<homeTabsChange>(
          builder: (context,value,child){
            if(value.currentIndex == 0){
              return const postsTab();
            }
            return const homeTab();
          }),
         bottomNavigationBar: Consumer<homeTabsChange>(
          builder: (context,value,child)
            =>BottomNavigationBar(
              onTap: (val)=>value.ChangeIndex(val),
          currentIndex: value.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: "Posts"),
              BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"),
              BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              label: "Chat"),
          ]),
         ),
      ),);
  }
}
