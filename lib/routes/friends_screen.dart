import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/state_managers/following_state.dart';
import 'package:propup/state_managers/friends_state_manager.dart';
import 'package:propup/widgets/friends_screen_widgets.dart';
import 'package:provider/provider.dart';

///
///this class is where all the friend list will be shown
///
//ignore: camel_case_types
class friendScreen extends StatelessWidget {
  const friendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //debugInvertOversizedImages = true;

    final auth = FirebaseAuth.instance.currentUser;
    final user = FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 8, 92, 181),
            leading: IconButton(onPressed: ()=> Navigator.pop(context), 
            icon: const Icon(Icons.arrow_back, color: Colors.white,)),
            centerTitle: true,
            title: const Text(
              "Friends",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              FutureBuilder(
                  future: user.get(),
                  builder: (context, snap) {
                    return IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: searchFriendsDeleget(
                                currentUser: snap.data,
                                  index: justStatic.index));
                        },
                        icon: const Icon(Icons.search, color: Colors.white,));
                  }),
                  IconButton(onPressed: ()=>Navigator.pushNamed(context, RouteGenerator.addFriendsscreen), 
                  icon: const Icon(Icons.group_add, color: Colors.white,))
            ],
            bottom: const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
              unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              indicatorColor: Colors.black,
              labelColor: Colors.white,
              indicatorWeight: 3,
              unselectedLabelColor: Colors.black,
              
              tabs: [
              Text(
                "Followers",
                style: TextStyle(),
              ),
              Text(
                "Friends",
                style: TextStyle(),
              ),
              Text(
                "Following",
                style: TextStyle(),
              ),
            ]),
          ),
          body: MultiProvider(
            providers:[
              ChangeNotifierProvider<friendsNotifier>(create: (context)=>friendsNotifier()),
              ChangeNotifierProvider<followersNotifier>(create: (context)=>followersNotifier()),
              ChangeNotifierProvider<followingNotifier>(create: (context)=>followingNotifier())
            ],
            child: const Padding(
              padding: EdgeInsets.only(top: 10, left: 2, right: 2),
              child: TabBarView(children: [
                followersWidget(),
                friendsWidget(),
                followingWidget()
              ])),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () =>
          //       Navigator.pushNamed(context, RouteGenerator.addFriendsscreen),
          //   child: const Icon(Icons.add),
          // ),
        ));
  }
}
