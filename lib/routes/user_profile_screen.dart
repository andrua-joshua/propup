import 'package:flutter/material.dart';
import 'package:propup/widgets/user_profile_screen_widgets.dart';

///
///the user profile screen where the user will be able to view his/her profile
///
//ignore: camel_case_types
class userProfileScreen extends StatelessWidget {
  const userProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Container(
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
