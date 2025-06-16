import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class NavItems extends StatefulWidget {
  const NavItems({super.key, 
  required this.defaultColor, 
  required this.hoverColor, 
  this.isHorizontal = true,
  required this.currentItem,
  required this.onItemSelected,
  this.currentSubItem,
  });

  final Color defaultColor;
  final Color hoverColor;
  final bool isHorizontal; // Whether the menu is displayed horizontally
  final String currentItem; // The currently active menu item
  final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected
  final String? currentSubItem; // The currently active sub menu item

  @override  
  NavItemsState createState() => NavItemsState();
}

class NavItemsState extends State<NavItems> {
  // Used to keep track of whether the "À propos" dropdown menu is open
  bool _isDesktopAboutOpen = false;   
  bool _isMobileAboutOpen = false;


  @override
  Widget build(BuildContext context) {
    final bool mobile = GlobalScreenSizes.isMobileScreen(context);
    final bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);
    final List<Map<String, dynamic>> navItemsData;
    final items = <Widget>[]; // Holds the final list of widgets (buttons or dropdowns)

    navItemsData = [
      {'icon': Icons.dashboard, 'label': 'Accueil', 'route': '/landing'},
      {'icon': Icons.folder_open, 'label': 'Nos réalisations', 'route': '/projects'},
      {'icon': Icons.info, 'label': 'À propos', 
        'children' : [
          {'subLabel': 'Qui sommes nous ?', 'route': '/about'},
          {'subLabel': 'Partenaires', 'route': '/contact'},
        ]
      },
      {'icon': Icons.contact_mail, 'label': 'Contact', 'route': '/contact'},
    ];

    for (var i = 0; i < navItemsData.length; i++) {
      final item = navItemsData[i];
      final bool isActive = item['label'] == widget.currentItem; // Determine if this nav item is currently selected
      final List? children = (item['children'] as List?)?.cast<Map<String, String>>(); // Extract children if any
      final bool hasChildren = children != null && children.isNotEmpty; // Check if this item has submenus
      final Widget navWidget;

      if (hasChildren) {
        // Build submenu (dropdown or expandable list)
        navWidget = widget.isHorizontal 
          ? Theme(  // Web version for the sub items
          data: Theme.of(context).copyWith( // Inject a custom theme to disable the default options of the PopupMenuButton widget
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            popupMenuTheme: PopupMenuThemeData(
              menuPadding: EdgeInsets.zero,
            )
          ),
          child: PopupMenuButton<String>( 
            tooltip: '', // Disable the infobulle on hover
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            position: PopupMenuPosition.under,
            color: Colors.white,
            elevation: 4.0,
            offset: const Offset(65.0, 38.0),
            onSelected: (route) {
              setState(() {
                _isDesktopAboutOpen = false; // Close hover state after navigation
              });
              final childLabel = children.firstWhere((e) => e['route'] == route)['subLabel']!;
              widget.onItemSelected(childLabel);
              Navigator.pushNamed(context, route); // Navigate to selected route
            },
            onCanceled: () { 
              setState(() {
                _isDesktopAboutOpen = false; // Close hover state when menu is closed by user action
              });
            },
            // Creation of the title item and sub items
            itemBuilder: (context) { 
              final List<PopupMenuEntry<String>> entries = [];
              for (var i = 0; i < children.length; i++) {
                entries.add(
                  (() {  // IIFE (Immediately-Invoked Function Expression) capture a bool hovering by item
                    bool hovering = false;
                    return PopupMenuItem<String>(
                      padding: EdgeInsets.zero, // Remove default padding
                      value: children[i]['route'],
                      child: StatefulBuilder(
                        builder: (context2, setState2) {
                          return MouseRegion(
                            onEnter: (_) => setState2(() => hovering = true),
                            onExit: (_) => setState2(() => hovering = false),
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 45.0,
                              color: hovering // Background on hover
                                ? GlobalColors.secondColor.withValues(alpha: 0.03) 
                                : Colors.transparent,
                              child: Text(
                                children[i]['subLabel'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: widget.currentSubItem == children[i]['subLabel'] // Highlight the current sub menu item
                                    ?  GlobalColors.orangeColor 
                                    : hovering // Change color on hover
                                      ? GlobalColors.orangeColor
                                      : GlobalColors.secondColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })(),
                );
                // Add divider if it's not the last one
                if (i < children.length - 1) {
                  entries.add(const PopupMenuDivider(height: 1));
                }
              }
              return entries; // Return the list of sub items
            },
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (_) {
                setState(() {
                  _isDesktopAboutOpen = true;
                });
              },
              child: CustomNavItem( 
                key: ValueKey(item['label']), // Trigger animation on color change
                icon: item['icon'],
                label: item['label'],
                isActive: isActive,
                onPressed: () {}, // Disabled since PopupMenuButton handles tap
                defaultColor: widget.defaultColor,
                hoverColor: widget.hoverColor,
                animationDelay: Duration(milliseconds: (i + 1) * 200),
                enableTap: false,
                forceHover: _isDesktopAboutOpen || (widget.currentItem=='À propos'), // Keep highlight active during dropdown open
              ),
            ) 
          )
        )
        : ExpansionTile( // Mobile version for the sub items
          onExpansionChanged: (isOpen) {
            setState(() {
              _isMobileAboutOpen = isOpen;
            });
          },
          tilePadding: EdgeInsets.zero,
          title: CustomNavItem( 
            key: ValueKey(item['label']), // Trigger animation on color change
            icon: item['icon'],
            label: item['label'],
            isActive: isActive,
            onPressed: () {},
            defaultColor: widget.defaultColor,
            hoverColor: widget.hoverColor,
            enableHover: false,
            animationDelay: Duration(milliseconds: (i + 1) * 200),
            enableTap: false,
            forceHover: _isMobileAboutOpen || (widget.currentItem=='À propos'), // Keep highlight active during dropdown open
          ),
          children: List.generate(children.length * 2 - 1, (index) { // Allows switching between ListTile (for submenus) and Container (for dividers),
            if (index.isEven) { // Check if index is an even number
              final e = children[index ~/ 2 ];
              
              return (() {
                bool hovering = false;
                return StatefulBuilder(
                  builder: (context2, setState2) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState2(() => hovering = true),
                      onExit: (_) => setState2(() => hovering = false),
                      child: GestureDetector(
                        onTap: () {
                          widget.onItemSelected(e['subLabel']);
                          Navigator.pushNamed(context, e['route']);
                        },
                        child: Container(
                          height: 45.0,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          color: 
                          hovering // Background on hover
                            ? GlobalColors.secondColor.withValues(alpha: 0.03) 
                            : Colors.transparent,
                            //  Colors.transparent,
                          child: Text(
                            e['subLabel'],
                            style: TextStyle(
                              fontSize: 16.0,                            
                              color: widget.currentSubItem == e['subLabel'] || hovering // // Highlight the current sub menu item or change color on hover
                                ? GlobalColors.orangeColor
                                : GlobalColors.secondColor,
                            ),
                          ),
                        ),
                      )
                    );  
                  }
                );
              })();
            } else { // Otherwise index is an odd number
              return Padding( // Divider
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 1.0,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              );
            }
          })
        );
      } else {
        // Creation of the others menu items without sub items
        navWidget = MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CustomNavItem( 
            key: ValueKey(item['label']), // Trigger animation on color change
            icon: item['icon'],
            label: item['label'],
            isActive: isActive,
            onPressed: () {
              widget.onItemSelected(item['label']);
              Navigator.pushNamed(context, item['route']);
            },
            defaultColor: widget.defaultColor,
            hoverColor: widget.hoverColor,
            animationDelay: Duration(milliseconds: (i + 1) * 200),
          )
        );
      }

      items.add(navWidget);
      if (i != navItemsData.length - 1 && widget.isHorizontal) {
        items.add(Text('|', style: TextStyle(color: widget.defaultColor, fontSize: 18)));
      }
    }

    // Return navigation row (desktop) or column (mobile)
    return widget.isHorizontal
    ? Row(
      children: items.map((e) => Padding(
        padding: EdgeInsets.symmetric(horizontal:  isSmallScreen ? 12.0 : 24.0, vertical: 8.0),
        child: e,
      )).toList(),
    )
    : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items //.where((item) => item is! Text).toList()); // Syntax for Exclude horizontal separators for vertical layout if this is not handled in the code
    );
  }
}

class CustomNavItem extends StatefulWidget {
  const CustomNavItem({super.key, 
  required this.icon, 
  required this.label, 
  required this.onPressed, 
  required this.defaultColor, 
  required this.hoverColor,
  this.enableHover = true, 
  required this.animationDelay,
  required this.isActive,
  this.enableTap = true,
  this.forceHover = false,
  });

  final IconData icon;
  final String label; 
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color hoverColor;
  final bool enableHover;
  final Duration animationDelay;
  final bool isActive;
  final bool enableTap;
  final bool forceHover;

  @override
  CustomNavItemstate createState() => CustomNavItemstate();
}

class CustomNavItemstate extends State<CustomNavItem> with SingleTickerProviderStateMixin {
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

     if (widget.forceHover != oldWidget.forceHover) {
       setState(() {
         if (widget.forceHover) {
           _textColor       = widget.hoverColor;
           _backgroundColor = widget.hoverColor.withValues(alpha: 0.2);
         } else {
           _textColor       = widget.defaultColor;
           _backgroundColor = Colors.transparent;
         }
       });
     }

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
      onEnter: (event) {
          setState(() {
            _textColor = widget.hoverColor; // Change text color on hover
            _backgroundColor =  const Color.fromARGB(255, 241, 237, 237); // Add background on hover
          });
      }, 
      onExit: (event) {
        if (!widget.forceHover) {
          setState(() {
            _textColor = widget.defaultColor; // Reset text color
            _backgroundColor = Colors.transparent; // Remove background
          });
        }
      },
      child: mobile 
      // Mobile navigation menu
      ? SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            color: widget.enableHover == true ? _backgroundColor : null,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // padding to repeat in ExpansionTile
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
        child: widget.enableTap
        ? GestureDetector(
          onTap: widget.onPressed,
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
              fontSize: isSmallScreen ? 16.0 : 18.0,
            ),
          ),
        )
        : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
                fontSize: isSmallScreen ? 16.0 : 18.0,
              ),
            ),
            const SizedBox(width: 8.0,),
            Icon(
              Icons.arrow_drop_down_sharp,
              color:widget.isActive ? GlobalColors.orangeColor : _textColor,
              size: 25.0,
            )
          ],
        )  
      ) 
    );
  }
}


// // Simple NavItem without sub items
// import 'package:flutter/material.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_screen_sizes.dart';

// class NavItems extends StatelessWidget {
//   const NavItems({super.key, 
//   required this.defaultColor, 
//   required this.hoverColor, 
//   this.isHorizontal = true,
//   required this.currentItem,
//   required this.onItemSelected,
//   });

//   final Color defaultColor;
//   final Color hoverColor;
//   final bool isHorizontal; // Whether the menu is displayed horizontally
//   final String currentItem; // The currently active menu item
//   final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> navItemsData = [
//       {'icon': Icons.dashboard, 'label': 'Accueil', 'route': '/landing'},
//       {'icon': Icons.info, 'label': 'À propos', 'route': '/about'},
//       {'icon': Icons.folder_open, 'label': 'Projets', 'route': '/projects'},
//       {'icon': Icons.contact_mail, 'label': 'Contact', 'route': '/contact'},
//       {'icon': Icons.article, 'label': 'Mentions légales', 'route': '/legalMontions'},
//     ];

//     final layoutItems = List.generate(navItemsData.length * 2 - 1, (index) {
//       bool mobile = GlobalScreenSizes.isMobileScreen(context);
//       bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);

//       if (index.isEven) { // Index even → menu item
//         final item = navItemsData[index ~/ 2]; // Access the correct element
//         final bool isLastItem = index ~/ 2 == navItemsData.length - 1; // Check if it is the last element

//         return AnimatedSwitcher( // Animation: Smooth transition of color change
//           duration: const Duration(milliseconds: 300),
//           child: Padding(
//             padding: mobile 
//             ? EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0) 
//             : EdgeInsets.only(
//               left: isSmallScreen ? 15.0 : 30.0, 
//               right: isSmallScreen ? 15.0 : (isLastItem ? 0.0 : 30.0), // If it's the last one, don't put padding on the left
//             ),
//             child: CustomNavItem( 
//               key: ValueKey(defaultColor), // Trigger animation on color change
//               icon: item['icon'],
//               label: item['label'],
//               isActive: currentItem == item['label'],
//               onPressed: () {
//                 onItemSelected(item['label']);
//                 Navigator.pushNamed(context, item['route']);
//               },
//               defaultColor: defaultColor,
//               hoverColor: hoverColor,
//               animationDelay: Duration(milliseconds: (index ~/ 2 + 1) * 200),
//             )
//           )
//         );
//       } else { // Index odd → divider
//         return isHorizontal // Menu format management if horizontal
//           ? Text('|', style: TextStyle(color: defaultColor, fontSize: 18))
//           : Divider(
//               color: GlobalColors.dividerColor1,
//               thickness: 1.0,
//               indent: 20.0,
//               endIndent: 20.0,
//             );
//       }
//     });

//     // Choose the layout: horizontal row or vertical column.
//     return isHorizontal
//       ? Row(children: layoutItems)
//       : Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: layoutItems //.where((item) => item is! Text).toList()); // Syntax for Exclude horizontal separators for vertical layout if this is not handled in the code
//       );
//   }
// }

// class CustomNavItem extends StatefulWidget {
//   const CustomNavItem({super.key, 
//   required this.icon, 
//   required this.label, 
//   required this.onPressed, 
//   required this.defaultColor, 
//   required this.hoverColor, 
//   required this.animationDelay,
//   required this.isActive,
//   });

//   final IconData icon;
//   final String label; 
//   final VoidCallback onPressed;
//   final Color defaultColor;
//   final Color hoverColor;
//   final Duration animationDelay;
//   final bool isActive;

//   @override
//   CustomdrawerItemstate createState() => CustomdrawerItemstate();
// }

// class CustomdrawerItemstate extends State<CustomNavItem> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Color _textColor;
//   late Color _backgroundColor;

//   @override
//   void initState() {
//     super.initState();
//     _textColor = widget.defaultColor;
//     _backgroundColor = Colors.transparent;

//     // Animation controller for the slide-in animation
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this
//     );

//     // Slide animation (starts offscreen and moves to position)
//     _slideAnimation = Tween<Offset> (
//       begin: const Offset(9.0, 0.0), // Start position (off-screen to the right)
//       end: Offset.zero, // End position (default location)
//     ).animate(CurvedAnimation(
//       parent: _controller, 
//       curve: Curves.easeInOut,
//     ));

//     Future.delayed(widget.animationDelay, () {
//       if (mounted) {
//         _controller.forward(); // Run the animation
//       }
//     });
//   }

//   // Automatically update _textColor when widget.defaultColor changes.
//   @override
//   void didUpdateWidget(CustomNavItem oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // Comparison between old color and new
//     if (widget.defaultColor != oldWidget.defaultColor) {
//       setState(() {
//         _textColor = widget.defaultColor; // Automatically update _textColor
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose of animation controller to free memory
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     bool mobile = GlobalScreenSizes.isMobileScreen(context);
//     bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);

//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           _textColor = widget.hoverColor; // Change text color on hover
//           _backgroundColor = const Color.fromARGB(255, 241, 237, 237); // Add background on hover
//         });
//       }, 
//       onExit: (_) {
//         setState(() {
//           _textColor = widget.defaultColor; // Reset text color
//           _backgroundColor = Colors.transparent; // Remove background
//         });
//       },
//       child: mobile 
//       // Mobile navigation menu
//       ? SlideTransition(
//         position: _slideAnimation,
//         child: GestureDetector(
//           onTap: widget.onPressed,
//           child: Container(
//             color:  _backgroundColor,
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
//             child: Row(
//               children: [
//                 Icon(
//                   widget.icon,
//                   color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
//                 ),
//                 const SizedBox(width: 8.0,),
//                 Text(
//                  widget.label,
//                  style: TextStyle(
//                     color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
//                    fontSize: isSmallScreen ? 16.0 : 18.0,
//                  ),
//                 ),
//               ],
//             ) 
//           ) 
//         ),
//       )
//       // Web navigation menu
//       : MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: GestureDetector(
//           onTap: widget.onPressed,
//           child: Text(
//             widget.label,
//             style: TextStyle(
//               color: widget.isActive ? GlobalColors.orangeColor : _textColor, // logic for the color change depending on the page you are on
//               fontSize: isSmallScreen ? 16.0 : 18.0,
//             ),
//           ),
//         ),
//       ) 
//     );
//   }
// }