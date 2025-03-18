// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import '../components/my_app_bar_component.dart';
// import '../components/drawer_component.dart';
// import '../utils/global_colors.dart';
// import '../components/carousel_slider_component.dart';

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   LandingScreenState createState() => LandingScreenState();
// }

// class LandingScreenState extends State<LandingScreen> {

//   final bool mobile = false;
  
//   @override
//   Widget build(BuildContext context) {

//     final screenWidth = MediaQuery.of(context).size.width;
//     final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

//     return Scaffold(
//       appBar: MyAppBar(),
//       endDrawer: mobile ? DrawerComponent() : null,
//       backgroundColor: GlobalColors.primaryColor,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableHeight = constraints.maxHeight;

//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: availableHeight,
//                   width: screenWidth,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/immeuble.jpeg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Flexible(
//                         flex: 1,
//                         child: Text(
//                           'Site en construction !',
//                           style: TextStyle(
//                             fontSize: 34.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           )
//                         )
//                       ),
//                       Flexible(
//                         flex: 3,
//                         child: RiveAnimation.asset(
//                         "assets/rive/work_in_progress.riv",
//                         ),
//                       ),
//                       Flexible(flex: 10, child: CarouselSliderComponent()),
//                     ],
//                   )
//                 //   child: Center(
//                 //     child: Text(
//                 //       'Bienvenue sur le site !',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 32.0,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //       textAlign: TextAlign.center,
//                 //     ),
//                 //   ),
//                 // ),
//                 // Row (
//                 //   children: [
//                 //     Expanded(
//                 //       child: Container(
//                 //         height: 400.0,
//                 //         color: Colors.red
//                 //       )
//                 //     ),
//                 //     Expanded(
//                 //       child: Container(
//                 //         height: 400.0,
//                 //         color: Colors.yellow
//                 //       )
//                 //     ),
//                 //   ]
//                 ),
//               ],
//             )
//           ); 
//         }
//       ),
//     );
//   }
// }

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

class LandingScreenState extends State<LandingScreen> {
  final bool mobile = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: mobile ? DrawerComponent() : null,
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
                          Flexible(
                            flex: 1,
                            child: Text(
                              'Site en construction !',
                              style: const TextStyle(
                                fontSize: 34.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: RiveAnimation.asset(
                              "assets/rive/work_in_progress.riv",
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            child: CarouselSliderComponent(),
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
