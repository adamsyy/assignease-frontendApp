import 'package:asignease/BottomNavBar/BottomNavBar.dart';
import 'package:asignease/auth/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      //delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));
      // Token exists, navigate to home screen or desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ScreenDecider()),
      );
    } else {
      await Future.delayed(Duration(seconds: 2));
      // Token does not exist, navigate to login screen or desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signin2()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("pictures/image14.png"),
          Text("EssayChains", style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist',
          ),)
        ],
      ))
    );
  }
}
