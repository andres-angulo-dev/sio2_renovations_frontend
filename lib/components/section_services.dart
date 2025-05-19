import 'package:flutter/material.dart';
import 'package:sio2_renovations_frontend/utils/global_others.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';
import '../utils/global_sizes.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  ServicesSectionState createState() => ServicesSectionState();
}

class ServicesSectionState extends State<ServicesSection> with SingleTickerProviderStateMixin {
  late AnimationController _servicesAnimationController;
  late Animation<Offset> _servicesSlideAnimation;
  late Animation<double> _servicesFadeAnimation;

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
    {"title": "Électricien", "image": GlobalImages.backgroundLanding},
    {"title": "Plombier", "image": GlobalImages.backgroundLanding},
    {"title": "Chauffagiste", "image": GlobalImages.backgroundLanding},
    {"title": "Carreleur", "image": GlobalImages.backgroundLanding},
    {"title": "Plaquiste", "image": GlobalImages.backgroundLanding},
    {"title": "Peintre", "image": GlobalImages.backgroundLanding},
    {"title": "Maçon", "image": GlobalImages.backgroundLanding},
    {"title": "Menuisier", "image": GlobalImages.backgroundLanding},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: GlobalSizes.isCustomServicesSection(context) ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First part: Presentation text of the services
          VisibilityDetector(
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
                          "NOTRE EXPERTISE EN RÉNOVATION",
                          style: TextStyle(
                            fontSize: 30.0,
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
          const SizedBox(height: 50),
          // Second part: Photos of the services
          SizedBox(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: servicesData.map((services) => ServiceTitle(services)).toList(),
            ),
          ),
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
                            "NOTRE EXPERTISE EN RÉNOVATION",
                            style: TextStyle(
                              fontSize: 30.0,
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
        child: Stack(
          alignment: Alignment.bottomCenter, // Positions overlay at the bottom
          children: [
            // Image with hover scale effect
            ClipRRect(
              // borderRadius: BorderRadius.circular(8), // Rounded corners for aesthetics
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ),
              child: Image.asset(
                widget.services["image"]!, 
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            // Bottom overlay with profession title appearing on hover
            AnimatedPositioned(
              duration: Duration(milliseconds: 300), // Smooth slide-up animation
              bottom: isHovered ? 0 : -30, // Moves up when hovered
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                ), // Rounded corners only at the bottom
                child: Container(
                  height: 30,
                  color: GlobalColors.fourthColor, 
                  alignment: Alignment.center, 
                  child: Text(
                    widget.services["title"]!,
                    style: TextStyle(
                      color: GlobalColors.thirdColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../utils/global_others.dart';
// import '../utils/global_colors.dart';

// class ServicesSection extends StatefulWidget {
//   const ServicesSection({super.key});

//   @override
//   ServicesSectionState createState() => ServicesSectionState();
// }

// class ServicesSectionState extends State<ServicesSection> {
//   final List<Map<String, String>> servicesData = const [
//     {"title": "Électricien", "image": GlobalImages.backgroundLanding},
//     {"title": "Plombier", "image": GlobalImages.backgroundLanding},
//     {"title": "Chauffagiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Carreleur", "image": GlobalImages.backgroundLanding},
//     {"title": "Plaquiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Peintre", "image": GlobalImages.backgroundLanding},
//     {"title": "Maçon", "image": GlobalImages.backgroundLanding},
//     {"title": "Menuisier", "image": GlobalImages.backgroundLanding},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
//       child: Row(
//         children: [
//           // 🔹 Partie gauche : Photos interactives
//           Expanded(
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: servicesData.map((services) => _buildServiceTitle(services)).toList(),
//             ),
//           ),
//           const SizedBox(width: 50),

//           // 🔹 Partie droite : Texte de présentation
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "NOS SERVICES DE RÉNOVATIONS",
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: GlobalColors.thirdColor),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Que vous souhaitiez rénover votre électricité, plomberie, peinture, poser du carrelage, du parquet, ou bien plus encore, SIO2 Rénovations est là pour vous offrir un service clé en main.",
//                   style: TextStyle(fontSize: 16, color: Colors.black87),
//                   textAlign: TextAlign.start,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Widget avec effet hover interactif
//   Widget _buildServiceTitle(Map<String, String> services) {
//     return StatefulBuilder(
//       builder: (context, setState) {
//         bool isHovered = false;
//         return MouseRegion(
//           onEnter: (_) => setState(() => isHovered = true),
//           onExit: (_) => setState(() => isHovered = false),
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               // 📌 Image avec effet de scale
//               AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 // transform: isHovered == true ? Matrix4.identity()..scale(1.1) : Matrix4.identity(),
//                 // transform: isHovered == true ? Matrix4.diagonal3Values(1.1, 1.1, 1.1) : Matrix4.identity(),
//                 // transform: isHovered == true ? Matrix4.identity().scaled(1.1, 1.1, 1.0) : Matrix4.identity(),
//                 // transform: isHovered == true ? Matrix4.translationValues(0, 0, 0)..scale(1.1, 1.1, 1.0) : Matrix4.translationValues(0, 0, 0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(
//                     services["image"]!,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // Transform.scale(
//               //   scale: 1.1, // ✅ Applique l'effet de zoom
//               //   child: ClipRRect(
//               //     borderRadius: BorderRadius.circular(8),
//               //     child: Image.asset(
//               //       services["image"]!,
//               //       width: 100,
//               //       height: 100,
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // ),


//               // 📌 Rectangle doré avec le titre du métier
//               AnimatedPositioned(
//                 duration: Duration(milliseconds: 300),
//                 bottom: -30, // Effet d'apparition
//                 child: Container(
//                   width: 100,
//                   height: 30,
//                   color: GlobalColors.thirdColor, // ✅ Couleur dorée
//                   alignment: Alignment.center,
//                   child: Text(
//                     services["title"]!,
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import '../utils/global_others.dart';
// import '../utils/global_colors.dart';

// class ServicesSection extends StatefulWidget {
//   const ServicesSection({super.key});

//   @override
//   ServicesSectionState createState() => ServicesSectionState();
// }

// class ServicesSectionState extends State<ServicesSection> {
//   OverlayEntry? _overlayEntry;

//   final List<Map<String, String>> servicesData = const [
//     {"title": "Électricien", "image": GlobalImages.backgroundLanding},
//     {"title": "Plombier", "image": GlobalImages.backgroundLanding},
//     {"title": "Chauffagiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Carreleur", "image": GlobalImages.backgroundLanding},
//     {"title": "Plaquiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Peintre", "image": GlobalImages.backgroundLanding},
//     {"title": "Maçon", "image": GlobalImages.backgroundLanding},
//     {"title": "Menuisier", "image": GlobalImages.backgroundLanding},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
//       child: Row(
//         children: [
//           // 🔹 Partie gauche : Images interactives
//           Expanded(
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: servicesData.map((services) => _buildServiceTitle(services)).toList(),
//             ),
//           ),
//           const SizedBox(width: 50),
//           // 🔹 Partie droite : Présentation des services
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "NOS SERVICES DE RÉNOVATIONS",
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: GlobalColors.thirdColor),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "SIO2 Rénovations vous accompagne dans tous vos projets de rénovation : électricité, plomberie, carrelage, peinture et bien plus encore.",
//                   style: TextStyle(fontSize: 16, color: Colors.black87),
//                   textAlign: TextAlign.start,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Widget avec effet hover (Scale + rectangle doré)
//   // Widget _buildServiceTitle(Map<String, String> services) {
//   //   return StatefulBuilder(
//   //     builder: (context, setState) {
//   //       bool isHovered = false;
//   //       return MouseRegion(
//   //         onEnter: (event) {
//   //           setState(() => isHovered = true);
//   //           _showTitleOverlay(event, services);
//   //         },
//   //         onExit: (_) {
//   //           setState(() => isHovered = false);
//   //           _hideTitleOverlay();
//   //         },
//   //         child: TweenAnimationBuilder(
//   //           duration: Duration(milliseconds: 300),
//   //           tween: Tween<double>(begin: 1.0, end: isHovered == true ? 1.8 : 1.2),
//   //           builder: (context, double scale, child) {
//   //             return Transform.scale(
//   //               scale: scale,
//   //               child: child,
//   //             );
//   //           },
//   //           child: ClipRRect(
//   //             borderRadius: BorderRadius.circular(8),
//   //             child: Image.asset(
//   //               services["image"]!,
//   //               width: 100,
//   //               height: 100,
//   //               fit: BoxFit.cover,
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//   Widget _buildServiceTitle(Map<String, String> services) {
//   return StatefulBuilder(
//     builder: (context, setState) {
//       bool isHovered = false;
//       return MouseRegion(
//         onEnter: (_) => setState(() => isHovered = true),
//         onExit: (_) => setState(() => isHovered = false),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             // 📌 Image avec effet de scale au survol
//             AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               transform: isHovered ? Matrix4.identity()..scale(1.1) : Matrix4.identity(),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   services["image"]!,
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // 📌 Rectangle doré avec effet de montée
//             AnimatedPositioned(
//               duration: Duration(milliseconds: 300),
//               bottom: isHovered ? 0 : -30, // ✅ Effet de montée fluide
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 30,
//                 color: GlobalColors.goldColor,
//                 alignment: Alignment.center,
//                 child: Text(
//                   services["title"]!,
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }


//   // ✅ Affichage du titre du métier en overlay
//   void _showTitleOverlay(PointerEvent event, Map<String, String> services) {
//     final overlay = Overlay.of(context);
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: event.position.dx - 50,
//         top: event.position.dy - 30,
//         child: Material(
//           color: Colors.transparent,
//           child: AnimatedOpacity(
//             opacity: 1.0,
//             duration: Duration(milliseconds: 200),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               decoration: BoxDecoration(
//                 color: GlobalColors.fourthColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 services["title"]!,
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     overlay.insert(_overlayEntry!);
//   }

//   // ✅ Suppression du titre en overlay lorsque la souris quitte
//   void _hideTitleOverlay() {
//     _overlayEntry?.remove();
//   }
// }




// // CA MARCHEEEEE
// import 'package:flutter/material.dart';
// import 'package:sio2_renovations_frontend/utils/global_colors.dart';
// import '../utils/global_others.dart'; 

// class ServicesSection extends StatefulWidget {
//   const ServicesSection({super.key});

//   @override
//   ServicesSectionState createState() => ServicesSectionState();
// }

// class ServicesSectionState extends State<ServicesSection> {
//   bool isHovered = false; // ✅ Variable to track hover state

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           // Image with scale effect on hover
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             width: isHovered ? 220 : 200, 
//             height: isHovered ? 420 : 400,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 GlobalImages.backgroundLanding,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Red rectangle appearing at the bottom with rounded edges
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             bottom: isHovered ? 0 : -30, // ✅ Smooth slide-up effect
//             left: 0,
//             right: 0,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(8),
//                 bottomRight: Radius.circular(8),
//               ), // ✅ Rounded edges only at the bottom
//               child: Container(
//                 height: 30,
//                 color: GlobalColors.orangeColor, // ✅ Background color
//                 alignment: Alignment.center,
//                 child: Text(
//                   "PLOMBIER",
//                   style: TextStyle(
//                     color: GlobalColors.secondColor,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';

// class ServicesSection extends StatelessWidget {
//   const ServicesSection({super.key});

//   final List<Map<String, String>> servicesData = const [
//     {"title": "Électricien", "image": GlobalImages.backgroundLanding},
//     {"title": "Plombier", "image": GlobalImages.backgroundLanding},
//     {"title": "Chauffagiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Carreleur", "image": GlobalImages.backgroundLanding},
//     {"title": "Plaquiste", "image": GlobalImages.backgroundLanding},
//     {"title": "Peintre", "image": GlobalImages.backgroundLanding},
//     {"title": "Maçon", "image": GlobalImages.backgroundLanding},
//     {"title": "Menuisier", "image": GlobalImages.backgroundLanding},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
//       child: Wrap(
//         alignment: WrapAlignment.center,
//         spacing: 16, // ✅ Horizontal spacing between elements
//         runSpacing: 16, // ✅ Vertical spacing between rows
//         children: servicesData.map((services) => ServiceTitle(services)).toList(),
//       ),
//     );
//   }
// }

// // Stateful widget to handle hover effect per image
// class ServiceTitle extends StatefulWidget {
//   final Map<String, String> services;
//   const ServiceTitle(this.services, {super.key});

//   @override
//   ServiceTitleState createState() => ServiceTitleState();
// }

// class ServiceTitleState extends State<ServiceTitle> {
//   bool isHovered = false; 

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true), 
//       onExit: (_) => setState(() => isHovered = false), 
//       child: TweenAnimationBuilder(
//         duration: Duration(milliseconds: 300), // Smooth animation duration
//         tween: Tween<double>(begin: 1.0, end: isHovered ? 1.1 : 1.0), // Scale transition effect
//         builder: (context, double scale, child) {
//           return Transform.scale(
//             scale: scale, // Applies scale effect dynamically
//             child: child,
//           );
//         },
//         child: Stack(
//           alignment: Alignment.bottomCenter, // Positions overlay at the bottom
//           children: [
//             // Image with hover scale effect
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8), // Rounded corners for aesthetics
//               child: Image.asset(
//                 widget.services["image"]!, 
//                 width: 200,
//                 height: 400,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             // Bottom overlay with profession title appearing on hover
//             AnimatedPositioned(
//               duration: Duration(milliseconds: 300), // Smooth slide-up animation
//               bottom: isHovered ? 0 : -30, // Moves up when hovered
//               left: 0,
//               right: 0,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8),
//                 ), // Rounded corners only at the bottom
//                 child: Container(
//                   height: 30,
//                   color: GlobalColors.fourthColor, 
//                   alignment: Alignment.center, 
//                   child: Text(
//                     widget.services["title"]!,
//                     style: TextStyle(
//                       color: GlobalColors.thirdColor,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

