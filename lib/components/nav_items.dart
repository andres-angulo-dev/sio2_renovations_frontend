import 'package:flutter/material.dart';

class NavItems extends StatelessWidget {
  const NavItems({super.key, required this.defaultColor, required this.hoverColor, this.isHorizontal = true});

  final Color defaultColor;
  final Color hoverColor;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    final navItems = [
      CustomNavItem(
        label: 'Accueil',
        onPressed: () => Navigator.pushNamed(context, '/landing'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
      CustomNavItem(
        label: 'Projets',
        onPressed: () => Navigator.pushNamed(context, '/projects'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
      CustomNavItem(
        label: 'À propos de nous',
        onPressed: () => Navigator.pushNamed(context, '/about'),
        defaultColor: defaultColor,
        hoverColor: hoverColor,
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
      CustomNavItem(
        label: 'Contact',
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        defaultColor: defaultColor,
        hoverColor: hoverColor,
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
      CustomNavItem(
        label: 'Mentions légales',
        onPressed: () => Navigator.pushNamed(context, '/legalMontions'), 
        defaultColor: defaultColor,
        hoverColor: hoverColor,
      ),
    ];

    return isHorizontal
      ? Row(children: navItems)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: navItems.where((item) => item is! Text).toList());
  }
}

class CustomNavItem extends StatefulWidget {
  const CustomNavItem({super.key, required this.label, required this.onPressed, required this.defaultColor, required this.hoverColor});

  final String label; 
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color hoverColor;

  @override
  CustomNavItemState createState() => CustomNavItemState();
}

class CustomNavItemState extends State<CustomNavItem> {
  late Color _textColor;

  @override
  void initState() {
    super.initState();
    _textColor = widget.defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    bool mobile768 = MediaQuery.of(context).size.width > 768 ? false : true;
    bool mobile954 = MediaQuery.of(context).size.width > 954 ? false : true;
 
    return Padding(
      padding: EdgeInsets.all(mobile768 ? 10.0 : mobile954 ? 15.0 : 30.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _textColor = widget.hoverColor),
        onExit: (_) => setState(() => _textColor = widget.defaultColor),
        child: GestureDetector(
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

// import 'package:flutter/material.dart';
// import 'package:widget_and_text_animator/widget_and_text_animator.dart';

// class NavItems extends StatelessWidget {
//   const NavItems({super.key, required this.defaultColor, required this.hoverColor, this.isHorizontal = true});

//   final Color defaultColor;
//   final Color hoverColor;
//   final bool isHorizontal;

//   @override
//   Widget build(BuildContext context) {
//     final navItems = [
//       CustomNavItem(
//         label: 'Accueil',
//         onPressed: () => Navigator.pushNamed(context, '/landing'), 
//         defaultColor: defaultColor,
//         hoverColor: hoverColor,
//         animationDelay: const Duration(milliseconds: 100),
//       ),
//       if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
//       CustomNavItem(
//         label: 'Projets',
//         onPressed: () => Navigator.pushNamed(context, '/projects'), 
//         defaultColor: defaultColor,
//         hoverColor: hoverColor,
//         animationDelay: const Duration(milliseconds: 200),
//       ),
//       if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
//       CustomNavItem(
//         label: 'À propos de nous',
//         onPressed: () => Navigator.pushNamed(context, '/about'),
//         defaultColor: defaultColor,
//         hoverColor: hoverColor,
//         animationDelay: const Duration(milliseconds: 300),
//       ),
//       if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
//       CustomNavItem(
//         label: 'Contact',
//         onPressed: () => Navigator.pushNamed(context, '/contact'),
//         defaultColor: defaultColor,
//         hoverColor: hoverColor,
//         animationDelay: const Duration(milliseconds: 400),
//       ),
//       if (isHorizontal) Text('|', style: TextStyle(color: defaultColor, fontSize: 18)),
//       CustomNavItem(
//         label: 'Mentions légales',
//         onPressed: () => Navigator.pushNamed(context, '/legalMontions'), 
//         defaultColor: defaultColor,
//         hoverColor: hoverColor,
//         animationDelay: const Duration(milliseconds: 500),
//       ),
//     ];

//     return isHorizontal
//       ? Row(children: navItems)
//       : Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: navItems.where((item) => item is! Text).toList());
//   }
// }

// class CustomNavItem extends StatefulWidget {
//   const CustomNavItem({super.key, required this.label, required this.onPressed, required this.defaultColor, required this.hoverColor, required this.animationDelay});

//   final String label; 
//   final VoidCallback onPressed;
//   final Color defaultColor;
//   final Color hoverColor;
//   final Duration animationDelay;

//   @override
//   CustomNavItemState createState() => CustomNavItemState();
// }

// class CustomNavItemState extends State<CustomNavItem> {
//   late Color _textColor;

//   @override
//   void initState() {
//     super.initState();
//     _textColor = widget.defaultColor;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool mobile768 = MediaQuery.of(context).size.width > 768 ? false : true;
//     bool mobile954 = MediaQuery.of(context).size.width > 954 ? false : true;
 
//     return mobile768 ? WidgetAnimator(
//       incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
//         duration: const Duration(milliseconds: 700),
//         delay: widget.animationDelay,
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(mobile768 ? 10.0 : mobile954 ? 15 : 30.0),
//         child: MouseRegion(
//           onEnter: (_) => setState(() => _textColor = widget.hoverColor),
//           onExit: (_) => setState(() => _textColor = widget.defaultColor),
//           child: GestureDetector(
//             onTap: widget.onPressed,
//             child: Text(
//               widget.label,
//               style: TextStyle(
//                 color: _textColor,
//                 fontSize: mobile954 ? 16.0 : 18.0,
//               ),
//             ),
//           )
//         ),
//       ),
//     ) : Padding(
//       padding: const EdgeInsets.symmetric(vertical: 400.0, horizontal: 300.0),

//         // padding: EdgeInsets.all(mobile768 ? 10.0 : mobile954 ? 15 : 30.0),
//         child: MouseRegion(
//           onEnter: (_) => setState(() => _textColor = widget.hoverColor),
//           onExit: (_) => setState(() => _textColor = widget.defaultColor),
//           child: GestureDetector(
//             onTap: widget.onPressed,
//             child: Text(
//               widget.label,
//               style: TextStyle(
//                 color: _textColor,
//                 fontSize: mobile954 ? 16.0 : 18.0,
//               ),
//             ),
//           )
//         ),
//       );
//   }
// }