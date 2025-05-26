import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../sections/welcome_section.dart';
import '../sections/company_profile_section.dart';
import '../sections/values_section.dart';
import '../sections/why_choose_us_section.dart';
import '../sections/key_figures_section.dart';
import '../sections/services_section.dart';
import '../sections/steps_section.dart';
import '../sections/what_type_of_renovations_section.dart';
import '../components/cookies_consent_banner.dart';
import '../components/my_button.dart';
import '../sections/customer_feedback_section.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin {
  // AnimationController: Manages the timing of the animations.
  late AnimationController _animationController;
  late AnimationController _servicesAnimationController;
  late List<AnimationController> _valuesAnimationControllers;

  
  // Animation<double>: Handles the fade-in effect for text (controls scale effect.
  late List<Animation<double>> _valuesScaleAnimations;

  // Animation<double>: Handles the fade-in effect for text (controls opacity effect).
  late List<Animation<double>> _valuesFadeAnimations;

  final ScrollController _scrollController = ScrollController(); // Scroll controller for the appBar

  bool _mobile = false; 
  bool _show = false;
  bool? _cookiesAccepted; // State to track cookies consent.
  bool _isBannerVisible = false;
  String currentItem = "Accueil"; // Holds the currently selected menu item to change text color

  @override
  void initState() {
    super.initState();
    _isBannerVisible = _cookiesAccepted == null;

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

    // handle animation in services section
   _servicesAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    );

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
  
    // Function to update the current item when a new one is selected to change text color
  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

  // Disposes of the animation controller to prevent memory leaks.
  @override
  void dispose() {
    _animationController.dispose(); 
    _servicesAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _mobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        scrollController: _scrollController,
      ), 
      endDrawer: _mobile ? 
      DrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Stack(
                      // Welcome section
                      children: [
                        // Background image with shadow effect.
                        Positioned.fill(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: screenWidth,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(GlobalImages.backgroundLanding),
                                  fit: BoxFit.cover, // Cover the entire space
                                ),
                              ),
                            ),
                        ),
                        Positioned.fill(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4),
                            ),
                          )
                        ),
                        WelcomeSection(),
                      ]
                    ),
                    SizedBox(height: 100.0),
                    // section 1
                    CompanyProfileSection(),
                    SizedBox(height: 150.0),
                    // section 2
                    WhatTypeOfRenovationsSection(),
                    SizedBox(height: 150.0),
                    // section 3
                    ValuesSection(),
                    SizedBox(height: 150.0),
                    // section 3
                    WhyChooseUsSection(),
                    SizedBox(height: 100.0),
                    // section 4
                    ServicesSection(),
                    SizedBox(height: 200.0),
                    // section 5
                    StepsSection(),
                    SizedBox(height: 150.0),
                    // section 6
                    KeyFiguresSection(),
                    SizedBox(height: 150.0),             
                    // section 7
                    SizedBox(
                      height: 600.0,
                      // width: screenWidth * 0.5,
                      child: Row(
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Container(
                                  width: 1500.0,
                                  height: 600.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/immeuble.jpeg'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "AVANT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Flexible(
                            child: Stack(
                              children: [
                                Container(
                                  width: 1500.0,
                                  height: 600.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/immeuble.jpeg'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "APRÈS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ]
                      ),
                    ),   
                    SizedBox(height: 150.0),
                    // section 7
                    CustomerFeedbackSection(),
                    SizedBox(height: 100.0),
                    FooterComponent(),
                  ],
                ),
              ),
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
                  child: MyButton(
                    onPressed: _toggleBannerVisibility,
                    buttonPath: GlobalButtonsAndIcons.cookiesButton, 
                    foregroundPath: GlobalButtonsAndIcons.iconCookieButton,
                  )
                )
              )
            ],
      )
      );
    
  }
}