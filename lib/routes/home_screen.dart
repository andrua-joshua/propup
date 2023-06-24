import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/widgets/home_screen_widgets.dart';
import 'package:propup/widgets/user_profile_screen_widgets.dart';

///
///this class is where the home screen page shall be placed
///
//ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: accountBalanceWidget()),
            SizedBox(
              height: 30,
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
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    profileImageWidget(),
                    Text(
                      "Anonymous user",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "anonymoususer@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    userInfoWidget()
                  ],
                ),
              ))),
    );
  }
}
