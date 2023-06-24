import 'package:flutter/material.dart';

///
///This is where all the user profile screen custom widgets will be defimed
///

//ignore:camel_case_types
class profileImageWidget extends StatelessWidget {
  const profileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 80,
      backgroundColor: Colors.white,
      child: CircleAvatar(
          radius: 77, backgroundImage: AssetImage("assets/images/profile.jpg")),
    );
  }
}

///
///this for the declaration of the users details
///
//ignore: camel_case_types
class userInfoWidget extends StatelessWidget {
  const userInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: const Column(
        children: [
          userDataTileWidget(
              icon: Icons.account_box_outlined, title: "Account Info"),
          userDataTileWidget(icon: Icons.account_balance, title: "Payments"),
          userDataTileWidget(icon: Icons.settings, title: "Settings"),
          userDataTileWidget(icon: Icons.help_center, title: "Help Center"),
          userDataTileWidget(icon: Icons.contact_mail, title: "Contact Us"),
          userDataTileWidget(icon: Icons.share, title: "Share App"),
          userDataTileWidget(icon: Icons.star_rate, title: "Rate App"),
          userDataTileWidget(icon: Icons.logout, title: "Logout")
        ],
      ),
    );
  }
}

///
///this is for the user data listing
///
//ignore:camel_case_types
class userDataTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const userDataTileWidget(
      {required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
}
