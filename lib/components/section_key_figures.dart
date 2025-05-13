import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../components/my_google_map.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';
import '../utils/global_sizes.dart';

class KeyFiguresSection extends StatefulWidget {
  const KeyFiguresSection({super.key});

  @override 
  KeyFiguresSectionState createState() => KeyFiguresSectionState();
}

class KeyFiguresSectionState extends State<KeyFiguresSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;

    // Function to create animated number display
  Widget _buildAnimatedStat(int finalValue, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated counter effect
          if (_isVisible) // Starts animation only if section is visible
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: finalValue),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              return Text(
                finalValue == 95 ? "$value%" : "$value", // Adds % for satisfaction rate
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: GlobalColors.thirdColor),
              );
            },
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 5),
          Text(description, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key("key_figures_section"), 
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_isVisible) {
          setState(() {
            _isVisible = true; // Animation starts only when 50% of the section is visible
          });
        } 
      },
      child: SizedBox(
        width: 1400.0,
        child: Column(
          children: [
            Text(
              "SIO2 RÉNOVATIONS EN QUELQUES CHIFFRES",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: GlobalColors.thirdColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAnimatedStat(
                        10, 
                        "Corps de métier réunis", 
                        "Des artisans qualifiés : électriciens, plombiers, chauffagistes, carreleurs, plaquistes, peintres, maçons…"
                      ),
                      _buildAnimatedStat(
                        30, 
                        "Ans d'expérience", 
                        "Une solide expérience en rénovation, avec des équipes formées pour intervenir efficacement sur l’ensemble de l’Île-de-France."
                      ),
                      _buildAnimatedStat(
                        48, 
                        "Projets réalisés depuis le début d'année", 
                        "Chaque chantier est une nouvelle opportunité de satisfaire nos clients et d’améliorer leur espace de vie."
                      ),
                      _buildAnimatedStat(
                        3360, 
                        "m² rénovés ces derniers mois", 
                        "Des surfaces transformées avec soin et professionnalisme pour des habitats modernisés et fonctionnels."
                      ),
                    ],
                  )
                ),
                const SizedBox(width: 50.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Découvrez en un coup d'oeil, nos dernières réalisations",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        height: 600.0,
                        width: 600.0,
                        child: MyGoogleMap(),
                      )
                    ],
                  )
                )
              ],
            )
          ],
        )
      ) 
    );
  }
}