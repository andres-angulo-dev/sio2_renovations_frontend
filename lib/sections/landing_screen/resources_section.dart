// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../data/articles_data.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_others.dart';
import '../../utils/global_screen_sizes.dart';

class ResourcesSection extends StatefulWidget {
  const ResourcesSection({super.key});

  @override
  ResourcesSectionState createState() => ResourcesSectionState();
}

class ResourcesSectionState extends State<ResourcesSection> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late List<bool> _isHoveredList;

  // Couleurs internes aux cartes uniquement (fond sombre des overlays)
  static const Color _onSurface = Color(0xFFE5E2E1);
  static const Color _onSurfaceVariant = Color(0xFFDBC2AF);

  @override
  void initState() {
    super.initState();
    _isHoveredList = List.generate(articlesData.length, (_) => false);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _openUrl(String url) {
    // Replace current history entry with the scroll URL so history.back() lands
    // on /?scroll=ressources and Flutter auto-scrolls to the resources section
    html.window.history.replaceState(null, '', '/?scroll=ressources');
    final separator = url.contains('?') ? '&' : '?';
    final fullUrl = '$url${separator}return=${Uri.encodeComponent('${Uri.base.origin}/?scroll=ressources')}';
    html.window.location.href = fullUrl;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = isMobile ? 24.0 : 160.0;
    final double availableWidth = screenWidth - horizontalPadding * 2;
    final double cardWidth = isMobile ? availableWidth : (availableWidth - 32.0) / 2;
    final double cardHeight = cardWidth * 0.55;

    return VisibilityDetector(
      key: const Key('resources-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_fadeController.isCompleted) {
          _fadeController.forward();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Titre — même style que les autres sections du site
              Text(
                "RESSOURCES & CONSEILS",
                style: TextStyle(
                  fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.thirdColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              // Sous-titre
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640.0),
                child: Text(
                  "Des conseils d'experts pour mieux préparer votre projet",
                  style: TextStyle(
                    fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60.0),
              // Cards grid
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCard(0, cardWidth, cardHeight, isMobile),
                        const SizedBox(height: 24.0),
                        _buildCard(1, cardWidth, cardHeight, isMobile),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 32.0,
                      children: [
                        _buildCard(0, cardWidth, cardHeight, isMobile),
                        _buildCard(1, cardWidth, cardHeight, isMobile),
                      ],
                    ),
              const SizedBox(height: 48.0),
              // CTA — pattern TextButton du site
              TextButton(
                onPressed: () => _openUrl("https://hub.sio2renovations.com/articles?ref=sio2renovations"),
                style: TextButton.styleFrom(
                  backgroundColor: GlobalColors.fourthColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                ),
                child: Text(
                  "Voir toutes nos ressources",
                  style: TextStyle(
                    fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                    color: GlobalColors.thirdColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index, double width, double height, bool isMobile) {
    final item = articlesData[index];
    final String badge = index == 0 ? "APPARTEMENT" : "SALLE DE BAINS";

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHoveredList[index] = true),
      onExit: (_) => setState(() => _isHoveredList[index] = false),
      child: GestureDetector(
        onTap: () => _openUrl(item["url"]!),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                // Image — zooms IN on hover (group-hover:scale-105)
                Positioned.fill(
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 700),
                    tween: Tween<double>(
                      begin: 1.0,
                      end: _isHoveredList[index] ? 1.05 : 1.0,
                    ),
                    curve: Curves.easeInOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Image.network(
                          item["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(color: const Color(0xFF1C1B1B));
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(color: const Color(0xFF1C1B1B));
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Gradient overlay: transparent → black/40 → black/90
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.9),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
                // Card content — pinned to bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Orange category badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: GlobalColors.orangeColor.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        // Article title
                        Text(
                          item["title"]!,
                          style: TextStyle(
                            color: _onSurface,
                            fontSize: isMobile ? 20.0 : 26.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        // Description
                        Text(
                          item["description"]!,
                          style: TextStyle(
                            color: _onSurfaceVariant.withValues(alpha: 0.8),
                            fontSize: isMobile ? 13.0 : GlobalSize.webSizeText,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // "Découvrir →" — always visible, orange text link
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Découvrir",
                              style: TextStyle(
                                color: GlobalColors.orangeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: GlobalSize.webSizeText,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            AnimatedSlide(
                              offset: _isHoveredList[index] ? const Offset(0.3, 0) : Offset.zero,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(
                                Icons.arrow_right_alt,
                                color: GlobalColors.orangeColor,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
