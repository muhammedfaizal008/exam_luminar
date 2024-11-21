// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sample_app/view/home_screen/home_screen.dart';
import 'package:sample_app/view/registration_screen/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool showPass=true;
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sign in to Your Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller,
                validator: validateEmail,
                decoration: InputDecoration(
                  hintText: "Your Email Address",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller2,
                obscureText: showPass,
                validator: validatePassword,
                decoration: InputDecoration(
                  hintText: "Your Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(onPressed: (){
                    showPass = !showPass;
                    setState(() {
                      
                    });
                  },icon: Icon(showPass ? Icons.remove_red_eye_outlined : Icons.visibility_off),),
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.check_box_outlined)),
                  Text("Remember Me"),
                  Spacer(),
                  InkWell(
                    onTap: () {
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String? savedEmail = prefs.getString('signup_email');
                    final String? savedPassword = prefs.getString('signup_password');

                    if (controller.text == savedEmail && controller2.text == savedPassword) {
                      await prefs.setBool('isLoggedin', true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Enter the Correct Details"),
                          content: Text("Email or Password does not match. Please try again."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Sign In")),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen()),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
