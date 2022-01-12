import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      title: Text(
        "Brain Tumor Classifier",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
          // decoration: LinearGradient(colors: Colors.amber,)
        ),
      ),
      image: Image.asset(
        'assets/brain.png'),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.004, 1],
        colors: [Color(0xff123456), Colors.blueAccent],
      ),
      backgroundColor: Colors.black,
      photoSize: 50,
      loaderColor: Color(0xff123456),
    );
  }
}
