import 'package:asignease/BottomNavBar/BottomNavBar.dart';
import 'package:asignease/Home/Home.dart';
import 'package:asignease/SplashScreen.dart';
import 'package:asignease/auth/SignIn.dart';
import 'package:asignease/auth/SignUp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}

