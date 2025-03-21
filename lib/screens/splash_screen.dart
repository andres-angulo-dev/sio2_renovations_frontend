import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sio2_renovations_frontend/utils/global_colors.dart';
import './landing_screen.dart';
import '../utils/global_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late Widget landingPage; // Holds the preloaded LandingScreen widget.

  @override
  void initState() {
    super.initState();
    _preloadLandingPage(); // Start preloading resources immediately after the widget is initialized.
  }

  Future<void> _preloadCarouselImages() async {
    // List of carousel images stored in GlobalImages for centralized management.
    final images = [
      GlobalImages.image1,
      GlobalImages.image2,
      GlobalImages.image3,
      GlobalImages.image4,
      GlobalImages.image5,
      GlobalImages.image6,
      GlobalImages.image7,
      GlobalImages.image8,
    ];

    // Preload each image and cache them in memory to reduce rendering delays.
    for (var image in images) {
      await precacheImage(AssetImage(image), context);
    }

    // Check if the widget is still mounted (exists in the widget tree) to ensure context is valid.
    if (mounted) {
      await precacheImage(const AssetImage('assets/immeubles.jpeg'), context); // Preloading the background image.
    }
  }

  void _preloadLandingPage() async {
    // Simulates a delay to represent the splash screen duration.
    await Future.delayed(const Duration(seconds: 3));

    // Preload carousel images to ensure smooth transitions later.
    await _preloadCarouselImages();

    // Construct the LandingScreen and store it in memory for efficient navigation.
    landingPage = const LandingScreen();

    // Check if the widget is still mounted to prevent accessing an invalid context.
    if (!mounted) return;

    // Transition to the LandingScreen using a fade effect for a smoother user experience.
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => landingPage, // Defines the new page to navigate to.
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation, // Links the fade animation to the navigation.
            child: child,
          );
        },
      ),
    );

    // // Transition to the LandingScreen using a slide effect for a smoother user experience.
    // Navigator.of(context).pushReplacement( 
    //   PageRouteBuilder( 
    //     pageBuilder: (context, animation, secondaryAnimation) => landingPage, 
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) { 
    //       var tween = Tween(
    //         begin: const Offset(0.0, 1.0), 
    //         end: Offset.zero
    //       ).chain(CurveTween(curve: Curves.easeInOut)); 
    //       var offsetAnimation = animation.drive(tween); 
    //       return SlideTransition( 
    //         position: offsetAnimation, 
    //         child: child, 
    //       ); 
    //     }, 
    //   ), 
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.primaryColor,
      child: Center(
        child: SizedBox(
          width: 600,
          height: 600,
          child: RiveAnimation.asset(GlobalImages.logoSplash),
        ),
      ),
    );
  }
}
