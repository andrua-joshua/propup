import 'package:flutter/material.dart';
import 'package:propup/routes.dart';
import 'package:propup/routes/friends_profile_screen.dart';
import 'package:propup/routes/friends_screen.dart';
import 'package:propup/routes/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteGenerator.welcomescreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: const friendsProfileScreen(name: "Anonymous"),
    );
  }
}
