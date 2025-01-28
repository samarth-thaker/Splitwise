import 'package:flutter/material.dart';
import 'package:splitwise/screens/editProfile.dart';
import 'package:splitwise/screens/loginscreen.dart';
import 'package:splitwise/screens/dashboard.dart';
import 'package:splitwise/screens/userProfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Loginscreen(),
      routes: {
        '/loginScreen': (context) => Loginscreen(),
        '/dashboard': (context) => Dashboard(),
        '/userProfile': (context) => UserProfile(),
        '/editProfile': (context) => Editprofile(),
      },
    );
  }
}
