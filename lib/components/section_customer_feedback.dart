// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:async';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_sizes.dart';

// class CustomerFeedbackSection extends StatefulWidget {
//   const CustomerFeedbackSection({super.key});

//   @override
//   CustomerFeedbackSectionState createState() => CustomerFeedbackSectionState();
// }

// class CustomerFeedbackSectionState extends State<CustomerFeedbackSection> {
//     // Controls the page scrolling automatic effect for testimonials
//   final PageController _pageController = PageController(viewportFraction: 1);
//   late Timer _timer;
//   int _currentIndex = 0;
  
//   // List of customer testimonials with comment, author, and project title
//   final List<Map<String, String>> feedbacks = [
//     {
//       "comment": "\"Excellente exécution d’un chantier portant sur la rénovation totale d’un appartement. Respect du cahier des charges, des engagements et des quelques aménagements décidés lors de la réalisation. Beau travail et belle équipe.\"",
//       "author": "M. & Mme T. ",
//       "title": "",
//     },
//     {
//       "comment": "\"Travail impeccable et équipe très professionnelle. Mon appartement a été transformé avec beaucoup d’élégance.\"",
//       "author": "Mme B. ",
//       "title": "Rénovation d'un appartement familial - 13ème arrondissement",
//     },
//     {
//       "comment": "\"Un vrai plaisir de voir mon projet réalisé avec autant de soin et de précision ! Bravo à toute l’équipe.\"",
//       "author": "M. D. ",
//       "title": "Modernisation complète d’un loft à République",
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Automatically scroll to the next testimonial every XX seconds
//     _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
//       if (_currentIndex < feedbacks.length - 1) {
//         _currentIndex++; // Move to the next testimonial
//       } else {
//         _currentIndex = 0; // Return to the first testimonial after the last one
//       }
//       // Animate transition between testimonials with a smooth effect
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the timer when the widget is removed to prevent memory leaks
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           "LE TEMOIGNAGE DE NOS CLIENTS",
//           style: TextStyle(
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             color: GlobalColors.thirdColor,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20.0),
//         Stack(
//           children: [
//             Container(
//               height: 600.0,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   alignment: Alignment.centerLeft,
//                   image: AssetImage(
//                     GlobalImages.backgroundFeedbackSection
//                   ),
//                   fit: BoxFit.fitHeight
//                 )
//               ),
//               child: GlobalSizes.isSmallScreen(context) ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                       child: SizedBox(
//                         width: 400.0,
//                         child: Text(
//                           "La confiance de nos clients et partenaires est notre plus belle récompense. Vos recommandations témoignent de notre engagement et de la qualité de notre travail",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Colors.black87,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       )
//                     ),
//                   const SizedBox(height: 20.0),
//                   Center(
//                     child: Container(
//                       width: 550.0,
//                       height: 450.0,
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [BoxShadow(
//                           color: Colors.black87, 
//                           blurRadius: 6
//                         )],
//                       ),
//                       child: SizedBox(
//                         child: PageView.builder(
//                           controller: _pageController,
//                           itemCount: feedbacks.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   feedbacks[index]["comment"]!,
//                                   style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//               : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                       child: SizedBox(
//                         width: 400.0,
//                         child: Text(
//                           "Notre engagement et notre exigence nous valent la reconnaissance de nos clients et partenaires.\n"
//                           "Vos recommandations sont la meilleure preuve de notre sérieux et de la qualité de notre travail.",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Colors.black87,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       )
//                     ),
//                   const SizedBox(width: 50.0),
//                   Center(
//                     child: Container(
//                       width: 550.0,
//                       height: 450.0,
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [BoxShadow(
//                           color: Colors.black26, 
//                           blurRadius: 6
//                         )],
//                       ),
//                       child: SizedBox(
//                         child: PageView.builder(
//                           controller: _pageController,
//                           itemCount: feedbacks.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   feedbacks[index]["comment"]!,
//                                   style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ),
//             GlobalSizes.isExtraSmallScreen(context) ? SizedBox.shrink()
//             : Positioned(
//               top: 0.0,
//               child: Padding(
//                 padding: GlobalSizes.isSmallScreen(context) ? EdgeInsets.all(16.0) : EdgeInsets.all(32.0),
//                 child: SvgPicture.asset(
//                   GlobalLogo.logoDots,
//                   width: 100,
//                   height: 100,
//                 )
//               )
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_sizes.dart';

class CustomerFeedbackSection extends StatefulWidget {
  const CustomerFeedbackSection({super.key});

  @override
  CustomerFeedbackSectionState createState() => CustomerFeedbackSectionState();
}

class CustomerFeedbackSectionState extends State<CustomerFeedbackSection> {
    // Controls the page scrolling automatic effect for testimonials
  final PageController _pageController = PageController(viewportFraction: 1);
  late Timer _timer;
  int _currentIndex = 0;
  
  // List of customer testimonials with comment, author, and project title
  final List<Map<String, String>> feedbacks = [
    {
      "comment": "\"Excellente exécution d’un chantier portant sur la rénovation totale d’un appartement. Respect du cahier des charges, des engagements et des quelques aménagements décidés lors de la réalisation. Beau travail et belle équipe.\"",
      "author": "M. & Mme T. ",
      "title": "",
    },
    {
      "comment": "\"Travail impeccable et équipe très professionnelle. Mon appartement a été transformé avec beaucoup d’élégance.\"",
      "author": "Mme B. ",
      "title": "Rénovation d'un appartement familial - 13ème arrondissement",
    },
    {
      "comment": "\"Un vrai plaisir de voir mon projet réalisé avec autant de soin et de précision ! Bravo à toute l’équipe.\"",
      "author": "M. D. ",
      "title": "Modernisation complète d’un loft à République",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Automatically scroll to the next testimonial every XX seconds
    _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
      if (_currentIndex < feedbacks.length - 1) {
        _currentIndex++; // Move to the next testimonial
      } else {
        _currentIndex = 0; // Return to the first testimonial after the last one
      }
      // Animate transition between testimonials with a smooth effect
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is removed to prevent memory leaks
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "LE TEMOIGNAGE DE NOS CLIENTS",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: GlobalColors.thirdColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        Container(
          height: 600.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.centerLeft,
              image: AssetImage(
                GlobalImages.backgroundFeedbackSection
              ),
              fit: BoxFit.fitHeight
            )
          ),
          child: GlobalSizes.isSmallScreen(context) ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                    width: 400.0,
                    child: Text(
                      "La confiance de nos clients et partenaires est notre plus belle récompense. Vos recommandations témoignent de notre engagement et de la qualité de notre travail",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: 550.0,
                  height: 450.0,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                      color: Colors.black26, 
                      blurRadius: 6
                    )],
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: feedbacks.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  feedbacks[index]["comment"]!,
                                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            GlobalLogo.logoDots,
                            width: 100,
                            height: 100,
                          )
                        )
                      )
                    ],
                  ) 
                ),
              )
            ],
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                    width: 400.0,
                    child: Text(
                      "La confiance de nos clients et partenaires est notre plus belle récompense. Vos recommandations témoignent de notre engagement et de la qualité de notre travail",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              const SizedBox(width: 50.0),
              Center(
                child: Container(
                  width: 550.0,
                  height: 450.0,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                      color: Colors.black26, 
                      blurRadius: 6
                    )],
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: feedbacks.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  feedbacks[index]["comment"]!,
                                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "- ${feedbacks[index]["author"]}, ${feedbacks[index]["title"]}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            GlobalLogo.logoDots,
                            width: 100,
                            height: 100,
                          )
                        )
                      )
                    ],
                  ) 
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}
