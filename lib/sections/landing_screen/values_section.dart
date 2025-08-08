import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_others.dart';
import '../../utils/global_screen_sizes.dart';

class ValuesSection extends StatefulWidget {
  const ValuesSection({super.key});

  @override   
  ValuesSectionState createState() => ValuesSectionState();
}
class ValuesSectionState extends State<ValuesSection> with TickerProviderStateMixin{
  // AnimationController: Manages the timing of the animations.
  late List<AnimationController> _animationControllers;
  // Animation<double>: Handles the fade-in effect for text (controls opacity effect).
  late List<Animation<double>> _fadeAnimations;
  // Animation<double>: Handles the fade-in effect for text (controls scale effect.
  late List<Animation<double>> _scaleAnimations;

  bool _showSection = false;

  @override
  void initState() {
    super.initState();

    _initializeAnimations(); // Run animations
  }

  // Handle animations
  void _initializeAnimations() {
    _animationControllers = List.generate(4, (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    ));

    _fadeAnimations = _animationControllers.map((controller) => Tween<double>(
      begin: 0.0, 
      end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInOut,
    ))).toList();

    _scaleAnimations = _animationControllers.map((controller) => Tween<double>(
      begin: 1.4,
      end: 1.0 
      ).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInCirc,
    ))).toList();
  }

  void _startAnimations() {
    for (int i=0; i < _animationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 600), () {
        if (mounted) {
          setState(() {
            _animationControllers[i].forward();
          });
        }
      });
    }
  }

 // Disposes of the animation controller to prevent memory leaks.
  @override  
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override  
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
      child: VisibilityDetector(
        key: const Key("section_values"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.3 && !_showSection) {
            setState(() {
              _showSection = true;
            });
            _startAnimations(); // Start animations sequentially
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title with fade effect
              AnimatedOpacity(
                opacity: _showSection ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  "NOS VALEURS",
                  style: TextStyle(
                    fontSize: GlobalScreenSizes.isMobileScreen(context) ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.thirdColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60.0),
              // Wrap containing animated columns
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 60.0,
                runSpacing: 40.0,
                children: List.generate(4, (index) => SizedBox(
                  width: 300.0,
                  child: AnimatedBuilder(
                    animation: _animationControllers[index], // use separate controller for each column
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimations[index], // individual fade animation
                        child: ScaleTransition(
                          scale: _scaleAnimations[index], // individual scale animation
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        // Dinamic icons
                        SvgPicture.asset(
                          [
                            GlobalLogosAndIcons.engagement,
                            GlobalLogosAndIcons.call,
                            GlobalLogosAndIcons.structured,
                            GlobalLogosAndIcons.customer
                          ][index],
                          width: 100,
                          height: 100,
                          semanticsLabel: [
                            'A handshake symbol, representing partnership and commitment.', 
                            'A bust silhouette wearing a headset, with an internet globe symbol below, representing communication and global connectivity.', 
                            'An organizational chart-like structure with bust silhouettes and a gear icon at the top, symbolizing the organizational structure and efficiency of the company', 
                            'An open hand containing a comment represented by wavy lines inside a circle and five stars forming a semicircle above, representing customer feedback and satisfaction.'
                          ][index],
                        ),
                        const SizedBox(height: 10.0),
                        // Dynamic title
                        Text(
                          ["Engagement", "Écoute", "Savoir-faire", "Confiance"][index],
                          style: TextStyle(
                            fontSize: GlobalScreenSizes.isMobileScreen(context) ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle, 
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30.0),
                        // Dynamic description
                        Text(
                          [
                            "Nous croyons en une collaboration sans surprise, portée par un engagement total. Chaque détail est anticipé et maîtrisé. De l’offre chiffrée aux mises à jour en temps réel, nous assurons un suivi précis et rigoureux à chaque étape de votre projet.",
                            "Nous sommes à vos côtés pour vous guider et vous conseiller. Un interlocuteur unique vous accompagne tout au long des travaux, avec disponibilité et réactivité pour vous assurer une expérience sereine et sans stress.",
                            "Grâce à notre expertise et à une équipe structurée, nous réalisons chaque projet avec rigueur et excellence. Une organisation méthodique et des compétences maîtrisées garantissent des travaux de haute qualité, dans le respect des normes et des délais.",
                            "La satisfaction client et au cœur de notre démarche. Plus qu’un simple projet, nous construisons une relation de confiance durable, où vos recommandations sont la plus belle preuve de notre engagement et de la qualité de notre travail."
                          ][index],
                          style: TextStyle(fontSize: GlobalScreenSizes.isMobileScreen(context) ? GlobalSize.mobileSizeText : GlobalSize.webSizeText),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        )
      ),
    );
  }
}