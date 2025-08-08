import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/nav_items_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';
import 'dart:ui';

class MyNavBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const MyNavBarComponent({super.key,
    required this.currentItem,
    required this.onItemSelected,
    this.currentSubItem,
    this.scrollController, // Added scroll controller
    // required this.onDesktopMenuOpenChanged, // (only for NavItem with click)
  });

  final String currentItem; // The currently active menu item
  final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected
  final String? currentSubItem; // The currently active sub menu item
  final ScrollController? scrollController; // Capture the scroll to change appBar background color and navItems text color 
  // final void Function(bool)? onDesktopMenuOpenChanged; //Captures and sends to the parent whether the dropdown menu is open or not // (only for NavItem with click)

  @override
  MyNavBarComponentState createState() => MyNavBarComponentState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0); // Heigh size of app bar
}

class MyNavBarComponentState extends State<MyNavBarComponent> {
  final ValueNotifier<Color> appBarColorNotifier = ValueNotifier<Color>(Colors.transparent);
  // bool _isDesktopMenuOpen = false;  // Check if the child (NavItem) has the dropdown menu or not (only for NavItem with click)

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
    final isMobile = GlobalScreenSizes.isMobileScreen(context);

    return ValueListenableBuilder<Color>( // Rebuild the widget automatically when the color changes. (no need setState())
      valueListenable: appBarColorNotifier, 
      builder: (context, color, child) {
        return AppBar(
          toolbarHeight: isMobile ? 250 : 300,
          leadingWidth: isMobile ? 150 : 200,
          elevation: 0.0, // Disables the shadow effect.
          scrolledUnderElevation: 0.0, // Disables the effect of change caused by scrolling.
          backgroundColor: color, // Change dynamiquement en fonction du scroll
          iconTheme: IconThemeData( // Change the color of the DrawerComponent icon
            color: widget.currentItem == "Accueil" ? (color == GlobalColors.firstColor ? GlobalColors.secondColor : GlobalColors.firstColor) : GlobalColors.secondColor,
            // color: widget.currentItem == "Accueil" ? GlobalColors.firstColor : GlobalColors.secondColor,
          ),
          flexibleSpace: widget.currentItem == "Accueil"  && color == Colors.transparent // Change the background color of the appbar
            ? ClipRect(
              child: 
              isMobile ?
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              )
              : BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
            : null,
          leading: isMobile
            ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/landing'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),  
                  child: SvgPicture.asset(
                    widget.currentItem == "Accueil" ? (color == Colors.transparent ? GlobalLogosAndIcons.whiteCompanyLogo : GlobalLogosAndIcons.blackCompanyLogo) : GlobalLogosAndIcons.blackCompanyLogo,
                    semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                    fit: BoxFit.contain,
                  ),
                ) 
              ),
              )
            : null,
          title: isMobile // && !_isDesktopMenuOpen // (only for NavItem with click)
            ? null // Manages the center part of the appbar
            : Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  isMobile // && _isDesktopMenuOpen // (only for NavItem with click)
                  ? SizedBox.shrink()   
                  : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/landing'),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          key: ValueKey(color),
                          widget.currentItem == "Accueil" ? (color == Colors.transparent ? GlobalLogosAndIcons.whiteCompanyLogo : GlobalLogosAndIcons.blackCompanyLogo) : GlobalLogosAndIcons.blackCompanyLogo,
                          semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
                          fit: BoxFit.contain,
                          width: 150.0,  // Logo size
                        ),
                      )
                    ),
                  ),
                  // Menu
                  NavItemsWidget(
                    defaultColor: widget.currentItem == "Accueil" ? (color == GlobalColors.firstColor ? GlobalColors.secondColor : GlobalColors.firstColor ) : GlobalColors.secondColor, 
                    hoverColor: GlobalColors.orangeColor, 
                    currentItem: widget.currentItem, // Pass the active item
                    onItemSelected: widget.onItemSelected, // Pass the callback
                    currentSubItem: widget.currentSubItem, // Pass the active sub item
                    // onDesktopMenuOpen: (bool isOpen) { // (only for NavItem with click)
                    //   setState(() => _isDesktopMenuOpen = isOpen); // Updates true or false with the information sent by his child (NavItem)
                    //   widget.onDesktopMenuOpenChanged?.call(isOpen); // updates true or false and sends the information to the parent (Screens) 
                    // },
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