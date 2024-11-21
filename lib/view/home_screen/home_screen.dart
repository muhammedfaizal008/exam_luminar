// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sample_app/view/login_screen/login_screem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Home Screen"),),
          ElevatedButton(onPressed: () async {
           final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedin', false);
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreem(),));
          }, child: Text("Log out"))
        ],
      ),
    );
  }
}