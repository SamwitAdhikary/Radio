import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_radio/config/palette.dart';

import 'UI/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.scaffold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }
}
