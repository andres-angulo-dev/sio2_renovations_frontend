import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'nav_items.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';
import 'dart:ui';

class MyAppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBarComponent({super.key,
    required this.currentItem,
    required this.onItemSelected,
    this.scrollController, // Added scroll controller
  });

  final String currentItem; // The currently active menu item
  final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected
  final ScrollController? scrollController; // Capture the scroll to change appBar background color and navItems text color

  @override
  MyAppBarComponentState createState() => MyAppBarComponentState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class MyAppBarComponentState extends State<MyAppBarComponent> {
  final ValueNotifier<Color> appBarColorNotifier = ValueNotifier<Color>(Colors.transparent);

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_scrollListener); // Adds an event listener that captures scrolling from parent Landing Screen using scrollController
  }

  // Detects when scrolling should change color
  void _scrollListener() {
    if (widget.scrollController != null) {
      bool isScrolled = widget.scrollController!.position.pixels > MediaQuery.of(context).size.height - 100; // After the homepage background image
      // bool isScrolled = widget.scrollController!.position.pixels > 50; // On the first scroll
      appBarColorNotifier.value = isScrolled ? GlobalColors.firstColor : Colors.transparent; // Change color if the condition is met
    } 
  }

  @override
  Widget build(BuildContext context) {
    final mobile = GlobalScreenSizes.isMobileScreen(context);

    return ValueListenableBuilder<Color>( // Rebuild the widget automatically when the color changes. (no need setState())
      valueListenable: appBarColorNotifier, 
      builder: (context, color, child) {
        return AppBar(
          toolbarHeight: mobile ? 250 : 300,
          leadingWidth: mobile ? 150 : 200,
          elevation: 0.0, // Disables the shadow effect.
          scrolledUnderElevation: 0.0, // Disables the effect of change caused by scrolling.
          backgroundColor: color, // Change dynamiquement en fonction du scroll
          iconTheme: IconThemeData( // Change the color of the DrawerComponent icon
            color: widget.currentItem == "Accueil" ?  color == GlobalColors.firstColor ? GlobalColors.secondColor : GlobalColors.firstColor   : GlobalColors.secondColor,
            // color: widget.currentItem == "Accueil" ? GlobalColors.firstColor : GlobalColors.secondColor,
          ),
          flexibleSpace: widget.currentItem == "Accueil" // Change the background color of the appbar
            ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
            : null,
          leading: mobile // Manages the left part (logo) of the appbar
            ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/landing'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),  
                  child: SvgPicture.asset(
                    widget.currentItem == "Accueil" ? (color == Colors.transparent ? GlobalLogo.whiteLogo : GlobalLogo.blackLogo) : GlobalLogo.blackLogo,
                    semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                    fit: BoxFit.contain,
                  ),
                ) 
              ),
              )
            : null,
          title: mobile ? null // Manages the center part of the appbar
            : Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/landing'),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          key: ValueKey(color),
                          widget.currentItem == "Accueil" ? (color == Colors.transparent ? GlobalLogo.whiteLogo : GlobalLogo.blackLogo) : GlobalLogo.blackLogo,
                          semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                          fit: BoxFit.contain,
                          width: 150.0,  // Logo size
                        ),
                      )
                    ),
                  ),
                  // Menu
                  NavItems(
                    defaultColor: widget.currentItem == "Accueil" ? (color == GlobalColors.firstColor ? GlobalColors.secondColor : GlobalColors.firstColor ) : GlobalColors.secondColor, 
                    hoverColor: GlobalColors.orangeColor, 
                    isHorizontal: true,
                    currentItem: widget.currentItem, // Pass the active item
                    onItemSelected: widget.onItemSelected, // Pass the callback
                  ),
                ],
              )
            ), 
          ),
          // Remove back arrow
          automaticallyImplyLeading: false,
          // Manages the right part of the appbar
          actions: null, 
          // Adds a white line at the bottom of the AppBar
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.5), // Sets the space reserved at the bottom of the appBar
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: GlobalColors.firstColor,
            ),
          ),
        );
      }
    );
  }
}