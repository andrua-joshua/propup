import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the custome widgets of the home screen are to be created from
///

///
///this will be used for showing the salutation widget on the home screen
///
//ignore: camel_case_types
class helloTitleWidget extends StatelessWidget {
  const helloTitleWidget({super.key});

  @override
  Widget build(BuildContext) {
    return Container(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Hello, Jacob",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "Good morning",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }
}

///
///this is for showing the current account size
///
//ignore: camel_case_types
class accountBalanceWidget extends StatelessWidget {
  const accountBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "\$5623.67",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          "July 01, 2022",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}

///
///This is responsible for the grid of the navigations
///
//ignore:camel_case_types
class gridDataWidget extends StatelessWidget {
  const gridDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          mainAxisExtent: 150),
      children: [
        gridData(
            title: "Friends",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.friendscreen)),
        gridData(
            title: "Fund Raise",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.fundRaisescreen)),
        gridData(
            title: "Transactions",
            callBack: () => Navigator.pushNamed(
                context, RouteGenerator.transactionsscreen)),
        gridData(
            title: "Loan",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.loanscreen)),
        gridData(
            title: "LeaderBoard",
            callBack: () => Navigator.pushNamed(
                context, RouteGenerator.leadersboardscreenportal)),
      ],
    );
  }
}

///for just the grid data
//ignore: camel_case_types
class gridData extends StatelessWidget {
  final String title;
  void Function() callBack;
  gridData({required this.title, required this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: GestureDetector(
          onTap: callBack,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }
}

////
///this is where all the postsTab widgets are

///
///posts top row widget here
///
//ignore:camel_case_types
class postsTopWidget extends StatelessWidget {
  const postsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 156, 236, 247),
                    Color.fromARGB(255, 182, 236, 243),
                    Color.fromARGB(255, 253, 216, 247),
                    Color.fromARGB(255, 245, 177, 241),
                  ])),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircleAvatar(
                          backgroundColor: Colors.cyanAccent,
                          radius: 25,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 22,
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                        ))))
          ],
        ));
  }
}

///
///post widget where the exact post shall be placed
///
//ignore:camel_case_types
class postsTabPostWidget extends StatelessWidget {
  final String image;
  const postsTabPostWidget({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Container(
        constraints: BoxConstraints.expand(height: 0.9 * width),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 224, 221, 221)),
        padding: const EdgeInsets.fromLTRB(3, 6, 3, 5),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            postOwnerWidget(name: "Drillox", image: "assets/images/profile.jpg"),
            Expanded(child: SizedBox()),
            reactionOptionsWidget()
          ],
        ),
      );
    });
  }
}

///this is for showing the user who had posted the image
//ignore:camel_case_types
class postOwnerWidget extends StatelessWidget {
  final String image;
  final String name;
  const postOwnerWidget({required this.name, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(image),
      ),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: const Text(
        "2 hrs ago",
        style: TextStyle(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }
}

///
///this is for showing reaction options about the post
///
//ignore:camel_case_types
class reactionOptionsWidget extends StatelessWidget {
  const reactionOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {},
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.heart_broken_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "5.2k",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    Text(
                      "1.2k",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    Text(
                      "365",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ))
        ],
      );
    });
  }
}
