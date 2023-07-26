import 'package:flutter/material.dart';

class compaignsStateNotifier with ChangeNotifier {
  int _currentSelected = 0;

  int get currentSelected => _currentSelected;

  void changeSelected({required int index}) {
    _currentSelected = index;
    notifyListeners();
  }
}
