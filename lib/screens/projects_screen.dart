import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/vertical_words_carousel_component.dart';
import '../components/photo_wall_component.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final ScrollController _scrollController = ScrollController();
  final bool mobile = false;
  String currentItem = 'Projets';
  bool _show = false;

  // Currently selected service, by default 'ALL'
  String selectedService = 'TOUT VOIR';

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

  // Scroll functions of the menu buttons 
  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 416,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 416,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // The filtered list of photos that will be transmitted to the PhotoWallComponent.
  List<String> get filteredPhotos {
    if (selectedService == 'TOUT VOIR') {
      // Combine all the photos
      final List<String> allPhotos = [];
      GlobalImages.photosByService.forEach((service, photos) {
        allPhotos.addAll(photos);
      });
      return allPhotos;
    }
    return GlobalImages.photosByService[selectedService] ?? [];
  }

  // Update of the service selection
  void updateSelectedService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    final List<Map<String, String>> servicesData = [
      {"title": "TOUT VOIR", "image": GlobalImages.backgroundLanding},
      {"title": "PEINTURE", "image": GlobalImages.backgroundLanding},
      {"title": "MENUISERIE", "image": GlobalImages.backgroundLanding},
      {"title": "SOLS", "image": GlobalImages.backgroundLanding},
      {"title": "PLOMBERIE", "image": GlobalImages.backgroundLanding},
      {"title": "CHAUFFAGE", "image": GlobalImages.backgroundLanding},
      {"title": "MAÇONNERIE", "image": GlobalImages.backgroundLanding},
      {"title": "ÉLECTRICITÉ", "image": GlobalImages.backgroundLanding},
    ];

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ),
      endDrawer: mobile ? 
        DrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
        ) : null,
      backgroundColor: GlobalColors.firstColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                          ),
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
                        bottom: 0.0,
                        height: 150.0,
                        width: GlobalScreenSizes.screenWidth(context),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      // White container centered at the bottom of the image
                      Positioned(
                        bottom: 0.0, // Align at the bottom
                        left: mobile ? null : GlobalScreenSizes.screenWidth(context) * 0.25, // Center horizontally 
                        child: Container(
                          height: 300.0,
                          width: mobile ? GlobalScreenSizes.screenWidth(context) : GlobalScreenSizes.screenWidth(context) * 0.5,
                          padding: GlobalScreenSizes.isCustomSize(context, 326.0) ? const EdgeInsetsDirectional.symmetric(horizontal: 20.0) : const EdgeInsets.all(60.0), // Add padding inside the container 
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor,
                          ),
                          child: AnimatedOpacity(
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
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors.thirdColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20.0), // Space between
                                  Text(
                                    "Une entreprise de rénovation tous corps d'état sur Paris et ses environs",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    constraints: const BoxConstraints(maxWidth: 1776.0), // Max size of container
                    height: GlobalScreenSizes.isMobileScreen(context) ? 150.0 : 200.0, // Size of menu
                    child: Row(
                      children: [
                        // Left button
                        CircleAvatar(
                          backgroundColor: GlobalColors.thirdColor,
                          radius: 20.0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onPressed: _scrollLeft,
                          ),
                        ),
                        // Hozirontal menu
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: servicesData.length,
                            itemBuilder: (context, index) {
                              final service = servicesData[index];
                              // When you click on a menu item, the selected category is updated.
                              return GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  _scrollController.jumpTo(_scrollController.offset - details.delta.dx);
                                },
                                onTap: () => updateSelectedService(service['title']!),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 100.0,
                                  width: GlobalScreenSizes.isMobileScreen(context) ? 200.0 : 400.0,
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedService == service['title'] ? GlobalColors.thirdColor : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          service['image']!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                        Container(
                                          color: Colors.black.withValues(alpha: 0.2),
                                        ),
                                        Center(
                                          child: Text(
                                            service['title']!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                        // Right button
                        CircleAvatar(
                          backgroundColor: GlobalColors.thirdColor,
                          radius: 20.0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onPressed: _scrollRight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                // Photo wall filtered
                PhotoWallComponent(photos: filteredPhotos),
                const SizedBox(height: 160.0),
                // Footer
                const FooterComponent(),
              ],
            ),
          );
        },
      ),
    );
  }
}
