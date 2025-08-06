import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/landing_screen.dart';
import './screens/about_screen.dart';
import './screens/contact_screen.dart';
import './screens/splash_screen.dart';
import './screens/projects_screen.dart';
import './screens/legal_montion_screen.dart';
import './screens/privacy_policy_screen.dart';
import './screens/partners_screen.dart';
import './manager/cookies_overlay_manager.dart';
import './manager/inject_google_maps_script_manager.dart';
import './utils/global_colors.dart';
import './utils/global_others.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: 'local.env'); // Load environment variables from the local.env file
    injectGoogleMapsScript(); // Inject the Google Maps script for web only
    runApp(const MyApp());
  } catch (error) {
    debugPrint('Error loading local.env file: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Allows to exclude the named pages from the display of cookie management
  bool isRouteExcluded(String route) {
    return route == '/';
  }

  // Add cookie management at the top of each page
  Widget routeWithCookiesOverlay(String route, Widget child) {
    return isRouteExcluded(route)
      ? child
      : CookiesOverlayManager(child: child);
  }

  // This widget is the root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GlobalPersonalData.companyName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        canvasColor: GlobalColors.firstColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => routeWithCookiesOverlay('/', SplashScreen()),
        '/landing': (context) => routeWithCookiesOverlay('/landing', LandingScreen()),
        '/projects': (context) => routeWithCookiesOverlay('/projects', ProjectsScreen()),
        '/contact': (context) => routeWithCookiesOverlay('/contact', ContactScreen()),
        '/about': (context) => routeWithCookiesOverlay('/about', AboutScreen()),
        '/legalMontions': (context) => routeWithCookiesOverlay('/legalMontions', LegalMontionScreen()),
        '/privacyPolicy': (context) => routeWithCookiesOverlay('/privacyPolicy', PrivacyPolicyScreen()),
        '/partners': (context) => routeWithCookiesOverlay('/partners', PartnersScreen()),
      }
    );
  }
}