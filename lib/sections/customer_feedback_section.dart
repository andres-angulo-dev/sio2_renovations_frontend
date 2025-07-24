import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:math';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class CustomerFeedbackSection extends StatefulWidget {
  const CustomerFeedbackSection({super.key});

  @override
  CustomerFeedbackSectionState createState() => CustomerFeedbackSectionState();
}

class CustomerFeedbackSectionState extends State<CustomerFeedbackSection> {
  // Controls the page scrolling automatic effect for testimonials
  PageController _pageController = PageController(viewportFraction: 1.0); // Property that allows the display of part of the following comment
  late Timer _timer;
  int _currentIndex = 0;
  bool _userInteracted = false;
  bool _isHovered = false;
  
  // List of customer testimonials with comment, author, and project title
  final List<Map<String, String>> feedbacks = [
    {
      "comment": "\"Excellente exécution d’un chantier portant sur la rénovation totale d’un appartement. Respect du cahier des charges, des engagements et des quelques aménagements décidés lors de la réalisation. Beau travail et belle équipe.\"",
      "author": "M. & Mme T. ",
      "title": "",
    },
    {
      "comment": "\"Travail impeccable et équipe très professionnelle. Mon appartement a été transformé avec beaucoup d’élégance.\"",
      "author": "Mme B. ",
      "title": "Rénovation d'un appartement familial - 13ème arrondissement",
    },
    {
      "comment": "\"Un vrai plaisir de voir mon projet réalisé avec autant de soin et de précision ! Bravo à toute l’équipe.\"",
      "author": "M. D. ",
      "title": "Modernisation complète d’un loft à République",
    },
    {
      "comment": "\"Merci pour le professionnalisme et le soin apporté aux finitions. Je referai appel à vous pour mes futures travaux.\"",
      "author": "J. H. ",
      "title": "Rénovation de la salle de bain ",
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = Random().nextInt(feedbacks.length); // Random selection of a comment at the start
    _pageController = PageController(initialPage: _currentIndex); // Sets the starting comment
    _startAutoScroll();
  }

 // Random : automatically scroll to the next testimonial every XX seconds
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!_userInteracted) {
        _nextFeedBack();
      }  
    });
  }

  // Generates a random index, different from the current one
  int _getRandomIndex() {
    int nextIndex;
    do {
      nextIndex = Random().nextInt(feedbacks.length); // Random choice of the next testimony
    } while (nextIndex == _currentIndex); // Avoid choosing the same as the previous one
    return nextIndex; // Move to the next testimonial
  }

  void _nextFeedBack() {
    setState(() {
      _currentIndex = _getRandomIndex(); // Move to the next testimonial

      // Animate transition between testimonials with a smooth effect
      _pageController.animateToPage(
        _currentIndex, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeInOut
      );

      _restartAutoScroll(); // Restart auto-scroll after interaction
    });
  }

  void _previousFeedBack() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + feedbacks.length) % feedbacks.length; // Manage the limits
      _pageController.animateToPage(
        _currentIndex, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeInOut,
      );
      _restartAutoScroll(); // Restart auto-scroll after interaction
    });
  }

  // Resets auto-scroll after interaction
  void _restartAutoScroll() {
    _userInteracted = true;
    _timer.cancel(); // Stop the old timer
    _timer = Timer(const Duration(seconds: 10), () { // Time before reactivating auto-scroll
      _userInteracted = false;
      _startAutoScroll(); // Restarts automatic scrolling
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is removed to prevent memory leaks
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Column(
      children: [
        //Tittle
        Text(
          "LE TEMOIGNAGE DE NOS CLIENTS",
          style: TextStyle(
            fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
            fontWeight: FontWeight.bold,
            color: GlobalColors.thirdColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            Container(
              height: 600.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage(
                    GlobalImages.backgroundFeedbackSection
                  ),
                  fit: BoxFit.fitHeight
                )
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 50.0,
              runSpacing: 20.0,
              children: [
                // Description
                SizedBox(
                  width: 750.0,
                  child: Align(
                    alignment: GlobalScreenSizes.isCustomSize(context, 1550) ? Alignment.center : Alignment.centerRight,
                    child: SizedBox(
                      width: 400.0,
                      child: Text(
                        "La confiance de nos clients et partenaires est notre plus belle récompense. Vos recommandations témoignent de notre engagement et de la qualité de notre travail",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                ),
                // Square that wraps the background squares and the feedbacks container
                Container(
                  width: GlobalScreenSizes.isCustomSize(context, 1550) ? 950 : 750,
                  height: 600,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Positioned( // Top square
                        top: 20.0,
                        right: 100.0,
                        child: Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: GlobalColors.thirdColor.withValues(alpha: 0.9),
                              width: 10.0,
                            )
                          ),
                        )
                      ),
                      Positioned( // Middle square
                        top: 180.0,
                        right: 50.0,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: GlobalColors.thirdColor.withValues(alpha: 0.6),
                              width: 10.0,
                            )
                          ),
                        )
                      ),
                      Positioned( // Bottom square
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          width: 350.0,
                          height: 350.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: GlobalColors.thirdColor.withValues(alpha: 0.75),
                              width: 10.0,
                            )
                          ),
                        )
                      ),
                      Align( // Feedbacks container
                        alignment: GlobalScreenSizes.isCustomSize(context, 1550.0) ? Alignment.center : Alignment.centerLeft,
                        child: Container(
                          width: 550.0,
                          height: 450.0,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [BoxShadow(
                              color: Colors.black26, 
                              blurRadius: 6.0,
                            )],
                          ),
                          child: MouseRegion(
                            onEnter: (_) => setState(() {
                              _isHovered = true;
                            }),
                            onExit: (_) => setState(() {
                              _isHovered = false;
                            }),
                            child: isMobile 
                            ? Column( // Mobile version
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Logo "quotation marks"
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    GlobalLogo.logoDots,
                                    width: isMobile ? 80.0 : 100.0,
                                    height: isMobile ? 80.0 : 100.0,
                                  )
                                ),
                                // Container of feedbacks
                                Expanded( 
                                  child: SizedBox( 
                                    width: 430.0,
                                    child: PageView.builder( // Display Feedbacks
                                      controller: _pageController,
                                      itemCount: feedbacks.length,
                                      itemBuilder: (context, index) {
                                        return Column( 
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [  
                                            // Message
                                            Text(
                                              feedbacks[index]["comment"]!,
                                              style: TextStyle(fontSize: GlobalSize.webSizeText, fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                            ),
                                            const SizedBox(height: 10.0),
                                            // Signing
                                            Text(
                                              "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
                                              style: TextStyle(fontSize: GlobalSize.mobileSizeText, fontWeight: FontWeight.w600, color: GlobalColors.fiveColor),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis
                                            ),
                                          ],
                                        );
                                      }
                                    ),
                                  ),
                                ),
                                // Container of arrows
                                SizedBox( 
                                  width: 200.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Previous arrow
                                      AnimatedOpacity(
                                        opacity: 1.0,
                                        duration: const Duration(milliseconds: 500),
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(3.1416), // π radians = 180° opposite direction
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: GlobalColors.thirdColor,
                                            ),
                                            onPressed: () {
                                              _previousFeedBack();
                                            },
                                          ),
                                        ),
                                      ),
                                      // Next arrow
                                      AnimatedOpacity(
                                        opacity: 1.0,
                                        duration: const Duration(milliseconds: 500),
                                        child: IconButton( 
                                          icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: GlobalColors.thirdColor,
                                            ),
                                          onPressed: () {
                                            _nextFeedBack();
                                          },
                                        )
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ) 
                            : Column( // Web version
                              children: [
                                // Logo "quotation marks"
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    GlobalLogo.logoDots,
                                    width: isMobile ? 80.0 : 100.0,
                                    height: isMobile ? 80.0 : 100.0,
                                  )
                                ),
                                SizedBox(
                                  width: 430.0,
                                  height: 250.0,
                                  child: Row( 
                                    mainAxisAlignment: MainAxisAlignment.center,  
                                    children: [
                                      // Previous arrow
                                      AnimatedOpacity(
                                        opacity: _isHovered ? 1.0 : 0.0,
                                        duration: const Duration(milliseconds: 500),
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(3.1416), // π radians = 180° opposite direction
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: GlobalColors.thirdColor,
                                            ),
                                            onPressed: () {
                                              _previousFeedBack();
                                            },
                                          ),
                                        ),
                                      ),
                                      // Container of feedbacks
                                      Expanded(
                                        child:PageView.builder(
                                          controller: _pageController,
                                          itemCount: feedbacks.length,
                                          itemBuilder: (context, index) {
                                           return Column( 
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [  
                                                // Message
                                                Text(
                                                  feedbacks[index]["comment"]!,
                                                  style: TextStyle(fontSize: GlobalSize.webSizeText, fontStyle: FontStyle.italic),
                                                  textAlign: TextAlign.justify,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 10,
                                                ),
                                                const SizedBox(height: 10.0),
                                                // Signing
                                                Text(
                                                  "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
                                                  style: TextStyle(fontSize: GlobalSize.mobileSizeText, fontWeight: FontWeight.w600, color: GlobalColors.fiveColor),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis
                                                ),
                                              ],
                                            );
                                          }
                                        ),
                                      ),
                                      // Next arrow
                                      AnimatedOpacity(
                                        opacity: _isHovered ? 1.0 : 0.0,
                                        duration: const Duration(milliseconds: 500),
                                        child: IconButton( 
                                          icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: GlobalColors.thirdColor,
                                            ),
                                          onPressed: () {
                                            _nextFeedBack();
                                          },
                                        )
                                      ),
                                    ]
                                  ),
                                )
                              ],
                            )
                          )
                        ),
                      ),
                    ],
                  )
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
