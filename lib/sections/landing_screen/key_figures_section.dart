import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../widgets/my_google_map_widget.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_others.dart';
import '../../utils/global_screen_sizes.dart';

class KeyFiguresSection extends StatefulWidget {
  const KeyFiguresSection({super.key});

  @override 
  KeyFiguresSectionState createState() => KeyFiguresSectionState();
}

class KeyFiguresSectionState extends State<KeyFiguresSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  // Function to create animated number display
  Widget _buildAnimatedStat(int finalValue, String title, String description) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    
    Map<String, String> formatStat(int counterValue, int finalValue) {
      String prefix = '';
      String suffix = '';

      if (finalValue == 30) prefix = '+';
      if (finalValue == 30) suffix = ' ans';
      if (finalValue == 3360) suffix = ' m²';

      return {
        "prefix" : prefix,
        'value': "$counterValue",
        'suffix': suffix,
      };
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated counter effect
          if (_isVisible) // Starts animation only if section is visible
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: finalValue),
            duration: Duration(seconds: 3),
            builder: (context, counterValue, child) {
              final parts = formatStat(counterValue, finalValue);

              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: parts['prefix'],
                      style: TextStyle(
                        fontSize: isMobile
                          ? GlobalSize.keyFiguresSectionMobileTitle
                          : GlobalSize.keyFiguresSectionWebTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.thirdColor,
                      ),
                    ),
                    TextSpan(
                      text: parts['value'],
                      style: TextStyle(
                        fontSize: isMobile
                          ? GlobalSize.keyFiguresSectionMobileTitle
                          : GlobalSize.keyFiguresSectionWebTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.thirdColor,
                      ),
                    ),
                    TextSpan(
                      text: parts['suffix'],
                      style: TextStyle(
                        fontSize: isMobile
                          ? GlobalSize.keyFiguresSectionSuffixMobileTitle
                          : GlobalSize.keyFiguresSectionSuffixWebTitle,
                        fontWeight: FontWeight.w400,
                        color: GlobalColors.thirdColor
                      ),
                    ),
                  ],
                ),
              ); 
            },
          ),
          const SizedBox(height: 5.0),
          Text(
            title, 
            style: TextStyle(
              fontSize: isMobile ? GlobalSize.keyFiguresSectionMobileSubTitle : GlobalSize.keyFiguresSectionWebSubTitle, 
              fontWeight: FontWeight.w600
            )
          ),
          const SizedBox(height: 5.0),
          Text(
            description, 
            textAlign: TextAlign.start, 
            style: TextStyle(
              fontSize: isMobile ? GlobalSize.keyFiguresSectionMobileDescription : GlobalSize.keyFiguresSectionWebDescription, 
              color: GlobalColors.fifthColor
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    
    return VisibilityDetector(
      key: const Key("key_figures_section"), 
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true; // Animation starts only when XX% of the section is visible
          });
        } 
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        child: SizedBox(
          // width: 1400.0,
          child: Column(
            children: [
              Text(
                "${GlobalPersonalData.companyPrefixName} RÉNOVATIONS EN QUELQUES CHIFFRES",
                style: TextStyle(
                  fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.thirdColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50.0),
              Wrap(
                spacing: 100.0,
                runSpacing: 50.0,
                alignment: WrapAlignment.center,
                children: [
                  // Left block: key figures
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAnimatedStat(
                          10, 
                          "corps de métier réunis", 
                          "Des artisans qualifiés : électriciens, plombiers, chauffagistes, carreleurs, plaquistes, peintres, maçons…"
                        ),
                        _buildAnimatedStat(
                          30, 
                          "d'expérience", 
                          "Une solide expérience en rénovation, avec des équipes formées pour intervenir efficacement sur l’ensemble de l’Île-de-France."
                        ),
                        _buildAnimatedStat(
                          48, 
                          "projets réalisés depuis le début d'année", 
                          "Chaque chantier est une nouvelle opportunité de satisfaire nos clients et d’améliorer leur espace de vie."
                        ),
                        _buildAnimatedStat(
                          3360, 
                          "rénovés ces derniers mois", 
                          "Des surfaces transformées avec soin et professionnalisme pour des habitats modernisés et fonctionnels."
                        ),
                      ],
                    ),
                  ),
                  // Right bloc: Google Maps
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Découvrez en un coup d'oeil, nos dernières réalisations",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        height: 600.0,
                        width: 600.0,
                        child: MyGoogleMapWidget(),
                      )
                    ],
                  ) 
                ],
              )
            ],
          )
        ) 
      )
    );
  }
}