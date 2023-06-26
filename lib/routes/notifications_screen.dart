import 'package:flutter/material.dart';
import 'package:propup/widgets/notifications_screen_widgets.dart';

///
///this is where all the notifications on the application shall be rendered
///
//ignore: camel_case_types
class notificationsScreen extends StatelessWidget {
  const notificationsScreen({super.key});

  final all = const <int>[
    0,
    1,
    0,
    2,
    1,
    3,
    2,
    3,
    1,
    2,
    0,
    2,
    3,
    1,
    0,
    2,
    2,
    1,
    2,
    0,
    1,
    2,
    0,
    0,
    3,
    2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Notifications",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
          SliverList.builder(
              itemCount: all.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: customNotificationsListTileWidget(type: all[index]),
                  ))
        ],
      ),
    );
  }
}
