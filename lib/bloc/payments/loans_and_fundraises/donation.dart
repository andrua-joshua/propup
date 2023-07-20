import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_outgoing_message_handler.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';

///
///--> provide a method for donating to a friend
///--> provide a method for collecting the donations
///-->
///

//ignore:camel_case_types
class donations {
  donations._();
  static final _singleObj = donations._();
  factory donations.instance() => _singleObj;

  Future<bool> requestDonation({
    required int amount,
    required String purpose
  }) async {

    bool returnedValue = false;

    final auth = FirebaseAuth.instance.currentUser;
    final donations = FirebaseFirestore.instance.collection("donations");
    final currentUser =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    //updating the users current donations status
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(currentUser);

      final userDonations = secureSnap.get("donations") as List;

      bool val = await hasNoOpenDonations(secureSnap);
      if (val) {
        //adding the donation to the donation compaigns
        final newDonation = await donations.add({
          "amount": amount,
          "donars": [],
          "user": currentUser.id,
          "closed": false,
          "recieved": 0
        });

        userDonations.add(newDonation.id);

        transaction.update(currentUser, {"donations": userDonations});

        //code to send the request friends
        final notificaton = notificationsMessage(
            head: DateTime.now().microsecondsSinceEpoch,
            messageID: newDonation.id,
            message: purpose,
            subType: "Donation");

        await fcmOutgoingMessages
            .instance()
            .sendNotificationMessage(message: notificaton);

        returnedValue = true;
      }
    });

    return returnedValue;
  }

  Future<bool> hasNoOpenDonations(DocumentSnapshot user) async {
    final donations = FirebaseFirestore.instance.collection("donations");
    final userDonations = user.get("donations") as List;

    for (var element in userDonations) {
      final ln = await donations.doc(element).get();
      bool vl = ln.get("closed") as bool;
      if (!vl) {
        return false;
      }
    }

    return true;
  }

  Future<int> donateToFriend(
      {required String donationId, required int amount}) async {
    ///
    /// return 0 -> low account balance
    /// return 1 -> donation was succesful
    /// return 2 -> donation closed
    /// return 3 -> data write or update failed
    /// return 4 -> unkown error

    final auth = FirebaseAuth.instance.currentUser;
    final donationRf =
        FirebaseFirestore.instance.collection("donations").doc(donationId);
    final donation = await donationRf.get();
    final userRf =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    final user = await userRf.get();
    final donatedUserRf = FirebaseFirestore.instance
        .collection("users")
        .doc(donation.get("user"));
    final donatedUser = await donatedUserRf.get();

    if ((user.get("account_balance") as int) > amount) {
      //to first check whether the current user has enough cash  to donate

      if (!(donation.get("closed") as bool)) {
        //to first check if the donation is close

        int balance =
            (donation.get("amount") as int) - (donation.get("recieved") as int);

        if (balance < amount) {
          //checks if the remaining balance is smaller the amount about to donate

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final donationSecureSnap = await transaction.get(donationRf);
            final donationUserSecureSnap = await transaction.get(donatedUserRf);

            ///updating the donation compaign status
            int totalDonationAmount = donationSecureSnap.get("amount") as int;

            final donars = donationSecureSnap.get("donars") as List;

            donars.add({"amount": balance, "donar": userRf.id});

            transaction.update(donationRf, {
              "recieved": totalDonationAmount,
              "donars": donars,
              "closed": true
            });

            ///updating the user who owned the donations and transactions status
            // ignore: non_constant_identifier_names
            int donationUser_balance =
                (donationUserSecureSnap.get("account_balance") as int) +
                    totalDonationAmount;
            int recieved = (donationUserSecureSnap.get("recieved") as int) +
                totalDonationAmount;
            final donationUserTransactions =
                donationUserSecureSnap.get("transactions") as List;

            donationUserTransactions.add({
              "type": "donation-recieved",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": totalDonationAmount
            });
            transaction.update(donatedUserRf, {
              "account_balance": donationUser_balance,
              "transactions": donationUserTransactions,
              "recieved": recieved
            });

            final notificaton = notificationsMessage(
                head: DateTime.now().microsecondsSinceEpoch,
                messageID: donation.id,
                message:
                    "Congulation,your donation compaing of $totalDonationAmount is completed.",
                subType: "donation-compaign");

            await fcmOutgoingMessages.instance().sendCompaignNotification(
                message: notificaton, recieverId: donationUserSecureSnap.id);

            ///updating the donars donation and transaction status
            // ignore: non_constant_identifier_names
            int account_balance =
                (userSecureSnap.get("account_balance") as int) - balance;
            int donated = (userSecureSnap.get("donated") as int) + balance;
            final userTransactions = userSecureSnap.get("transactions") as List;

            userTransactions.add({
              "type": "donation",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": balance,
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transaction": userTransactions,
              "donated": donated
            });

            bool chkD = await checkDonation(
                expRecieved: totalDonationAmount, donationId: donationId);

            bool chkB = await chechBalance(expBalance: account_balance);

            if (chkD && chkB) {
              return 1;
            } else {
              return 3;
            }
          });
        } else {
          //incase the balance is greater than than the amount being donated

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final donationSecureSnap = await transaction.get(donationRf);

            ///updating the donation compaign's status
            int totalDonationAmount =
                (donationSecureSnap.get("recieved") as int) + amount;

            final donars = donationSecureSnap.get("donars") as List;

            donars.add({"amount": amount, "donar": userRf.id});

            transaction.update(donationRf,
                {"recieved": totalDonationAmount, "donars": donars});

            ///updating the donars donations Status
            // ignore: non_constant_identifier_names
            int account_balance =
                (userSecureSnap.get("account_balance") as int) - amount;
            int donated = (userSecureSnap.get("donated") as int) + amount;
            final userTransactions = userSecureSnap.get("transactions") as List;

            userTransactions.add({
              "type": "donation",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": amount
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transactions": userTransactions,
              "donated": donated
            });

            final notificaton = notificationsMessage(
                head: DateTime.now().microsecondsSinceEpoch,
                messageID: donation.id,
                message:
                    "${userSecureSnap.get("username")} has made a donation of "
                    "$amount to  your donation compaing of $totalDonationAmount.",
                subType: "donation-compaign");

            await fcmOutgoingMessages.instance().sendCompaignNotification(
                message: notificaton, recieverId: donation.get("user"));

            bool chkD = await checkDonation(
                expRecieved: totalDonationAmount, donationId: donationId);

            bool chkB = await chechBalance(expBalance: account_balance);

            if (chkD && chkB) {
              return 1;
            } else {
              return 3;
            }
          });
        }

        // ignore: curly_braces_in_flow_control_structures
      } else
        return 2;

      // ignore: curly_braces_in_flow_control_structures
    } else
      return 0;

    return 4;
  }

  Future<bool> checkDonation(
      {required int expRecieved, required String donationId}) async {
    final donation = await FirebaseFirestore.instance
        .collection("donations")
        .doc(donationId)
        .get();

    int recieved = donation.get("recieved") as int;

    return recieved == expRecieved;
  }

  Future<bool> chechBalance({required int expBalance}) async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    int balance = user.get("account_balance") as int;

    return balance == expBalance;
  }
}
