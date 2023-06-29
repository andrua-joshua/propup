import 'package:flutter/material.dart';
import 'package:propup/widgets/friend_request_widgets.dart';
import 'package:propup/widgets/friends_profile_screen_widgets.dart';

///
///this is where friend request is declared
///
//ignore: camel_case_types
class friendRequestScreen extends StatelessWidget {
  const friendRequestScreen({super.key});

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
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            const SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: 20,
              ),
              Center(
                  child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 90,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              )),
              Center(
                  child: Text(
                "Tracy Zoe",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
              friendLocationWidget(),
              SizedBox(
                height: 30,
              ),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0) ,child:Text(
                "Love is like the wind, you can't see it but you can feel it.",
                style: TextStyle(color: Colors.black, fontSize: 19),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 30,
              ),
              requestOptionsRowWidget(),
              SizedBox(
                height: 30,
              ),
              friendDetailsRowWidget(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Photos",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              Padding(
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
