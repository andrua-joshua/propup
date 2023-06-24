import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the notification screen shall be declared
///

//ignore:camel_case_types
class customNotificationsListTileWidget extends StatelessWidget {
  //final String title;
  final int type;

  /// type == 0 :> support
  /// type == 1 :> loan
  /// type == 2 :> friendRequest

  const customNotificationsListTileWidget({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (type) {
          case 0:
            Navigator.pushNamed(context, RouteGenerator.supportscreen);
            break;
          case 1:
            Navigator.pushNamed(context, RouteGenerator.lendfriendscreen);
            break;
          case 2:
            Navigator.pushNamed(context, RouteGenerator.friendrequestscreen);
            break;
        }
      },
      leading: Card(
          elevation: 8,
          color: Colors.white,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: Icon((type == 0)
                ? Icons.support
                : (type == 1)
                    ? Icons.balance
                    : Icons.child_friendly),
          )),
      title: Text(
          (type == 0)
              ? "Your Friend Bupe needs your support"
              : (type == 1)
                  ? "Your Friend Jacob wants a loan"
                  : "Leonard has sent you a friend request",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (type == 0)
                  ? "Support"
                  : (type == 1)
                      ? "Loan"
                      : "Friend request",
              style: const TextStyle(color: Colors.grey),
            ),
            const Text(
              "July 14, 2022",
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
