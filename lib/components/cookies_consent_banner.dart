import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/global_colors.dart'; 

class CookiesConsentBanner extends StatefulWidget {
  const CookiesConsentBanner({
    super.key,
    required this.onConsentGiven, // Function triggered when global consent is given.
    required this.onConsentLoaded, // Function triggered when loading initial cookie states.
    required this.toggleVisibility, // Function to toggle the visibility of the banner.
  });

  final Function(bool) onConsentGiven; // Callback for global cookie consent.
  final Function(bool?) onConsentLoaded; // Callback to inform parent widget about cookie state.
  final VoidCallback toggleVisibility; // Callback to manage banner toggling.

  @override
  CookiesConsentBannerState createState() => CookiesConsentBannerState();
}

class CookiesConsentBannerState extends State<CookiesConsentBanner> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool isManagingCookies = false; // Tracks whether the user is managing cookies.
  bool globalConsentCookies = false; // Controls the "Select All" checkbox.
  bool necessaryCookies = true; // Always active; required for site functionality.
  bool preferencesCookies = false; 
  bool statisticsCookies = false; 
  bool marketingCookies = false;
  bool _hovering = false; // Tracks hover state for the "Learn More" link.

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset> (
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double> (
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _loadConsentStatus(); // Loads saved cookie preferences from SharedPreferences.
  }

  // Retrieves saved preferences from SharedPreferences.
  Future<void> _loadConsentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final cookiesConsent = prefs.getBool('necessaryCookies'); // Retrieves the consent for necessary cookies.

    // Loads the states of individual cookie preferences or defaults to `false`.
    setState(() {
      preferencesCookies = prefs.getBool('preferencesCookies') ?? false;
      statisticsCookies = prefs.getBool('statisticsCookies') ?? false;
      marketingCookies = prefs.getBool('marketingCookies') ?? false;

      // Updates the global consent checkbox based on individual cookie states.
      _updateGlobalConsent();
    });

    widget.onConsentLoaded(cookiesConsent); // Notifies parent widget about loaded cookie states.
  }

  // Saves the global consent status to SharedPreferences.
  Future<void> _saveConsentStatus(bool consentGiven) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('necessaryCookies', true); // Necessary cookies are always enabled.
    await prefs.setBool('preferencesCookies', true);
    await prefs.setBool('statisticsCookies', true);
    await prefs.setBool('marketingCookies', true);
  }

  // Saves individual cookie preferences to SharedPreferences.
  Future<void> _saveConsentPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('necessaryCookies', true); // Necessary cookies are always enabled.
    await prefs.setBool('preferencesCookies', preferencesCookies);
    await prefs.setBool('statisticsCookies', statisticsCookies);
    await prefs.setBool('marketingCookies', marketingCookies);
  }

  // Automatically checks or unchecks the "Select All" checkbox based on individual states.
  void _updateGlobalConsent() {
    setState(() {
      globalConsentCookies = preferencesCookies && statisticsCookies && marketingCookies;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  // Decides between showing the consent banner or cookie management screen.
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: isManagingCookies
          ? _buildCookiesManager() // Shows the cookie management screen.
          : _buildConsentBanner(), // Shows the main banner.
        ),
      ),
    );
  }

  /// Main banner widget displaying cookie information.
  Widget _buildConsentBanner() {
    return Container(
      width: 400, 
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: GlobalColors.primaryColor, 
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 128), // Subtle shadow for depth.
            blurRadius: 5.0,
            offset: const Offset(0, 2), // Position of the shadow.
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left.
        mainAxisSize: MainAxisSize.min, // Adjusts height dynamically based on content.
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left.
                mainAxisSize: MainAxisSize.min, // Adjusts height dynamically based on content.
                children: [
                   const Text(
                    "Ce site utilise",
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  const Text(
                    "des Cookies",
                    style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),    
              SvgPicture.asset(
                "assets/cookie.svg",
                width: 40,
                height: 40,
                semanticsLabel: 'A cookie icon',
              ),
            ]
          ),
          Divider(
            color: Colors.grey[100],
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
          RichText(
            textAlign: TextAlign.justify, // Justified text for cleaner appearance.
            text: TextSpan(
              text: "Sio2 Rénovations utilise des cookies pour améliorer la navigation sur son site web, pour vous proposer une expérience plus personnalisée, des publicités ciblées et pour recueillir des données afin de vous offrir un réel suivi. Pour en savoir plus sur les différents types de cookies utilisés, consultez la politique relative à la protection des données. ",
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                height: 1.5, // Line spacing for readability.
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline, // Aligns with the main text baseline.
                  baseline: TextBaseline.alphabetic,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Displays a "pointer" cursor on hover.
                    onEnter: (_) => setState(() {
                      _hovering = true; // Changes hover state on entry.
                    }),
                    onExit: (_) => setState(() {
                      _hovering = false; // Reverts hover state on exit.
                    }),
                    child: GestureDetector(
                      onTap: () async {
                        const url = 'https://www.sio2renovations.com/';
                        try {
                          await launchUrl(Uri.parse(url));
                        } catch (error) {
                          throw 'Could not launch $url, error: $error';
                        }
                      },
                      child: Text(
                        "En savoir plus",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: !_hovering ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: Colors.grey[100],
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isManagingCookies = true; // Opens the cookie management screen.
                  });
                },
                child: const Text('Je choisis'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  widget.onConsentGiven(true);
                  _saveConsentStatus(true);
                  _animationController.reverse(); // Slide-out + Fade-out
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.navItemsHover,
                  foregroundColor: Colors.white,
                ),
                child: const Text('J\'ai compris et j\'accepte'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Cookie management screen with individual cookie preferences.
  Widget _buildCookiesManager() {
    return Container(
      width: 600,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 125), // Subtle shadow for depth.
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gérer vos préférences de cookies",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            "Choisissez comment nous collectons et utilisons vos données pour une meilleure expérience de navigation sur notre site. Votre vie privée est primordiale et vous avez le plein contrôle ici.",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10.0),
          Divider(
            color: Colors.grey[100],
            thickness: 1.0,
          ),
          CheckboxListTile(
            title: const Text(
              "Tout sélectionner",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            activeColor: Colors.black,
            value: globalConsentCookies,
            onChanged: (bool? value) {
              setState(() {
                globalConsentCookies = value ?? false;
                preferencesCookies = value ?? false;
                statisticsCookies = value ?? false;
                marketingCookies = value ?? false;
              });
            },
          ),
          const SizedBox(height: 10.0),
          Container(
            // Box for detailed cookie preferences with individual checkboxes.
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey[100]!,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              color: Colors.grey[50]!,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns all items in the center.
              children: [
                // Checkbox for "Necessary Cookies" (always active and uneditable).
                CheckboxListTile(
                  title: const Text(
                    "Nécessaires (Toujours activés)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Les cookies nécessaires contribuent à rendre un site web utilisable en activant des fonctions de base comme la navigation de page et l\'accès aux zones sécurisées du site web, enregistrer vos préférences pour les réglages de cookie. Le site web ne peut pas fonctionner correctement sans ces cookies.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5, // Line spacing for improved readability.
                    ),
                  ),
                  activeColor: Colors.black,
                  value: necessaryCookies, // Always true.
                  onChanged: null, // Cannot be changed by the user.
                ),
                Divider(
                  color: Colors.grey[200], // Divider to separate sections.
                  thickness: 1.0,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Préférences",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Les cookies de préférences permettent à un site web de retenir des informations qui modifient la manière dont le site se comporte ou s’affiche, comme votre langue préférée ou la région dans laquelle vous vous situez.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  activeColor: Colors.black,
                  value: preferencesCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      preferencesCookies = value ?? false; // Updates preferences state.
                      _updateGlobalConsent(); // Updates global consent if needed.
                    });
                  },
                ),
                Divider(
                  color: Colors.grey[200],
                  thickness: 1.0,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Statistiques",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  activeColor: Colors.black,
                  subtitle: const Text(
                    'Les cookies statistiques aident les propriétaires du site web, par la collecte et la communication d\'informations de manière anonyme, à comprendre comment les visiteurs interagissent avec les sites web.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  value: statisticsCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      statisticsCookies = value ?? false; // Updates statistics state.
                      _updateGlobalConsent(); // Updates global consent.
                    });
                  },
                ),
                Divider(
                  color: Colors.grey[200],
                  thickness: 1.0,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Marketing",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Les cookies marketing sont utilisés pour effectuer le suivi des visiteurs au travers des sites web. Le but est d\'afficher des publicités qui sont pertinentes et intéressantes pour l\'utilisateur individuel et donc plus précieuses pour les éditeurs et annonceurs tiers',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  activeColor: Colors.black,
                  value: marketingCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      marketingCookies = value ?? false; // Updates marketing state.
                      _updateGlobalConsent(); // Updates global consent if necessary.
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: Colors.grey[100],
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  widget.onConsentGiven(true); // Signals global consent to the parent.
                  await _saveConsentPreferences(); // Saves preferences to persistent storage.
                  _animationController.reverse();
                  setState(() {
                    isManagingCookies = false; // Returns to the main banner screen.
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.navItemsHover,
                  foregroundColor: Colors.white, 
                ),
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
