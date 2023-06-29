//ignore:camel_case_types
import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

class postsCommentScreen extends StatelessWidget {
  const postsCommentScreen({super.key});

  final images = const<String>[
    "assets/images/pic1.jpg",
    "assets/images/pp.jpg",
    "assets/images/pp2.jpg",
    "assets/images/profile.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "comments",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15), 
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (context,index){
                    return postsCommentWidget(
                      image: images[index], 
                      comment: "Some random comment here. never mind, it aint about "+
                      "you or any of your friend and thats it", name: "randomNa");
                  })),
              const SizedBox(height: 10,),
              const commentingAreaWidget()
            ],
          )),
      ),
    );
  }
}
