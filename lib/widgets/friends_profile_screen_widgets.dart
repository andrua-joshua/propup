import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///this is where all the custom widgets of the friends screen will be defined
///

///the one for holding the location
//ignore: camel_case_types
class locationWidget extends StatelessWidget {
  final String location;
  const locationWidget({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.place,
          color: Colors.grey,
        ),
        Text(
          location,
          style: const TextStyle(color: Colors.grey, fontSize: 22),
        )
      ],
    );
  }
}

///
///this is for expression of moodes towards the friend
///
//ignore: camel_case_types
class expressionsWidget extends StatelessWidget {
  const expressionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.purple),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_down,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "1.6k",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "FRIENDS",
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.green),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

///
///this is to show the recieved and donated catch\
///
//ignore: camel_case_types
class transfersWidget extends StatelessWidget {
  const transfersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Column(
            children: [
              Text(
                "\$489",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              Text(
                "Recieved",
                style: TextStyle(color: Colors.purple, fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Text(
                "\$3.7k",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              Text(
                "Donated",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///
///summary of the friend
///
//ignore:camel_case_types
class friendSummaryWidget extends StatelessWidget {
  const friendSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("122",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "followers",
                style: TextStyle(),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("67",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "friends",
                style: TextStyle(),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("122",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "following",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

///
///this is for the add friend btn
//ignore:camel_case_types
class addFriendBtnWidget extends StatelessWidget {
  const addFriendBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 5, 38, 65), borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {},
          child: const Text(
            "Add friend",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}


///
///this is for showning the images in the user or friends profile
//ignore:camel_case_types
class friendPostWidget extends StatelessWidget{
  final String image;
  const friendPostWidget({required this.image,super.key});

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return FutureBuilder<ImageDescriptor>(
        future: rootBundle.load(image)
         .then((value) => value.buffer.asUint8List())
          .then((value) => ImmutableBuffer.fromUint8List(value))
            .then((value) => ImageDescriptor.encoded(value)),
        builder: (context, snap){
          if(snap.hasError){
            return const Center(child: Text("there occurred some error"),);
          }
          if(snap.hasData==false){
            return const Center(child: CircularProgressIndicator(),);
          }
          int h=0;
          int w = 0;

          if(snap.hasData){
            h = snap.data?.height??1;
            w = snap.data?.width??1;
          }
          return Container(
        constraints: BoxConstraints.expand(
          height: width/(w/h)),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 224, 221, 221)),
        padding: const EdgeInsets.fromLTRB(3, 6, 3, 5),
        
      );
        });
    });
  }
}

///
///this is for the showing of all the images
///
//ignore: camel_case_types
class friendPostsWidget extends StatelessWidget{
  const friendPostsWidget({super.key});


  final images = const <String>[
    "assets/images/profile.jpg",
    "assets/images/pp.jpg",
    "assets/images/pic1.jpg",
    "assets/images/pic2.jpg",
    "assets/images/pp2.jpg",
  ];

  @override
  Widget build(BuildContext context){
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10
      ),
      children: List.generate(images.length, 
      (index) => friendPostWidget(image: images[index])),
      );
  }
}