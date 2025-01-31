import 'package:flutter/material.dart';
import 'package:splitwise/screens/editProfile.dart';
import 'package:splitwise/screens/group.dart';
import 'package:splitwise/screens/loginscreen.dart';
import 'package:splitwise/screens/dashboard.dart';
import 'package:splitwise/screens/userProfile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("MyBox");
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
        '/group' : (context) => Groups(),
      },
    );
  }
}
