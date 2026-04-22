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
import '../sections/landing_screen/resources_section.dart';
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
  final ScrollController _scrollController = ScrollController();

  // Key used to locate ResourcesSection in the layout for programmatic scroll
  final GlobalKey _resourcesSectionKey = GlobalKey();

  bool isMobile = false;
  String currentItem = "Accueil";
  bool _showBackToTopButton = false;
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
    _scrollToSectionIfRequested();
  }

  // Reads ?scroll= from the URL (Flutter Web) and scrolls to the matching section after first frame.
  void _scrollToSectionIfRequested() {
    final scrollTarget = Uri.base.queryParameters['scroll'];
    if (scrollTarget != 'ressources') return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Capture RenderBox synchronously (no async gap) to satisfy lint rule
      final renderBox = _resourcesSectionKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      // Short delay lets the layout stabilise before computing the offset
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted || !_scrollController.hasClients) return;
        final dy = renderBox.localToGlobal(Offset.zero).dy;
        // Subtract navbar height so the section title is visible below the appbar
        const navbarOffset = 90.0;
        final target = (dy + _scrollController.offset - navbarOffset).clamp(
          _scrollController.position.minScrollExtent,
          _scrollController.position.maxScrollExtent,
        );
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      });
    });
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
            BeforeAfterSection(),
            SizedBox(height: 150.0),
            // section 9
            KeyFiguresSection(),
            SizedBox(height: 150.0),             
            // section 10
            ResourcesSection(key: _resourcesSectionKey),
            SizedBox(height: 150.0),
            // section 11
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