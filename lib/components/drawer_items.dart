import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key, required this.defaultColor, required this.hoverColor, this.isHorizontal = true});

  final Color defaultColor;
  final Color hoverColor;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    final drawerItems = [
      SizedBox(height: 40.0),
      CustomNavItem(
        icon: Icons.dashboard,
        label: 'Accueil',
        onPressed: () => Navigator.pushNamed(context, '/landing'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
        animationDelay: const Duration(milliseconds: 100),
      ),
      isHorizontal ? 
      Text('|', style: TextStyle(color: defaultColor, fontSize: 18)) 
      : 
      Divider(
        color: GlobalColors.dividerColor1,
        thickness: 1.0,
        indent: 20.0,
        endIndent: 20.0
      ),
      CustomNavItem(
        icon: Icons.folder_open,
        label: 'Projets',
        onPressed: () => Navigator.pushNamed(context, '/projects'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
        animationDelay: const Duration(milliseconds: 200),
      ),
      isHorizontal ? 
      Text('|', style: TextStyle(color: defaultColor, fontSize: 18)) 
      : 
      Divider(
        color: GlobalColors.dividerColor1,
        thickness: 1.0,
        indent: 20.0,
        endIndent: 20.0
      ),      
      CustomNavItem(
        icon: Icons.info,
        label: 'À propos de nous',
        onPressed: () => Navigator.pushNamed(context, '/about'),
        defaultColor: defaultColor,
        hoverColor: hoverColor,
        animationDelay: const Duration(milliseconds: 300),
      ),
      isHorizontal ? 
      Text('|', style: TextStyle(color: defaultColor, fontSize: 18)) 
      : 
      Divider(
        color: GlobalColors.dividerColor1,
        thickness: 1.0,
        indent: 20.0,
        endIndent: 20.0
      ),      
      CustomNavItem(
        icon: Icons.contact_mail,
        label: 'Contact',
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        defaultColor: defaultColor,
        hoverColor: hoverColor,
        animationDelay: const Duration(milliseconds: 400),
      ),
      isHorizontal ? 
      Text('|', style: TextStyle(color: defaultColor, fontSize: 18)) 
      : 
      Divider(
        color: GlobalColors.dividerColor1,
        thickness: 1.0,
        indent: 20.0,
        endIndent: 20.0
      ),      
      CustomNavItem(
        icon: Icons.article,
        label: 'Mentions légales',
        onPressed: () => Navigator.pushNamed(context, '/legalMontions'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
        animationDelay: const Duration(milliseconds: 500),
      ),
    ];

    // Choose the layout: horizontal row or vertical column.
    return isHorizontal
      ? Row(children: drawerItems)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: drawerItems.where((item) => item is! Text).toList()); // Exclude horizontal separators for vertical layout
  }
}

class CustomNavItem extends StatefulWidget {
  const CustomNavItem({super.key, required this.icon, required this.label, required this.onPressed, required this.defaultColor, required this.hoverColor, required this.animationDelay});

  final IconData icon;
  final String label; 
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color hoverColor;
  final Duration animationDelay;

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

  @override
  void dispose() {
    _controller.dispose(); // Dispose of animation controller to free memory
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    bool mobile768 = MediaQuery.of(context).size.width > 768 ? false : true;
    bool mobile954 = MediaQuery.of(context).size.width > 954 ? false : true;
 
    return Padding(
      padding: mobile768 ? 
        EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0) 
        : 
        EdgeInsets.all(mobile954 ? 15.0 : 30.0),
      child: MouseRegion(
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
        child: mobile768 ? 
        SlideTransition(
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
                    color: _textColor,
                  ),
                  const SizedBox(width: 8.0,),
                  Text(
                   widget.label,
                   style: TextStyle(
                     color: _textColor,
                     fontSize: mobile954 ? 16.0 : 18.0,
                   ),
                  ),
                ],
              ) 
            ) 
          ),
        ) 
        : 
        GestureDetector(
          onTap: widget.onPressed,
          child: Text(
            widget.label,
            style: TextStyle(
              color: _textColor,
              fontSize: mobile954 ? 16.0 : 18.0,
            ),
          ),
        ),
      ),
    );
  }
}