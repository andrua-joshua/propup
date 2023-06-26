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
            "Hello, Jacobz",
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
