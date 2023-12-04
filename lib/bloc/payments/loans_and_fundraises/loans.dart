import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/cloud_messaging_api/fcm_handlers/fcm_outgoing_message_handler.dart';

import '../../cloud_messaging_api/fcm_models/fcm_notifiaction_messae_modal.dart';

///
///-> request a loan
///-> lend a person
///-> payback a loan
///

//ignore:camel_case_types
class loans {
  loans._();
  static final _singleObj = loans._();
  factory loans.instance() => _singleObj;

  Future<bool> requestLoan(
      {required int amount,
      required bool isPublic,
      required int interestRate,
      required DateTime paybackTime,
      required String purpose}) async {
    bool v = false;

    final auth = FirebaseAuth.instance.currentUser;
    final loans = FirebaseFirestore.instance.collection("loans");
    final currentUser =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    final publicLoans = FirebaseFirestore.instance
        .collection("public-compaigns")
        .doc("O8DnKgq2bN8QcKJifrca");

    //updating the users current loan compaigns status
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(currentUser);
      final securePublicLoan = await transaction.get(publicLoans);
      final userLoans = secureSnap.get("loans") as List;

      bool val = await hasNoOpenLoans(secureSnap);

      if (val) {
        final newLoan = await loans.add({
          "amount": amount,
          "closed": false,
          "interest": interestRate,
          "paybackTime": paybackTime.microsecondsSinceEpoch,
          "lenders": [],
          "paidback": 0,
          "recieved": 0,
          "user": auth?.uid,
          "purpose": purpose
        });

        userLoans.add(newLoan.id);
        transaction.update(currentUser, {"loans": userLoans});

        //checking if is public loan
        if (isPublic) {
          final loans = securePublicLoan.get("loans") as List;
          loans.add(newLoan.id);

          transaction.update(publicLoans, {"loans": loans});
        }

        //code to send the request friends
        final notificaton = notificationsMessage(
            head: DateTime.now().microsecondsSinceEpoch,
            messageID: newLoan.id,
            message: purpose,
            subType: "Loan");

        await fcmOutgoingMessages
            .instance()
            .sendNotificationMessage(message: notificaton);

        v = true;
      }
    });

    return v;
  }

  Future<bool> hasNoOpenLoans(DocumentSnapshot user) async {
    final loans = FirebaseFirestore.instance.collection("loans");
    final userLoans = user.get("loans") as List;

    for (var element in userLoans) {
      final ln = await loans.doc(element).get();
      bool vl = ln.get("closed") as bool;
      if (!vl) {
        return false;
      }
    }

    return true;
  }

  Future<int> lendFriend({required String loanId, required int amount}) async {
    ///
    /// return 0 -> low account balance
    /// return 1 -> loan was succesful
    /// return 2 -> loan closed
    /// return 3 -> data write or update failed
    /// return 4 -> unkown error
    ///

    int returned = 4;
    final auth = FirebaseAuth.instance.currentUser;
    final loanRf = FirebaseFirestore.instance.collection("loans").doc(loanId);
    final loan = await loanRf.get();
    final userRf =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    final user = await userRf.get();
    final lentUserRf =
        FirebaseFirestore.instance.collection("users").doc(loan.get("user"));
    final publicLoans = FirebaseFirestore.instance
        .collection("public-compaigns")
        .doc("O8DnKgq2bN8QcKJifrca");
    final lentUser = await lentUserRf.get();
    final fees = FirebaseFirestore.instance
        .collection("fees")
        .doc("onbwmX03juwvQoKce736");

    final val = await FirebaseFirestore.instance
        .collection("rates")
        .doc("YojsvptcUqpsyCsCcHO1")
        .get();

    if ((user.get("account_balance") as int) > amount) {
      //to first check whether the current user has enough cash to lend

      if (!(loan.get("closed") as bool)) {
        int balance =
            (loan.get("amount") as int) - (loan.get("recieved") as int);

        if (balance <= amount) {
          //checks if the remainin balance is smaller than the amount to lend

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final loanSecureSnap = await transaction.get(loanRf);
            final lentUserSecureSnap = await transaction.get(lentUserRf);
            final secureFee = await transaction.get(fees);
            final securePublicLoan = await transaction.get(publicLoans);

            ///updating the donation compaign status
            int totalLentAmount = loanSecureSnap.get("amount") as int;

            final lenders = loanSecureSnap.get("lenders") as List;

            lenders.add({"amount": balance, "lender": userRf.id});

            transaction.update(loanRf, {
              "recieved": totalLentAmount,
              "lenders": lenders,
              "closed": true
            });

            double mult = val.get("compaignRate") as double;
            double fee = (loan.get("amount") as int) * mult;

            ///updating the user who owned the loan and transactions status
            // ignore: non_constant_identifier_names
            double vl = 0.0;
            int lentUser_balance =
                (lentUserSecureSnap.get("account_balance") as int) +
                    (totalLentAmount - (fee.round()));

            final lentUserTransactions =
                lentUserSecureSnap.get("transactions") as List;

            lentUserTransactions.add({
              "id": loanId,
              "type": "loan-recieved",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": totalLentAmount - (fee.round()),
              "message": "You recieved a loan"
            });
            transaction.update(lentUserRf, {
              "account_balance": lentUser_balance,
              "transactions": lentUserTransactions
            });

            final allfees = secureFee.get("allfees") as List;
            allfees.add({"source": "Loan compaign", "amount": fee.round()});

            transaction.update(fees, {"allfees": allfees});

            final loans = securePublicLoan.get("loans") as List;
            final rmvd = loans.remove(loanId);

            debugPrint(":::::::@Drillox >>>Removed:>  $rmvd");

            transaction.update(publicLoans, {"loans": loans});

            final notificaton = notificationsMessage(
                head: DateTime.now().microsecondsSinceEpoch,
                messageID: loan.id,
                message:
                    "Congulation,your loan compaing of $totalLentAmount is completed.",
                subType: "loan-compaign");

            await fcmOutgoingMessages.instance().sendCompaignNotification(
                message: notificaton, recieverId: lentUserSecureSnap.id);

            ///updating the lenders lending and transaction status
            // ignore: non_constant_identifier_names
            int account_balance =
                (userSecureSnap.get("account_balance") as int) - balance;

            final userTransactions = userSecureSnap.get("transactions") as List;

            userTransactions.add({
              "id": loanId,
              "type": "Lent",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": balance,
              "message": "You lent ${lentUserSecureSnap.get("username")}"
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transactions": userTransactions,
            });

            returned = 1;
          });
        } else {
          //if the balance is greater than the amount to lend

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final loanSecureSnap = await transaction.get(loanRf);
            final lentUserSecureSnap = await transaction.get(lentUserRf);

            ///updating the loan compaign's status
            int totalLentAmount =
                (loanSecureSnap.get("recieved") as int) + amount;

            final lenders = loanSecureSnap.get("lenders") as List;

            lenders.add({"amount": amount, "lender": userRf.id});

            transaction.update(
                loanRf, {"recieved": totalLentAmount, "lenders": lenders});

            ///updating the lenders donations Status
            // ignore: non_constant_identifier_names
            int account_balance =
                (userSecureSnap.get("account_balance") as int) - amount;
            final userTransactions = userSecureSnap.get("transactions") as List;

            userTransactions.add({
              "id": loanId,
              "type": "Lent",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": amount,
              "message": "You lent ${lentUserSecureSnap.get("username")}"
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transactions": userTransactions
            });

            final notificaton = notificationsMessage(
                head: DateTime.now().microsecondsSinceEpoch,
                messageID: loan.id,
                message: "${userSecureSnap.get("username")} has lent you Ugx "
                    "$amount to  your loan compaing of ${loanSecureSnap.get("amount")}.",
                subType: "loan-compaign");

            await fcmOutgoingMessages.instance().sendCompaignNotification(
                message: notificaton, recieverId: loan.get("user"));

            returned = 1;
          });

          //---------
        }
      } else {
        returned = 2;
      }
    } else {
      returned = 0;
    }

    return returned;
  }

  Future<bool> checkLoan(
      {required int expRecieved, required String loanId}) async {
    final loan =
        await FirebaseFirestore.instance.collection("loans").doc(loanId).get();

    int recieved = loan.get("recieved") as int;

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
