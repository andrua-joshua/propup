import 'package:flutter/material.dart';
import 'package:propup/widgets/edit_profile_widgets.dart';

///
///this is for defining the screen for editing the user profile
///
//ignore: camel_case_types
class editProfileScreen extends StatelessWidget {
  const editProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Account Info",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                profilePicRowWidget(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Full name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                fullNameRowWidget(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "District",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                locationRowWidget(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "About you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                aboutRowWidget(),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: saveBtnWidget(),
                )
              ],
            )),
      )),
    );
  }
}
