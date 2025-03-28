// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sio2_renovations_frontend/components/my_hover_route_navigator.dart';
// import 'package:sio2_renovations_frontend/components/my_hover_url_navigator.dart';
// import '../utils/global_others.dart';
// import '../utils/global_colors.dart';

// class FooterComponent extends StatelessWidget {
//   const FooterComponent({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;
    
//     return Container(
//       width: double.infinity,
//       color: const Color.fromARGB(255, 165, 127, 78),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 2000),
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Colonne 1 : Section "Logo"
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SvgPicture.asset(
//                               GlobalLogo.blackLogo,
//                               semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
//                               fit: BoxFit.contain,
//                               width: 115,
//                               height: 115,
//                             ),
//                             Text(
//                               'Rénover votre studio, appartement,\n maison ou local commercial\n en toute sérénité.',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: GlobalSize.footerWebSubTitle,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),

//                       // Colonne 2 : Section "Contact"
//                       Expanded( 
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Contact",
//                               style: TextStyle(
//                                 fontSize: GlobalSize.footerWebTitle,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               // textAlign: TextAlign.start,
//                             ),
//                             const SizedBox(height: 6.0),
//                             Container(
//                               height: 2,
//                               width: 350,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(height: 20.0),
//                             Text(
//                               "contact@sio2renovations.com",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: GlobalSize.footerWebText,
//                               ),
//                             ),
//                             const SizedBox(height: 4.0),
//                             Text(
//                               "+(33) 6 46 34 12 03",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: GlobalSize.footerWebText,
//                               ),
//                             ),
//                             const SizedBox(height: 4.0),
//                             MyHoverRouteNavigator(
//                               routeName: '/contact', 
//                               text: 'Demande de devis',
//                               hoverColor: GlobalColors.orangeColor,
//                               color: GlobalColors.primaryColor,
//                               webSize: GlobalSize.footerWebText,
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Colonne 3 : Section "Informations légales"
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Informations légales",
//                               style: TextStyle(
//                                 fontSize: GlobalSize.footerWebTitle,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               // textAlign: TextAlign.start,
//                             ),
//                             const SizedBox(height: 6.0),
//                             Container(
//                               height: 2,
//                               width: 350,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(height: 20.0),
//                             MyHoverRouteNavigator(
//                               routeName: '/legalMontions', 
//                               text: "Mentions légales",
//                               color: GlobalColors.primaryColor,
//                               hoverColor: GlobalColors.orangeColor,
//                               webSize: GlobalSize.footerWebText,
//                             ),
//                             const SizedBox(height: 4.0),
//                             MyHoverRouteNavigator(
//                               routeName: '/privacyPolicy', 
//                               text: "Politique de confidentialité",
//                               hoverColor: GlobalColors.orangeColor,
//                               color: GlobalColors.primaryColor,
//                               webSize: GlobalSize.footerWebText,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ), 
//           ),
//           const SizedBox(height: 16.0),
//           // Divider blanc
//           const Divider(
//             color: Colors.white,
//             thickness: 2,
//           ),
//           const SizedBox(height: 8.0),
//           // Texte centré en bas
//           Center(
//             child: RichText(
//               text: TextSpan(
//                 text: "SIO2 Rénovations © 2025 | Tous droits réservés | Propulsé par",
//                   style: TextStyle(
//                   fontSize: GlobalSize.footerWebCopyright,
//                   color: Colors.white,
//                 ),
//                 children: [
//                   TextSpan(text: " "),
//                   WidgetSpan(
//                     alignment: PlaceholderAlignment.baseline,
//                     baseline: TextBaseline.alphabetic,
//                     child: MyHoverUrlNavigator(
//                     url: 'https://www.andres-angulo.com', 
//                     text: 'Andrés Angulo',
//                     hoverColor: GlobalColors.orangeColor,
//                     color: GlobalColors.primaryColor,
//                     webSize: GlobalSize.footerWebCopyright,
//                     )
//                   ),
//                   TextSpan(text: "."),
//                 ]
//               ),
//               textAlign: TextAlign.center,  
//             ) 
//           ),
//         ],
//       ) 
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sio2_renovations_frontend/components/my_hover_route_navigator.dart';
import 'package:sio2_renovations_frontend/components/my_hover_url_navigator.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;
    
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 165, 127, 78),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 2000),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Colonne 1 : Section "Logo"
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                GlobalLogo.blackLogo,
                                semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                                fit: BoxFit.contain,
                                width: 115,
                                height: 115,
                              ),
                              Text(
                                'Rénover votre studio, appartement,\n maison ou local commercial\n en toute sérénité.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: GlobalSize.footerWebSubTitle,
                                ),
                              )
                            ],
                          ),
                        )
                      ),

                      // Colonne 2 : Section "Contact"
                      Expanded( 
                        child: Container(
                          alignment: AlignmentDirectional(1, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact",
                                style: TextStyle(
                                  fontSize: GlobalSize.footerWebTitle,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                // textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                height: 2,
                                width: 350,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "contact@sio2renovations.com",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: GlobalSize.footerWebText,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "+(33) 6 46 34 12 03",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: GlobalSize.footerWebText,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              MyHoverRouteNavigator(
                                routeName: '/contact', 
                                text: 'Demande de devis',
                                hoverColor: GlobalColors.orangeColor,
                                color: GlobalColors.primaryColor,
                                webSize: GlobalSize.footerWebText,
                              ),
                            ],
                          ),
                        )
                      ),

                      // Colonne 3 : Section "Informations légales"
                      Expanded(
                        child: Container(
                          alignment: AlignmentDirectional(1, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Informations légales",
                                style: TextStyle(
                                  fontSize: GlobalSize.footerWebTitle,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                // textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                height: 2,
                                width: 350,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 20.0),
                              MyHoverRouteNavigator(
                                routeName: '/legalMontions', 
                                text: "Mentions légales",
                                color: GlobalColors.primaryColor,
                                hoverColor: GlobalColors.orangeColor,
                                webSize: GlobalSize.footerWebText,
                              ),
                              const SizedBox(height: 4.0),
                              MyHoverRouteNavigator(
                                routeName: '/privacyPolicy', 
                                text: "Politique de confidentialité",
                                hoverColor: GlobalColors.orangeColor,
                                color: GlobalColors.primaryColor,
                                webSize: GlobalSize.footerWebText,
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ), 
          ),
          const SizedBox(height: 16.0),
          // Divider blanc
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
          const SizedBox(height: 8.0),
          // Texte centré en bas
          Center(
            child: RichText(
              text: TextSpan(
                text: "SIO2 Rénovations © 2025 | Tous droits réservés | Propulsé par",
                  style: TextStyle(
                  fontSize: GlobalSize.footerWebCopyright,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: " "),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: MyHoverUrlNavigator(
                    url: 'https://www.andres-angulo.com', 
                    text: 'Andrés Angulo',
                    hoverColor: GlobalColors.orangeColor,
                    color: GlobalColors.primaryColor,
                    webSize: GlobalSize.footerWebCopyright,
                    )
                  ),
                  TextSpan(text: "."),
                ]
              ),
              textAlign: TextAlign.center,  
            ) 
          ),
        ],
      ) 
    );
  }
}
