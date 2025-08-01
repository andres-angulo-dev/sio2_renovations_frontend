// Width Carrousel slide widget
import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import '../widgets/my_hover_route_navigator_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class WhatTypeOfRenovationsSection extends StatefulWidget {
  const WhatTypeOfRenovationsSection({super.key});

  @override   
  WhatTypeOfRenovationsSectionState createState() => WhatTypeOfRenovationsSectionState();
}

class WhatTypeOfRenovationsSectionState extends State<WhatTypeOfRenovationsSection> with TickerProviderStateMixin {
  late List<AnimationController> _animationController;
  late List<Animation<Offset>> _slideAnimation;
  late List<bool> isHoveredList;

  final CarouselSliderController _carouselController = CarouselSliderController(); // controller added to go to image on button click
  int _currentIndex = 0;

  @override 
  void initState() {
    super.initState();
    isHoveredList = List.generate(GlobalData.typeOfRenovationData.length, (_) => false); // Generating each element to be displayed

    _initializeSlideAnimation();
  }

  void _initializeSlideAnimation() {
    _animationController = List.generate(GlobalData.typeOfRenovationData.length, (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    ));

    _slideAnimation = _animationController.map((controller) => Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: controller, 
      curve: Curves.easeInOut,
    ))).toList();
  }

  void startAnimation(int index) {
    _animationController[index].forward();
  }

  void resetAnimation(int index) {
    _animationController[index].reverse();
  }

  @override
  void dispose() {
    for (var controller in _animationController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    final isMobile = GlobalScreenSizes.isMobileScreen(context);
    final double activeCarouselSlider = 1560;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "QUELS TYPES DE RÉNOVATIONS RÉALISONS-NOUS ?", 
            style: TextStyle(
              fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
              fontWeight: FontWeight.bold,
              color: GlobalColors.thirdColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
        GlobalScreenSizes.isCustomSize(context, activeCarouselSlider) // Web and mobile 
        ? CarouselSlider( // Carousel activated if screen < 1560
          controller: _carouselController, // Added controller in widget,
          options: CarouselOptions(
            height: isMobile ? 500.0 : 700.0,
            enlargeCenterPage: true, // Zoom effect on the active image
            autoPlay: true,
            viewportFraction: isMobile ? 0.6 : 0.3, 
            enableInfiniteScroll: true, 
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: GlobalData.typeOfRenovationData.map((item) {
            int index = GlobalData.typeOfRenovationData.indexOf(item);
            final projectFiltersArguments = {'selectedService': item["title"], 'scrollToMenu': true};

            return MouseRegion(
              cursor: item["routePath"] == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
              onEnter: (_) => {
                setState(() => isHoveredList[index] = true),
                startAnimation(index),
              },
              onExit: (_) => {
                setState(() => isHoveredList[index] = false),
                resetAnimation(index),
              },
              child: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () => {
                      if (item["routePath"] != null)
                      Navigator.pushNamed(context, item["routePath"]!, arguments: projectFiltersArguments)
                    },
                    child: SizedBox(
                      width: isMobile ? null : 400.0, // Static container
                      child: ClipRRect( // Allows you to make invisible what is larger than the parent container
                        child: Stack(
                          children: [
                            OverflowBox( // Allows the image to be much larger without being cropped
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                            child: TweenAnimationBuilder<double>( // Animation zoom and zoom out works with ClipRRect + Stack + Overflow
                              duration: Duration(milliseconds: 300),
                              tween: Tween<double>(
                                begin: 1.0, 
                                end: isHoveredList[index] ? 0.90 : 1.0, // Zoom out of image only when is Hovered
                              ),
                              curve: Curves.easeInOut,
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Image.asset(
                                    item["image"]!,
                                    width: 600.0, // Image much larger than the parent container
                                    height: 1000.0, // Image much larger than the parent container
                                    fit: BoxFit.cover,
                                  )
                                );
                              },
                            ),
                            ),
                            isMobile // Mobile no animation on hover
                            ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black.withValues(alpha: 0.2),
                              alignment: Alignment.center,
                              child: item["routePath"] != null  
                                ? MyHoverRouteNavigatorWidget( // Animation hover text
                                routeName: item["routePath"]!, 
                                text: item["title"]!,
                                color: GlobalColors.firstColor,
                                hoverColor: GlobalColors.orangeColor,
                                mobileSize: 20.0,
                                webSize: 24.0,
                                arguments: projectFiltersArguments,
                                mobile: isMobile,
                                boldText: true,
                                textAlign: true,
                              )
                              : Text( // Text only
                                item["title"]!,
                                style: TextStyle(
                                  color: GlobalColors.firstColor,
                                  fontSize: isMobile ? 20.0 : 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ) 
                            : isHoveredList[index] ? // Web active animation on hover
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black.withValues(alpha: 0.5),
                              alignment: Alignment.center,
                              child: ClipRect(
                                child: SlideTransition(
                                  position: _slideAnimation[index],
                                  child: item["routePath"] != null  
                                    ? MyHoverRouteNavigatorWidget( // Animation hover text if routePath isn't empty
                                    routeName: item["routePath"]!, 
                                    text: item["title"]!,
                                    color: GlobalColors.firstColor,
                                    hoverColor: GlobalColors.orangeColor,
                                    mobileSize: 20.0,
                                    webSize: 24.0,
                                    mobile: isMobile,
                                    boldText: true,
                                  )
                                  : Text( // Text only
                                    item["title"]!,
                                    style: TextStyle(
                                      color: GlobalColors.firstColor,
                                      fontSize: isMobile ? 20.0 : 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            )
                            : SizedBox.shrink(),
                          ],
                        ),
                      )
                    )
                  );
                },
              ),
            );
          }).toList(),
        )
        : Row( // Web
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.0,
          children: List.generate(GlobalData.typeOfRenovationData.length, (index) { // Generating each element to be displayed
            final item = GlobalData.typeOfRenovationData[index]; // Each element
            final projectFiltersArguments = {'selectedService': item["title"], 'scrollToMenu': true};

            return MouseRegion(
              cursor: item["routePath"] == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
              onEnter: (_) => {
                setState(() => isHoveredList[index] = true),
                startAnimation(index),
              },
              onExit: (_) => {
                setState(() => isHoveredList[index] = false),
                resetAnimation(index),
              },
              child: GestureDetector(
                onTap: () => {
                  if (item["routePath"] != null) 
                  Navigator.pushNamed(context, item["routePath"]!, arguments: projectFiltersArguments)
                },
                child: SizedBox(
                  width: GlobalScreenSizes.isCustomSize(context, 1810) ? 300.0 : 350.0, // Static container
                  height: isMobile ? 500.0 : 700.0,
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
                          child: ClipRect(
                            child: SlideTransition(
                              position: _slideAnimation[index],
                              child: item["routePath"] != null  
                              ? MyHoverRouteNavigatorWidget( // Animation hover text
                                routeName: item["routePath"]!, 
                                text: item["title"]!,
                                color: GlobalColors.firstColor,
                                hoverColor: GlobalColors.orangeColor,
                                mobileSize: 20.0,
                                webSize: 24.0,
                                mobile: isMobile,
                                arguments: projectFiltersArguments,
                                boldText: true,
                                textAlign: true,
                              )
                              : Text( // text only
                                item["title"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: GlobalColors.firstColor,
                                  fontSize: isMobile ? 20.0 : 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ), 
              ), 
            );
          }),
        ), 
        if (GlobalScreenSizes.isCustomSize(context, activeCarouselSlider)) 
        const SizedBox(height: 15.0),
        if (GlobalScreenSizes.isCustomSize(context, activeCarouselSlider)) 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(GlobalData.typeOfRenovationData.length, (index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
                child: GestureDetector(
                onTap: () {
                  _carouselController.animateToPage(index); // Go to the associated image
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? GlobalColors.orangeColor : Colors.grey[400],
                  ),
                ),
              )
            );
          }),
        ),
      ],
    );
  }
}






// // With Wrap widget only
// import 'package:flutter/material.dart';
// import '../components/my_hover_route_navigator.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_screen_sizes.dart';

// class WhatTypeOfRenovationsSection extends StatefulWidget {
//   const WhatTypeOfRenovationsSection({super.key});

//   @override   
//   WhatTypeOfRenovationsSectionState createState() => WhatTypeOfRenovationsSectionState();
// }

// class WhatTypeOfRenovationsSectionState extends State<WhatTypeOfRenovationsSection> {
//   late List<bool> isHoveredList; // Creating a list of booleans

//   // List type that accepts the null argument
//   final List<Map<String, String?>> GlobalData.typeOfRenovationData =  [
//     {"title": "Rénovation totale", "image": GlobalImages.backgroundLanding, "routePath": null},
//     {"title": "Rénovation partielle", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
//     {"title": "Rénovation de cuisine", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
//     {"title": "Rénovation de salle de bain", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
//     {"title": "Rénovation après sinistre", "image": GlobalImages.backgroundLanding, "routePath": '/contact'},
//   ];

//   @override 
//   void initState() {
//     super.initState();
//     isHoveredList = List.generate(GlobalData.typeOfRenovationData.length, (_) => false); // Injecting each boolean into each image
//   }

//   @override 
//   Widget build(BuildContext context) {
//   final isMobile = GlobalScreenSizes.isMobileScreen(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "QUELS TYPES DE RÉNOVATIONS RÉALISONS-NOUS ?", 
//           style: TextStyle(
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             color: GlobalColors.thirdColor,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 50),
//         Wrap(
//           alignment: WrapAlignment.center,
//           runSpacing: 10.0,
//           spacing: 10.0,
//           children: List.generate(GlobalData.typeOfRenovationData.length, (index) { // Generating each element to be displayed
//             final item = GlobalData.typeOfRenovationData[index]; // Each element

//             return MouseRegion(
//               onEnter: (_) => setState(() => isHoveredList[index] = true),
//               onExit: (_) => setState(() => isHoveredList[index] = false),
//               child: SizedBox(
//                 width: 400.0, // Static container
//                 height: isMobile ? 500.0 : 700.0,
//                 child: ClipRRect( // Allows you to make invisible what is larger than the parent container
//                   child: Stack(
//                     children: [
//                       OverflowBox( // Allows the image to be much larger without being cropped
//                         maxWidth: double.infinity,
//                         maxHeight: double.infinity,
//                         child: TweenAnimationBuilder<double>( // Animation zoom and zoom out works with Stack + Overflow
//                           duration: Duration(milliseconds: 300),
//                           tween: Tween<double>(
//                             begin: 1.0, 
//                             end: isHoveredList[index] ? 0.9 : 1.0, // Zoom out of image only when is Hovered
//                           ),
//                           curve: Curves.easeInOut,
//                           builder: (context, scale, child) {
//                             return Transform.scale(
//                               scale: scale,
//                               child: Image.asset(
//                                 item["image"]!,
//                                 width: 600.0, // Image much larger than the parent container
//                                 height: 1000.0, // Image much larger than the parent container
//                                 fit: BoxFit.cover, // 
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       if (isHoveredList[index]) // Animation Dark effect
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: Colors.black.withValues(alpha: 0.5),
//                         alignment: Alignment.center,
//                         child: item["routePath"] != null  
//                         ? MyHoverRouteNavigatorWidget( // Animation hover text
//                           routeName: item["routePath"]!, 
//                           text: item["title"]!,
//                           color: GlobalColors.firstColor,
//                           hoverColor: GlobalColors.orangeColor,
//                           mobileSize: 20.0,
//                           webSize: 24.0,
//                           mobile: isMobile,
//                           boldText: true,
//                         )
//                         : Text( // text only
//                           item["title"]!,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: GlobalColors.firstColor,
//                             fontSize: isMobile ? 20.0 : 24.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ), 
//       ],
//     );
//   }
// }
