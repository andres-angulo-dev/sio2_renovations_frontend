import 'package:flutter/material.dart';
import 'package:sio2_renovations_frontend/utils/global_screen_sizes.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';
import '../components/my_rive_button.dart';
import '../utils/global_others.dart';

class StepsSection extends StatefulWidget {
  const StepsSection({super.key});

  @override
  StepsSectionState createState() => StepsSectionState();
}

class StepsSectionState extends State<StepsSection> {
  final ScrollController _scrollController = ScrollController(); // ScrollController to handle horizontal scrolling
  double _scrollOffset = 0.0; // Variable to track manual scrolling offset
  double _progress = 0.0; // ✅ Variable pour stocker la progression du scroll
  bool showProgressBar = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() { // ✅ Met à jour la barre de progression à chaque mouvement
      setState(() {
        _progress = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main title
          Text(
            "VOUS AVEZ UN PROJET ?", 
            style: TextStyle(
              fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
              fontWeight: FontWeight.bold,
              color: GlobalColors.thirdColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          // Subtitle
          Text(
            "Votre parcours en quatre temps", 
            style: TextStyle(
              fontSize: isMobile ? GlobalSize.stepsSectionMobilebSubTitle : GlobalSize.stepsSectionWebSubTitle,
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          // Scrollable container with drag-scroll
          GestureDetector(
            onHorizontalDragUpdate: (details) { // Detects horizontal mouse drag movement
              setState(() {
                _scrollOffset -= details.primaryDelta ?? 0.0;
                _scrollController.jumpTo(_scrollOffset.clamp(
                  _scrollController.position.minScrollExtent,
                  _scrollController.position.maxScrollExtent,
                ));
              });
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController, // Enables manual scrolling
              child: Row(
                children: List.generate(4, (index) => _buildProjectCard(index)), // Generates project cards dynamically
              ),
            ),
          ),
          if (GlobalScreenSizes.isCustomSize(context, 1067))
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // ✅ Bords arrondis pour un effet moderne
              child: Container(
                width: 150, // ✅ Largeur contrôlée
                height: 8, // ✅ Épaisseur fine et élégante
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // ✅ Couleur de fond discrète
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FractionallySizedBox(
                  widthFactor: _progress, // ✅ Ajuste la largeur en fonction du scroll
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.thirdColor, // ✅ Couleur principale
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Function to generate a project card with color gradient
  Widget _buildProjectCard(int index) {
    final List<Color> gradientColors = [
      Color(0xFF892323), // Dark red
      Color(0xFF455A64), // Dark gray
      Color(0xFF880E4F), // Deep magenta
      Color.fromARGB(255, 165, 127, 78), // Primary color
    ];

    // ✅ List storing unique titles and descriptions for each step
    final List<Map<String, String>> stepData = [
      {
        "title": "Décrivez votre projet", 
        "description": "Indiquez-nous vos besoins, vos préférences et les spécificités de votre rénovation. "
      },
      {
        "title": "Le devis détaillé", 
        "description": "Nous examinons votre projet attentivement, avec un retour sous 48h."
      },
      {
        "title": "Validation et planification", 
        "description": "Après une visite des lieux, divers échanges et le devis validé, nous planifions chaque étape du chantier."
      },
      {
        "title": "Début des travaux", 
        "description": "Place à la transformation ! Votre projet prend vie sous vos yeux, étape après étape."
      },
    ];

    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    
    return VisibilityDetector(
      key: Key("card_$index"), 
      onVisibilityChanged: (info) {
          setState(() {
            showProgressBar = info.visibleFraction > 0.1;
          });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: gradientColors[index], // Assigns color based on index for gradient effect
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number rectangle positioned at top-left
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}", // Step number dynamically generated
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: isMobile ? GlobalSize.stepsSectionMobileTitleCard : GlobalSize.stepsSectionWebTitleCard, 
                              fontWeight: FontWeight.bold,
                              color: gradientColors[index], // Matches step number color to card background
                            ),
                          ),
                        ),
                      ),
                    ),  
                  ),
                  // Ensures consistent layout by expanding the text area
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        SizedBox(
                          height: 60.0,
                          child: Text(
                            stepData[index]["title"]!,
                            style: TextStyle(
                              fontSize: isMobile ? GlobalSize.stepsSectionMobileSubTitleCard : GlobalSize.stepsSectionWebSubTitleCard,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Description
                        Text(
                          stepData[index]["description"]!,
                          style: TextStyle(
                            fontSize: isMobile ? GlobalSize.webSizeText : GlobalSize.webSizeText,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        // Adds button only in the first card (`index == 0`)
                        if (index == 0) ...[
                          SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            width:  120,
                            child: MyRiveButton(
                              onPressed: () => Navigator.pushNamed(context, ('/contact')), // Navigates to contact page
                              buttonPath: GlobalButtonsAndIcons.contactButtonWithReverse,
                            )
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}


// // EXAMPLE OF SCROLLING WITH SHIFT + MOUSE WHEEL ONLY
// import 'package:flutter/material.dart';
// import '../utils/global_colors.dart';

// class StepsSection extends StatelessWidget {
//   const StepsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Main title
//           Text(
//             "VOUS AVEZ UN PROJET ?", 
//             style: TextStyle(
//               fontSize: 30.0,
//               fontWeight: FontWeight.bold,
//               color: GlobalColors.thirdColor,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 10),
//           // Subtitle
//           Text(
//             "Votre parcours en quatre temps", 
//             style: TextStyle(
//               fontSize: 24,
//               fontFamily: 'DancingScript',
//               fontWeight: FontWeight.w800,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 40),
//           // Scrollable container for side-by-side cards
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal, // Enables horizontal scrolling
//             child: Row(
//               children: List.generate(4, (index) => _buildProjectCard(index)), // Generates four cards dynamically
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to generate a card with a gradient color
//   Widget _buildProjectCard(int index) {
//     // Gradient color palette for visual effect
//     final List<Color> gradientColors = [
//       Colors.blue.shade900, // Darkest shade
//       Colors.blue.shade700,
//       Colors.blue.shade500,
//       Colors.blue.shade300, // Lightest shade
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adds spacing between cards
//       child: Card(
//         elevation: 6, // Gives the card a shadow effect
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners for a modern look
//         color: gradientColors[index], // Assigns color based on index for gradient transition
//         child: SizedBox(
//           width: 300, 
//           height: 500, 
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center, // Centers content within the card
//               children: [
//                 Icon(Icons.check_circle, size: 40, color: Colors.white), // Illustrative icon
//                 SizedBox(height: 10),
//                 Text(
//                   "Étape ${index + 1}", 
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Description de l'étape ${index + 1}, expliquant ce qui se passe ici.", 
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white70,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


