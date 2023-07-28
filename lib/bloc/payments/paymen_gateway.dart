import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

//ignore:camel_case_types
class paymentGateWay {
  paymentGateWay._();

  static final _singleObj = paymentGateWay._();
  factory paymentGateWay.instance() => _singleObj;

  Future<String> depositToWallet(
      {required int amount,
      required String reason,
      required String phone}) async {
    String url = "https://ugexportsolutions.com/easypay.php";
    String result = "";

    FormData payload = FormData.fromMap(
        {"pay": true, "IDz": reason, "amnt": amount, "phone": phone});

    try {
      Dio dio = Dio();

      final response = await dio.post(url,
          data: payload,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                debugPrint("@Drillox {status}::> $status");

                return status! < 500;
              },
              headers: {"Accept": "application/json"}));

      result = jsonEncode(response.data);
    } catch (e) {
      debugPrint("@Drillox {Exceptions IN depositing}:: $e");
    }

    final formatedResult = resultFormat(result: result);

    if (formatedResult == '1') {
      await updateAccountBalance(
        amount: amount,
      );
    }

    return resultFormat(result: result);
  }

  Future<String> withDrawFromWallet(
      {required int amount,
      required String reason,
      required String phone}) async {
    final auth = FirebaseAuth.instance.currentUser;
    final val = await FirebaseFirestore.instance
        .collection("rates")
        .doc("YojsvptcUqpsyCsCcHO1")
        .get();
    final fees = FirebaseFirestore.instance
        .collection("fees")
        .doc("onbwmX03juwvQoKce736");

    double mult = val.get("withdrawRate") as double;

    //    double mult =  val.get("")
    String url = "https://ugexportsolutions.com/drilloxpay.php";
    String result = "";
    // ignore: non_constant_identifier_names

    debugPrint("::::>>> here in the Withdraw method");
    int account_balance = await getAccountBalance();

    double fee = 0.0;

    if (amount < 15000) {
      fee = 440 + (440 * mult);
    } else if (amount < 30000) {
      fee = 600 + (600 * mult);
    } else if (amount < 45000) {
      fee = 800 + (800 * mult);
    } else if (amount < 60000) {
      fee = 1000 + (1000 * mult);
    } else if (amount < 125000) {
      fee = 1300 + (1300 * mult);
    } else if (amount < 250000) {
      fee = 1500 + (1500 * mult);
    } else if (amount < 500000) {
      fee = 2000 + (2000 * mult);
    } else if (amount < 1000000) {
      fee = 5000 + (5000 * mult);
    } else if (amount < 2000000) {
      fee = 7000 + (7000 * mult);
    } else if (amount < 5000000) {
      fee = 9000 + (9000 * mult);
    } else {
      fee = 10000 + (10000 * mult);
    }

    FormData payload = FormData.fromMap(
        {"pay": true, "IDz": reason, "amnt": amount - fee, "phone": phone});

    if (amount < account_balance) {
      try {
        Dio dio = Dio();

        final response = await dio.post(url,
            data: payload,
            options: Options(
              headers: {"Accept": "application/json"},
              followRedirects: false,
              validateStatus: (status) {
                debugPrint("@Drillox {status}::> $status");

                return status! < 500;
              },
            ));

        result = jsonEncode(response.data);
      } catch (e) {
        debugPrint("@Drillox {Exceptions IN withdrawing}:: $e");
      }
    }

    final formatedResult = resultFormat(result: result);

    if (formatedResult == '1') {
      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          final secureFee = await transaction.get(fees);
          final allfees = secureFee.get("allfees") as List;
          allfees.add({"source": "withdraw", "amount": fee.round()});

          transaction.update(fees,{
            "allfees":allfees
          });
        },
      );
      await updateAccountBalance(amount: amount, isWithdraw: true);
    }

    return formatedResult;
  }

  //will be used for formating the transactions result
  String resultFormat({required String result}) {
    String returned = '';

    if (result.length > 30) {
      int suIndex = result.indexOf('success');
      returned = result.substring(suIndex + 12, suIndex + 13);

      // debugPrint("$suIndex ::> \"$sub\"");
    }

    return returned;
  }

  // for getting our current account balance
  Future<int> getAccountBalance() async {
    int balance = 0;

    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    balance = user.get("account_balance") as int;

    return balance;
  }

  Future<int> updateAccountBalance(
      {bool isWithdraw = false, required int amount}) async {
    int balance = 0;

    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnap = await transaction.get(user);

      // ignore: non_constant_identifier_names
      int secure_balance = secureSnap.get("account_balance") as int;
      final usersTransactions = secureSnap.get("transactions") as List;

      usersTransactions.add({
        "id": "",
        "type": isWithdraw ? "Withdraw" : "Deposit",
        "date": DateTime.now().microsecondsSinceEpoch,
        "amount": amount,
        "message":
            "You have made a ${isWithdraw ? "Withdraw from " : "Deposit to "} your account"
      });

      // ignore: non_constant_identifier_names
      int updated_balance =
          (isWithdraw) ? secure_balance - amount : secure_balance + amount;

      transaction.update(user, {
        "account_balance": updated_balance,
        "transactions": usersTransactions
      });

      balance = updated_balance;
    });

    return balance;
  }
}
