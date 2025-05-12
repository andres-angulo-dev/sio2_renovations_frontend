import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../components/carousel_slider_component.dart';
import '../utils/global_others.dart';
import '../utils/global_sizes.dart';

class WebsiteUnderConstruction extends StatefulWidget{
  const WebsiteUnderConstruction({super.key});

  @override
  WebsiteUnderConstructionState createState() => WebsiteUnderConstructionState();
}

class WebsiteUnderConstructionState extends State<WebsiteUnderConstruction> with SingleTickerProviderStateMixin {
  // AnimationController: Manages the timing of the animations.
  late AnimationController _animationController;
  // Animation<Offset>: Handles the slide effect for text (moves it vertically effect).
  late Animation<Offset> _slideAnimation;
  // Animation<double>: Handles the fade-in effect for text (controls opacity effect).
  late Animation<double> _fadeAnimation;

  bool _show = false;

  @override  
  void initState() {
    super.initState(); 

    // Starts the animation after a 100ms delay and displays on the screen.
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _show = true;
      });
      _animationController.forward(); // Triggers the sliding and fade-in animations.
    });

     // Initialize AnimationController with a 1.5-second duration.
    _animationController = AnimationController(
      vsync: this, // Links the animation to the widget lifecycle for efficiency.
      duration: const Duration(milliseconds: 1500),  
    );

    // Creates the sliding animation for the text, starting from off-screen (above)
    // and ending at its normal position.
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start position: from top to bottom.
      end: Offset.zero // End position: Default screen location.
    ).animate(CurvedAnimation(
      parent: _animationController, // Links the animation to the controller.
      curve: Curves.easeInOut, // Eases in at the start, then slows down at the end.
    ));

    // Creates the fade-in effect for the text (opacity from 0 to 1).
    _fadeAnimation = Tween<double>(
      begin: 0.0, // Invisible at the start.
      end: 1.0, // Fully visible at the end.
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut, // Syncs with the sliding animation curve.
    ));

  }

  @override 
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override  
  Widget build(BuildContext context) {
    return  Positioned.fill(
      child: Column(
        children: [
          // Animated logo component.
          if (_show)
            Flexible(
              flex: 3, // Occupies 3/10ths of the available space.
              child: AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0, 
              duration: const Duration(seconds: 3),
                child: RiveAnimation.asset(
                  GlobalAnimations.logoWebsiteInProgress,
                ), 
              ),
            ),
          // Animated text component with slide and fade effects.
          Flexible(
            flex: 1, // Occupies 1/10th of the available space.
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  'EN CONSTRUCTION !',
                  style: TextStyle(
                    fontSize: GlobalSizes.isMobileScreen(context) ? 24.0 : 34.0,
                    color: Colors.grey.shade800, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
              ),  
            ),
          ),
          Expanded(child: SizedBox()), // Adds flexible empty space.
          // Animated carousel component.
          Flexible(
            flex: 10, // Occupies 10/10ths of the space for the carousel.
            child: AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0, 
              duration: const Duration(seconds: 3),
              child: CarouselSliderComponent(), // Custom carousel component. 
            ),
          ),
        ],
      ),
    );
  }
}
