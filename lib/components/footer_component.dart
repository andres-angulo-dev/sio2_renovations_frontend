import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/my_hover_route_navigator_widget.dart';
import '../widgets/my_hover_url_navigator_widget.dart';
import '../widgets/opening_hours_widget.dart';
import '../widgets/my_hover_slide_link_widget.dart';
import '../utils/global_screen_sizes.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    final Color backgroundColor = GlobalColors.fourthColor;
    final Color mainColor = Colors.black87;
    
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isMobile) const SizedBox(height: 10.0), 
          isMobile 
          ? Column( // Mobile
            children: [
              SvgPicture.asset(
                GlobalLogosAndIcons.blackCompanyLogo,
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
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 30.0),
              OpeningHoursWidget(crossAxisPosition: CrossAxisAlignment.center, mainAxisPosition: MainAxisAlignment.center, color: mainColor),
              const SizedBox(height: 20.0),
              Text(
                "Contact",
                style: TextStyle(
                  fontSize: GlobalSize.footerWebTitle,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 1,
                width: 350.0,
                color: mainColor,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  const SizedBox(width: 4.0),
                  Icon(
                    Icons.email,
                    size: 20.0,
                    color: GlobalColors.orangeColor,
                  ),
                  const SizedBox(width: 5.0),
                  Flexible(
                    child: Text(
                      GlobalPersonalData.email,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: GlobalSize.footerWebText,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
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
                  Flexible(
                    child: Text(
                      GlobalPersonalData.contactPhone,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: GlobalSize.footerWebText,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
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
                  Flexible(
                    child: MyHoverRouteNavigatorWidget(
                      routeName: '/contact', 
                      text: 'Demande de devis',
                      hoverColor: GlobalColors.orangeColor,
                      color: mainColor,
                      webSize: GlobalSize.footerWebText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                "Légal",
                style: TextStyle(
                  fontSize: GlobalSize.footerWebTitle,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 1,
                width: 350,
                color: mainColor,
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
                      fontSize: isMobile ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Flexible(
                    child: MyHoverRouteNavigatorWidget(
                      routeName: '/legalMontions', 
                      text: "Mentions légales",
                      color: mainColor,
                      hoverColor: GlobalColors.orangeColor,
                      webSize: GlobalSize.footerWebText,
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
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: isMobile ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Flexible(
                    child: MyHoverRouteNavigatorWidget(
                      routeName: '/privacyPolicy', 
                      text: "Politique de confidentialité",
                      hoverColor: GlobalColors.orangeColor,
                      color: mainColor,
                      webSize: GlobalSize.footerWebText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
            ],
          )
          : Column( // Web
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left part
                    Flexible(
                      child:Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: [
                          // Logo
                          SizedBox(
                            width: 350.0,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  GlobalLogosAndIcons.blackCompanyLogo,
                                  semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                                  fit: BoxFit.cover,
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  'Rénover votre studio, appartement,\n maison ou local commercial\n en toute sérénité.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: GlobalSize.footerWebSubTitle,
                                    color: mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Schedules
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: 350.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: mainColor, width: 1.0),
                            ),
                            child: OpeningHoursWidget(
                              color: mainColor,
                              squareColor: GlobalColors.orangeColor,
                            ),
                          )
                        ],
                      ) 
                    ),         
                    SizedBox(width: 20.0),         
                    // Right Part
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: [
                          // Section "Contact"
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: 350.0,
                            height: 161.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: mainColor, width: 1.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  "Contact",
                                  style: TextStyle(
                                    fontSize: GlobalSize.footerWebTitle,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                // Divider
                                Container(
                                  height: 1, 
                                  width: MediaQuery.of(context).size.width * 0.5, 
                                  color: mainColor
                                ),
                                const SizedBox(height: 20.0),
                                // Icon + text
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: GlobalSize.footerWebText,
                                      alignment: Alignment.center,
                                      child: Icon(Icons.email, size: 20.0, color: GlobalColors.orangeColor),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Flexible(
                                      child: Text(
                                        GlobalPersonalData.email,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: GlobalSize.footerWebText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: GlobalSize.footerWebText,
                                      alignment: Alignment.center,
                                      child: Icon(Icons.phone, size: 20.0, color: GlobalColors.orangeColor),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Flexible(
                                      child: Text(
                                        GlobalPersonalData.contactPhone,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: GlobalSize.footerWebText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: GlobalSize.footerWebText,
                                      alignment: Alignment.center,
                                      child: Icon(Icons.description, size: 20.0, color: GlobalColors.orangeColor),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Flexible(
                                      child: MyHoverRouteNavigatorWidget(
                                        routeName: '/contact', 
                                        text: 'Demande de devis',
                                        hoverColor: GlobalColors.orangeColor,
                                        color: mainColor,
                                        webSize: GlobalSize.footerWebText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Section "About"
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: 350.0,
                            height: 161.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: mainColor, width: 1.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  "Légal",
                                  style: TextStyle(
                                    fontSize: GlobalSize.footerWebTitle,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                // Divider
                                Container(
                                  height: 1, 
                                  width: MediaQuery.of(context).size.width * 0.5, 
                                  color: mainColor
                                ),
                                const SizedBox(height: 20.0),
                                // Text
                                MyHoverSlideLinkWidget(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.arrow_forward_rounded, size: 20.0, color: GlobalColors.orangeColor,),
                                      const SizedBox(width: 5.0),
                                      MyHoverRouteNavigatorWidget(
                                        routeName: '/legalMontions',
                                        text: "Mentions légales",
                                        color: mainColor,
                                        hoverColor: GlobalColors.orangeColor,
                                        webSize: GlobalSize.footerWebText,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                MyHoverSlideLinkWidget(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.arrow_forward_rounded, size: 20.0, color: GlobalColors.orangeColor,),
                                      const SizedBox(width: 5.0),
                                      MyHoverRouteNavigatorWidget(
                                        routeName: '/privacyPolicy',
                                        text: "Politique de confidentialité",
                                        hoverColor: GlobalColors.orangeColor,
                                        color: mainColor,
                                        webSize: GlobalSize.footerWebText,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isMobile) const SizedBox(height: 10.0),
          Divider(
            color: GlobalColors.firstColor,
            thickness: 2,
          ),
          const SizedBox(height: 8.0),
          Center(
            child: RichText(
              text: TextSpan(
                text: "${GlobalPersonalData.companyName} © 2025 | Tous droits réservés | Réalisé par",
                  style: TextStyle(
                  fontSize: GlobalSize.footerWebCopyright,
                  color: mainColor,
                ),
                children: [
                  TextSpan(text: " "),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: MyHoverUrlNavigatorWidget(
                    url: 'https://www.andres-angulo.com', 
                    text: 'Andrés Angulo',
                    hoverColor: GlobalColors.orangeColor,
                    color: mainColor,
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



