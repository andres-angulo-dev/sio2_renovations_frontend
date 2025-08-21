import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_others.dart';
import '../../utils/global_screen_sizes.dart';

class CompanyProfileSection extends StatefulWidget {
  const CompanyProfileSection({super.key});

  @override  
  CompanyProfileSectionState createState() => CompanyProfileSectionState();
}

class CompanyProfileSectionState extends State<CompanyProfileSection> {
  bool _showSection = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 40.0,
        runSpacing: 20.0,
        children: [
          SizedBox(
            width: 600.0,
            child: VisibilityDetector(
              key: const Key('company_profile_about'), 
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.3) {
                  setState(() {
                    _showSection = true;
                  });
                }
              },
              child: AnimatedOpacity(
                opacity: _showSection ? 1.0 : 0.0, 
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
                              fontSize: GlobalScreenSizes.isMobileScreen(context) ? GlobalSize.mobileTitle: GlobalSize.webTitle,
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
                              fontSize: GlobalScreenSizes.isMobileScreen(context) ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
          SizedBox(
            width: 600.0,
            child: Center(
              child: Container(
                height: 600.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(GlobalImages.imageCompanyProfileSection),
                    fit: BoxFit.cover,
                  )
                ),
              )
            )
          ),
        ]
      );
  }
}