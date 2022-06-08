import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_radio/config/palette.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 4;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.scaffold,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Row(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.15,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/logo.png'
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                  child: Text(
                    'The Radio',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
