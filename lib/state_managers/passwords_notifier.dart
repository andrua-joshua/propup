import 'package:flutter/material.dart';

///
///this will be for the signIn
///

//ignore:camel_case_types
class viewPassoword with ChangeNotifier {
  bool _visible = true;

  bool get visibile => _visible;
  void setVisibility({required bool visibility}) {
    _visible = visibility;
    notifyListeners();
  }
}

///
///this is for the signUp screen
///

//ignore:camel_case_types
class viewsignUpVisibility with ChangeNotifier {
  bool _passVisible = true;
  bool _confirmPassVisible = true;

  bool passVisible() => _passVisible;
  bool confirmPassVisible() => _confirmPassVisible;

  void setPassVisibility({required bool visibility}) {
    _passVisible = visibility;
    notifyListeners();
  }

  void setConfirmPassVisibility({required visibility}) {
    _confirmPassVisible = visibility;
    notifyListeners();
  }
}
