import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sio2_renovations_frontend/utils/global_screen_sizes.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/section_why_choose_us.dart';
import '../components/section_key_figures.dart';
import '../components/section_services.dart';
import '../components/section_steps.dart';
import '../components/section_what_type_of_renovations.dart';
import '../components/cookies_consent_banner.dart';
import '../components/my_button.dart';
import '../components/footer.dart';
import '../components/section_customer_feedback.dart';
import '../components/my_rive_button.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

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
  late Animation<Offset> _servicesSlideAnimation;
  
  // Animation<double>: Handles the fade-in effect for text (controls scale effect.
  late List<Animation<double>> _valuesScaleAnimations;

  // Animation<double>: Handles the fade-in effect for text (controls opacity effect).
  late Animation<double> _servicesFadeAnimation;
  late List<Animation<double>> _valuesFadeAnimations;

  final ScrollController _scrollController = ScrollController(); // Scroll controller for the appBar

  bool _mobile = false; 
  bool _show = false;
  bool? _cookiesAccepted; // State to track cookies consent.
  bool _isBannerVisible = false;
  bool _showAboutSection = false;
  bool _showValuesSection = false;
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
    for (var controller in _valuesAnimationControllers) {
      controller.dispose();
    }
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: screenWidth,
                          child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenWidth * 0.9,
                            padding: EdgeInsets.all(32.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment : GlobalScreenSizes.isMobileScreen(context) ? WrapAlignment.center : WrapAlignment.spaceBetween,
                              spacing: 10.0,
                              runSpacing: 30.0,
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment: GlobalScreenSizes.isMobileScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "SIO2 RÉNOVATIONS",
                                        style: TextStyle(
                                          color: GlobalColors.firstColor,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text(
                                        "Donner une nouvelle vie à votre espace, c’est notre métier.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: GlobalColors.firstColor,
                                          fontSize: 22.0,
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 341.0,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 50,
                                        child: MyRiveButton(
                                          enableCursor: false,
                                          buttonPath: GlobalButtonsAndIcons.callUsButton
                                        ),
                                      ),
                                      SizedBox(width: 20.0),
                                      Container(
                                        height: 60.0,
                                        width: 1.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20.0),
                                      SizedBox(
                                        width: 150,
                                        height: 50,
                                        child: MyRiveButton(
                                          onPressed: () => Navigator.pushNamed(context, '/contact'), 
                                          buttonPath: GlobalButtonsAndIcons.freeQuoteButton
                                        ),
                                      ),
                                    ],
                                  )
                                )
                              ]),
                            )                             
                          )
                        ),
                      ]
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
                                if (info.visibleFraction > 0.3) {
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
                                            "VOTRE PROJET DE RÉNOVATION ENTRE DES MAINS EXPERTES !",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.thirdColor,
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
                    SizedBox(height: 150.0),
                    WhatTypeOfRenovationsSection(),
                    SizedBox(height: 150.0),
                    // section 2
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: VisibilityDetector(
                        key: const Key("section_values"),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.3 && !_showValuesSection) {
                            setState(() {
                              _showValuesSection = true;
                            });
                            _startValuesAnimation(); // Start animations sequentially
                          }
                        },
                        child: SingleChildScrollView(
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
                                    color: GlobalColors.thirdColor,
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
                        )
                      ),
                    ),
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