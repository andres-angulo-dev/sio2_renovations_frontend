import 'package:flutter/material.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_others.dart';
import '../../utils/global_screen_sizes.dart';

class WorkTogetherSection  extends StatefulWidget{
  const WorkTogetherSection({super.key});

  @override
  WorkTogetherSectionState createState() => WorkTogetherSectionState();
}

class WorkTogetherSectionState extends State<WorkTogetherSection> {

  @override  
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    final screenSize = GlobalScreenSizes.screenWidth(context);

    return Stack(
      alignment: isMobile ? AlignmentDirectional.center : AlignmentDirectional.centerEnd, // Center content
      children: [
        Container(
          width: screenSize,
          height: 600.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                GlobalImages.workTogetherSection,
              ),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          right: GlobalScreenSizes.isCustomSize(context, 1050.0) ? null : isMobile ? null : 200.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 600.0),
              padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
              color: isMobile ? GlobalColors.firstColor.withValues(alpha: 0.5) : null,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                crossAxisAlignment: CrossAxisAlignment.center, // Center content
                children: [
                  // Title
                  Text(
                    "AUTONOMIE ET COLLABORATION",
                    style: TextStyle(
                      fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.thirdColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0), // Space between
                  // Description
                  Text(
                    "Notre entreprise de rénovations se distingue par sa capacité à mener à bien des projets dans leur globalité, en toute autonomie tout en étant parfaitement à l’aise pour collaborer avec des partenaires selon le besoin et la volonté du client. "
                    "Nous savons conjuguer indépendance et travail d’équipe, en nous adaptant à chaque projet et en collaborant étroitement avec tous les acteurs impliqués pour garantir un résultat à la hauteur de vos attentes.",
                    style: TextStyle(
                      fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                      color: GlobalColors.secondColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0), // Space between
                  // Partners
                  Text(
                    "NOS PARTENAIRES",
                    style: TextStyle(
                      fontSize: isMobile ? GlobalSize.footerMobileSubTitle: GlobalSize.footerWebSubTitle,
                      color: GlobalColors.thirdColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Architectes, Assureurs, Décorateurs d’intérieur, Bureaux d’étude, Syndics ect...",
                    style: TextStyle(
                      fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                      color: GlobalColors.secondColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            ) 
          )
        )
      ],
    );
  }
}