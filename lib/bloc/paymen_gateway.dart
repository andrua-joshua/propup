import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class paymentGateWay{

  paymentGateWay._();
  static final _singleObj = paymentGateWay._();

  factory paymentGateWay.instance()=> _singleObj;

  Future<bool> depositToWallet(int amount, String id, String phone)async{
    String val = "https://ugexportsolutions.com/drilloxpay.php?pay=true&IDz=$id&amnt=$amount&phone=$phone";
    debugPrint("some thing .............$val");
    final value = await http.post(
      Uri.parse("https://ugexportsolutions.com/drilloxpay.php?pay=true&IDz=$id&amnt=$amount&phone=$phone"),);

      debugPrint(value.body.toString());
      debugPrint("After some thing .............3");
    return true;
  }

}