import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import './landing_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: SizedBox(
        width: 600,
        height: 600,
          child: Center(
            child: AnimatedSplashScreen(
              splash: Text(
                'Hello',
                textAlign: TextAlign.center,
              ), 
              backgroundColor: Colors.yellow,
              nextScreen: const LandingScreen(),
              duration: 1500,
            ) 
          ) 
        )
      )
    ); 
  }
}