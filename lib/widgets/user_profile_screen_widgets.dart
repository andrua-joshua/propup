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
        radius: 77,
        backgroundImage: NetworkImage(
            "data:image/jpeg;base64,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"),
      ),
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
