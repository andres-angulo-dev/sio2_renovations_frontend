import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/carousel_slider_component.dart';
import '../components/cookies_consent_banner.dart';
import '../components/my_button.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import 'dart:ui'; // Import for the blur effect.

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

  // Animation<Offset>: Handles the slide effect for text (moves it vertically effect).
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _servicesSlideAnimation;
  
  // Animation<double>: Handles the fade-in effect for text (controls scale effect.
  late List<Animation<double>> _valuesScaleAnimations;

  // Animation<double>: Handles the fade-in effect for text (controls opacity effect).
  late Animation<double> _fadeAnimation;
  late Animation<double> _servicesFadeAnimation;
  late List<Animation<double>> _valuesFadeAnimations;



  bool _mobile = false; 
  bool _show = false;
  bool? _cookiesAccepted; // State to track cookies consent.
  bool _isBannerVisible = false;
  bool _showAboutSection = false;
  bool _showValuesSection = false;
  String currentItem = "Accueil"; // Holds the currently selected menu item to change text color
  
  // Function to update the current item when a new one is selected to change text color
  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }


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

    // handle animation in services section
   _servicesAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    );

    _servicesSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start position: from right to left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _servicesAnimationController,
      curve: Curves.easeInOut,
    ));

    _servicesFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _servicesAnimationController, 
      curve: Curves.easeInOut,
    ));

    _initializeValuesAnimations();
  }

  // handle animation in values section
  void _initializeValuesAnimations() {
    _valuesAnimationControllers = List.generate(4, (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    ));

    _valuesFadeAnimations = _valuesAnimationControllers.map((controller) =>  Tween<double>(
      begin: 0.0,
      end: 1.0, 
    ).animate(CurvedAnimation(
      parent: controller, 
      curve: Curves.easeInOut,
    ))).toList();

    _valuesScaleAnimations = _valuesAnimationControllers.map((controller) => Tween<double>(
      begin: 1.4,
      end: 1.0
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInCirc,
    ))).toList();    
  }

  void _startValuesAnimation() {
    for (int i=0; i < _valuesAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 600), () {
        if (mounted) {
          setState(() {
            _valuesAnimationControllers[i].forward();
          });
        }
      });
    }
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

  // Disposes of the animation controller to prevent memory leaks.
  @override
  void dispose() {
    _animationController.dispose(); 
    _servicesAnimationController.dispose();
    for (var controller in _valuesAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ), 
      endDrawer: _mobile ? 
      DrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,
      backgroundColor: GlobalColors.primaryColor, 
      body: LayoutBuilder( // LayoutBuilder dynamically adapts widgets based on parent constraints, enabling responsive design.
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;

          return Stack(
            children: [
              SingleChildScrollView(
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
                              image: AssetImage(GlobalImages.backgroundLanding),
                              fit: BoxFit.cover, // Cover the entire space
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
                        //                 fontSize: _m.0obile ? 24.0 : 34.0,
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
                        // if (_isBannerVisible)
                        // CookiesConsentBanner(
                        //   onConsentGiven: _handleCookiesConsent,
                        //   onConsentLoaded: _handleLoadedConsent,
                        //   toggleVisibility: _toggleBannerVisibility,
                        // ),
                        // // Image button appears after cookie consent is accepted.                    
                        // if (!_isBannerVisible && _cookiesAccepted == true)
                        // Positioned(
                        //   bottom: 20,
                        //   left: 20,
                        //   child: AnimatedOpacity(
                        //     opacity: _show ? 1.0 : 0.0, 
                        //     duration: const Duration(seconds: 2),
                        //     child: MyButton(
                        //       onPressed: _toggleBannerVisibility,
                        //       buttonPath: GlobalButtonsAndIcons.cookiesButton, 
                        //       foregroundPath: GlobalButtonsAndIcons.iconCookieButton,
                        //   )
                        //   )
                        // )
                      ],
                    ),
                    SizedBox(height: 100.0),
                    // section 1
                    SizedBox(
                      height: 600.0,
                      width: screenWidth * 0.5,
                      child: Row(
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: VisibilityDetector(
                              key: const Key('section_about'), 
                              onVisibilityChanged: (info) {
                                if (info.visibleFraction > 0.5) {
                                  setState(() {
                                    _showAboutSection = true;
                                  });
                                }
                              },
                              child: AnimatedOpacity(
                                opacity: _showAboutSection ? 1.0 : 0.0, 
                                duration: const Duration(milliseconds: 1500),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: SingleChildScrollView(
                                     child: Column(
                                        children: [
                                          Text(
                                            "DE L’IDÉE À LA RÉALISATION, VOTRE PROJET DE RÉNOVATION ENTRE DES MAINS EXPERTES !",
                                            style: TextStyle(
                                              fontSize: 30.0, // Adjust font size
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.tertiaryColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20.0), // Space between
                                          Text(
                                            "Fruit d’un savoir-faire transmis de génération en génération, notre entreprise générale de bâtiment en Île-de-France incarne la passion et l’excellence du travail bien fait. Forts de cette tradition familiale, nous avons développé une expertise solide qui nous permet d’orchestrer chaque projet avec une approche globale. De la rénovation complète aux ajustements spécifiques, nous transformons vos idées en réalité en conjuguant esthétique, savoir-faire technique et respect des normes actuelles.\n\n" 
                                            "Votre patrimoine mérite le meilleur, et c’est notre mission de l’honorer.",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                ) 
                              ), 
                            ), 
                          ),
                          SizedBox(width: 50.0),
                          Flexible(
                              child: Center(
                                child: Container(
                                  width: 1500.0,
                                  height: 600.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/immeuble.jpeg'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                )
                              )
                            // )
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 100.0),
                    // section 2
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
                    SizedBox(height: 100.0),
                    // section 3
                    SizedBox(
                      height: 600.0,
                      width: screenWidth * 0.9,
                      child: Row(
                        children: [
                          Flexible(
                              child: Center(
                                child: Container(
                                  width: 1500.0,
                                  height: 600.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/immeuble.jpeg'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                )
                              )
                            // )
                          ),
                          SizedBox(width: 50.0),
                          Flexible(
                            fit: FlexFit.loose,
                            child: VisibilityDetector(
                              key: const Key('section_services'), 
                              onVisibilityChanged: (info) {
                                if (info.visibleFraction > 0.5) {
                                  setState(() {
                                    _servicesAnimationController.forward();
                                  });
                                }
                              },
                              child: AnimatedBuilder(
                                animation: _servicesAnimationController, 
                                builder: (context, child) {
                                  return FadeTransition(
                                    opacity: _servicesFadeAnimation,
                                    child: SlideTransition(
                                      position: _servicesSlideAnimation,
                                      child: child,
                                    )
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    width: 700.0,
                                    padding: EdgeInsets.all(16.0),
                                    child: SingleChildScrollView(
                                     child: Column(
                                        children: [
                                          Text(
                                            "NOS SERVICES DE RÉNOVATIONS",
                                            style: TextStyle(
                                              fontSize: 30.0, // Adjust font size
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.tertiaryColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20), // Space between
                                          Text(
                                            "Que vous souhaitiez rénover votre électricité, plomberie, peinture, poser du carrelage, du parquet, ou bien plus encore, SIO2 Rénovations est là pour vous offrir des conseils personnalisés, une expertise éprouvée et un service clé en main."
                                            "Le succès de chaque projet de rénovation repose sur une organisation solide. C/’est pourquoi nous vous accompagnons à chaque étape, de la planification à la livraison, à Paris et en l/’Île-de-France. Notre objectif : transformer votre intérieur en un espace unique, moderne et chaleureux."
                                            "Nous mettons un point d/’honneur à confier vos travaux à nos équipes sélectionnées pour leur sérieux et leur souci du détail. En restant agiles face aux imprévus de chantier, nous assurons un service au juste prix et dans le respect des délais."
                                            "Enfin, nous proposons à nos clients un compte rendu d/’activité régulier pour avertir en temps réel des avancées de l/’ensemble des travaux de rénovation réalisés ou en cours de réalisation.",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                ) 
                              ), 
                            ), 
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 100.0),
                    // section 4
                    SizedBox(
                      height: 600.0,
                      width: screenWidth * 0.7,
                      child: VisibilityDetector(
                        key: const Key("section_values"),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.5 && !_showValuesSection) {
                            setState(() {
                              _showValuesSection = true;
                            });
                            _startValuesAnimation(); // Start animations sequentially
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // section title with fade effect
                            AnimatedOpacity(
                              opacity: _showValuesSection ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                "NOS VALEURS",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.tertiaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 60.0),
                            // row containing animated columns
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(4, (index) => Expanded(
                                child: AnimatedBuilder(
                                  animation: _valuesAnimationControllers[index], // use separate controller for each column
                                  builder: (context, child) {
                                    return FadeTransition(
                                      opacity: _valuesFadeAnimations[index], // individual fade animation
                                      child: ScaleTransition(
                                        scale: _valuesScaleAnimations[index], // individual scale animation
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      // dinamic icons
                                      SvgPicture.asset(
                                        [
                                          GlobalLogo.logoEngagement,
                                          GlobalLogo.logoCall,
                                          GlobalLogo.logoStructured,
                                          GlobalLogo.logoCustomer
                                        ][index],
                                        width: 100,
                                        height: 100,
                                        semanticsLabel: [
                                          'A handshake symbol, representing partnership and commitment.', 
                                          'A bust silhouette wearing a headset, with an internet globe symbol below, representing communication and global connectivity.', 
                                          'An organizational chart-like structure with bust silhouettes and a gear icon at the top, symbolizing the organizational structure and efficiency of the company', 
                                          'An open hand containing a comment represented by wavy lines inside a circle and five stars forming a semicircle above, representing customer feedback and satisfaction.'
                                        ][index],
                                      ),
                                      const SizedBox(height: 30.0),
                                      // dynamic title
                                      Text(
                                        ["Engagement", "Écoute", "Savoir-faire", "Confiance"][index],
                                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 30.0),
                                      // dynamic description
                                      Text(
                                        [
                                          "Nous croyons en une collaboration sans surprise, portée par un engagement total. Chaque détail est anticipé et maîtrisé. De l’offre chiffrée aux mises à jour en temps réel, nous assurons un suivi précis et rigoureux à chaque étape de votre projet.",
                                          "Nous sommes à vos côtés pour vous guider et vous conseiller. Un interlocuteur unique vous accompagne tout au long des travaux, avec disponibilité et réactivité pour vous assurer une expérience sereine et sans stress.",
                                          "Grâce à notre expertise et à une équipe structurée, nous réalisons chaque projet avec rigueur et excellence. Une organisation méthodique et des compétences maîtrisées garantissent des travaux de haute qualité, dans le respect des normes et des délais.",
                                          "La satisfaction client et au cœur de notre démarche. Plus qu’un simple projet, nous construisons une relation de confiance durable, où vos recommandations sont la plus belle preuve de notre engagement et de la qualité de notre travail."
                                        ][index],
                                        style: const TextStyle(fontSize: 16.0),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              )).expand((widget) => [widget, const SizedBox(width: 50.0)]).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),


                    // SizedBox(
                    //   height: 600.0,
                    //   width: screenWidth * 0.7,
                    //   child: VisibilityDetector(
                    //     key: const Key("section_values"), 
                    //     onVisibilityChanged: (info) {
                    //       if (info.visibleFraction > 0.5) {
                    //         setState(() {
                    //           _valuesAnimationController.forward();
                    //           _showValuesSection = true;
                    //         });
                    //       }
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         // Title with fade effect
                    //         AnimatedOpacity(
                    //           opacity: _showValuesSection ? 1.0 : 0.0, 
                    //           duration: const Duration(milliseconds: 1000),
                    //           child: Text(
                    //             "NOS VALEURS",
                    //             style: TextStyle(
                    //               fontSize: 30.0, // Adjust font size
                    //               fontWeight: FontWeight.bold,
                    //               color: GlobalColors.tertiaryColor,
                    //             ),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 60.0),
                    //         AnimatedBuilder(
                    //           animation: _valuesAnimationController,
                    //           builder: (context, child) {
                    //             return FadeTransition(
                    //               opacity: _valuesFadeAnimation,
                    //               child: ScaleTransition(
                    //                 scale: _valuesScaleAnimation,
                    //                 child: child,
                    //               )
                    //             );
                    //           },
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoEngagement,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Engagement",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Nous croyons en une collaboration sans surprise, portée par un engagement total. Chaque détail est anticipé et maîtrisé. De l’offre chiffrée aux mises à jour en temps réel, nous assurons un suivi précis et rigoureux à chaque étape de votre projet.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoCall,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Écoute",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Nous sommes à vos côtés pour vous guider et vous conseiller. Un interlocuteur unique vous accompagne tout au long des travaux, avec disponibilité et réactivité pour vous assurer une expérience sereine et sans stress.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoStructured,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Savoire-faire",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Grâce à notre expertise et à une équipe structurée, nous réalisons chaque projet avec rigueur et excellence. Une organisation méthodique et des compétences maîtrisées garantissent des travaux de haute qualité, dans le respect des normes et des délais.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoCustomer,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Confiance",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "La satisfaction client est au cœur de notre démarche. Plus qu’un simple projet, nous construisons une relation de confiance durable, où vos recommandations sont la plus belle preuve de notre engagement et de la qualité de notre travail.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     )    
                    //   ) 
                    // ),


                    // SizedBox(
                    //   height: 600.0,
                    //   width: screenWidth * 0.7,
                    //   child: VisibilityDetector(
                    //     key: const Key("section_values"), 
                    //     onVisibilityChanged: (info) {
                    //       if (info.visibleFraction > 0.5) {
                    //         setState(() {
                    //           _valuesAnimationController.forward();
                    //         });
                    //       }
                    //     },
                    //     child: AnimatedBuilder(
                    //       animation: _valuesAnimationController,
                    //       builder: (context, child) {
                    //         return FadeTransition(
                    //           opacity: _valuesFadeAnimation,
                    //           child: ScaleTransition(
                    //             scale: _valuesScaleAnimation,
                    //             child: child,
                    //           )
                    //         );
                    //       },
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "NOS VALEURS",
                    //             style: TextStyle(
                    //               fontSize: 30.0, // Adjust font size
                    //               fontWeight: FontWeight.bold,
                    //               color: GlobalColors.tertiaryColor,
                    //             ),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //           const SizedBox(height: 60.0),
                    //           Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoEngagement,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Engagement",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Nous croyons en une collaboration sans surprise, portée par un engagement total. Chaque détail est anticipé et maîtrisé. De l’offre chiffrée aux mises à jour en temps réel, nous assurons un suivi précis et rigoureux à chaque étape de votre projet.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoCall,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Écoute",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Nous sommes à vos côtés pour vous guider et vous conseiller. Un interlocuteur unique vous accompagne tout au long des travaux, avec disponibilité et réactivité pour vous assurer une expérience sereine et sans stress.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoStructured,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Savoire-faire",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Grâce à notre expertise et à une équipe structurée, nous réalisons chaque projet avec rigueur et excellence. Une organisation méthodique et des compétences maîtrisées garantissent des travaux de haute qualité, dans le respect des normes et des délais.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //               SizedBox(width: 50.0),
                    //               Expanded(
                    //                 child: Column(
                    //                  children: [
                    //                   SvgPicture.asset(
                    //                     GlobalLogo.logoCustomer,
                    //                     width: 100,
                    //                     height: 100,
                    //                     semanticsLabel: 'A handshake icon',
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "Confiance",
                    //                     style: TextStyle(
                    //                       fontSize: 18.0,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                   SizedBox(height: 30.0),
                    //                   Text(
                    //                     "La satisfaction client est au cœur de notre démarche. Plus qu’un simple projet, nous construisons une relation de confiance durable, où vos recommandations sont la plus belle preuve de notre engagement et de la qualité de notre travail.",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                     ),
                    //                     textAlign: TextAlign.justify,
                    //                   )
                    //                  ] 
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    //     ) 
                    //   ) 
                    // ),
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
          );
        },
      ),
    );
  }
}