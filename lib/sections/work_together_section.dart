import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class WorkTogetherSection  extends StatefulWidget{
  const WorkTogetherSection({super.key});

  @override
  WorkTogetherSectionState createState() => WorkTogetherSectionState();
}

class WorkTogetherSectionState extends State<WorkTogetherSection> {

  @override  
  Widget build(BuildContext context) {
    final bool mobile = GlobalScreenSizes.isMobileScreen(context);
    final screenSize = GlobalScreenSizes.screenWidth(context);

    return Stack(
      alignment: mobile ? AlignmentDirectional.center : AlignmentDirectional.centerEnd, // Center content
      children: [
        Container(
          width: screenSize,
          height: 600.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                GlobalImages.backgroundWorkTogetherSection,
              ),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          right: GlobalScreenSizes.isCustomSize(context, 1050.0) ? null : mobile ? null : 200.0,
          child: Container(
            constraints: BoxConstraints(maxWidth: 600.0),
            padding: EdgeInsets.all(mobile ? 24.0 : 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              crossAxisAlignment: CrossAxisAlignment.center, // Center content
              children: [
                // Title
                Text(
                  "AUTONOMIE ET COLLABORATION",
                  style: TextStyle(
                    fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.thirdColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20), // Space between
                // Description
                Text(
                  "Notre entreprise de rénovations se distingue par sa capacité à mener à bien des projets de A à Z de manière autonome tout en étant parfaitement à l’aise pour collaborer avec des partenaires tels que des architectes, décorateurs d’intérieur ou bureaux d’étude selon le client. "
                  "Nous savons conjuguer indépendance et travail d’équipe, en nous adaptant à chaque projet et en collaborant étroitement avec tous les acteurs impliqués pour garantir un résultat à la hauteur de vos attentes.",
                  style: TextStyle(
                    fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                    color: GlobalColors.secondColor
                  ),
                  textAlign: TextAlign.center,
                ),
              ]
            )
          )
        )
      ],
    );
  }
}