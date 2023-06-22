import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/routes/friends_profile_screen.dart';
import 'package:propup/routes/friends_screen.dart';
import 'package:propup/routes/home_screen.dart';

///
///this is for managing the routings through the application
///
//ignore:camel_case_types
class RouteGenerator {
  static const String homescreen = "/";
  static const String friendscreen = "/friendscreen";
  static const String friendprofilescreen = "/friendprofilescreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homescreen:
        return MaterialPageRoute(builder: (context) => const homeScreen());
      case friendscreen:
        return MaterialPageRoute(builder: (context) => const friendScreen());
      case friendprofilescreen:
        return MaterialPageRoute(
            builder: (context) =>
                const friendsProfileScreen(name: "Anonymous"));
      default:
        return MaterialPageRoute(builder: (context) => const homeScreen());
    }
  }
}
