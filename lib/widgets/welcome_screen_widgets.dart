import 'package:flutter/material.dart';

import '../routes.dart';

///
///this is where all the welcome screen custome widgets shall be defined
///
//ignore: camel_case_types
class salutationWidget extends StatelessWidget {
  const salutationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Welcome  to Prop-up Platform",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(
          height: 90,
        ),
        const switchesWidget(),
        const SizedBox(
          height: 30,
        ),
        TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteGenerator.loginscreen),
            child: Container(
              constraints: const BoxConstraints.expand(height: 50),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

//ignore: camel_case_types
class switchesWidget extends StatelessWidget {
  const switchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 18,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 122, 246, 236),
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          height: 10,
          width: 15,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }
}
