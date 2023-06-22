import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

///
///this class is where the home screen page shall be placed
///
//ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const helloTitleWidget(),
          actions: [
            IconButton(
                onPressed: ()=> Navigator.pop(context),
                icon: const Icon(Icons.notification_add_outlined)),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
              ),
            )
          ],
        ),
        body: const SafeArea(
          //child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: accountBalanceWidget()),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10), child: gridDataWidget()))
            ],
          ),
        )
        //),
        );
  }
}
