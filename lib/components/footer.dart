import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sio2_renovations_frontend/components/my_hover_route_navigator.dart';
import 'package:sio2_renovations_frontend/components/my_hover_url_navigator.dart';
import 'package:sio2_renovations_frontend/utils/global_sizes.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;
    
    return Container(
      width: double.infinity,
      color: GlobalColors.thirdColor,
      padding: const EdgeInsets.all(16.0),
      child: Column( // mobile
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!mobile) const SizedBox(height: 10.0),
          mobile ? Column(
            children: [
              SvgPicture.asset(
                GlobalLogo.blackLogo,
                semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Rénover votre studio, appartement,\n maison ou local commercial\n en toute sérénité.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: GlobalSize.footerWebSubTitle,
                  color: GlobalColors.firstColor
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                "Contact",
                style: TextStyle(
                  fontSize: GlobalSize.footerWebTitle,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.firstColor,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 1,
                width: 350.0,
                color: GlobalColors.firstColor,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4.0),
                  Icon(
                    size: 20.0,
                    Icons.email,
                    color: GlobalColors.orangeColor,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    "contact@sio2renovations.com",
                    style: const TextStyle(
                      color: GlobalColors.firstColor,
                      fontSize: GlobalSize.footerWebText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4.0),
                  Icon(
                    size: 20.0,
                    Icons.phone,
                    color: GlobalColors.orangeColor,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    "+(33) 6 46 34 12 03",
                    style: const TextStyle(
                      color: GlobalColors.firstColor,
                      fontSize: GlobalSize.footerWebText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4.0),
                  Icon(
                    size: 20.0,
                    Icons.description,
                    color: GlobalColors.orangeColor,
                  ),
                  const SizedBox(width: 5.0),
                  MyHoverRouteNavigator(
                    routeName: '/contact', 
                    text: 'Demande de devis',
                    hoverColor: GlobalColors.orangeColor,
                    color: GlobalColors.firstColor,
                    webSize: GlobalSize.footerWebText,
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                "À propos",
                style: TextStyle(
                  fontSize: GlobalSize.footerWebTitle,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.firstColor,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 1,
                width: 350,
                color: GlobalColors.firstColor,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4.0),
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: GlobalSizes.isMobileScreen(context) ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.firstColor,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  MyHoverRouteNavigator(
                    routeName: '/legalMontions', 
                    text: "Mentions légales",
                    color: GlobalColors.firstColor,
                    hoverColor: GlobalColors.orangeColor,
                    webSize: GlobalSize.footerWebText,
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4.0),
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: GlobalSizes.isMobileScreen(context) ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.firstColor,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  MyHoverRouteNavigator(
                    routeName: '/privacyPolicy', 
                    text: "Politique de confidentialité",
                    hoverColor: GlobalColors.orangeColor,
                    color: GlobalColors.firstColor,
                    webSize: GlobalSize.footerWebText,
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
            ],
          )
          : Row( // Web
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left part
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        GlobalLogo.blackLogo,
                        semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Rénover votre studio, appartement,\n maison ou local commercial\n en toute sérénité.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: GlobalSize.footerWebSubTitle,
                          color: GlobalColors.firstColor
                        ),
                      )
                    ],
                  ),
                )
              ),
              // Right part
              SizedBox(
                width: 600.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column 1 : Section "Contact"
                    Expanded( 
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact",
                              style: TextStyle(
                                fontSize: GlobalSize.footerWebTitle,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.firstColor,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              height: 1,
                              width: 350.0,
                              color: GlobalColors.firstColor,
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 4.0),
                                Icon(
                                  size: 20.0,
                                  Icons.email,
                                  color: GlobalColors.orangeColor,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  "contact@sio2renovations.com",
                                  style: const TextStyle(
                                    color: GlobalColors.firstColor,
                                    fontSize: GlobalSize.footerWebText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 4.0),
                                Icon(
                                  size: 20.0,
                                  Icons.phone,
                                  color: GlobalColors.orangeColor,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  "+(33) 6 46 34 12 03",
                                  style: const TextStyle(
                                    color: GlobalColors.firstColor,
                                    fontSize: GlobalSize.footerWebText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 4.0),
                                Icon(
                                  size: 20.0,
                                  Icons.description,
                                  color: GlobalColors.orangeColor,
                                ),
                                const SizedBox(width: 5.0),
                                MyHoverRouteNavigator(
                                  routeName: '/contact', 
                                  text: 'Demande de devis',
                                  hoverColor: GlobalColors.orangeColor,
                                  color: GlobalColors.firstColor,
                                  webSize: GlobalSize.footerWebText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(width: 20.0),
                    // Column 2 : Section "About"
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "À propos",
                              style: TextStyle(
                                fontSize: GlobalSize.footerWebTitle,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.firstColor,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              height: 1,
                              width: 350,
                              color: GlobalColors.firstColor,
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 4.0),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    fontSize: GlobalSizes.isMobileScreen(context) ? 18.0 : 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.firstColor,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                MyHoverRouteNavigator(
                                  routeName: '/legalMontions', 
                                  text: "Mentions légales",
                                  color: GlobalColors.firstColor,
                                  hoverColor: GlobalColors.orangeColor,
                                  webSize: GlobalSize.footerWebText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 4.0),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    fontSize: GlobalSizes.isMobileScreen(context) ? 18.0 : 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.firstColor,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                MyHoverRouteNavigator(
                                  routeName: '/privacyPolicy', 
                                  text: "Politique de confidentialité",
                                  hoverColor: GlobalColors.orangeColor,
                                  color: GlobalColors.firstColor,
                                  webSize: GlobalSize.footerWebText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
          if (!mobile) const SizedBox(height: 10.0),
          const Divider(
            color: GlobalColors.firstColor,
            thickness: 2,
          ),
          const SizedBox(height: 8.0),
          Center(
            child: RichText(
              text: TextSpan(
                text: "SIO2 Rénovations © 2025 | Tous droits réservés | Réalisé par",
                  style: TextStyle(
                  fontSize: GlobalSize.footerWebCopyright,
                  color: GlobalColors.firstColor,
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
                    color: GlobalColors.firstColor,
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