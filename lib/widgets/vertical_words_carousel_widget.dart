import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';
import '../utils/global_others.dart';

class VerticalWordsCarouselWidget extends StatefulWidget {
  const VerticalWordsCarouselWidget({super.key});

  @override
  VerticalWordsCarouselWidgetState createState() => VerticalWordsCarouselWidgetState();
}

class VerticalWordsCarouselWidgetState extends State<VerticalWordsCarouselWidget> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late PageController _pageController; // Controller for PageView
  Timer? _autoPlayTimer; // Timer for auto-rotation
  final double viewportFraction = 0.3; // Fraction of the viewport occupied by each page
  late final int initialPage; // A high offset to simulate infinite scrolling
  // List of words to display in the carousel
  final List<String> words = ["TOTALES", "PARTIELLES", "DE CUISINE", "DE SALLE DE BAIN"];

  @override
  void initState() {
    super.initState();
    // Set an initially high word number for infinite scrolling effect
    initialPage = words.length * 500;
    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: viewportFraction,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );

    _slideAnimation =Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0, 
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    // Timer to auto-scroll every X seconds
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // Calculate the next word (round the current word, then add one)
        int nextPage = (_pageController.page?.round() ?? initialPage) + 1;
        // Animate to the next word with easing
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the auto-scroll timer 
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return AnimatedBuilder(
      animation: _animationController, 
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              color: GlobalColors.orangeColor.withValues(alpha: 0.7),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                runSpacing: 20.0,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Top text description container
                  Container(
                    padding: GlobalScreenSizes.isCustomSize(context, 1150) ? null : EdgeInsets.only(left: 50.0),
                    child: Text(
                      "Chez ${GlobalPersonalData.companyName} nous réalisons des rénovations :",
                      style: TextStyle(
                        color: GlobalColors.firstColor,
                        fontSize: isMobile ? GlobalSize.welcomeSectionMobileSubTitle : GlobalSize.welcomeSectionWebSubTitle,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Container for the vertical words carousel
                  SizedBox(
                    height: GlobalScreenSizes.isMobileScreen(context) ? 235.0 : 200.0,
                    width: 400.0,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling
                      // No fixed itemCount concept used here for infinite scrolling
                      itemBuilder: (context, index) {
                        // Determine which word to display 
                        int currentWordIndex = index % words.length;
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1.0; // scale factor
                            double opacity = 1.0; // opacity factor
                            // Ensure the PageController is attached to a PageView and its dimensions are computed before accessing its page values
                            if (_pageController.hasClients && _pageController.position.haveDimensions) {
                              // Get the current word position; fallback to initial word if not available
                              double wordPos = _pageController.page ?? initialPage.toDouble();
                              // Calculate the absolute difference between the current word and this item's index
                              double diff = (wordPos - index).abs();
                              // Adjust the scale: the center word will be 1.0, others will be reduced gradually
                              value = (1 - (diff * 0.9)).clamp(0.4, 1.0);
                              // Adjust the opacity: the center word fully opaque (1.0) and others become more transparent
                              opacity = (1 - (diff * 0.7)).clamp(0.3, 1.0);
                            }
                            return Center(
                              child: Opacity(
                                opacity: opacity, // Apply dynamic opacity based on diff
                                child: Transform.scale(
                                  scale: value, // Apply dynamic scaling based on diff
                                  child: Text(
                                    words[currentWordIndex],
                                    style: TextStyle(
                                      color: GlobalColors.firstColor,
                                      fontSize: isMobile ? GlobalSize.welcomeSectionMobileTitle : GlobalSize.welcomeSectionWebTitle,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          )
        );
      }
    );
  }
}
