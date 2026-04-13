final domaine = 'https://www.sio2renovations.com';

// Contains the last update dates for each route.
// Update manually only when the content of that section actually changes.
class GlobalDates {
  static const String lastUpdateLanding = '2026-04-14';
  static const String lastUpdateProjects = '2026-04-13';
  static const String lastUpdateContact = '2026-04-13';
  static const String lastUpdateAbout = '2026-04-13';
  static const String lastUpdatePartners = '2026-04-13';
}

// For the sitemap — only path and lastModified are needed.
// changeFreq and priority are ignored by Google and removed to avoid noise.
class RouteInfo {
  final String path;
  final String lastModified;

  const RouteInfo({
    required this.path,
    required this.lastModified,
  });
}

// Routes included in sitemap.xml.
// Rules:
//   - SplashScreen (/) excluded — it is a loading transition, not indexable content.
//   - legalMentions and privacyPolicy excluded — zero SEO value.
//   - /landing is the real homepage and must be listed first.
class GlobalRoutes {
  static const List<RouteInfo> routes = [
    RouteInfo(
      path: '/landing',
      lastModified: GlobalDates.lastUpdateLanding,
    ),
    RouteInfo(
      path: '/projects',
      lastModified: GlobalDates.lastUpdateProjects,
    ),
    RouteInfo(
      path: '/contact',
      lastModified: GlobalDates.lastUpdateContact,
    ),
    RouteInfo(
      path: '/about',
      lastModified: GlobalDates.lastUpdateAbout,
    ),
    RouteInfo(
      path: '/partners',
      lastModified: GlobalDates.lastUpdatePartners,
    ),
  ];
}
