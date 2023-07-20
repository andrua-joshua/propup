
import 'package:flutter/material.dart';

//ignore:camel_case_types
class homeTabsChange with ChangeNotifier{
  int _currentIndex = 0;

  homeTabsChange._();
  static final singleObj = homeTabsChange._();
  factory homeTabsChange()=>singleObj;

  int get currentIndex => _currentIndex;

  void ChangeIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}