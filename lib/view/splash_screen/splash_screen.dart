// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sample_app/view/home_screen/home_screen.dart';
import 'package:sample_app/view/login_screen/login_screem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isLoggedIn=await prefs.getBool('isLoggedin');
      if (isLoggedIn == true) {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } 
      else {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreem()),
        );
      }
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}