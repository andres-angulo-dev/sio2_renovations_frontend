import 'package:flutter/material.dart';

class NavItems extends StatelessWidget {
  const NavItems({super.key, required this.color, this.isHorizontal = true});

  final Color color;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    final navItems = [
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/landing'), 
        child: Text('Accueil', style: TextStyle(color: color, fontSize: 18))
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: color, fontSize: 18)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/projects'), 
        child: Text('Projets', style: TextStyle(color: color, fontSize: 18)),
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: color, fontSize: 18)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/about'),
        child: Text('À propos de nous', style: TextStyle(color: color, fontSize: 18)),
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: color, fontSize: 18)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        child: Text('Contact', style: TextStyle(color: color, fontSize: 18)),
      ),
      if (isHorizontal) Text('|', style: TextStyle(color: color, fontSize: 18)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/legalMontions'), 
        child: Text('Mentions légales', style: TextStyle(color: color, fontSize: 18)),
      ),
    ];

    return isHorizontal
      ? Row(children: navItems)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: navItems.where((item) => item is! Text).toList());
  }
}