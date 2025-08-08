import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../components/my_nav_bar_component.dart';
import '../components/my_drawer_component.dart';
import '../components/footer_component.dart';
import '../widgets/vertical_words_carousel_widget.dart';
import '../widgets/photo_wall_widget.dart';
import '../widgets/my_rive_button_widget.dart';
import '../widgets/my_back_to_top_button_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> with TickerProviderStateMixin {
  late AnimationController _animationTitleController;
  late AnimationController _animationButtonController;
  late Animation<Offset> _slideTitleAnimation;
  late Animation<Offset> _slideButtonAnimation;
  late Animation<double> _fadeAnimation;
  // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Allows to scroll  to the menu
  final GlobalKey _menuKey = GlobalKey();
  String currentItem = 'Nos réalisations';
  bool _showTitleScreen = false;
  bool _showBackToTopButton = false;

  // Currently selected service, by default 'ALL'
  String selectedService = 'TOUT VOIR';
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

  @override  
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        _showTitleScreen = true;
      });
    });

    // Title animation
    _animationTitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideTitleAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationTitleController, 
      curve: Curves.easeInOut,
    ));

    // Button animation
    _animationButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideButtonAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationButtonController, 
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationTitleController,
      curve: Curves.easeInOut
    ));

    // Handle back to top button 
    _pageScrollController.addListener(_pageScrollListener); // Adds an event listener that captures scrolling
  
    // Access the menu and photo sorting directly. Launches after the first render frame. Necessary because we access context-bound objects like ModalRoute and GlobalKeys
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Retrieve the arguments passed via Navigator.pushNamed from the Landing page
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      // The received argument
      final String? receivedService = args?['selectedService'];
      // Convert the received argument to lowercase
      final String? receivedServiceLower = receivedService?.toLowerCase();
      // Extract all valid titles from servicesDatas and convert to lowercase
      final List<String> validServices = GlobalData.servicesData.map((item) => item['title']!.toLowerCase()).toList();

      // Verification: if the transmitted service is in the list
      if (receivedServiceLower != null && validServices.contains(receivedServiceLower)) {
        updateSelectedService(receivedServiceLower);

        // Scroll to the menu section
        if (args?['scrollToMenu'] == true) {
          Scrollable.ensureVisible( // Scroll to the menu using its GlobalKey
            _menuKey.currentContext!, // Reference to the widget with this key
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      } 
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

  // The filtered list of photos that will be transmitted to the PhotoWallWidget.
  List<String> get filteredPhotos {
    if (selectedService == 'TOUT VOIR') {
      // Combine all the photos 
      return GlobalData.photosWall.values.expand((list) => list).toList(); // .values → gets all the lists .expand → flattens them into a single list .toList → converts the result into a usable List<String>

      // // Combine all the photos
      // final List<String> allPhotos = [];
      // GlobalData.photosWall.forEach((service, photos) {
      //   allPhotos.addAll(photos);
      // });
      // return allPhotos;
    }

    return GlobalData.photosWall[selectedService.toLowerCase()] ?? [];
  }

  // Update of the service selection
  void updateSelectedService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  // Detects when scrolling should show back to top button
  void _pageScrollListener() {
    final shouldShow = _pageScrollController.position.pixels > MediaQuery.of(context).size.height - 1000.0;
    if (shouldShow != _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageScrollController.removeListener(_pageScrollListener);
    _pageScrollController.dispose();
    _animationTitleController.dispose();
    _animationButtonController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyNavBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);}, // receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click)
      ),
      endDrawer: isMobile // && !_isDesktopMenuOpen (only for NavItem with click)
      ? MyDrawerComponent( 
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) : null,
      backgroundColor: GlobalColors.firstColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = 800.0;
          
          return SingleChildScrollView(
            controller: _pageScrollController,
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
                            image: AssetImage(GlobalImages.backgroundLanding), 
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
                          child: VerticalWordsCarouselWidget(),
                        ),
                      ),
                      // Bottom rectangle shape 
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
                        left: isMobile ? null : GlobalScreenSizes.screenWidth(context) * 0.25, // Center horizontally 
                        child: Container(
                          height: 300.0,
                          width: isMobile ? GlobalScreenSizes.screenWidth(context) : GlobalScreenSizes.screenWidth(context) * 0.5,
                          padding: GlobalScreenSizes.isCustomSize(context, 326.0) ? const EdgeInsetsDirectional.symmetric(horizontal: 20.0) : const EdgeInsets.all(60.0), // Add padding inside the container 
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor,
                          ),
                          child: AnimatedOpacity(
                            opacity: _showTitleScreen ? 1.0 : 0.0,
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
                                      fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors.thirdColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20.0), // Space between
                                  Text(
                                    "Une entreprise de rénovation tous corps d'état sur Paris et ses environs",
                                    style: TextStyle(
                                      fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
                    key: _menuKey,
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
                            itemCount: GlobalData.servicesData.length,
                            itemBuilder: (context, index) {
                              final service = GlobalData.servicesData[index];
                              // When you click on a menu item, the selected category is updated.
                              return GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  _scrollController.jumpTo(_scrollController.offset - details.delta.dx);
                                },
                                // onTap: () => updateSelectedService(service['title']!),
                                onTap: () { 
                                  updateSelectedService(service['title']!);
                                },
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
                                        Image.asset(
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
                // Photo wall 
                PhotoWallWidget(photos: filteredPhotos),
                const SizedBox(height: 100.0),
                // A quote section
                Container(
                  height: 600.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        GlobalImages.bakcgroundQuote,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VisibilityDetector( // Title animation
                            key: const Key('title'), 
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0.3) {
                                _animationTitleController.forward();
                              }
                            },
                            child: AnimatedBuilder(
                              animation: _animationTitleController, 
                              builder: (context, child) {
                                return FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: SlideTransition(
                                    position: _slideTitleAnimation,
                                    child: child,
                                  ) 
                                );
                              },
                              child: Text(
                                'UN PROJET ?',
                                style: TextStyle(
                                  color: GlobalColors.firstColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? GlobalSize.mobileBigTitle : GlobalSize.webBigTitle,
                                ),
                              ),
                            ), 
                          ),
                          const SizedBox(height: 50.0),
                          VisibilityDetector(
                            key: const Key('button'), 
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0.3) {
                              _animationButtonController.forward();
                              }
                            },
                            child: AnimatedBuilder(
                              animation: _animationButtonController, 
                              builder: (context, child) {
                                return FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: SlideTransition(
                                    position: _slideButtonAnimation,
                                    child: child, 
                                  )
                                );
                              },
                              child: MyRiveButtonWidget(
                                onPressed: () => Navigator.pushNamed(context, '/contact'),
                                buttonPath: GlobalButtonsAndIcons.freeQuoteButtonV2,
                              ),
                            ), 
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // Footer
                const FooterComponent(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _showBackToTopButton 
      ? MyBackToTopButtonWidget(
        controller: _pageScrollController,
      )
      : null
    );
  }
}
