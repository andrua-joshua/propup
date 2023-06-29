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

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          
          slivers: [
            const SliverAppBar(
              centerTitle: true,
              pinned: true,
              title: Text(
                "User's Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                child: Center(child:CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage("assets/images/profile.jpg"))),
              ),
              Center(child:Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
              const locationWidget(location: "flocation"),
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
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: friendSummaryWidget()),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(
                    thickness: 1,
                  )),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  child: transfersWidget()),
              const Center(child:addFriendBtnWidget()),
              const SizedBox(
                height: 20,
              ),
              const Center(child:Text(
                "Photos",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(
                    thickness: 1,
                  )),
            ])),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 10,mainAxisExtent: 150),
              delegate: SliverChildListDelegate.fixed(List.generate(
                  images.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      //color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage(images[index]))
                    ),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
