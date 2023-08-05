import 'package:flutter/material.dart';

class fundRaiseCompaign with ChangeNotifier {
  bool _currentState = false;

  bool get currentState => _currentState;

  void currentStateSet(bool state) {
    _currentState = state;
    notifyListeners();
  }
}


class loanCompaign with ChangeNotifier {
  bool _currentState = false;

  bool get currentState => _currentState;

  void currentStateSet(bool state) {
    _currentState = state;
    notifyListeners();
  }
}