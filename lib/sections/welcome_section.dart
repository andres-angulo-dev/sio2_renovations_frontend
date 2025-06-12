// Animation Typewrite effect
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; 
import '../components/my_rive_button.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: screenWidth,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: screenWidth * 0.9,
          padding: EdgeInsets.all(32.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: GlobalScreenSizes.isMobileScreen(context) ? WrapAlignment.center : WrapAlignment.spaceBetween,
            spacing: 10.0,
            runSpacing: 30.0,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: GlobalScreenSizes.isMobileScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SIO2 RÉNOVATIONS",
                      style: TextStyle(
                        color: GlobalColors.firstColor,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: GlobalColors.firstColor,
                        fontSize: 22.0,
                      ),
                      child: AnimatedTextKit(
                        totalRepeatCount: 1, // Play the animation only once
                        pause: Duration(milliseconds: 1000), // Pause between texts
                        animatedTexts: [
                          TypewriterAnimatedText( // Displaying the slogan
                            "Donner une nouvelle vie à votre espace, c’est notre métier.", 
                            speed: Duration(milliseconds: 90),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 20.0,
                  runSpacing: 10.0,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: MyRiveButton(
                        enableCursor: false,
                        buttonPath: GlobalButtonsAndIcons.callUsButton,
                      ),
                    ),
                    if (!GlobalScreenSizes.isCustomSize(context, 450))
                      Container(
                        height: 60.0,
                        width: 1.0,
                        color: Colors.white,
                      ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: MyRiveButton(
                        onPressed: () => Navigator.pushNamed(context, '/contact'),
                        buttonPath: GlobalButtonsAndIcons.freeQuoteButton,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// // Transition with Fade out particle and Animated opacity widget
// import 'package:flutter/material.dart';
// import 'package:fade_out_particle/fade_out_particle.dart';
// import '../components/my_rive_button.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_screen_sizes.dart';

// class WelcomeSection extends StatefulWidget {
//   const WelcomeSection({super.key});

//   @override
//   WelcomeSectionState createState() => WelcomeSectionState();
// }

// class WelcomeSectionState extends State<WelcomeSection> {
//   bool _showWelcome = true;
//   bool _showSlogan = false;
//   bool _startFadeOut = false;

//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//   }

//   void _startAnimation() {
//     Future.delayed(Duration(seconds: 3), () {
//       setState(() {
//         _startFadeOut = true; // Launches the particle effect
//       });

//       Future.delayed(Duration(milliseconds: 2000), () {
//         setState(() {
//           _showWelcome = false; // Switch to slogan display
//         });

//         // Activates the progressive display of the slogan
//         Future.delayed(Duration(milliseconds: 1000), () { 
//           setState(() {
//             _showSlogan = true;
//           });
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       width: screenWidth,
//       child: Align(
//         alignment: Alignment.center,
//         child: Container(
//           width: screenWidth * 0.9,
//           padding: EdgeInsets.all(32.0),
//           child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             alignment: GlobalScreenSizes.isMobileScreen(context) ? WrapAlignment.center : WrapAlignment.spaceBetween,
//             spacing: 10.0,
//             runSpacing: 30.0,
//             children: [
//               SizedBox(
//                 child: Column(
//                   crossAxisAlignment: GlobalScreenSizes.isMobileScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "SIO2 RÉNOVATIONS",
//                       style: TextStyle(
//                         color: GlobalColors.firstColor,
//                         fontSize: 32.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     _showWelcome 
//                     ? FadeOutParticle( // Apply the effect to "Welcome"
//                       disappear: _startFadeOut,
//                       duration: Duration(milliseconds: 2500),
//                       child: Text(
//                         "Bienvenue",
//                         style: TextStyle(
//                           color: GlobalColors.firstColor,
//                           fontSize: 22.0,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     )
//                     : AnimatedOpacity( // Adds a fade effect for the slogan
//                       duration: Duration(milliseconds: 1500),
//                       opacity: _showSlogan ? 1.0 : 0.0,
//                       child: Text(
//                         "Donner une nouvelle vie à votre espace, c’est notre métier.",
//                         style: TextStyle(
//                           color: GlobalColors.firstColor,
//                           fontSize: 22.0,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 20.0),
//               SizedBox(
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   spacing: 20.0,
//                   runSpacing: 10.0,
//                   children: [
//                     SizedBox(
//                       width: 150,
//                       height: 50,
//                       child: MyRiveButton(
//                         enableCursor: false,
//                         buttonPath: GlobalButtonsAndIcons.callUsButton,
//                       ),
//                     ),
//                     if (!GlobalScreenSizes.isCustomSize(context, 450))
//                       Container(
//                         height: 60.0,
//                         width: 1.0,
//                         color: Colors.white,
//                       ),
//                     SizedBox(
//                       width: 150,
//                       height: 50,
//                       child: MyRiveButton(
//                         onPressed: () => Navigator.pushNamed(context, '/contact'),
//                         buttonPath: GlobalButtonsAndIcons.freeQuoteButton,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







// // No effect 
// import 'package:flutter/material.dart';
// import '../components/my_rive_button.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_screen_sizes.dart';

// class WelcomeSection extends StatelessWidget {
//   const WelcomeSection({super.key});

//   @override 
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return  SizedBox(
//       height: MediaQuery.of(context).size.height,
//       width: screenWidth,
//       child: Align(
//       alignment: Alignment.center,
//       child: Container(
//         width: screenWidth * 0.9,
//         padding: EdgeInsets.all(32.0),
//         child: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           alignment : GlobalScreenSizes.isMobileScreen(context) ? WrapAlignment.center : WrapAlignment.spaceBetween,
//           spacing: 10.0,
//           runSpacing: 30.0,
//           children: [
//             SizedBox(
//               child: Column(
//                 crossAxisAlignment: GlobalScreenSizes.isMobileScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "SIO2 RÉNOVATIONS",
//                     style: TextStyle(
//                       color: GlobalColors.firstColor,
//                       fontSize: 32.0,
//                       fontWeight: FontWeight.bold
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "Donner une nouvelle vie à votre espace, c’est notre métier.",
//                     style: TextStyle(
//                       color: GlobalColors.firstColor,
//                       fontSize: 22.0,
//                     ),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(width: 20.0,),
//             SizedBox(
//               child: Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 spacing: 20.0,
//                 runSpacing: 10.0,
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     height: 50,
//                     child: MyRiveButton(
//                       enableCursor: false,
//                       buttonPath: GlobalButtonsAndIcons.callUsButton
//                     ),
//                   ),
//                   if (!GlobalScreenSizes.isCustomSize(context, 450)) Container(
//                     height: 60.0,
//                     width: 1.0,
//                     color: Colors.white,
//                   ), 
//                   SizedBox(
//                     width: 150,
//                     height: 50,
//                     child: MyRiveButton(
//                       onPressed: () => Navigator.pushNamed(context, '/contact'), 
//                       buttonPath: GlobalButtonsAndIcons.freeQuoteButton
//                     ),
//                   ),
//                 ],
//               )
//             )
//           ]),
//         )                             
//       )
//     );
//   }
// }
