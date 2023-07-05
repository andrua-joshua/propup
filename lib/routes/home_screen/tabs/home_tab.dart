import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';
import 'package:propup/widgets/user_profile_screen_widgets.dart';

import '../../../routes.dart';

///
///for the home optin of the tab
//ignore:camel_case_types
class homeTab extends StatelessWidget{
  const homeTab({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const helloTitleWidget(),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, RouteGenerator.notificationscreen),
              icon: const Icon(Icons.notification_add_outlined)),
        ],
      ),
      body: const SafeArea(
        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: accountBalanceWidget()),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10), child: gridDataWidget()))
          ],
        ),
      ),
      drawer: SafeArea(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/userbg.png"),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const profileImageWidget(),
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName??"unknown",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser?.email??"unknown",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const userInfoWidget()
                  ],
                ),
              ))),
    );
  }
}