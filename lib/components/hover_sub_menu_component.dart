import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class HoverSubMenuComponent extends StatefulWidget {
  const HoverSubMenuComponent({
    super.key,
    required this.label,
    required this.items,
    required this.defaultColor,
    required this.hoverColor,
    required this.currentSubItem,
    required this.onItemSelected,
  });

  final Widget label; // widget CustomNavItem which only manages the menu title
  final List<Map<String, String>> items; // Array with the submenus     
  final Color defaultColor; 
  final Color hoverColor;
  final String currentSubItem;
  final ValueChanged<String> onItemSelected;

  @override
  HoverSubMenuComponentState createState() => HoverSubMenuComponentState();
}

class HoverSubMenuComponentState extends State<HoverSubMenuComponent> with SingleTickerProviderStateMixin{
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _entry;
  Timer? _hideTimer; // timer to close the menu after a short delay
  /// Contrôleur et Tween pour l’effet “drop in” / “lift up”
  late final AnimationController _animController;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation dropdown menu
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic, 
    );

    // When the reverse animation is finished, we finally remove the overlay
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _removeOverlay(); // Already present here therefore not necessary in dispose
      }
    });
  }
  // Will close the menu if there is no more hover
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 200), () { // Time before disappearing
    _animController.reverse();
    });
  }

  // Cancels the closing timer (when we hover back)
  void _cancelHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  // Immediately remove the OverlayEntry (close the menu)
  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
  }

  // Displays the dropdown menu under the title, via an OverlayEntry
  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox; // Allows to retrieve the exact dimensions
    final size = renderBox.size; // Allows you to position the dropdown directly under the menu title
    
    if (_entry != null) return; // // If already displayed, we do not reinsert
    
    _entry = OverlayEntry(builder: (context) {
    final bool mobile = GlobalScreenSizes.isMobileScreen(context);
    final bool isSmallScreen = GlobalScreenSizes.isSmallScreen(context);

    return Positioned(
      width: isSmallScreen ? 145.0 : 200.0, // The desired with of the container for each sub-menu
      child: CompositedTransformFollower( // // allows the overlay to stick and follow the position of title menu
        link: _layerLink, // Connect your overlay to the title's position
        showWhenUnlinked: false, // Guarantees that it remains hidden if this connection is ever broken.
        offset: Offset(isSmallScreen ? -27.0 : -48.0, size.height), // menu offset from the bottom of the title
        child: MouseRegion( // For the list containing the entire dropdown menu
          onEnter: (_) => _cancelHideTimer(),
          onExit:  (_) => _startHideTimer(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 38.0), // Space between the title and the start of the dropdown menu (if one wants a menu distant from the title)
              ClipRect( // This allows you not to see what is outside the frame.
                child: SizeTransition(
                  axis: Axis.vertical,
                  axisAlignment: -1.0, // // 0 = centre, -1 = top
                  sizeFactor: _sizeAnimation, // Anime the height of 0 → 1
                  child: Material(
                    elevation: 4.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items.map((index) {
                        // Bool local for EACH sub-element
                        bool hovering = false;

                        return StatefulBuilder(
                          builder: (context2, setHover) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setHover(() => hovering = true),
                              onExit:  (_) => setHover(() => hovering = false),
                              child: InkWell(
                                onTap: () {
                                  _removeOverlay();
                                  widget.onItemSelected(index['subLabel']!);
                                  Navigator.pushNamed(context2, index['route']!);
                                },
                                child: Container(
                                  height: 45.0,
                                  padding: EdgeInsets.only(left: isSmallScreen ? 5.0 : 10.0, right: isSmallScreen ? 5.0 : 10.0),
                                  alignment: Alignment.centerLeft,
                                  color: hovering
                                    ? Colors.black.withValues(alpha: 0.03)
                                    : Colors.transparent,
                                  child: Text(
                                    index['subLabel']!,
                                    style: TextStyle(
                                      fontSize: mobile || isSmallScreen  ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                      color: hovering || widget.currentSubItem == index['subLabel']
                                        ? widget.hoverColor
                                        : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList()
                    ),
                  ), 
                )
              )
            ],
          ),
        ),
      ),
    );
  });
    //Insert the overlay into the Flutter overlay tree
    Overlay.of(context).insert(_entry!);

    // Start the animation 
    _animController.forward();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget( // Records its position/size of menu title
      // Allows CompositedTransformFollower to position the overlay here
      link: _layerLink, // Connect your overlay to the title's position
      child: MouseRegion( // To display the dropdown menu when hovering over the menu title
        onEnter: (_) {
          _cancelHideTimer(); // On enter, cancel the function of hiding the dropdown menu.
          _showOverlay(context);
        },
        onExit: (_) {
          _startHideTimer(); // On exit, activate the function to hide the dropdown menu
        },
        child: widget.label, // Menu Title
      ),
    );
  }
}