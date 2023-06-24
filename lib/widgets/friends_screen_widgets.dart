import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the friends screen are to be defined
///
//ignore:camel_case_types
class friendsTitleWidget extends StatelessWidget {
  const friendsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          "My Friends (580)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 68, 221, 255)),
          padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
          child: const Text(
            "Add friends",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}

///
///custom widget for holding all the friends in the friends screen grid
///
//ignore: camel_case_types
class gridDataWidget extends StatelessWidget {
  final String name;
  final String title;
  const gridDataWidget({required this.name, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        //color: Colors.white,
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  margin: const EdgeInsets.only(top: 10),
                  child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage("assets/images/profile.jpg")),
                ), // for holding the profile pic

                const SizedBox(
                  height: 10,
                ),
                statusWidget(
                  name: name,
                  online: true,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
          ),
        ));
  }
}

///
///for holding the name and the online status
///
//ignore: camel_case_types
class statusWidget extends StatelessWidget {
  final String name;
  final bool isOnline;
  const statusWidget({required this.name, bool online = false, super.key})
      : isOnline = online;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? Colors.green : Colors.grey),
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
