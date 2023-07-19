import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      required int interestRate,
      required DateTime paybackTime,
      required String purpose
      }) async {
    final auth = FirebaseAuth.instance.currentUser;
    final loans = FirebaseFirestore.instance.collection("loans");
    final currentUser =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);

    //updating the users current loan compaigns status
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(currentUser);
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
          "user": auth?.uid
        });

        userLoans.add(newLoan.id);
        transaction.update(currentUser, {"loans": userLoans});

        //code to send the request friends
        final notificaton = notificationsMessage(
            head: DateTime.now().microsecondsSinceEpoch,
            messageID: newLoan.id,
            message: purpose,
            subType: "Loan");

        await fcmOutgoingMessages
            .instance()
            .sendNotificationMessage(message: notificaton);

        return true;
      }
    });

    return false;
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
    /// return 1 -> donation was succesful
    /// return 2 -> donation closed
    /// return 3 -> data write or update failed
    /// return 4 -> unkown error
    ///

    final auth = FirebaseAuth.instance.currentUser;
    final loanRf = FirebaseFirestore.instance.collection("loans").doc(loanId);
    final loan = await loanRf.get();
    final userRf =
        FirebaseFirestore.instance.collection("users").doc(auth?.uid);
    final user = await userRf.get();
    final lentUserRf = FirebaseFirestore.instance
        .collection("users")
        .doc(loan.get("user"));
    final lentUser = await lentUserRf.get();


    if((user.get("account_balance") as int)>amount){
      //to first check whether the current user has enough cash to lend
      
      if(!(loan.get("closed") as bool)){

        int balance =
            (loan.get("amount") as int) - (loan.get("recieved") as int);

          if(balance<amount){
            //checks if the remainin balance is smaller than the amount to lend

            await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final loanSecureSnap = await transaction.get(loanRf);
            final lentUserSecureSnap = await transaction.get(lentUserRf);

            ///updating the donation compaign status
            int totalLentAmount = loanSecureSnap.get("amount") as int;

            final lenders = loanSecureSnap.get("lenders") as List;

            lenders.add({"amount": balance, "lender": userRf.id});

            transaction.update(loanRf, {
              "recieved": totalLentAmount,
              "lenders": lenders,
              "closed": true
            });

            ///updating the user who owned the loan and transactions status
            // ignore: non_constant_identifier_names
            int lentUser_balance =
                (lentUserSecureSnap.get("account_balance") as int) +
                    totalLentAmount;
            
            final lentUserTransactions =
                lentUserSecureSnap.get("transactions") as List;

            lentUserTransactions.add({
              "type": "loan-recieved",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": totalLentAmount
            });
            transaction.update(lentUserRf, {
              "account_balance": lentUser_balance,
              "transactions":lentUserTransactions
            });

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
              "type": "lent",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": balance,
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transactions": userTransactions,
            });

            bool chkD = await checkLoan(
                expRecieved: totalLentAmount, loanId: loanId);

            bool chkB = await chechBalance(expBalance: account_balance);

            if (chkD && chkB) {
              return 1;
            } else {
              return 3;
            }
          });
          }else{
            //if the balance is greater than the amount to lend

            await FirebaseFirestore.instance.runTransaction((transaction) async {
            final userSecureSnap = await transaction.get(userRf);
            final loanSecureSnap = await transaction.get(loanRf);

            ///updating the loan compaign's status
            int totalLentAmount =
                (loanSecureSnap.get("recieved") as int) + amount;

            final lenders = loanSecureSnap.get("lenders") as List;

            lenders.add({"amount": amount, "lender": userRf.id});

            transaction.update(loanRf,
                {"recieved": totalLentAmount, "lenders": lenders});

            ///updating the lenders donations Status
            // ignore: non_constant_identifier_names
            int account_balance =
                (userSecureSnap.get("account_balance") as int) - amount;
            final userTransactions = userSecureSnap.get("transactions") as List;

            userTransactions.add({
              "type": "lent",
              "date": DateTime.now().microsecondsSinceEpoch,
              "amount": amount,
            });

            transaction.update(userRf, {
              "account_balance": account_balance,
              "transactions": userTransactions
            });

            final notificaton = notificationsMessage(
                head: DateTime.now().microsecondsSinceEpoch,
                messageID: loan.id,
                message:
                    "${userSecureSnap.get("username")} has lent you"
                    "$amount to  your loan compaing of $totalLentAmount.",
                subType: "donation-compaign");

            await fcmOutgoingMessages.instance().sendCompaignNotification(
                message: notificaton, recieverId: loan.get("user"));

            bool chkD = await checkLoan(
                expRecieved: totalLentAmount, loanId: loanId);

            bool chkB = await chechBalance(expBalance: account_balance);

            if (chkD && chkB) {
              return 1;
            } else {
              return 3;
            }
          });

            //---------
          }

      }else{
        return 2;
      }

    }else{
      return 0;
    }

    return 4;

  }


  Future<bool> checkLoan(
      {required int expRecieved, required String loanId}) async {
    final loan = await FirebaseFirestore.instance
        .collection("loans")
        .doc(loanId)
        .get();

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
