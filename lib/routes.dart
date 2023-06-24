import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/routes/friend_request_screen.dart';
import 'package:propup/routes/friends_profile_screen.dart';
import 'package:propup/routes/friends_screen.dart';
import 'package:propup/routes/fundraise_screen.dart';
import 'package:propup/routes/home_screen.dart';
import 'package:propup/routes/lend_friend_screen.dart';
import 'package:propup/routes/loan_screen.dart';
import 'package:propup/routes/login_screen.dart';
import 'package:propup/routes/notifications_screen.dart';
import 'package:propup/routes/support_friend_screen.dart';
import 'package:propup/routes/transactions_screen.dart';
import 'package:propup/routes/user_profile_screen.dart';
import 'package:propup/routes/welcome_screen.dart';

///
///this is for managing the routings through the application
///
//ignore:camel_case_types
class RouteGenerator {
  static const String welcomescreen = "/";
  static const String loginscreen = "login";
  static const String homescreen = "/home";
  static const String friendscreen = "/friendscreen";
  static const String friendprofilescreen = "/friendprofilescreen";
  static const String transactionsscreen = "/transactionsscreen";
  static const String fundRaisescreen = "/fundRaisescreen";
  static const String loanscreen = "/loanScreen";
  static const String userProfilescreen = "/userprofilescreen";
  static const String notificationscreen = "/notificationscreen";
  static const String supportscreen = "/supportscreen";
  static const String lendfriendscreen = "/lendfriendscreen";
  static const String friendrequestscreen = "/friendrequestscreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homescreen:
        return MaterialPageRoute(builder: (context) => const homeScreen());
      case friendscreen:
        return MaterialPageRoute(builder: (context) => const friendScreen());
      case transactionsscreen:
        return MaterialPageRoute(
            builder: (context) => const transactionsScreen());
      case fundRaisescreen:
        return MaterialPageRoute(builder: (context) => const fundRaiseScreen());
      case loanscreen:
        return MaterialPageRoute(builder: (context) => const loanScreen());
      case loginscreen:
        return MaterialPageRoute(builder: (context) => const loginScreen());
      case notificationscreen:
        return MaterialPageRoute(
            builder: (context) => const notificationsScreen());
      case friendrequestscreen:
        return MaterialPageRoute(
            builder: (context) => const friendRequestScreen());
      case supportscreen:
        return MaterialPageRoute(
            builder: (context) => const supportFriendScreen());
      case lendfriendscreen:
        return MaterialPageRoute(
            builder: (context) => const lendFriendScreen());
      case userProfilescreen:
        return MaterialPageRoute(
            builder: (context) => const userProfileScreen());
      case friendprofilescreen:
        return MaterialPageRoute(
            builder: (context) =>
                const friendsProfileScreen(name: "Anonymous"));
      default:
        return MaterialPageRoute(builder: (context) => const welcomeScreen());
    }
  }
}
