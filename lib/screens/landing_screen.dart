import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';
import '../components/carousel_slider_component.dart';
import 'dart:ui'; // Import for the blur effect.

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  final bool mobile = false;
  bool show = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        show = true;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Libérer les ressources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(),
      // endDrawer: mobile ? DrawerComponent() : null,
      backgroundColor: GlobalColors.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Background image container
                    Container(
                      height: availableHeight,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/immeuble.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Blur effect over the image
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0, // Horizontal blur intensity
                          sigmaY: 5.0, // Vertical blur intensity
                        ),
                        child: Container(
                          color: Colors.transparent, // Transparent overlay
                        ),
                      ),
                    ),
                    // Foreground content
                    Positioned.fill(
                      child: Column(
                        children: [
                          if (show)
                            Flexible(
                              flex: 3,
                              child: RiveAnimation.asset(
                                "assets/rive/work_in_progress.riv",
                              ),
                            ),

                          Flexible(
                            flex: 1,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: SlideTransition(
                              position: _slideAnimation,
                                child: Text(
                                  'EN CONSTRUCTION !',
                                  style: TextStyle(
                                    fontSize: mobile ? 24.0 : 34.0,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),  
                            )
                          ),

                          Expanded(child:SizedBox()),

                          AnimatedOpacity(
                            opacity: show ? 1.0 : 0.0, // Opacité basée sur l'état
                            duration: const Duration(seconds: 2), // Durée de l'animation fade
                            child: show
                                ? Flexible(
                                    flex: 10,
                                    child: CarouselSliderComponent(),
                                  )
                                : const SizedBox(), // Widget vide avant l'apparition
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
