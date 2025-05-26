import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class NavItems extends StatelessWidget {
  const NavItems({super.key, 
  required this.defaultColor, 
  required this.hoverColor, 
  this.isHorizontal = true,
  required this.currentItem,
  required this.onItemSelected,
  });

  final Color defaultColor;
  final Color hoverColor;
  final bool isHorizontal; // Whether the menu is displayed horizontally
  final String currentItem; // The currently active menu item
  final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItemsData = [
      {'icon': Icons.dashboard, 'label': 'Accueil', 'route': '/landing'},
      {'icon': Icons.info, 'label': 'À propos de nous', 'route': '/about'},
      {'icon': Icons.folder_open, 'label': 'Projets', 'route': '/projects'},
      {'icon': Icons.contact_mail, 'label': 'Contact', 'route': '/contact'},
      {'icon': Icons.article, 'label': 'Mentions légales', 'route': '/legalMontions'},
    ];

  final layoutItems = List.generate(navItemsData.length * 2 - 1, (index) {
    bool mobile = GlobalScreenSizes.isMobileScreen(context);
    bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);

    if (index.isEven) { // Index even → menu item
      final item = navItemsData[index ~/ 2]; // Access the correct element
      final bool isLastItem = index ~/ 2 == navItemsData.length - 1; // Check if it is the last element
      
      return AnimatedSwitcher( // Animation: Smooth transition of color change
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: mobile 
          ? EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0) 
          : EdgeInsets.only(
            left: isSmallScreen ? 15.0 : 30.0, 
            right: isSmallScreen ? 15.0 : (isLastItem ? 0.0 : 30.0), // If it's the last one, don't put padding on the left
          ),
          child: CustomNavItem( 
            key: ValueKey(defaultColor), // Trigger animation on color change
            icon: item['icon'],
            label: item['label'],
            isActive: currentItem == item['label'],
            onPressed: () {
              onItemSelected(item['label']);
              Navigator.pushNamed(context, item['route']);
            },
            defaultColor: defaultColor,
            hoverColor: hoverColor,
            animationDelay: Duration(milliseconds: (index ~/ 2 + 1) * 200),
          )
        )
      );
    } else { // ✅ Index odd → divider
      return isHorizontal
        ? Text('|', style: TextStyle(color: defaultColor, fontSize: 18))
        : Divider(
            color: GlobalColors.dividerColor1,
            thickness: 1.0,
            indent: 20.0,
            endIndent: 20.0,
          );
    }
  });

  // Choose the layout: horizontal row or vertical column.
  return isHorizontal
    ? Row(children: layoutItems)
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: layoutItems);//.where((item) => item is! Text).toList()); // Exclude horizontal separators for vertical layout
  }
}

class CustomNavItem extends StatefulWidget {
  const CustomNavItem({super.key, 
  required this.icon, 
  required this.label, 
  required this.onPressed, 
  required this.defaultColor, 
  required this.hoverColor, 
  required this.animationDelay,
  required this.isActive,
  });

  final IconData icon;
  final String label; 
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color hoverColor;
  final Duration animationDelay;
  final bool isActive;

  @override
  CustomdrawerItemstate createState() => CustomdrawerItemstate();
}

class CustomdrawerItemstate extends State<CustomNavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Color _textColor;
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    _textColor = widget.defaultColor;
    _backgroundColor = Colors.transparent;

    // Animation controller for the slide-in animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this
    );

    // Slide animation (starts offscreen and moves to position)
    _slideAnimation = Tween<Offset> (
      begin: const Offset(9.0, 0.0), // Start position (off-screen to the right)
      end: Offset.zero, // End position (default location)
    ).animate(CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.forward(); // Run the animation
      }
    });
  }

  // Automatically update _textColor when widget.defaultColor changes.
  @override
  void didUpdateWidget(CustomNavItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Comparison between old color and new
    if (widget.defaultColor != oldWidget.defaultColor) {
      setState(() {
        _textColor = widget.defaultColor; // Automatically update _textColor
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of animation controller to free memory
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    bool mobile = GlobalScreenSizes.isMobileScreen(context);
    bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _textColor = widget.hoverColor; // Change text color on hover
          _backgroundColor = const Color.fromARGB(255, 241, 237, 237); // Add background on hover
        });
      }, 
      onExit: (_) {
        setState(() {
          _textColor = widget.defaultColor; // Reset text color
          _backgroundColor = Colors.transparent; // Remove background
        });
      },
      child: mobile 
      // Mobile navigation menu
      ? SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            color:  _backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
                ),
                const SizedBox(width: 8.0,),
                Text(
                 widget.label,
                 style: TextStyle(
                    color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
                   fontSize: isSmallScreen ? 16.0 : 18.0,
                 ),
                ),
              ],
            ) 
          ) 
        ),
      )
      // Web navigation menu
      : MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
              fontSize: isSmallScreen ? 16.0 : 18.0,
            ),
          ),
        ),
      ) 
    );
  }
}