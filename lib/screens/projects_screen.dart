import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/vertical_words_carousel_component.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final bool mobile = false;
  String currentItem = 'Projets';
  bool _show = false;

  @override  
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        _show = true;
      });
    });
  }

  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }


  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ),
      endDrawer: mobile ? 
      DrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,
      backgroundColor: GlobalColors.firstColor,
      body: LayoutBuilder(
        builder: (context, contraints) {
          final availableHeight = 800.0;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Welcome section
                SizedBox(
                  height: availableHeight,
                  width: GlobalScreenSizes.screenWidth(context), // Take full width
                  child: Stack(
                    children: [
                      // Background Image
                      Container(
                        height: availableHeight,
                        width: GlobalScreenSizes.screenWidth(context),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/immeuble.jpeg'), 
                            fit: BoxFit.cover, // Cover the entire space
                          )
                        ),
                      ),
                      // Title
                      Positioned(
                        top: GlobalScreenSizes.isCustomSize(context, 1100) ? 80.0 : 160.0,
                        left: 0.0,
                        right: 0.0,
                        child: Align(
                          child: VerticalWordsCarouselComponent(),
                        ),
                      ),
                      // bottom rectangle shape 
                      Positioned(
                        bottom: 0,
                        height: 150.0,
                        width: GlobalScreenSizes.screenWidth(context),
                        child: Container(
                          color: Colors.white,
                          )
                      ),
                      // White container centered at the bottom of the image
                      Positioned(
                        bottom: 0, // Align at the bottom
                        left: mobile ? null : GlobalScreenSizes.screenWidth(context) * 0.25 , // Center horizontally 
                        child: Container(
                          height: 300.0,
                          // width: GlobalScreenSizes.screenWidth(context) * 0.5, 
                          width: mobile ? GlobalScreenSizes.screenWidth(context) : GlobalScreenSizes.screenWidth(context) * 0.5, 
                          padding: GlobalScreenSizes.isCustomSize(context, 326) ? const EdgeInsetsDirectional.symmetric(horizontal: 20.0) : const EdgeInsets.all(60.0), // Add padding inside the container
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor, // White background
                          ),
                          child:  AnimatedOpacity(
                            opacity: _show ? 1.0 : 0.0, 
                            duration: const Duration(milliseconds: 1500),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                                crossAxisAlignment: CrossAxisAlignment.center, // Center content
                                children: [
                                  // Title
                                  Text(
                                    "NOS RÉALISATIONS",
                                    style: TextStyle(
                                      fontSize: 30, // Adjust font size
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors.thirdColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20), // Space between
                                  Text(
                                    "Une entreprise de rénovation tous corps d'état sur Paris et ses environs",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          ),
                        ) 
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}