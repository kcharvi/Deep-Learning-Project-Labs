import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:splashscreen/splashscreen.dart';
class MySplash extends StatefulWidget {
  @override
  MySplashState createState() => MySplashState();
}
class MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MyHomePage(),
      title: Text(
        "Rapid Neural Style Transfer",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.004, 1],
        colors: [Color(0xff123456), Colors.greenAccent],
      ),
      backgroundColor: Colors.black,
      photoSize: 50,
      loaderColor: Color(0xff123456),
    );

  }
}
