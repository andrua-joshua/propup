import 'package:flutter/material.dart';
import 'package:propup/widgets/friends_screen_widgets.dart';

///
///this class is where all the friend list will be shown
///
//ignore: camel_case_types
class friendScreen extends StatelessWidget {
  const friendScreen({super.key});

  final friends = const <String>[
    "John Mars",
    "Bupe vause",
    "Kathryn Murphy",
    "Darrel Stewart",
    "Sheldon F",
    "Leonard H.S",
    "Rajesh patel",
    "Penni salve",
  ];

  final titles = const <String>[
    "Developer",
    "Retail supervisor",
    "Photographer",
    "UI/UX designer",
    "Theoretical physcist",
    "Experimental physcist",
    "Astronomical physcists",
    "Model, Actress",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            collapsedHeight: 90,
            pinned: true,
            floating: true,
            title: const Text(
              "My Friends (580)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.1,
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 68, 221, 255)),
                padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
                child: const Text(
                  "Add friends",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu_open))
            ],
            centerTitle: true,
          ),
          SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200),
              itemCount: friends.length,
              itemBuilder: (context, index) =>
                  gridDataWidget(name: friends[index], title: titles[index]))
        ],
      ),
    );
  }
}
