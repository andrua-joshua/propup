import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

///
///this is where the post tabs shall be created from
///
//ignore:camel_case_types
class postsTab extends StatelessWidget {
  const postsTab({super.key});

  final images = const<String>[
    "assets/images/pic1.jpg",
    "assets/images/pp.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5), child: postsTopWidget()),
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (contxt, index) {
                  return Padding(
                      padding: EdgeInsets.all(10),
                      child: postsTabPostWidget(
                          image: images[index]));
                }))
      ],
    ));
  }
}
