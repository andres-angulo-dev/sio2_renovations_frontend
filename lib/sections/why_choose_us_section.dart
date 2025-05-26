import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';

class WhyChooseUsSection extends StatefulWidget {
  const WhyChooseUsSection({super.key});

  @override 
  WhyChooseUsSectionState createState() => WhyChooseUsSectionState();
}

class WhyChooseUsSectionState extends State<WhyChooseUsSection> with SingleTickerProviderStateMixin {
  late AnimationController _whyChooseUsController;
  late Animation<double> _whyChooseUsFadeAnimation;

  @override  
  void initState() {
    super.initState();

    _whyChooseUsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),  
    );

    _whyChooseUsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _whyChooseUsController, 
      curve: Curves.easeInOut,
    ));
  }

  @override 
  void dispose() {
    _whyChooseUsController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return VisibilityDetector(
      key: const Key("why_choose_us_section"), 
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          _whyChooseUsController.forward();
        }
      },
      child: Stack(
        children: [ 
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [GlobalColors.fourthColor, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FadeTransition(
              opacity: _whyChooseUsFadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "CONFIEZ-NOUS VOTRE PROJET EN TOUTE SÉRÉNITÉ",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.thirdColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Sub-title
                  SizedBox(
                    width: 800.0,
                    child: Text(
                      "Chez SIO2 Rénovations, chaque rénovation est menée avec rigueur et professionnalisme. Nous comprenons l’importance d’un projet bien encadré et nous nous engageons à offrir une expérience fluide et maîtrisée, du premier échange jusqu’à la livraison finale.",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Key Points
                  SizedBox(
                    width: 1000.0,
                    child: Column(
                      children: [
                  _buildKeyPoint(
                    Icons.verified_user,
                    "Une gestion précise et efficace",
                    "Nos méthodes de travail garantissent un suivi rigoureux et une parfaite maîtrise des délais, du budget et de la qualité. Chaque étape est planifiée avec soin pour éviter toute surprise.",
                  ),
                  _buildKeyPoint(
                    Icons.person,
                    "Un accompagnement sur mesure",
                    "Nous prenons le temps d’analyser votre projet en profondeur afin de vous proposer des solutions adaptées. Vous bénéficiez d’un interlocuteur unique, à l’écoute de vos attentes et toujours disponible pour répondre à vos questions.",
                  ),
                  _buildKeyPoint(
                    Icons.workspace_premium,
                    "Un savoir-faire reconnu",
                    "Avec plusieurs centaines de chantiers réalisés, nous maîtrisons une large gamme de rénovation. Notre expertise nous permet d’anticiper les contraintes et de garantir des travaux impeccables.",
                  ),

                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          Positioned.fill(
            child:CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),     
        ]
      ),
    );
  }  
  // Helper function to build key points
  Widget _buildKeyPoint(IconData icon, String title, String description) {
    return FadeTransition(
      opacity: _whyChooseUsFadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: GlobalColors.thirdColor),
            const SizedBox(width: 10),
            Expanded(
              child:            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: GlobalColors.thirdColor
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.black87
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            )
          ],
        )
      )
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    // First rounded curve at the top
    Path path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height * 0.1, size.width, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);

    // Second rounded curve at the bottom
    path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, size.height * 0.9, size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}