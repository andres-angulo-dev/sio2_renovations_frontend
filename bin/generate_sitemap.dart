import 'dart:io';
import 'package:sio2_renovations_frontend/utils/global_routes.dart';

void main() {
  final domain = domaine;
  final buffer = StringBuffer();

  buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
  buffer.writeln('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">');

  for (final route in GlobalRoutes.routes) {
    final loc = '$domain${route.path}';

    buffer.writeln('  <url>');
    buffer.writeln('    <loc>$loc</loc>');
    buffer.writeln('    <lastmod>${route.lastModified}</lastmod>');
    buffer.writeln('    <changefreq>${route.changeFrequency}</changefreq>');
    buffer.writeln('    <priority>${route.priority}</priority>');
    buffer.writeln('  </url>');
  }

  buffer.writeln('</urlset>');

  final outputPath = 'build/web/sitemap.xml';

  File(outputPath).createSync(recursive: true);
  File(outputPath).writeAsStringSync(buffer.toString());

  print('✅ sitemap.xml généré avec domaine : $domain ✅');
}