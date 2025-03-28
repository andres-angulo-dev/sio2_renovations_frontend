import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import './screens/landing_screen.dart';
import './screens/about_screen.dart';
import './screens/contact_screen.dart';
import './screens/splash_screen.dart';
import './screens/projects_screen.dart';
import './screens/legal_montion_screen.dart';
import './screens/privacy_policy_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIO2 Rénovations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        canvasColor: GlobalColors.primaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/landing': (context) => LandingScreen(),
        '/projects': (context) => ProjectsScreen(),
        '/contact': (context) => ContactScreen(),
        '/about': (context) => AboutScreen(),
        '/legalMontions': (context) => LegalMontionScreen(),
        '/privacyPolicy': (context) => PrivacyPolicyScreen(),

      }
    );
  }
}