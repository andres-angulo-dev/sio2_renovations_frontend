import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  final bool mobile = false;

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    final List<Widget> navItems = [
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/landing'), 
        child: const Text('Accueil', style: TextStyle(color: Colors.white))
      ),
      const Text('|', style: TextStyle(color: Colors.white)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/projects'), 
        child: Text('Projets', style: TextStyle(color: Colors.white)),
      ),
      const Text('|', style: TextStyle(color: Colors.white)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/about'),
        child: Text('À propos de nous', style: TextStyle(color: Colors.white)),
      ),
      const Text('|', style: TextStyle(color: Colors.white)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        child: Text('Contact', style: TextStyle(color: Colors.white)),
      ),
      const Text('|', style: TextStyle(color: Colors.white)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/legalMontions'), 
        child: Text('Mentions légales', style: TextStyle(color: Colors.white)),
      ),
    ];
    
    return AppBar(
      toolbarHeight: mobile ? null : 300,
      leadingWidth: mobile ? null : 200,
      backgroundColor: Colors.red,
      leading: mobile ?
        null
        :
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/landing'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),  
            child: Image.asset(
              'assets/Black.png',
              fit: BoxFit.contain,
            ),
          ) 
        ),
      actions: mobile ? null : navItems,
    );
  }

  @override
  Size get preferredSize => mobile ? const Size.fromHeight(kToolbarHeight) : const Size.fromHeight(100.0);
}