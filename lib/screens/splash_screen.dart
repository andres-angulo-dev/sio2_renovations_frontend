// // Simple transitionsplash with AnimatedSplashScreen widget
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:sio2_renovations_frontend/utils/global_colors.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import './landing_screen.dart';
// import '../utils/global_images.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: GlobalColors.primaryColor,
//       child: Center(
//         child: SizedBox(
//         width: 600,
//         height: 600,
//           child: Center(
//             child: AnimatedSplashScreen(
//               splash: RiveAnimation.asset(
//                 GlobalImages.logoSplash,
//               ),
//               nextScreen: const LandingScreen(),
//               splashTransition: SplashTransition.slideTransition,
//               pageTransitionType: PageTransitionType.sharedAxisScale,
//               duration: 3000,
//             ) 
//           ) 
//         )
//       )
//     ); 
//   }
// }




// // Transitionsplash with fade-out on logo and AnimatedSplashScreen widget 
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import './landing_screen.dart';
import '../utils/global_others.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController; // Controls the fade animation.
  late Animation<double> _fadeAnimation; // Controls the opacity of the logo.

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController for fade-out effect.
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Duration of the fade-out.
    );

    // Define the fade animation (opacity from 1.0 to 0.0).
    _fadeAnimation = Tween<double>(
      begin: 1.0, // Fully visible.
      end: 0.0, // Fully invisible.
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start the fade-out sequence after 2 seconds.
    _startFadeOut();
  }

  void _startFadeOut() async {
    await Future.delayed(const Duration(seconds: 3)); // Keep the splash visible for 2 seconds.
    if (mounted) {
      _fadeController.forward(); // Trigger the fade-out animation.
    }
  }

  @override
  void dispose() {
    _fadeController.dispose(); // Clean up animation resources to avoid leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: FadeTransition(
        opacity: _fadeAnimation, // Apply the fade-out animation to the logo.
        child: SizedBox(
          width: 600,
          height: 600,
          child: RiveAnimation.asset(
            GlobalOthers.logoSplash, // Animation Rive as the splash logo.
          ),
        ),
      ),
      nextScreen: const LandingScreen(), // Navigate to this screen after the splash.
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.sharedAxisScale,
      duration: 3000, // Overall duration (2 seconds visible + 1 second fade-out).
      // backgroundColor: Colors.white, // Background color for the splash screen.
    );
  }
}




// // Transition splash with manual transition
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:sio2_renovations_frontend/utils/global_colors.dart';
// import './landing_screen.dart';
// import '../utils/global_images.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late Widget landingPage; // Holds the preloaded LandingScreen widget.
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _fadeAnimation = Tween<double> (
//       begin: 1.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));

//     _preloadLandingPage(); // Start preloading resources immediately after the widget is initialized.
//   }

//   void _preloadLandingPage() async {
//     // Simulates a delay to represent the splash screen duration.
//     await Future.delayed(const Duration(seconds: 3));

//     // Construct the LandingScreen and store it in memory for efficient navigation.
//     landingPage = const LandingScreen();

//     // Check if the widget is still mounted to prevent accessing an invalid context.
//     if (!mounted) return;

//     // Transition 1 to the LandingScreen using a fade effect for a smoother user experience.
//     _fadeController.forward().then((_) {
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => landingPage, // Defines the new page to navigate to.
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation, // Links the fade animation to the navigation.
//               child: child,
//             );
//           },
//         ),
//       );
//     });

//     // // Transition 2 to the LandingScreen using a slide effect for a smoother user experience.
//     // _fadeController.forward().then((_) {
//     //   Navigator.of(context).pushReplacement( 
//     //     PageRouteBuilder( 
//     //       pageBuilder: (context, animation, secondaryAnimation) => landingPage, 
//     //       transitionsBuilder: (context, animation, secondaryAnimation, child) { 
//     //         var tween = Tween(
//     //           begin: const Offset(0.0, 1.0), 
//     //           end: Offset.zero
//     //         ).chain(CurveTween(curve: Curves.easeInOut)); 
//     //         var offsetAnimation = animation.drive(tween); 
//     //         return SlideTransition( 
//     //           position: offsetAnimation, 
//     //           child: child, 
//     //         ); 
//     //       }, 
//     //     ) 
//     //   );
//     // });

//     @override
//     // ignore: unused_element
//     void dipose() {
//       _fadeController.dispose();
//       super.dispose();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: GlobalColors.primaryColor,
//       child: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: SizedBox(
//             width: 600,
//             height: 600,
//             child: RiveAnimation.asset(GlobalImages.logoSplash),
//           ),
//         ),
//       ),
//     );
//   }
// }





// // Transition splash with manual transition & preload assets
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:sio2_renovations_frontend/utils/global_colors.dart';
// import './landing_screen.dart';
// import '../utils/global_images.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late Widget landingPage; // Holds the preloaded LandingScreen widget.
//   late AnimationController _fadeController; // Controls the fade animation.
//   late Animation<double> _fadeAnimation; // Animation for fading out.

//   @override
//   void initState() {
//     super.initState();

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController, 
//       curve: Curves.easeInOut,
//     ));

//     _preloadLandingPage(); // Start preloading resources immediately after the widget is initialized.
//   }

//   Future<void> _preloadCarouselImages() async {
//     // List of carousel images stored in GlobalImages for centralized management.
//     final images = [
//       GlobalImages.image1,
//       GlobalImages.image2,
//       GlobalImages.image3,
//       GlobalImages.image4,
//       GlobalImages.image5,
//       GlobalImages.image6,
//       GlobalImages.image7,
//       GlobalImages.image8,
//     ];

//     // Preload each image and cache them in memory to reduce rendering delays.
//     for (var image in images) {
//       await precacheImage(AssetImage(image), context);
//     }

//     //Check if the widget is still mounted (exists in the widget tree) to ensure context is valid.
//     if (mounted) {
//       await precacheImage(const AssetImage(GlobalImages.backgroundLanding), context); // Preloading the background image.
//     }
//   }

//   void _preloadLandingPage() async {
//     // Simulates a delay to represent the splash screen duration.
//     await Future.delayed(const Duration(seconds: 3));

//     // Preload carousel images to ensure smooth transitions later.
//     await _preloadCarouselImages();

//     // Construct the LandingScreen and store it in memory for efficient navigation.
//     landingPage = const LandingScreen();

//     // Transition 1 Trigger the fade-out animation before navigating to the next page.
//     // & the landingScreen using a fade effect for a smoother user experience.
//     if (mounted) {
//       _fadeController.forward().then((_) { // Launch fade animation.
//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) => landingPage,
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: animation, // Links the fade animation to the navigation.
//                 child: child,
//               );
//             },
//           ),
//         );
//       });
//     }

//     // // Transition 2 Trigger the fade-out animation before navigating to the next page.
//     // // & landingScreen using a slide effect for a smoother user experience.
//     // if (mounted) {
//     //   _fadeController.forward().then((_) { // Launch fade animation.
//     //     Navigator.of(context).pushReplacement(
//     //       PageRouteBuilder( 
//     //         pageBuilder: (context, animation, secondaryAnimation) => landingPage, 
//     //         transitionsBuilder: (context, animation, secondaryAnimation, child) { 
//     //           var tween = Tween(
//     //             begin: const Offset(0.0, 1.0), 
//     //             end: Offset.zero
//     //           ).chain(CurveTween(curve: Curves.easeInOut)); 
//     //           var offsetAnimation = animation.drive(tween); 
//     //           return SlideTransition( 
//     //             position: offsetAnimation, 
//     //             child: child, 
//     //           ); 
//     //         }, 
//     //       ), 
//     //     );
//     //   });
//     // }

//     // ignore_for_file: unused_element
//     @override
//     void dispose() {
//       _fadeController.dispose(); // Dispose the animation controller to free resources.
//       super.dispose();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: GlobalColors.primaryColor,
//       child: Center(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SizedBox(
//               width: 600,
//               height: 600,
//               child: RiveAnimation.asset(GlobalImages.logoSplash),
//           ),
//         ),
//       ),
//     );
//   }
// }
