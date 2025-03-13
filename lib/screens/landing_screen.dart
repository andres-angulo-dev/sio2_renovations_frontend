import 'package:flutter/material.dart';
import '../components/widgets/my_app_bar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  final bool mobile = false;
  
  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    // List<Widget> navItems = [
    //   ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/landing'), child: Text('Accueil')),
    //   ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/projects'), child: Text('Projets')),
    //   ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/about'), child: Text('À propos de nous')),
    //   ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/contact'), child: Text('Contact')),
    //   ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/legalMontions'), child: Text('Mentions légales'))
    // ];

    List<Widget> navItems = [
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
    
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Text('SLT'),
      ),
      drawer: mobile ? 
        Drawer(
          child: ListView(
            children: navItems,
          )
        )
        : 
        null,
    );
  }
}
