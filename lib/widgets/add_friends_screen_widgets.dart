import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

//ignore:camel_case_types
class searchFriendWidget extends StatelessWidget {
  const searchFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return SizedBox(
        height: 30,
        width: 0.7 * width,
        child: const SearchBar(leading: Icon(Icons.search), hintText: "Search"),
      );
    });
  }
}

//ignore: camel_case_types
class possibleFriendsWidget extends StatelessWidget {
  const possibleFriendsWidget({super.key});

  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
  ];

  final names = const <String>[
    "Mugisha Moses",
    "Anthony Rock",
    "Tom Cruisce",
    "John dush",
    "Natalia Joyce",
    "Mugisha Moses",
    "Anthony Rock",
    "Tom Cruisce",
    "John dush",
    "Natalia Joyce",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          images.length,
          (index) => Padding(
                padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                child: possibleFriendWidget(
                  name: names[index],
                  image: images[index],
                  description: "Here i am using propup to develop",
                ),
              )),
    );
  }
}

//ignore:camel_case_types
class possibleFriendWidget extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  const possibleFriendWidget(
      {required this.description,
      required this.name,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
      leading: CircleAvatar(
          radius: 35,
          child: Center(
              child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 35,
            backgroundImage: AssetImage(image),
          ))),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
