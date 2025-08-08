import 'package:flutter/material.dart';
import '../widgets/zoom_fade_image_carousel_widget.dart';
import '../components/my_nav_bar_component.dart';
import '../components/my_drawer_component.dart';
import '../components/footer_component.dart';
import '../sections/landing_screen/welcome_section.dart';
import '../sections/landing_screen/company_profile_section.dart';
import '../sections/landing_screen/values_section.dart';
import '../sections/landing_screen/why_choose_us_section.dart';
import '../sections/landing_screen/key_figures_section.dart';
import '../sections/landing_screen/services_section.dart';
import '../sections/landing_screen/work_together_section.dart';
import '../sections/landing_screen/steps_section.dart';
import '../sections/landing_screen/what_type_of_renovations_section.dart';
import '../sections/landing_screen/before_after_section.dart';
import '../sections/landing_screen/customer_feedback_section.dart';
import '../widgets/my_back_to_top_button_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  // Scroll controller for the back to top button and appBar 
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState with _scrollController = ScrollController();

  bool isMobile = false; 
  String currentItem = "Accueil"; // Holds the currently selected menu item to change text color
  bool _showBackToTopButton = false; // Show or hide Back to top button
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

  @override
  void initState() {
    super.initState();

    // Handle back to top button 
    _scrollController.addListener(_scrollListener); // Adds an event listener that captures scrolling from parent Landing Screen using scrollController
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
        _showBackToTopButton = shouldShow;
      });
    }
  }

  // Disposes of the animation controller to prevent memory leaks
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyNavBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        scrollController: _scrollController,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);},// receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click)
      ),       
      endDrawer: isMobile // && !_isDesktopMenuOpen (only for NavItem with click)
      ? MyDrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,         
      extendBodyBehindAppBar: true,
      backgroundColor: GlobalColors.firstColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Welcome section
            Stack(
              children: [
                // Image carousel
                ZoomFadeIamgeCarouselWidget(
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
      floatingActionButton: _showBackToTopButton
      ? MyBackToTopButtonWidget(controller: _scrollController)
      : null,
    );
  }
}