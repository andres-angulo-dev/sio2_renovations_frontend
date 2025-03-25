import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CookiesConsentBanner extends StatefulWidget {
  const CookiesConsentBanner({super.key, required this.onConsentGiven, required this.onConsentLoaded, required this.toggleVisibility});

  final Function(bool) onConsentGiven;
  final Function(bool?) onConsentLoaded;
  final VoidCallback toggleVisibility;

  @override 
  CookiesConsentBannerState createState() => CookiesConsentBannerState();
}

class CookiesConsentBannerState extends State<CookiesConsentBanner> {
  bool isBannerVisible = true;
  bool isManagingCookies = false;
  bool globalConsentCookies = false;
  bool necessaryCookies = true;
  bool preferencesCookies = false;
  bool statisticsCookies = false;
  bool marketingCookies = false;

  @override 
  void initState() {
    super.initState();
    _loadConsentStatus();
  }

  Future<void> _loadConsentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final cookiesConsent = prefs.getBool('necessaryCookies');

    setState(() {
      preferencesCookies = prefs.getBool('preferencesCookies') ?? false;
      statisticsCookies = prefs.getBool('statisticsCookies') ?? false;
      marketingCookies = prefs.getBool('marketingCookies') ?? false;
      necessaryCookies = true;
    });
    widget.onConsentLoaded(cookiesConsent);
  }

  Future<void> _saveConsentStatus(bool consentGiven) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('cookiesConsent', consentGiven);
    await prefs.setBool('necessaryCookies', true);
    await prefs.setBool('preferencesCookies', true);
    await prefs.setBool('statisticsCookies', true);
    await prefs.setBool('marketingCookies', true);
  }

  Future<void> _saveConsentPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('necessaryCookies', necessaryCookies );
    await prefs.setBool('preferencesCookies', preferencesCookies );
    await prefs.setBool('statisticsCookies', statisticsCookies);
    await prefs.setBool('marketingCookies', marketingCookies);
  }

  void _updateGlobalConsent() {
    setState(() {
      globalConsentCookies = preferencesCookies && statisticsCookies && marketingCookies;
    });
  }
  
  @override 
  Widget build(BuildContext context) {
   return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 10,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isManagingCookies
            ? _buildCookiesManager()
            : _buildConsentBanner(),
        ),
      ),
    );
  }        
          
  Widget _buildConsentBanner() {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Ce Site utilise",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        const Text(
          "des Cookies",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Sio2 Rénovations utilise des cookies pour améliorer la navigation sur son site web, pour vous proposer une expérience plus personnalisée et des publicités ciblées, et pour recueillir des données afin de vous offrir un réel suivi. Pour en savoir plus sur les différents types de cookies utilisés, consultez la politique relative à la protection des données.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        TextButton(
          onPressed: () async {
            const url = 'https://www.sio2renovations.com/';
            try {
              await launchUrl(Uri.parse(url));
            } catch (error) {
              throw 'Could not launch $url, error: $error';
            }
          }, 
          child: const Text('En savoir plus'),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isManagingCookies = true;
                });
              }, 
              child: const Text('Je choisis'),
            ),
            const SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                widget.onConsentGiven(true);
                _saveConsentStatus(true); 
                setState(() {
                  isBannerVisible = false;
                });
              }, 
              child: const Text('J\'ai compris et j\'accepte'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCookiesManager() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gérer vos préférences de cookies",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          "Choisissez comment nous collectons et utilisons vos données pour une meilleure expérience de navigation sur notre site. Votre vie privée est primordiale et vous avez le plein contrôle ici.",
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        CheckboxListTile(
          title: const Text("Tout Cocher"),
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
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 1.0,
              style: BorderStyle.solid
            ),
            color: Colors.yellow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CheckboxListTile(
                title: const Text("Nécessaires (Toujours activés)"),
                subtitle: const Text('Les cookies nécessaires contribuent à rendre un site web utilisable en activant des fonctions de base comme la navigation de page et l\'accès aux zones sécurisées du site web. Le site web ne peut pas fonctionner correctement sans ces cookies.'),
                value: necessaryCookies,
                onChanged: null, // Non modifiable (toujours activé).
              ),
              CheckboxListTile(
                title: const Text("Préférences"),
                subtitle: const Text('Les cookies de préférences permettent à un site web de retenir des informations qui modifient la manière dont le site se comporte ou s’affiche, comme votre langue préférée ou la région dans laquelle vous vous situez.'),
                value: preferencesCookies,
                onChanged: (bool? value) {
                  setState(() {
                    preferencesCookies = value ?? false;
                    _updateGlobalConsent();
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Statistiques"),
                subtitle: const Text('Les cookies statistiques aident les propriétaires du site web, par la collecte et la communication d\'informations de manière anonyme, à comprendre comment les visiteurs interagissent avec les sites web.'),
                value: statisticsCookies,
                onChanged: (bool? value) {
                  setState(() {
                    statisticsCookies = value ?? false;
                    _updateGlobalConsent();
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Marketing"),
                subtitle: const Text('Les cookies marketing sont utilisés pour effectuer le suivi des visiteurs au travers des sites web. Le but est d\'afficher des publicités qui sont pertinentes et intéressantes pour l\'utilisateur individuel et donc plus précieuses pour les éditeurs et annonceurs tiers.'),
                value: marketingCookies,
                onChanged: (bool? value) {
                  setState(() {
                    marketingCookies = value ?? false;
                    _updateGlobalConsent();
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                widget.onConsentGiven(true);
                await _saveConsentPreferences(); // Sauvegarder les préférences.
                setState(() {
                  isManagingCookies = false; // Retour à la bannière classique.
                  isBannerVisible = false;
                });
              },
              child: const Text("Enregistrer"),
            ),
          ],
        ),
      ],
    );
  }
}
