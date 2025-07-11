import 'package:flutter/material.dart';
import '../components/zoom_fade_image_carousel_component.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/cookies_consent_banner.dart';
import '../components/my_button.dart';
import '../components/my_back_to_top_button.dart';
import '../components/footer.dart';
import '../sections/welcome_section.dart';
import '../sections/company_profile_section.dart';
import '../sections/values_section.dart';
import '../sections/why_choose_us_section.dart';
import '../sections/key_figures_section.dart';
import '../sections/services_section.dart';
import '../sections/work_together_section.dart';
import '../sections/steps_section.dart';
import '../sections/what_type_of_renovations_section.dart';
import '../sections/before_after_section.dart';
import '../sections/customer_feedback_section.dart';
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
  // Scroll controller for the back to top button and appBar 
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState with _scrollController = ScrollController();

  bool _mobile = false; 
  bool _show = false;
  bool? _cookiesAccepted; // State to track cookies consent.
  bool _isBannerVisible = false;
  String currentItem = "Accueil"; // Holds the currently selected menu item to change text color
  bool _showBackToTopButton = false; // Show or hide Back to top button
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

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

    // Handle animation in services section
   _servicesAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    );

    // Handle back to top button 
    _scrollController.addListener(_scrollListener); // Adds an event listener that captures scrolling from parent Landing Screen using scrollController
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

  // Detects when scrolling should show back to top button
  void _scrollListener() {
    final shouldShow = _scrollController.position.pixels > MediaQuery.of(context).size.height - 100;
    if (shouldShow != _showBackToTopButton) {
      setState(() {
        setState(() {
          _showBackToTopButton = shouldShow;
        }); 
      });
    }
  }

  // Disposes of the animation controller to prevent memory leaks.
  @override
  void dispose() {
    _animationController.dispose(); 
    _servicesAnimationController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    _mobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        scrollController: _scrollController,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);},// receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click)
      ), 
      endDrawer: _mobile // && !_isDesktopMenuOpen (only for NavItem with click)
      ? DrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,
      extendBodyBehindAppBar: true,
      backgroundColor: GlobalColors.firstColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Welcome section
                Stack(
                  children: [
                    // Image carousel
                    ZoomFadeIamgeCarouselComponent(
                      imagePaths: GlobalImages.landingCarouselImages,
                      height: MediaQuery.of(context).size.height,
                    ),
                    // Shadow effect
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
                // section 4
                WhyChooseUsSection(),
                SizedBox(height: 100.0),
                // section 5
                ServicesSection(),
                SizedBox(height: 150.0),
                // section 6
                WorkTogetherSection(),
                SizedBox(height: 150.0),
                // section 7
                StepsSection(),
                SizedBox(height: 150.0),
                // section 8
                KeyFiguresSection(),
                SizedBox(height: 150.0),             
                // section 9
                BeforeAfterSection(),
                SizedBox(height: 150.0),
                // section 10
                CustomerFeedbackSection(),
                SizedBox(height: 160.0),
                FooterComponent(),
              ],
            ),
          ),
          // Cookie consent banner appears when banner visibility is true
          if (_isBannerVisible)
          CookiesConsentBanner(
            onConsentGiven: _handleCookiesConsent,
            onConsentLoaded: _handleLoadedConsent,
            toggleVisibility: _toggleBannerVisibility,
          ),
          // Image button appears after cookie consent is accepted.                    
          if (!_isBannerVisible && _cookiesAccepted == true)
          Positioned(
            bottom: 15,
            left: 15,
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
      ),
      floatingActionButton: _showBackToTopButton
      ? MyBackToTopButton(controller: _scrollController)
      : null,
    );
  }
}