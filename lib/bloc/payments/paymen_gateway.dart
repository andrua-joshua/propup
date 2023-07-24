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
    String url = "https://ugexportsolutions.com/drilloxpay.php";
    String result = "";
    // ignore: non_constant_identifier_names
    double account_balance = await getAccountBalance();

    FormData payload = FormData.fromMap(
        {"pay": true, "IDz": reason, "amnt": amount, "phone": phone});

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
  Future<double> getAccountBalance() async {
    double balance = 0.0;

    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    balance = user.get("account_balance") as double;

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
        "transactions":usersTransactions
        });

      balance = updated_balance;
    });

    return balance;
  }
}
