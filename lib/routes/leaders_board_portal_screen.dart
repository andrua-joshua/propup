import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where the portal for accessing the different leaders board shall be declared
///
//ignore:camel_case_types
class leardersBoardPortalScreen extends StatelessWidget {
  const leardersBoardPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  RouteGenerator.led = true;
                  Navigator.pushNamed(
                      context, RouteGenerator.leadersboardScreen);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(80, 1, 80, 1),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Recievers",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  RouteGenerator.led = false;
                  Navigator.pushNamed(
                      context, RouteGenerator.leadersboardScreen);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(80, 1, 80, 1),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Donors",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
