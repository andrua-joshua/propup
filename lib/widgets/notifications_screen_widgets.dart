import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the notification screen shall be declared
///

//ignore:camel_case_types
class customNotificationsListTileWidget extends StatelessWidget {
  final String notificationId;
  final String subType;
  final int head;
  final String notificationMessage;
  final bool viewedStatus;
  final void Function() callback;

  /// type == 0 :> support
  /// type == 1 :> loan
  /// type == 2 :> friendRequest
  /// type == 3 :> donation-recieved
  /// type == 4 :> loan-recieved
  ///
  /// ----- --- transitioned values -----
  /// type == loan               :> loan request
  /// type == donation           :> donation request
  /// type == donation-compaign  :> donation compaign status
  /// type == loan-comaign       :> loan compaign status

  const customNotificationsListTileWidget(
      {required this.callback,
      required this.subType,
      required this.notificationId,
      required this.head,
      required this.viewedStatus,
      required this.notificationMessage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection((subType == 'Loan') ? "loans" : "donations")
            .doc(notificationId)
            .get(),
        builder: (context, snap) {
          if (snap.hasData) {
            debugPrint("here we are :::: $subType:::${snap.data?.exists}");
            if (snap.data != null) {
              return ListTile(
                onTap: () => callback(),
                leading: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(10),
                      child: Icon((subType == 'Donation')
                          ? Icons.support
                          : (subType == 'Loan')
                              ? Icons.balance
                              : Icons.child_friendly),
                    )),
                title: (subType == 'Loan' || subType == 'Donation')
                    ? FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(snap.data?.get("user"))
                            .get(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return Text(
                                (subType == 'Donation')
                                    ? "Your friend ${snapShot.data?.get("username")} needs your support"
                                    : (subType == 'Loan')
                                        ? "Your Friend ${snapShot.data?.get("username")} has requested for a loan"
                                        : notificationMessage,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: viewedStatus
                                        ? Colors.black
                                        : Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold));
                          }

                          if (snapShot.hasError) {
                            return const Text(
                              "Error, check your network plz",
                              style: TextStyle(color: Colors.red),
                            );
                          }

                          return Container(
                            constraints:
                                const BoxConstraints.expand(height: 30),
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 219, 219),
                                borderRadius: BorderRadius.circular(10)),
                          );
                        })
                    : Text(notificationMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: viewedStatus ? Colors.black : Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                subtitle: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subType,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd")
                            .format(DateTime.fromMicrosecondsSinceEpoch(head)),
                        style: const TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
              );
            }
          }

          if (snap.hasError) {
            return const Text(
              "Error, check your network plz",
              style: TextStyle(color: Colors.red),
            );
          }

          return Container(
            constraints: const BoxConstraints.expand(height: 50),
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 219, 219, 219),
                borderRadius: BorderRadius.circular(10)),
          );
        });
  }
}
