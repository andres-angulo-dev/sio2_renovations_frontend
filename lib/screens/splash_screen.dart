// Transitionsplash with preload images, fade-out on logo and manual transition (type fade) 
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';
import '../widgets/image_preloader_widget.dart';
import '../utils/global_colors.dart';
import '../screens/landing_screen.dart';
import '../utils/global_others.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController; // Controls the fade animation
  late Animation<double> _fadeAnimation; // Controls the opacity of the logo
  late final LandingScreen _landingScreen;
  bool _animationFinished = false;
  bool _imagesPreloaded = false;

  final List<String> imagesToPreload = [
    ...GlobalImages.landingCarouselImages,
    GlobalImages.backgroundLanding,
  ];

  @override
  void initState() {
    super.initState();
    _landingScreen = const LandingScreen();

    // Initialize the AnimationController for fade-out effect
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0, // Fully visible
      end: 0.0 // Fully invisible
    ).animate(CurvedAnimation(
      parent: _fadeController, 
      curve: Curves.easeInOut
    ));

    // Optional
    // _fadeController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     // If we want to launch something after the fade animation on the logo is finished
    //   }
    // });

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(seconds: 3)); // Keep the splash visible for X seconds
    setState(() {
      _animationFinished = true;
    });
    await _fadeController.forward(); // Trigger the fade-out animation
    _checkReadyToTransition();
  }

  void _checkReadyToTransition() {
    if (_animationFinished && _imagesPreloaded) {
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade,
          child: _landingScreen,
        ),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose(); // Clean up animation resources to avoid leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animation logo
          Center(
            child: SizedBox(
              width: 600.0,
              height: 600.0,
              child: FadeTransition(
                opacity: _fadeAnimation, // Apply the fade-out animation to the logo
                child: ImagePreloaderWidget(
                  imagePaths: imagesToPreload, 
                  onLoaded: () {
                    setState(() {
                      _imagesPreloaded = true;
                    });
                    _checkReadyToTransition();
                  }, 
                  child: RiveAnimation.asset(GlobalLogo.logoSplash),
                )
              ),
            ),
          ),
          // Animation preload 
          Positioned(
            bottom: 100.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: AnimatedOpacity(
                opacity: _imagesPreloaded ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: CircularProgressIndicator(
                color: GlobalColors.thirdColor,
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}






// // Transitionsplash with preload images, fade-out on logo and custom transition (type vertical curtain opening effect)
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import '../widgets/image_preloader_widget.dart';
// import '../screens/landing_screen.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _fadeController; // Controls the fade animation
//   late Animation<double> _fadeAnimation; // Controls the opacity of the logo
//   bool _animationFinished = false;
//   bool _imagesPreloaded = false;

//   final List<String> imagesToPreload = [
//     ...GlobalImages.landingCarouselImages,
//     GlobalImages.backgroundLanding,
//   ];

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the AnimationController for fade-out effect
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 1.0, // Fully visible
//       end: 0.0 // Fully invisible
//     ).animate(CurvedAnimation(
//       parent: _fadeController, 
//       curve: Curves.easeInOut
//     ));

//     // Optional
//     // _fadeController.addStatusListener((status) {
//     //   if (status == AnimationStatus.completed) {
//     //     // If we want to launch something after the fade animation on the logo is finished
//     //   }
//     // });

//     _startAnimationSequence();
//   }

//   void _startAnimationSequence() async {
//     await Future.delayed(const Duration(seconds: 3)); // Keep the splash visible for X seconds
//     setState(() {
//       _animationFinished = true;
//     });
//     await _fadeController.forward(); // Trigger the fade-out animation
//     _checkReadyToTransition();
//   }

//   void _checkReadyToTransition() {
//     if (_animationFinished && _imagesPreloaded) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (_) => LandingRevealTransition(),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose(); // Clean up animation resources to avoid leaks
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Center(
//             child: SizedBox(
//               width: 600,
//               height: 600,
//               child: FadeTransition(
//                 opacity: _fadeAnimation, // Apply the fade-out animation to the logo
//                 child: ImagePreloaderWidget(
//                   imagePaths: imagesToPreload, 
//                   onLoaded: () {
//                     setState(() {
//                       _imagesPreloaded = true;
//                     });
//                     _checkReadyToTransition();
//                   }, 
//                   child: RiveAnimation.asset(GlobalLogo.logoSplash),
//                 )
//               ),
//             ),
//           ),
//           // Animation preload 
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: AnimatedOpacity(
//                 opacity: _imagesPreloaded ? 0.0 : 1.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: CircularProgressIndicator(
//                 color: GlobalColors.thirdColor,
//               ),
//               )
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // This widget triggers the animated transition revealing the LandingScreen behind a white split effect
// class LandingRevealTransition extends StatefulWidget {
//   const LandingRevealTransition({super.key});

//   @override
//   LandingRevealTransitionState createState() => LandingRevealTransitionState();
// }

// class LandingRevealTransitionState extends State<LandingRevealTransition> with SingleTickerProviderStateMixin {
//   // Animation controller to drive the curtain split effect
//   late AnimationController _controller; 
//   // Left and right offset animations controlling each curtain panel's movement
//   late Animation<double> _leftOffset;
//   late Animation<double> _rightOffset;

//   bool _transitionFinished = false;   // Boolean flag to stop rendering the curtain once animation ends

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     // Left curtain moves from 50% of screen to 0%
//     _leftOffset = Tween<double>(begin: 0.5, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     // Right curtain moves from 50% to 100% (full width)
//     _rightOffset = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     _controller.forward();

//     // When animation finishes, hide the curtains
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() => _transitionFinished = true);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Underlying LandingScreen is already rendered in the background
//         const LandingScreen(),

//          // Overlay animated white curtains only if animation is still running
//         if (!_transitionFinished)
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (_, __) {
//               return Stack(
//                 children: [
//                   // Left curtain panel shrinking toward left edge
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: FractionallySizedBox(
//                       widthFactor: _leftOffset.value, // shrinking from center to left
//                       heightFactor: 1.0,
//                       child: Container(color: Colors.white),
//                     ),
//                   ),
//                   // Right curtain panel expanding toward right edge
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: FractionallySizedBox(
//                       widthFactor: 1.0 - _rightOffset.value, // shrinking from center to right
//                       heightFactor: 1.0,
//                       child: Container(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
