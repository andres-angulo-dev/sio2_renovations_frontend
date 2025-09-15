import 'package:flutter/material.dart';
import '../utils/global_screen_sizes.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class MyHorizontalMenuWidget extends StatefulWidget{
  final Function(String) updateSelectedService;
  final String selectedService;
  final ScrollController? externalScrollController;

  const MyHorizontalMenuWidget({
    super.key,
    required this.updateSelectedService,
    required this.selectedService,
    this.externalScrollController,
  });

  @override
  MyHorizontalMenuWidgetState createState() => MyHorizontalMenuWidgetState();
}

class MyHorizontalMenuWidgetState extends State<MyHorizontalMenuWidget> with SingleTickerProviderStateMixin {
  // Scroll controller for slide horizontal menu
  late final ScrollController _resolvedScrollController;
  // Allows to scroll  to the menu
  final GlobalKey _menuKey = GlobalKey();

  @override
  void initState(){
    super.initState();

    _resolvedScrollController = widget.externalScrollController ?? ScrollController();

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
        // Find the index of the selected service in the list by comparing lowercase titles
        final int targetIndex = GlobalData.servicesData.indexWhere((item) => item['title']!.toLowerCase() == receivedServiceLower);
        // Determine the width of each menu item based on screen size (mobile or desktop)
        final double itemWidth = GlobalScreenSizes.isMobileScreen(context) ? 200.0 : 400.0;
        // Calculate the horizontal scroll offset needed to bring the selected item into view
        final double scrollOffset = targetIndex * itemWidth;

        // Update current item with the chosen menu from the parent
        widget.updateSelectedService(receivedServiceLower);
        
        // Animate the horizontal scroll to the calculated offset, smoothly over X seconds
        _resolvedScrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
        );

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

  // Scroll functions to the top of menu
  void _scrolToSelf() {
    final context = _menuKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }
  
  // Scroll functions of the menu buttons 
  void _scrollLeft() {
    _resolvedScrollController.animateTo(
      _resolvedScrollController.offset - 416,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _scrollRight() {
    _resolvedScrollController.animateTo(
      _resolvedScrollController.offset + 416,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    if (widget.externalScrollController == null) {
      _resolvedScrollController.dispose();
    }
    super.dispose();
  }

  @override  
  Widget build(BuildContext context) {
    return Center(
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
                controller: _resolvedScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: GlobalData.servicesData.length,
                itemBuilder: (context, index) {
                  final service = GlobalData.servicesData[index];
                  // When you click on a menu item, the selected category is updated.
                  return GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      _resolvedScrollController.jumpTo(_resolvedScrollController.offset - details.delta.dx);
                    },
                    // onTap: () => updateSelectedService(service['title']!),
                    onTap: () { 
                      widget.updateSelectedService(service['title']!);
                      _scrolToSelf();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100.0,
                      width: GlobalScreenSizes.isMobileScreen(context) ? 200.0 : 400.0,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.selectedService.toLowerCase() == service['title']!.toLowerCase() ? GlobalColors.thirdColor : Colors.transparent,
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
    );
  }
} 