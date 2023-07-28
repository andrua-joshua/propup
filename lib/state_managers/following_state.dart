import 'package:flutter/material.dart';

///thi is used for the managment of the
//ignore:camel_case_types
class followStateNotifier with ChangeNotifier {
  bool _followingCurrentUser = false;

  followStateNotifier._();
  static final followStateNotifier _singleObj = followStateNotifier._();
  factory followStateNotifier() => _singleObj;

  bool get followingCurrentUser => _followingCurrentUser;

  void editFollow(bool fl) {
    _followingCurrentUser = fl;
    notifyListeners();
  }
}

//ignore:camel_case_types
class followStateNotifier2 with ChangeNotifier {
  bool _followingCurrentUser2 = followStateNotifier().followingCurrentUser;

  bool get followingCurrentUser2 => _followingCurrentUser2;

  void editFollow2(bool fl) {
    _followingCurrentUser2 = fl;
    notifyListeners();
  }
}

class justStatic {
  static int index = 0;
}
