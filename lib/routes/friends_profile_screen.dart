import 'package:flutter/material.dart';
import 'package:propup/widgets/friends_profile_screen_widgets.dart';

///
///the ui for viewing a friends profile
///
//ignore:camel_case_types
class friendsProfileScreen extends StatelessWidget {
  final String name;
  final String flocation;

  const friendsProfileScreen(
      {required this.name, String location = "unknown", super.key})
      : flocation = location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User's Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage("assets/images/profile.jpg")),
            ),
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            locationWidget(location: flocation),
            const SizedBox(
              height: 30,
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Live is like the wind, you can't see it but you can feel it.",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 40,
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: expressionsWidget()),
            const SizedBox(
              height: 40,
            ),
            const Padding(padding: EdgeInsets.all(15), child: transfersWidget())
          ],
        ),
      ),
    );
  }
}
