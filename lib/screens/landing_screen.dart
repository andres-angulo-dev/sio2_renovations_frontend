import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sio2_renovations_frontend/utils/global_images.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';
import '../components/carousel_slider_component.dart';
import 'dart:ui'; // Import for the blur effect.

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  // AnimationController: Manages the timing of the animations.
  late AnimationController _animationController;

  // Animation<Offset>: Handles the slide effect for text (moves it vertically).
  late Animation<Offset> _slideAnimation;

  // Animation<double>: Handles the fade-in effect for text (controls opacity).
  late Animation<double> _opacityAnimation;

  final bool mobile = false; // Checks if the device is mobile or not.
  bool show = false; // Controls the visibility of the components (e.g., carousel).

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with a 1.5-second duration.
    _animationController = AnimationController(
      vsync: this, // Links the animation to the widget lifecycle for efficiency.
      duration: const Duration(milliseconds: 1500),
    );

    // Creates the sliding animation for the text, starting from off-screen (above)
    // and ending at its normal position.
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start position: Above the screen.
      end: Offset.zero // End position: Default screen location.
    ).animate(CurvedAnimation(
      parent: _animationController, // Links the animation to the controller.
      curve: Curves.easeInOut, // Eases in at the start, then slows down at the end.
    ));

    // Creates the fade-in effect for the text (opacity from 0 to 1).
    _opacityAnimation = Tween<double>(
      begin: 0.0, // Invisible at the start.
      end: 1.0, // Fully visible at the end.
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut, // Syncs with the sliding animation curve.
    ));

    // Starts the animation after a 100ms delay and displays on the screen.
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        show = true;
      });
      _animationController.forward(); // Triggers the sliding and fade-in animations.
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Disposes of the animation controller to prevent memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(), 
      // endDrawer: mobile ? DrawerComponent() : null,
      backgroundColor: GlobalColors.primaryColor, 
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: availableHeight,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(GlobalImages.backgroundLanding),
                          fit: BoxFit.cover, 
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        children: [
                          if (show)
                            Flexible(
                              flex: 3, // Occupies 3/10ths of the available space.
                              child: AnimatedOpacity(
                              opacity: show ? 1.0 : 0.0, 
                              duration: const Duration(seconds: 3),
                                child: RiveAnimation.asset(
                                  GlobalImages.logoWebsiteInProgress,
                                ), 
                              ),
                            ),
                          Flexible(
                            flex: 1, // Occupies 1/10th of the available space.
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: Text(
                                  'EN CONSTRUCTION !',
                                  style: TextStyle(
                                    fontSize: mobile ? 24.0 : 34.0,
                                    color: Colors.grey.shade800, 
                                    fontWeight: FontWeight.bold, 
                                  ),
                                ),
                              ),  
                            ),
                          ),
                          Expanded(child: SizedBox()), // Adds flexible empty space.
                          // AnimatedOpacity(
                          //   opacity: show ? 1.0 : 0.0, 
                          //   duration: const Duration(seconds: 2), 
                          //   child: Column(
                          //     children: [
                          //       show
                          //       ? Flexible(
                          //           flex: 10, // Occupies 10/10ths of the space for the carousel.
                          //           child: CarouselSliderComponent(), // Custom carousel component.
                          //         )
                          //       : const SizedBox(), // Placeholder widget before the carousel appears.
                          //     ],
                          //   ) 
                          // ),
                          // Flexible(
                          //   flex: 10, // Occupies 10/10ths of the space for the carousel.
                          //   child: CarouselSliderComponent(), // Custom carousel component.
                          // )
                          Flexible(
                            flex: 10, // Occupies 10/10ths of the space for the carousel.
                            child: AnimatedOpacity(
                              opacity: show ? 1.0 : 0.0, 
                              duration: const Duration(seconds: 3),
                              child: CarouselSliderComponent(), // Custom carousel component. 
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
