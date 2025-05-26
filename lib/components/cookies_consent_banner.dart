import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/my_hover_route_navigator.dart';
import '../utils/global_colors.dart'; 
import '../utils/global_others.dart';

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

  bool _isManagingCookies = false; // Tracks whether the user is managing cookies.
  bool _globalConsentCookies = false; // Controls the "Select All" checkbox.
  final bool _necessaryCookies = true; // Always active; required for site functionality.
  bool _preferencesCookies = false; 
  bool _statisticsCookies = false; 
  bool _marketingCookies = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Creates the slide animation to move the banner into view from the left
    _slideAnimation = Tween<Offset> (
      begin: const Offset(-1.0, 0.0), // Start off-screen (left)
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    // Creates the fade animation for smooth opacity changes
    _fadeAnimation = Tween<double> (
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    ));

    _animationController.forward(); // Starts the show animation
    _loadConsentStatus(); // Loads saved user cookie preferences 
  }

  // Loads saved cookie preferences from SharedPreferences and updates the state  
  Future<void> _loadConsentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final cookiesConsent = prefs.getBool('necessaryCookies'); // Check if necessary cookies were previously accepted

    // Loads the states of individual cookie preferences or defaults to `false`.
    setState(() {
      _preferencesCookies = prefs.getBool('preferencesCookies') ?? false;
      _statisticsCookies = prefs.getBool('statisticsCookies') ?? false;
      _marketingCookies = prefs.getBool('marketingCookies') ?? false;

      // Updates "Select All" status based on individual preferences
      _updateGlobalConsent();
    });

    widget.onConsentLoaded(cookiesConsent); // Notify parent about loaded consent state
  }

  // Saves the global consent status as "true" to SharedPreferences.
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
    await prefs.setBool('preferencesCookies', _preferencesCookies);
    await prefs.setBool('statisticsCookies', _statisticsCookies);
    await prefs.setBool('marketingCookies', _marketingCookies);
  }

  // Automatically checks or unchecks the "Select All" checkbox based on individual states.
  void _updateGlobalConsent() {
    setState(() {
      _globalConsentCookies = _preferencesCookies && _statisticsCookies && _marketingCookies;
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
          child: _isManagingCookies
          ? _buildCookiesManager() // Shows the cookie management screen.
          : _buildConsentBanner(), // Shows the main banner.
        ),
      ),
    );
  }

  // Constructs the main banner widget that displays cookie information.
  Widget _buildConsentBanner() {
    return Container(
      width: 400, 
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: GlobalColors.firstColor, 
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: GlobalColors.shadowColor, // Subtle shadow for depth.
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
                    style: TextStyle(fontSize: GlobalSize.mobileSizeText, color: GlobalColors.secondColor),
                  ),
                  const Text(
                    "des Cookies",
                    style: TextStyle(fontSize: 18.0, color: GlobalColors.secondColor, fontWeight: FontWeight.bold),
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
            color: GlobalColors.dividerColor2,
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
        // Description and "Learn More" link
          RichText(
            textAlign: TextAlign.justify, // Justified text for cleaner appearance.
            text: TextSpan(
              text: "Sio2 Rénovations utilise des cookies pour améliorer la navigation sur son site web, pour vous proposer une expérience plus personnalisée, des publicités ciblées et pour recueillir des données afin de vous offrir un réel suivi. Pour en savoir plus sur les différents types de cookies utilisés, consultez la politique relative à la protection des données. ",
              style: const TextStyle(
                fontSize: GlobalSize.mobileSizeText,
                color: GlobalColors.secondColor,
                height: 1.5, // Line spacing for readability.
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline, // Aligns with the main text baseline.
                  baseline: TextBaseline.alphabetic,
                  child: MyHoverRouteNavigator(routeName: '/privacyPolicy', text: 'En savoir plus')
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: GlobalColors.dividerColor2,
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
        // Action buttons for cookie preferences and consent
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isManagingCookies = true; // Opens the cookie management screen.
                  });
                },
                child: const Text('Je choisis'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  widget.onConsentGiven(true); // Trigger the consent action to parent widget
                  _saveConsentStatus(true);
                  _animationController.reverse(); // Triggers slide-out + Fade-out
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.orangeColor,
                  foregroundColor: GlobalColors.firstColor,
                ),
                child: const Text('J\'ai compris et j\'accepte'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builds the cookie management screen allowing users to select individual cookie preferences.
  Widget _buildCookiesManager() {
    return Container(
      width: 600,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: GlobalColors.firstColor, 
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: GlobalColors.shadowColor, // Subtle shadow for depth.
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
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: GlobalColors.secondColor),
          ),
          const Text(
            "Choisissez comment nous collectons et utilisons vos données pour une meilleure expérience de navigation sur notre site. Votre vie privée est primordiale et vous avez le plein contrôle ici.",
            style: TextStyle(
              fontSize: GlobalSize.mobileSizeText,
              color: GlobalColors.secondColor,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10.0),
          Divider(
            color: GlobalColors.dividerColor2,
            thickness: 1.0,
          ),
        // "Select All" Checkbox
          CheckboxListTile(
            title: const Text(
              "Tout sélectionner",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            activeColor: GlobalColors.secondColor,
            value: _globalConsentCookies,
            onChanged: (bool? value) {
              setState(() {
                _globalConsentCookies = value ?? false;
                _preferencesCookies = value ?? false;
                _statisticsCookies = value ?? false;
                _marketingCookies = value ?? false;
              });
            },
          ),
          const SizedBox(height: 10.0),
          // Individual Cookie Preferences with individual checkboxes.
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: GlobalColors.borderColor,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              color: GlobalColors.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns all items in the center.
              children: [
                // Checkbox for "Necessary Cookies" (always active and uneditable).
                _buildCheckbox(
                  title: "Nécessaires (Toujours activés)",
                  subtitle: 'Les cookies nécessaires contribuent à rendre un site web utilisable en activant des fonctions de base comme la navigation de page et l\'accès aux zones sécurisées du site web, enregistrer vos préférences pour les réglages de cookie. Le site web ne peut pas fonctionner correctement sans ces cookies.',
                  value: _necessaryCookies,
                  enable: false,
                ),
                Divider(
                  color: GlobalColors.dividerColor3, // Divider to separate sections.
                  thickness: 1.0,
                ),
                _buildCheckbox(
                  title: "Préférences",
                  subtitle: 'Les cookies de préférences permettent à un site web de retenir des informations qui modifient la manière dont le site se comporte ou s’affiche, comme votre langue préférée ou la région dans laquelle vous vous situez.',
                  value: _preferencesCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      _preferencesCookies = value ?? false; // Updates preferences state.
                      _updateGlobalConsent(); // Updates global consent.
                    });
                  }
                ),
                Divider(
                  color: GlobalColors.dividerColor3,
                  thickness: 1.0,
                ),
                _buildCheckbox(
                  title: "Statistiques",
                  subtitle: 'Les cookies statistiques aident les propriétaires du site web, par la collecte et la communication d\'informations de manière anonyme, à comprendre comment les visiteurs interagissent avec les sites web.',
                  value: _statisticsCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      _statisticsCookies = value ?? false; // Updates preferences state.
                      _updateGlobalConsent(); // Updates global consent.
                    });
                  }
                ),
                Divider(
                  color: GlobalColors.dividerColor3,
                  thickness: 1.0,
                ),
                _buildCheckbox(
                  title: "Marketing",
                  subtitle: 'Les cookies marketing sont utilisés pour effectuer le suivi des visiteurs au travers des sites web. Le but est d\'afficher des publicités qui sont pertinentes et intéressantes pour l\'utilisateur individuel et donc plus précieuses pour les éditeurs et annonceurs tiers',
                  value: _marketingCookies,
                  onChanged: (bool? value) {
                    setState(() {
                      _marketingCookies = value ?? false; // Updates preferences state.
                      _updateGlobalConsent(); // Updates global consent.
                    });
                  }
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: GlobalColors.dividerColor2,
            thickness: 1.0, // Adds a thin divider line for separation.
          ),
          SizedBox(height: 10.0),
          // Save Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  widget.onConsentGiven(true); // Notify parent about global consent.
                  await _saveConsentPreferences(); // Saves preferences to persistent storage.
                  _animationController.reverse(); // Hide banner with animation.
                  setState(() {
                    _isManagingCookies = false; // Returns to the main banner screen.
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.orangeColor,
                  foregroundColor: GlobalColors.firstColor, 
                ),
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builds an individual checkbox item for cookie preferences.
  Widget _buildCheckbox({
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool?> ? onChanged,
    bool enable = true,
  }) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      activeColor: GlobalColors.secondColor,
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.justify,
        style: TextStyle(
          height: 1.5,
        )
      ),
      value: value,
      onChanged: enable ? onChanged : null, // Null if checkbox is disabled.
    );
  }
}
