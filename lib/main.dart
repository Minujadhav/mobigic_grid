
import 'dart:async';

import 'package:flutter/material.dart';

import 'GridInputScreen.dart';


void main(){
  runApp(
      const MaterialApp(
        title: "My Splash Screen",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      )
  );
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a timer to wait for 3 seconds before navigating to the next screen
    Timer(Duration(seconds: 3), () {
      // Navigate to the GridInputScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GridInputScreen(), // Example with 3 rows and 4 columns
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500, // Adjust the width as desired
          height: 500, // Adjust the height as desired
          child: Image.asset('assets/images/Button.png'),
        ),

      ),
    );
  }
}