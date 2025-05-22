import 'package:flutter/material.dart';
import '../components/my_hover_route_navigator.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_sizes.dart';

class WhatTypeOfRenovationsSection extends StatefulWidget {
  const WhatTypeOfRenovationsSection({super.key});

  @override   
  WhatTypeOfRenovationsSectionState createState() => WhatTypeOfRenovationsSectionState();
}

class WhatTypeOfRenovationsSectionState extends State<WhatTypeOfRenovationsSection> {
  late List<bool> isHoveredList; // Creating a list of booleans

  // List type that accepts the null argument
  final List<Map<String, String?>> typeOfRenovationData =  [
    {"title": "Rénovation totale", "image": GlobalImages.backgroundLanding, "routePath": null},
    {"title": "Rénovation partielle", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
    {"title": "Rénovation de cuisine", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
    {"title": "Rénovation de salle de bain", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
    {"title": "Rénovation après sinistre", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
  ];

  @override 
  void initState() {
    super.initState();
    isHoveredList = List.generate(typeOfRenovationData.length, (_) => false); // Injecting each boolean into each image
  }

  @override 
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "QUELS TYPES DE RÉNOVATIONS RÉALISONS-NOUS ?", 
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: GlobalColors.thirdColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10.0,
          spacing: 10.0,
          children: List.generate(typeOfRenovationData.length, (index) { // Generating each element to be displayed
            final item = typeOfRenovationData[index]; // Each element

            return MouseRegion(
              onEnter: (_) => setState(() => isHoveredList[index] = true),
              onExit: (_) => setState(() => isHoveredList[index] = false),
              child: SizedBox(
                width: 400.0, // Static container
                height: GlobalSizes.isMobileScreen(context) ? 500.0 : 700.0,
                child: ClipRRect( // Allows you to make invisible what is larger than the parent container
                  child: Stack(
                    children: [
                      OverflowBox( // Allows the image to be much larger without being cropped
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        child: TweenAnimationBuilder<double>( // Animation zoom and zoom out
                          duration: Duration(milliseconds: 300),
                          tween: Tween<double>(
                            begin: 1.0, 
                            end: isHoveredList[index] ? 0.9 : 1.0, // Zoom out of image only when is Hovered
                          ),
                          curve: Curves.easeInOut,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Image.asset(
                                item["image"]!,
                                width: 600.0, // Image much larger than the parent container
                                height: 1000.0, // Image much larger than the parent container
                                fit: BoxFit.cover, // 
                              ),
                            );
                          },
                        ),
                      ),
                      if (isHoveredList[index]) // Animation Dark effect
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withValues(alpha: 0.5),
                        alignment: Alignment.center,
                        child: item["routePath"] != null  
                        ? MyHoverRouteNavigator( // Animation hover text
                          routeName: item["routePath"]!, 
                          text: item["title"]!,
                          color: GlobalColors.firstColor,
                          hoverColor: GlobalColors.orangeColor,
                          mobileSize: 20.0,
                          webSize: 24.0,
                          mobile: GlobalSizes.isMobileScreen(context),
                          boldText: true,
                        )
                        : Text( // text only
                          item["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: GlobalColors.firstColor,
                            fontSize: GlobalSizes.isMobileScreen(context) ? 20.0 : 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ), 
      ],
    );
  }
}