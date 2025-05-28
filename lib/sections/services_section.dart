import 'package:flutter/material.dart';
import 'package:sio2_renovations_frontend/utils/global_others.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  ServicesSectionState createState() => ServicesSectionState();
}

class ServicesSectionState extends State<ServicesSection> with SingleTickerProviderStateMixin {
  late AnimationController _servicesAnimationController;
  late Animation<Offset> _servicesSlideAnimation;
  late Animation<double> _servicesFadeAnimation;
  bool showAllServices = false;

  @override
  void initState() {
    super.initState();

    _servicesAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    );

    _servicesSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
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
  }

  @override
  void dispose() {
    _servicesAnimationController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> servicesData = const [
    {"title": "Peintre", "image": GlobalImages.backgroundLanding},
    {"title": "Plaquiste", "image": GlobalImages.backgroundLanding},
    {"title": "Menuisier", "image": GlobalImages.backgroundLanding},
    {"title": "Carreleur", "image": GlobalImages.backgroundLanding},
    {"title": "Électricien", "image": GlobalImages.backgroundLanding},
    {"title": "Plombier", "image": GlobalImages.backgroundLanding},
    {"title": "Chauffagiste", "image": GlobalImages.backgroundLanding},
    {"title": "Maçon", "image": GlobalImages.backgroundLanding},
  ];

  @override
  Widget build(BuildContext context) {
    final int initialItemCount = GlobalScreenSizes.isCustomSize(context, 638) ? 1 : 4;
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return SizedBox(
      width: GlobalScreenSizes.screenWidth(context) * 0.7,
      child: GlobalScreenSizes.isCustomSize(context, 1879) 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First part: Presentation text of the services
          VisibilityDetector(
            key: const Key('services_section'), 
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.3) {
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
                child: SizedBox(
                  child: SingleChildScrollView(
                   child: Column(
                      children: [
                        Text(
                          "UNE ENTREPRISE TOUS CORPS D’ÉTAT",
                          style: TextStyle(
                            fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                            fontWeight: FontWeight.bold,
                            color: GlobalColors.thirdColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20), // Space between
                        Text(
                          'Vous souhaitez moderniser votre intérieur, appliquer une nouvelle peinture, '
                          'poser du carrelage ou du parquet, rénover votre plomberie, ou encore mettre aux normes votre installation électrique par exemple ?\n\n'
                          'SIO2 Rénovations vous accompagne avec un savoir-faire éprouvé et des solutions adaptées à vos besoins.\n\n'
                          'Nous prenons en charge votre projet de A à Z, en assurant une gestion rigoureuse à chaque étape : '
                          'de la conception aux finitions, nous garantissons une rénovation fluide et efficace. '
                          'Intervenant à Paris et en Île-de-France, nous transformons chaque espace pour qu’il reflète votre vision, '
                          'avec modernité et élégance.\n\n'
                          'Notre engagement repose sur des équipes d’artisans qualifiés, sélectionnés pour leur sérieux et leur exigence du détail. '
                          'Et pour une transparence totale, nous tenons nos clients informés des avancées des travaux grâce à des suivis réguliers et détaillés.\n\n '
                          'Quelle que soit la complexité du chantier, avec ou sans architecte,  nous nous adaptons aux imprévus et veillons à respecter délais et budget, '
                          'tout en garantissant un haut niveau de qualité.',
                          style: TextStyle(
                            fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
          const SizedBox(height: 50),
          // Second part: Photos of the services
          AnimatedSwitcher( // Transition animation
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation, // Added a fade animation
                child: SizeTransition(
                  sizeFactor: animation, // Progressive enlargement
                  child: child,
                ),
              );
            },
            child: 
            Container(
              padding: EdgeInsets.all(15.0),
              key: ValueKey<bool>(showAllServices), // Allows you to force the rebuilding of the widget so that the animation starts
              child: 
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: servicesData.take(showAllServices ? servicesData.length : initialItemCount) // Allows to limit the number of items to display
                      .map((services) => ServiceTitle(services)).toList(),
                  ), 
                ),
              
            ),
          ),
          if (servicesData.length > initialItemCount) // Manage the display of the button
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAllServices = !showAllServices; // Toggles between true and false
                });
              }, 
              style: TextButton.styleFrom(
                backgroundColor: GlobalColors.fourthColor,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              ),
              child: Text(
                showAllServices ? "Réduire" :  "Afficher plus", // Switch between different texts
                style: TextStyle(
                  fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                  color: GlobalColors.thirdColor,
                  fontWeight: FontWeight.bold,
                )
              )
            ),
          )
        ]
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left side: Photos of the services
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              width: 900.0,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: servicesData.map((services) => ServiceTitle(services)).toList(),
              ),
            )
          ),
          const SizedBox(width: 50),
          // Right side: Presentation text of the services
          Flexible(
            fit: FlexFit.loose,
            child: VisibilityDetector(
              key: const Key('section_services'), 
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.3) {
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
                  child: SizedBox(
                    child: SingleChildScrollView(
                     child: Column(
                        children: [
                          Text(
                            "UNE ENTREPRISE TOUS CORPS D’ÉTAT",
                            style: TextStyle(
                              fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.thirdColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20), // Space between
                          Text(
                            'Vous souhaitez moderniser votre intérieur, appliquer une nouvelle peinture, '
                            'poser du carrelage ou du parquet, rénover votre plomberie, ou encore mettre aux normes votre installation électrique par exemple ?\n\n'
                            'SIO2 Rénovations vous accompagne avec un savoir-faire éprouvé et des solutions adaptées à vos besoins.\n\n'
                            'Nous prenons en charge votre projet de A à Z, en assurant une gestion rigoureuse à chaque étape : '
                            'de la conception aux finitions, nous garantissons une rénovation fluide et efficace. '
                            'Intervenant à Paris et en Île-de-France, nous transformons chaque espace pour qu’il reflète votre vision, '
                            'avec modernité et élégance.\n\n'
                            'Notre engagement repose sur des équipes d’artisans qualifiés, sélectionnés pour leur sérieux et leur exigence du détail. '
                            'Et pour une transparence totale, nous tenons nos clients informés des avancées des travaux grâce à des suivis réguliers et détaillés.\n\n '
                            'Quelle que soit la complexité du chantier, avec ou sans architecte,  nous nous adaptons aux imprévus et veillons à respecter délais et budget, '
                            'tout en garantissant un haut niveau de qualité.',
                            style: TextStyle(
                              fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
      )
    );
  }
}

class ServiceTitle extends StatefulWidget {
  final Map<String, String> services;
  const ServiceTitle(this.services, {super.key});

  @override
  ServiceTitleState createState() => ServiceTitleState();
}

class ServiceTitleState extends State<ServiceTitle> {
  bool isHovered = false; 

  @override
  Widget build(BuildContext context) {
  final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
  
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true), 
      onExit: (_) => setState(() => isHovered = false), 
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 300), // Smooth animation duration
        tween: Tween<double>(begin: 1.0, end: isHovered ? 1.1 : 1.0), // Scale transition effect
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale, // Applies scale effect dynamically
            child: child,
          );
        },
        child: SizedBox(
          width: 200.0,
          height: 300.0,
          child: ClipRRect( // Allows you to make invisible what is larger than the parent container
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            child: Stack(
            children: [
              // Image with hover scale effect                
              Image.asset(
                widget.services["image"]!, 
                width: 200.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              // Bottom overlay with profession title appearing on hover
              AnimatedPositioned(
                width: 200.0,
                duration: Duration(milliseconds: 300), // Smooth slide-up animation
                bottom: isHovered ? 0.0 : -30.0, // Moves up when hovered
                child: Container(
                  height: 30.0,
                  color: GlobalColors.fourthColor, 
                  alignment: Alignment.center, 
                  child: Text(
                    widget.services["title"]!,
                    style: TextStyle(
                      color: GlobalColors.thirdColor,
                      fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          )
        ) 
      ),
    );
  }
}
