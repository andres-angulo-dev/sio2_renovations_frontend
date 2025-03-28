import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_hover_route_navigator.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

/// PrivacyPolicyScreen displays the privacy policy and cookie management details.
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override 
  PrivacyPolicyScreenState createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: mobile ? const DrawerComponent() : null,
      backgroundColor: GlobalColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    Text(
                      "POLITIQUE DE CONFIDENTIALITÉ",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.orangeColor,
                      ),
                    ),
                    const SizedBox(height: 30.0),
 
                    // Section: Who We Are
                    Text(
                      "1. Qui Sommes-Nous ?",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                          color: GlobalColors.secondaryColor
                        ),
                        children: [
                          const TextSpan(
                            text: "L’adresse de notre site Web est : https://www.sio2renovations.com.\n",
                          ),
                          TextSpan(
                            text: "Consultez les",
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: MyHoverRouteNavigator(routeName: '/legalMontions', text: 'mentions légales', mobile: mobile)
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "pour plus d'informations",
                          ),
                        ]
                      )
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Definitions
                    Text(
                      "2. Définitions",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "L’Éditeur : La personne, physique ou morale, qui édite les services de communication en ligne.\n"
                      "Le Site : L’ensemble des pages Internet et services en ligne proposés par l’Éditeur.\n"
                      "L’Utilisateur : La personne utilisant le Site et ses services.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Collection of Identity Data
                    Text(
                      "3. Collecte des données d'identité",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "La consultation du Site s'effectue librement, sans inscription préalable. Aucune donnée nominative (nom, prénom, adresse, etc.) n'est collectée lors de la simple consultation du Site.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Nature of Collected Data
                    Text(
                      "4. Nature des données collectées",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Dans le cadre de l’utilisation du Site, l’Éditeur peut collecter :\n"
                      "- Vos coordonnées via le formulaire de contact.\n"
                      "- Des informations pour Google Analytics pour des mesures statistiques.\n"
                      "- Les avis et témoignages que vous déposez sur le site.",
                      style: TextStyle(
                      fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,

                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Contact Forms
                    Text(
                      "5. Formulaires de contact",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Les informations saisies dans le formulaire de contact servent uniquement à répondre à vos demandes. Elles ne sont enregistrées que si l'Utilisateur utilise expressément les services proposés par le Site, et ce, conformément à votre acceptation préalable.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Reviews and Testimonials
                    Text(
                      "6. Avis et témoignages",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Si vous déposez un témoignage, seuls votre nom (ou pseudo) et le texte de votre message seront enregistrés. "
                      "Les témoignages sont soumis à modération et seront publiés sans limitation de temps, sauf si vous demandez leur retrait via le formulaire de contact.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Cookie
                    Text(
                      "7. Cookies",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Sio2 Rénovations utilise des cookies afin d’optimiser votre expérience sur son site web. Ces cookies nous permettent \n"
                      "d’améliorer la navigation, de personnaliser l’affichage, de diffuser des publicités ciblées et de recueillir des données \n"
                      "indispensables pour un suivi précis des performances du site. Pour en savoir plus sur les différents types de cookies utilisés,\n" 
                      "veuillez consulter la section \"Gestion des cookies\" ci-dessous.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Cookie Management
                    Text(
                      "8. Gestion des Cookies",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                          color: GlobalColors.secondaryColor,
                        ),
                        children: [
                          // Introductory text
                          const TextSpan(
                            text: "Vous pouvez définir vos préférences concernant la collecte et l’utilisation de vos données. Choisissez comment nous devons collecter et traiter ces informations pour vous offrir une expérience sur-mesure tout en garantissant le respect de votre vie privée.\n\n"
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            // Use Transform.scale to visually enlarge the bullet without increasing line height.
                            child: Transform.scale(
                              scale: 2.3, // initial size * 2.3 ≈ 32; 
                              child: const Text(
                                "•",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "  "),
                          const TextSpan(
                            text: "Cookies nécessaires : Ces cookies garantissent le bon fonctionnement du site. Ils activent des fonctions essentielles telles que la navigation, l’accès sécurisé aux zones protégées et la sauvegarde des préférences d'affichage. Sans ces cookies, le site ne pourrait pas fonctionner correctement.\n\n",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            // Use Transform.scale to visually enlarge the bullet without increasing line height.
                            child: Transform.scale(
                              scale: 2.3, // initial size * 2.3 ≈ 32; 
                              child: const Text(
                                "•",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "  "),
                          const TextSpan(
                            text: "Cookies de préférences : Ces cookies permettent de mémoriser vos choix (langue, région, options d’affichage) afin d’harmoniser l’expérience utilisateur lors de vos visites ultérieures, facilitant ainsi une navigation personnalisée.\n\n",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            // Use Transform.scale to visually enlarge the bullet without increasing line height.
                            child: Transform.scale(
                              scale: 2.3, // initial size * 2.3 ≈ 32; 
                              child: const Text(
                                "•",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "  "),
                          const TextSpan(
                            text: "Cookies statistiques : Ces cookies collectent anonymement des informations sur la fréquence et les modes d’utilisation du site, nous aidant à améliorer les services proposés en comprenant comment les visiteurs interagissent avec le site.\n\n",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            // Use Transform.scale to visually enlarge the bullet without increasing line height.
                            child: Transform.scale(
                              scale: 2.3, // initial size * 2.3 ≈ 32; 
                              child: const Text(
                                "•",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "  "),
                          const TextSpan(
                            text: "Cookies marketing : Utilisés pour suivre votre comportement de navigation, ces cookies permettent d’afficher des publicités adaptées à vos centres d’intérêt, facilitant ainsi la diffusion d’annonces pertinentes sans collecter d’informations personnelles identifiables.",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Cookie Retention Period
                    Text(
                      "9. Durée de conservation des cookies",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Conformément aux recommandations de la CNIL, les cookies sont conservés pour un maximum de 13 mois après leur dépôt initial.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: User Right to Refuse Cookies
                    Text(
                      "10. Droit de l'Utilisateur de refuser les cookies",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Lors de l'accès au Site, votre consentement est demandé pour l'installation des cookies. Si vous refusez, seuls les cookies strictement nécessaires seront générés.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Embedded Content
                    Text(
                      "11. Contenu embarqué depuis d'autres sites",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Les articles du Site peuvent inclure des contenus intégrés (vidéos, images, articles, etc.) provenant d'autres sites. Ces contenus se comportent comme si vous visitiez ces sites directement. Toutefois, certains contenus (comme les vidéos YouTube en mode confidentialité avancée) n'installent pas de cookies sur le Site.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Data Retention for Technical Data
                    Text(
                      "12. Durée de conservation des données techniques",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Les données techniques sont conservées pour la durée strictement nécessaire à l'accomplissement des finalités décrites ci-dessus.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Data Communication
                    Text(
                      "13. Communication des données personnelles",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Aucune donnée personnelle ne sera communiquée à des tiers, sauf obligation légale. Les données pourront être divulguées en application d'une loi, d'un règlement, ou suite à une décision d'une autorité compétente.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Modifications of Policy
                    Text(
                      "14. Modification des CGU et de la politique de confidentialité",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "En cas de modification substantielle des présentes conditions, l'éditeur s'engage à en informer les utilisateurs avant la mise en ligne.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0)   ,
 
                    // Section: Lexicon
                    Text(
                      "15. Lexique",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Informations personnelles: Données qui permettent d'identifier directement ou indirectement un individu.",
                      style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSize : GlobalSize.webSize,
                        color: GlobalColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
          FooterComponent(),
        ],
      ) 
      ),  
    );
  }
}

