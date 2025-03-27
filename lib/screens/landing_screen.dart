import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/carousel_slider_component.dart';
import '../components/cookies_consent_banner.dart';
import '../components/image_icon_button.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
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
  late Animation<double> _fadeAnimation;

  bool _mobile = false; 
  bool _show = false;
  bool? _cookiesAccepted; // State to track cookies consent.
  bool _isBannerVisible = false;

  @override
  void initState() {
    super.initState();
    _isBannerVisible = _cookiesAccepted == null;

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
    _fadeAnimation = Tween<double>(
      begin: 0.0, // Invisible at the start.
      end: 1.0, // Fully visible at the end.
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut, // Syncs with the sliding animation curve.
    ));

    // Starts the animation after a 100ms delay and displays on the screen.
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _show = true;
      });
      _animationController.forward(); // Triggers the sliding and fade-in animations.
    });
  }

  // Handles user consent for cookies and manages the visibility of the cookie consent banner.
  void _handleCookiesConsent(bool? consent) {
    setState(() {
      _cookiesAccepted = consent;
      if (_isBannerVisible) {
        _animationController.reverse().then((_) {
          setState(() {
            _isBannerVisible = false; // Hide banner after animation
          });
        });
      }
    });
  }

  // Loads previously saved cookie consent state and updates the banner visibility accordingly.
  void _handleLoadedConsent(bool? consent) {
    if (_cookiesAccepted == null) {
      setState(() {
        _cookiesAccepted = consent;
        _isBannerVisible = consent == null;
      });
    }
  }

  // Toggles the visibility of the cookie consent banner (with animations).
  void _toggleBannerVisibility() {
    if (_isBannerVisible) {
      _animationController.reverse().then((_) {
        setState(() {
          _isBannerVisible = false; // Hide banner after animation
        });
      });
    } else {
      setState(() {
        _isBannerVisible = true;
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Disposes of the animation controller to prevent memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(), 
      endDrawer: _mobile ? DrawerComponent() : null,
      backgroundColor: GlobalColors.primaryColor, 
      body: LayoutBuilder( // LayoutBuilder dynamically adapts widgets based on parent constraints, enabling responsive design.
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Background image with blur effect.
                    Container(
                      height: availableHeight,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(GlobalOthers.backgroundLanding),
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
                    // Positioned.fill(
                    //   child: Column(
                    //     children: [
                    //       // Animated logo component.
                    //       if (_show)
                    //         Flexible(
                    //           flex: 3, // Occupies 3/10ths of the available space.
                    //           child: AnimatedOpacity(
                    //           opacity: _show ? 1.0 : 0.0, 
                    //           duration: const Duration(seconds: 3),
                    //             child: RiveAnimation.asset(
                    //               GlobalOthers.logoWebsiteInProgress,
                    //             ), 
                    //           ),
                    //         ),
                    //       // Animated text component with slide and fade effects.
                    //       Flexible(
                    //         flex: 1, // Occupies 1/10th of the available space.
                    //         child: FadeTransition(
                    //           opacity: _fadeAnimation,
                    //           child: SlideTransition(
                    //             position: _slideAnimation,
                    //             child: Text(
                    //               'EN CONSTRUCTION !',
                    //               style: TextStyle(
                    //                 fontSize: _mobile ? 24.0 : 34.0,
                    //                 color: Colors.grey.shade800, 
                    //                 fontWeight: FontWeight.bold, 
                    //               ),
                    //             ),
                    //           ),  
                    //         ),
                    //       ),
                    //       Expanded(child: SizedBox()), // Adds flexible empty space.
                    //       // Animated carousel component.
                    //       Flexible(
                    //         flex: 10, // Occupies 10/10ths of the space for the carousel.
                    //         child: AnimatedOpacity(
                    //           opacity: _show ? 1.0 : 0.0, 
                    //           duration: const Duration(seconds: 3),
                    //           child: CarouselSliderComponent(), // Custom carousel component. 
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Cookie consent banner appears when banner visibility i
                    if (_isBannerVisible)
                    CookiesConsentBanner(
                      onConsentGiven: _handleCookiesConsent,
                      onConsentLoaded: _handleLoadedConsent,
                      toggleVisibility: _toggleBannerVisibility,
                    ),
                    // Image button appears after cookie consent is accepted.                    
                    if (!_isBannerVisible && _cookiesAccepted == true)
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: AnimatedOpacity(
                        opacity: _show ? 1.0 : 0.0, 
                        duration: const Duration(seconds: 2),
                        child: ImageIconButton(
                          onPressed: _toggleBannerVisibility,
                          imagePath: GlobalOthers.cookiesButton, 
                          iconPath: GlobalOthers.iconCookieButton,
                      )
                      )
                    )
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