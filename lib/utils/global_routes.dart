final domaine = 'https://www.sio2renovations.com';

// Contains the last update dates for each route
class GlobalDates {
  static const String lastUpdateMain = '2025-08-15'; 
  static const String lastUpdateLanding = '2025-08-15'; 
  static const String lastUpdateProjects = '2025-08-15'; 
  static const String lastUpdateContact = '2025-08-15'; 
  static const String lastUpdateAbout = '2025-08-15'; 
  static const String lastUpdateLegalMontions = '2025-08-15'; 
  static const String lastUpdatePrivacyPolicy = '2025-08-15'; 
  static const String lastUpdatePartners = '2025-08-15'; 
}

// For the sitemap
class RouteInfo {
  final String path;
  final String lastModified;
  final String changeFrequency;
  final String priority;

  const RouteInfo({
    required this.path,
    required this.lastModified,
    required this.changeFrequency,
    required this.priority,
  });
}

// Represents the routes and the information associated for the sitemap
class GlobalRoutes {
  static const List<RouteInfo> routes = [
    RouteInfo(
      path: '/',
      lastModified: GlobalDates.lastUpdateMain,
      changeFrequency: 'daily',
      priority: '1.0',
    ),
    RouteInfo(
      path: '/landing',
      lastModified: GlobalDates.lastUpdateLanding,
      changeFrequency: 'weekly',
      priority: '0.9',
    ),
    RouteInfo(
      path: '/projects',
      lastModified: GlobalDates.lastUpdateProjects,
      changeFrequency: 'weekly',
      priority: '0.9',
    ),
    RouteInfo(
      path: '/contact',
      lastModified: GlobalDates.lastUpdateContact,
      changeFrequency: 'monthly',
      priority: '0.8',
    ),
    RouteInfo(
      path: '/about',
      lastModified: GlobalDates.lastUpdateAbout,
      changeFrequency: 'monthly',
      priority: '0.8',
    ),
    RouteInfo(
      path: '/legalMontions',
      lastModified: GlobalDates.lastUpdateLegalMontions,
      changeFrequency: 'yearly',
      priority: '0.6',
    ),
    RouteInfo(
      path: '/privacyPolicy',
      lastModified: GlobalDates.lastUpdatePrivacyPolicy,
      changeFrequency: 'yearly',
      priority: '0.6',
    ),
    RouteInfo(
      path: '/partners',
      lastModified: GlobalDates.lastUpdatePartners,
      changeFrequency: 'monthly',
      priority: '0.7',
    ),
  ];
}