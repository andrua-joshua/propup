import 'package:flutter/material.dart';
import 'package:propup/routes/add_friends_screen.dart';
import 'package:propup/routes/edit_profile_screen.dart';
import 'package:propup/routes/email_verification_screen.dart';
import 'package:propup/routes/friend_request_screen.dart';
import 'package:propup/routes/friends_profile_screen.dart';
import 'package:propup/routes/friends_screen.dart';
import 'package:propup/routes/fundraise_screen.dart';
import 'package:propup/routes/home_screen/home_screen.dart';
import 'package:propup/routes/home_screen/tabs/postsTab/posts_comments_screen.dart';
import 'package:propup/routes/leaders_board_portal_screen.dart';
import 'package:propup/routes/leaders_board_screen.dart';
import 'package:propup/routes/lend_friend_screen.dart';
import 'package:propup/routes/loan_screen.dart';
import 'package:propup/routes/login_screen.dart';
import 'package:propup/routes/messaging_screen.dart';
import 'package:propup/routes/notifications_screen.dart';
import 'package:propup/routes/my_profile_screen.dart';
import 'package:propup/routes/payments_screen/deposit_option_screen.dart';
import 'package:propup/routes/payments_screen/payment_options_screen.dart';
import 'package:propup/routes/payments_screen/withdraw_option_screen.dart';
import 'package:propup/routes/personal_posts_review.dart';
import 'package:propup/routes/support_friend_screen.dart';
import 'package:propup/routes/transactions_screen.dart';
import 'package:propup/routes/user_profile_screen.dart';
import 'package:propup/routes/welcome_screen.dart';

import 'routes/signup_screen.dart';


///
///this is for managing the routings through the application
///
//ignore:camel_case_types
class RouteGenerator {
  static const String welcomescreen = "/";
  static const String loginscreen = "/login";
  static const String signupscreen = "/signupscreen";
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
  static const String editprofilescreen = "/editprofilescreen";
  static const String myProfilescreen = "/myProfilescreen";
  static const String leadersboardscreenportal = "/leadersboardscreenportal";
  static const String leadersboardScreen = "/leaderboardscreen";
  static const String messagingscreen = "/messagingscreen";
  static const String addFriendsscreen = "/addFriendsScreen";
  static const String paymentOptionsscreen = "/paymentOptionsScreen";
  static const String depositOptionscreen = "/deposteOptionScreen";
  static const String withdrawOptionscreen = "/withdrawOptionScreen";
  static const String postsCommentscreen ="/postsCommentscreen";
  static const String emailVerificationscreen = "/emailVerification";
  static const String personalPostsReviewscreen = "/personalPostsReviewPage";

  static bool led = true;
  static bool isFollowing = false;
  static String src = "";
  static String user = "";

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
      case signupscreen:
        return MaterialPageRoute(builder: (context) => const signUpScreen());
      case notificationscreen:
        return MaterialPageRoute(
            builder: (context) => const notificationsScreen());
      case editprofilescreen:
        return MaterialPageRoute(
            builder: (context) => const editProfileScreen());
      case myProfilescreen:
        return MaterialPageRoute(
            builder: (context) => const myProfileScreen());
      case friendrequestscreen:
        return MaterialPageRoute(
            builder: (context) => const friendRequestScreen());
      case supportscreen:
      final String args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => supportFriendScreen(donationId: args,));
      case lendfriendscreen:
        final String args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => lendFriendScreen(loanId: args,));
      case userProfilescreen:
        return MaterialPageRoute(
            builder: (context) => const userProfileScreen());
      case messagingscreen:
        final String args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => messagingScreen(chatId: args));
      case friendprofilescreen:
        return MaterialPageRoute(
            builder: (context) =>
                friendsProfileScreen(userID: user));
      case addFriendsscreen:
        return MaterialPageRoute(
            builder: (context) =>
                const addFriendsScreen());
      case leadersboardscreenportal:
        return MaterialPageRoute(
            builder: (context) => const leardersBoardPortalScreen());
      case paymentOptionsscreen:
        return MaterialPageRoute(
            builder: (context) => const paymentOptionsScreen());
      case depositOptionscreen:
        return MaterialPageRoute(
            builder: (context) => const depositOptionScreen());
      case postsCommentscreen:
        return MaterialPageRoute(
            builder: (context) => const postsCommentScreen());
      case withdrawOptionscreen:
        return MaterialPageRoute(
            builder: (context) => const withdrawOptionScreen());
      case emailVerificationscreen:
        return MaterialPageRoute(
            builder: (context) => const emailVerificationScreen());
      case personalPostsReviewscreen:
        return MaterialPageRoute(
            builder: (context) => personalPostsReview(src: src,));
      case leadersboardScreen:
        return MaterialPageRoute(
            builder: (context) =>  leadersBoardScreen(
                  receivers: led,
                ));
      default:
        return MaterialPageRoute(builder: (context) => const welcomeScreen());
    }
  }
}
