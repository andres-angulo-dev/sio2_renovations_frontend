import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:rive/rive.dart';
import './landing_screen.dart';
import '../utils/global_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
        width: 600,
        height: 600,
          child: Center(
            child: AnimatedSplashScreen(
              splash: RiveAnimation.asset(
                GlobalImages.logoSplash,
              ),
              // backgroundColor: Colors.white,
              nextScreen: const LandingScreen(),
              duration: 3000,
            ) 
          ) 
        )
      )
    ); 
  }
}