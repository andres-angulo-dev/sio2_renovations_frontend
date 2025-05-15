// DEFILEMENT AVEC SHIFT + ROULETTE 
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
//           // 📌 Titre principal
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

//           // 📌 Sous-titre
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

//           // 📌 Conteneur scrollable des quatre cartes côte à côte
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal, // ✅ Permet le défilement horizontal
//             child: Row(
//               children: List.generate(4, (index) => _buildProjectCard(index)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Fonction qui génère une carte avec une nuance de couleur
//   Widget _buildProjectCard(int index) {
//     // 🔹 Dégradé de couleurs (nuances progressives)
//     final List<Color> gradientColors = [
//       Colors.blue.shade900, // Plus foncé
//       Colors.blue.shade700,
//       Colors.blue.shade500,
//       Colors.blue.shade300, // Plus clair
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0), // ✅ Ajoute un espace entre les cartes
//       child: Card(
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: gradientColors[index], // ✅ Couleur en fonction du dégradé
//         child: SizedBox(
//           width: 300, // ✅ Taille fixe des cartes
//           height: 500,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center, // ✅ Centrage du contenu
//               children: [
//                 Icon(Icons.check_circle, size: 40, color: Colors.white), // ✅ Icône illustrative
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

import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../components/my_rive_button.dart';
import '../utils/global_others.dart';

class StepsSection extends StatefulWidget {
  const StepsSection({super.key});

  @override
  StepsSectionState createState() => StepsSectionState();
}

class StepsSectionState extends State<StepsSection> {
  final ScrollController _scrollController = ScrollController(); // ✅ ScrollController pour gérer le scroll
  double _scrollOffset = 0.0; // ✅ Variable pour suivre le défilement manuel

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 📌 Titre principal
          Text(
            "VOUS AVEZ UN PROJET ?",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: GlobalColors.thirdColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),

          // 📌 Sous-titre
          Text(
            "Votre parcours en quatre temps",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          // 📌 Conteneur scrollable avec drag-scroll
          GestureDetector(
            onHorizontalDragUpdate: (details) { // ✅ Capture le mouvement horizontal de la souris
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
              controller: _scrollController, // ✅ Ajout du controller
              child: Row(
                children: List.generate(4, (index) => _buildProjectCard(index)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Fonction qui génère une carte avec une nuance de couleur
  Widget _buildProjectCard(int index) {
    final List<Color> gradientColors = [
      Color(0xFF892323), // Rouge foncé
      Color(0xFF455A64), // Gris foncé
      Color(0xFF880E4F), // Bordeaux
      Color.fromARGB(255, 165, 127, 78), // Couleur principale
      // Color.fromARGB(255, 120, 85, 50), // Brun chocolat (foncé)
      // Color(0xFF00897B), // Vert foncé
      // Color(0xFFF57C00), // Orange brûlé
    ];

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: gradientColors[index], // ✅ Dégradé progressif
        child: SizedBox(
          width: 300,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📌 Rectangle positionné en haut à gauche
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
                          "${index + 1}",
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 52.0,
                            fontWeight: FontWeight.bold,
                            color: gradientColors[index],
                          ),
                        ),
                      ),
                    ),
                  ),  
                ),
                // ✅ Ajout d'un espace avant le texte
                // Spacer(),
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sub-title
                      Text(
                        stepData[index]["description"]!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      // ✅ Vérifie si l'index est 0, alors ajoute un bouton
                      if (index == 0) ...[
                        SizedBox(height: 20),
                        // TextButton(
                        //   onPressed: () {
                        //   // ✅ Ajoute ici la logique pour le bouton (ex: navigation, popup, etc.)
                        //   },
                        //   style: TextButton.styleFrom(
                        //     backgroundColor: Colors.white, // 
                        //     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        //   ),
                        //   child: Text(
                        //     "En savoir plus",
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //       color: gradientColors[index], // ✅ Couleur du texte correspondant à la carte
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 60,
                          width:  120,
                          child: MyRiveButton(
                            onPressed: () => Navigator.pushNamed(context, ('/contact')), 
                            buttonPath: GlobalButtonsAndIcons.contactButtonWithReverse,
                          )
                        ),
                      ]
                    ],
                  ),
                ),
                // SizedBox(height: 45),
              ],
            ),
          ),
        ),
      )
    );
  }
}
