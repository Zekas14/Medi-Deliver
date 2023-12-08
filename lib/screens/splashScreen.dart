import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medi_deliver/screens/loginPage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 188, 63),
      body: Center(
        child: Image.asset(
          'asset/images/Medi-Deliver-logos.png',
        ), // Customize with your app logo or image
      ),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Adjust the duration as needed
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Login(), // Replace with your main screen
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
