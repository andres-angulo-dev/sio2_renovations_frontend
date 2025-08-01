import 'package:flutter/material.dart';
import '../components/my_nav_bar_component.dart';
import '../components/my_drawer_component.dart';
import '../components/footer_component.dart';
import '../widgets/my_hover_route_navigator_widget.dart';
import '../widgets/my_hover_url_navigator_widget.dart';
import '../widgets/my_back_to_top_button_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';


// PrivacyPolicyScreen displays the privacy policy and cookie management details.
class PrivacyPolicyScreen extends StatefulWidget {
  
  const PrivacyPolicyScreen({super.key,});

  @override 
  PrivacyPolicyScreenState createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Allows you to target the section to trigger a scroll
  GlobalKey? _cookiesKey;   
  String currentItem = 'Politique de confidentialité';
  bool _showBackToTopButton = false;

  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)
  @override 
  void initState() {
    super.initState( );
    // Handle back to top button 
    _pageScrollController.addListener(_pageScrollListener); // Adds an event listener that captures scrolling
  }

  // Allows scroll to Cookies section using dynamic Key and called just after initState(), the context is fully initialized, we can retrieve the route arguments via ModalRoute.of(context)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // We retrieve the target key passed as an argument, if it exists
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is GlobalKey) {
      _cookiesKey = args;

      // Schedule a callback after the first frame is rendered. This ensures the widget tree is fully built before attempting to scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = _cookiesKey?.currentContext;
        if (context != null) {
          // Programmatically scroll the widget associated with cookiesKey into view
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          );
        }
      });
    }
  }
  
  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

   // Detects when scrolling should show back to top button
  void _pageScrollListener() {
    final shouldShow = _pageScrollController.position.pixels > MediaQuery.of(context).size.height - 1000.0;
    if (shouldShow != _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = shouldShow;
      });
    }
  }

  @override 
  void dispose() {
    _scrollController.dispose();
    _pageScrollController.removeListener(_pageScrollListener);
    _pageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    int numberSection = 1;

    return Scaffold(
      appBar: MyNavBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);}, // receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click) 
      ),
      endDrawer: isMobile // && !_isDesktopMenuOpen (only for NavItem with click)
        ? MyDrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
        ) 
        : null,
      backgroundColor: GlobalColors.firstColor,
      body: SingleChildScrollView(
        controller: _pageScrollController,
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
                          fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.orangeColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Who We Are
                      Text(
                        "${numberSection++}. Qui Sommes-Nous ?",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                            color: GlobalColors.secondColor
                          ),
                          children: [
                            const TextSpan(
                              text: "L’adresse de notre site Web est : https://${GlobalPersonalData.website}.\n",
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
                              child: MyHoverRouteNavigatorWidget(routeName: '/legalMontions', text: 'mentions légales', mobile: isMobile,)
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "pour plus d'informations.",
                            ),
                          ]
                        )
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Le présente page décrit les modalités de collecte, d’utilisation et de protection des données personnelles sur notre site vitrine.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section: Collection of Identity Data
                      Text(
                        "${numberSection++}. Collecte des données d’identité",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "La consultation du site s'effectue librement, sans inscription préalable. Aucune donnée nominative (nom, prénom, adresse, etc.) n'est collectée lors de la simple consultation du site.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Nature of Collected Data and recipients
                      Text(
                        "${numberSection++}. Nature des données collectées et destinataires",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Dans le cadre de l’utilisation du site, l’éditeur peut collecter notamment :\n"
                        "- Vos données via le formulaire de contact.\n"
                        "- Des informations pour Google Analytics pour des mesures statistiques.\n"
                        "- Des données de suivi de conversion (Google Ads).\n"
                        "- Les avis et témoignages que vous déposez sur le site.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),   
                      const SizedBox(height: 20.0), 
                      Text(
                        "Destinataires des données Les informations que vous nous transmettez sont accessibles à :\n"
                        "- Nos services internes dédiés (commercial, technique, relation client).\n"
                        "- Notre hébergeur ${GlobalPersonalData.hostingProviderName}.\n"
                        "- Nos prestataires techniques pour l’envoi d’e-mails et l’analyse d’audience.\n"
                        "- Les autorités compétentes, sur réquisition légale ou judiciaire. ",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Contact Forms
                      Text(
                        "${numberSection++}. Formulaires de contact",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Toutes les données que vous partagez sur les formulaires disponibles sur note site après acceptation de votre part des \"conditions de collecte et d'utilisation des données\" sont "
                            "centralisées et traitées exclusivement par ${GlobalPersonalData.companyName}. Elles servent à répondre à "
                            "vos requêtes (devis, informations, suivi client…) et sont accessibles aux destinataires listés à la section 3. « Nature des données collectées et destinataires ».",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Conformément au RGPD, vous pouvez à tout moment :",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "consulter et corriger les informations vous concernant",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "demander leur effacement ou en restreindre le traitement",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "obtenir leur portabilité",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "définir des directives sur leur conservation après votre décès",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Vos informations de contact sont archivées pendant une durée maximale de trois ans à compter "
                            "de votre dernier échange avec nos services.",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Pour exercer vos droits ou formuler une demande spécifique (y compris la modification ou la "
                            "suppression d’un témoignage), procédez ainsi :",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1. Accédez au formulaire sur la page Contact",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "2. Choisissez le type de demande « Autre »",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "3. Décrivez précisément votre requête",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Nous accusons réception de votre demande dans les 48 heures et nous engageons à y répondre sous "
                            "un délai de 5 jours ouvrés. En cas de litige non résolu, vous pouvez saisir la CNIL.",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Section: Reviews and Testimonials
                      Text(
                        "${numberSection++}. Avis et témoignages",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lorsqu’un utilisateur dépose un témoignage, seul son nom (ou pseudo) et le texte du message "
                            "sont enregistrés. Après modération, cet avis reste en ligne sans limitation de durée.",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Si vous souhaitez faire évoluer votre témoignage (correction de texte) ou en réclamer la "
                            "suppression, il suffit de repasser par le formulaire de la page \"Contact\" en choisissant le type de demande « Autre », "
                            "puis de mentionner :",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "la date et l’objet de votre témoignage",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.scale(
                                          scale: 2.0,
                                          child: const Text(
                                            "•",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(child: SizedBox(width: 8.0)),
                                      TextSpan(
                                        text: "la modification souhaitée ou la demande de retrait",
                                        style: TextStyle(
                                          fontSize: isMobile
                                              ? GlobalSize.mobileSizeText
                                              : GlobalSize.webSizeText,
                                          color: GlobalColors.secondColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Nous accusons réception sous 48 heures et mettons à jour ou retirons votre avis dans un délai "
                            "de 5 jours ouvrés. Les données relatives à votre témoignage (nom/pseudo et contenu) sont "
                            "conservées, comme pour les autres formulaires, pendant trois ans à compter de leur dépôt initial.",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),

                      // Section: Cookies
                      Text(
                        "${numberSection++}. Les Cookies",
                        // key: GlobalScrollTargets.cookiesKey,
                        // key: PrivacyPolicyScreen.cookiesKey,
                        key: _cookiesKey,
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${GlobalPersonalData.companyName} utilise des cookies afin d’optimiser votre expérience sur son site web. Ces cookies nous permettent \n"
                        "d’améliorer la navigation, de personnaliser l’affichage, de diffuser des publicités ciblées et de recueillir des données \n"
                        "indispensables pour un suivi précis des performances du site. Pour en savoir plus sur les différents types de cookies utilisés,\n" 
                        "veuillez consulter la section 6.1 « Gestion des préférences » ci-dessous.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section: Cookie Management
                            Text(
                              "6.1 Gestion des préférences",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vous pouvez définir vos préférences concernant la collecte et l’utilisation de vos données lors de l'arrivée sur notre site ou sur notre bouton \"Cookies\" en bas à gauche de l'écran. Choisissez comment nous devons collecter et traiter ces informations pour vous offrir une expérience sur-mesure tout en garantissant le respect de votre vie privée.",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                Padding(
                                  padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.baseline,
                                              baseline: TextBaseline.alphabetic,
                                              // Use Transform.scale to visually enlarge the bullet without increasing line height.
                                              child: Transform.scale(
                                                scale: 2.0, // initial size * 2.3 ≈ 32; 
                                                child: const Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: GlobalColors.secondColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const WidgetSpan(child: SizedBox(width: 8.0)),
                                            TextSpan(
                                              text: "Cookies nécessaires : ces cookies garantissent le bon fonctionnement du site. Ils activent des fonctions essentielles telles que la navigation, l’accès sécurisé aux zones protégées et la sauvegarde des préférences d'affichage. Sans ces cookies, le site ne pourrait pas fonctionner correctement.",
                                              style: TextStyle(
                                                fontSize: isMobile
                                                    ? GlobalSize.mobileSizeText
                                                    : GlobalSize.webSizeText,
                                                color: GlobalColors.secondColor,
                                              ),
                                            ),                                    
                                          ]
                                        )
                                      ),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.baseline,
                                              baseline: TextBaseline.alphabetic,
                                              // Use Transform.scale to visually enlarge the bullet without increasing line height.
                                              child: Transform.scale(
                                                scale: 2.0, // initial size * 2.3 ≈ 32; 
                                                child: const Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: GlobalColors.secondColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const WidgetSpan(child: SizedBox(width: 8.0)),
                                            TextSpan(
                                              text: "Cookies de préférences : ces cookies permettent de mémoriser vos choix (langue, région, options d’affichage) afin d’harmoniser l’expérience utilisateur lors de vos visites ultérieures, facilitant ainsi une navigation personnalisée.",
                                              style: TextStyle(
                                                fontSize: isMobile
                                                    ? GlobalSize.mobileSizeText
                                                    : GlobalSize.webSizeText,
                                                color: GlobalColors.secondColor,
                                              ),
                                            ),                                    
                                          ]
                                        )
                                      ),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.baseline,
                                              baseline: TextBaseline.alphabetic,
                                              // Use Transform.scale to visually enlarge the bullet without increasing line height.
                                              child: Transform.scale(
                                                scale: 2.0, // initial size * 2.3 ≈ 32; 
                                                child: const Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: GlobalColors.secondColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const WidgetSpan(child: SizedBox(width: 8.0)),
                                            TextSpan(
                                              text: "Cookies statistiques : ces cookies collectent anonymement des informations sur la fréquence et les modes d’utilisation du site, nous aidant à améliorer les services proposés en comprenant comment les visiteurs interagissent avec le site.",
                                              style: TextStyle(
                                                fontSize: isMobile
                                                    ? GlobalSize.mobileSizeText
                                                    : GlobalSize.webSizeText,
                                                color: GlobalColors.secondColor,
                                              ),
                                            ),                                    
                                          ]
                                        )
                                      ),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.baseline,
                                              baseline: TextBaseline.alphabetic,
                                              // Use Transform.scale to visually enlarge the bullet without increasing line height.
                                              child: Transform.scale(
                                                scale: 2.0, // initial size * 2.3 ≈ 32; 
                                                child: const Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: GlobalColors.secondColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const WidgetSpan(child: SizedBox(width: 8.0)),
                                            TextSpan(
                                              text: "Cookies marketing : utilisés pour suivre votre comportement de navigation, ces cookies permettent d’afficher des publicités adaptées à vos centres d’intérêt, facilitant ainsi la diffusion d’annonces pertinentes sans collecter d’informations personnelles identifiables.",
                                              style: TextStyle(
                                                fontSize: isMobile
                                                    ? GlobalSize.mobileSizeText
                                                    : GlobalSize.webSizeText,
                                                color: GlobalColors.secondColor,
                                              ),
                                            ),                                    
                                          ]
                                        )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20.0),

                            // Section: Cookie Retention Period
                            Text(
                              "6.2. Durée de conservation des cookies",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Conformément aux lignes directrices de la CNIL (sept. 2020.0), la durée de vie des cookies doit être "
                                  "proportionnée à leur finalité. Vous trouverez ci-dessous le détail de nos durées de conservation :",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Table(
                                  border: TableBorder.all(color: GlobalColors.secondColor.withValues(alpha: 0.3)),
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(color: GlobalColors.secondColor.withValues(alpha: 0.1)),
                                      children: [
                                        _buildCell("Catégorie", isHeader: true),
                                        _buildCell("Finalité", isHeader: true),
                                        _buildCell("Durée de conservation", isHeader: true),
                                      ],
                                    ),
                                    TableRow(children: [
                                      _buildCell("Nécessaires"),
                                      _buildCell("Sécurisation de la navigation, accès aux zones protégées"),
                                      _buildCell("Durée de session (suppression à la fermeture du navigateur)"),
                                    ]),
                                    TableRow(children: [
                                      _buildCell("Préférences"),
                                      _buildCell("Mémorisation de la langue, de la mise en page…"),
                                      _buildCell("13 mois après dépôt"),
                                    ]),
                                    TableRow(children: [
                                      _buildCell("Statistiques (Analytics)"),
                                      _buildCell("Mesure d’audience anonymisée (Google Analytics)"),
                                      _buildCell("13 mois après dépôt"),
                                    ]),
                                    TableRow(children: [
                                      _buildCell("Marketing (Ads)"),
                                      _buildCell("Publicités personnalisées"),
                                      _buildCell("6 mois après dépôt"),
                                    ]),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Padding(
                                  padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.baseline,
                                            baseline: TextBaseline.alphabetic,
                                            child: Transform.scale(
                                              scale: 2.0,
                                              child: const Text(
                                                "•",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: GlobalColors.secondColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const WidgetSpan(child: SizedBox(width: 8.0)),
                                          TextSpan(
                                            text:
                                                "À l’issue de la période indiquée, les cookies sont automatiquement supprimés ou invalidés.",
                                            style: TextStyle(
                                              fontSize: isMobile
                                                  ? GlobalSize.mobileSizeText
                                                  : GlobalSize.webSizeText,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        text: TextSpan(children: [
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.baseline,
                                            baseline: TextBaseline.alphabetic,
                                            child: Transform.scale(
                                              scale: 2.0,
                                              child: const Text(
                                                "•",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: GlobalColors.secondColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const WidgetSpan(child: SizedBox(width: 8.0)),
                                          TextSpan(
                                            text:
                                                "Vos consentements sont renouvelés dès que la durée limite est atteinte.",
                                            style: TextStyle(
                                              fontSize: isMobile
                                                  ? GlobalSize.mobileSizeText
                                                  : GlobalSize.webSizeText,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        text: TextSpan(children: [
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.baseline,
                                            baseline: TextBaseline.alphabetic,
                                            child: Transform.scale(
                                              scale: 2.0,
                                              child: const Text(
                                                "•",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: GlobalColors.secondColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const WidgetSpan(child: SizedBox(width: 8.0)),
                                          TextSpan(
                                            text:
                                                "Vous pouvez à tout moment modifier vos choix via notre bouton \"Cookies\" en bas à gauche de l'écran.",
                                            style: TextStyle(
                                              fontSize: isMobile
                                                  ? GlobalSize.mobileSizeText
                                                  : GlobalSize.webSizeText,
                                              color: GlobalColors.secondColor,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  "En cas de question relative à ces durées ou pour exercer vos droits, consultez la section « Gestion des cookies » "
                                  "ou contactez-nous à ${GlobalPersonalData.email}.",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                                                
                            // Section: Google Analytics 
                            Text(
                              "6.3. Statistiques et mesures d’audience – Google Analytics",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                                "Nous utilisons le service Google Analytics pour analyser et optimiser la navigation sur notre Site. "
                                "Ce service recueille des données pseudonymisées telles que le nombre de visites, la durée des sessions et les parcours de navigation. "
                                "Les adresses IP sont tronquées (anonymize_ip) avant tout traitement pour préserver votre anonymat. "
                                "Les données anonymes collectées par Google Analytics peuvent être transférées aux États-Unis. "
                                "Conformément à l’article 46 du RGPD, nous avons intégré les Clauses Contractuelles Types (CCT) adoptées par la Commission européenne dans les Conditions relatives au traitement des données de Google Analytics, afin de garantir un niveau de protection équivalent à celui de l’Union européenne.",
                                style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: GlobalColors.secondColor,
                                  fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Vous pouvez refuser ou désactiver Google Analytics à tout moment en installant le module complémentaire officiel :',
                                  ),
                                  TextSpan(text: " "),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: MyHoverUrlNavigatorWidget(url: 'https://tools.google.com/dlpage/gaoptout/', text: "https://tools.google.com/dlpage/gaoptout", color: GlobalColors.secondColor,),
                                  ),
                                  TextSpan(text: "."),
                                ]
                              )
                            ),
                            const SizedBox(height: 20.0),

                            // Section: Google Ads 
                            Text(
                              "6.4. Statistiques et mesures d’audience – Google Analytics",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                                "Dans le cadre de nos campagnes publicitaires via Google Ads, un cookie de suivi de conversion est installé après un clic sur une annonce, exclusivement avec votre consentement (article 6.1 a RGPD). "
                                "Ce cookie, strictement pseudonymisé, expire après 30 jours et permet de comptabiliser les actions (achats, formulaires, etc.) effectuées sur notre site. "
                                "Si vous préférez ne pas participer à ce suivi, vous pouvez modifier vos préférences à tout moment ; voir section 6.1 « Gestion des préférences » pour en savoir plus. "
                                "Les données générées sont susceptibles d’être transférées aux États-Unis. "
                                "Conformément à l’article 46 du RGPD, nous avons intégré les Clauses Contractuelles Types (CCT) de la Commission européenne pour garantir un niveau de protection équivalent à celui de l’Union européenne.",
                                style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            // Section: User Right to Refuse Cookies
                            Text(
                              "6.5. Droit de refuser les cookies",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Lors de l’accès au Site, votre consentement est requis pour l’installation des cookies. En cas de refus," 
                              "seuls les cookies strictement nécessaires au bon fonctionnement du Site seront générés ; certaines fonctionnalités pourraient être restreintes.",
                              style: TextStyle(
                                fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Contenu tiers embarqué
                      Text(
                        "${numberSection++}. Contenu tiers embarqué",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Le Site peut afficher des contenus hébergés par des services externes "
                        "(vidéos YouTube, cartes Google Maps, publications de réseaux sociaux, "
                        "articles intégrés, etc.). Ces éléments fonctionnent comme si vous "
                        "naviguiez directement sur les sites tiers et sont susceptibles de "
                        "déposer des cookies et de collecter des données vous concernant.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDefinition(
                              "Widgets en « mode confidentialité avancée »",
                              "Certains fournisseurs, comme YouTube, proposent un mode qui n’installe aucun "
                              "cookie tiers tant que vous n’interagissez pas avec le contenu "
                              "(lecture de la vidéo, activation du son, etc.).",
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Cookies et collectes associées",
                              "Dès que vous lancez ou interagissez avec un contenu embarqué, le tiers peut "
                              "déposer des cookies de suivi et collecter des informations "
                              "(adresse IP, navigation, préférences).",
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Gestion et refus",
                              "Vous pouvez gérer ou bloquer ces cookies via notre bandeau de gestion des cookies "
                              "ou directement dans les réglages de votre navigateur. Pour en savoir plus, "
                              "veuillez consulter la section 6.1 « Gestion des préférences ».",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Data Retention for Technical Data
                      Text(
                        "${numberSection++}. Sécurité et confidentialité ",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Nous assurons la protection de vos données par :",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Chiffrement SSL des échanges."
                            ),
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Accès restreint aux bases de données. "
                            ),
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Sauvegardes régulières et procédures de restauration."
                            ),
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Formation et sensibilisation de notre personnel."
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Data Communication
                      Text(
                        "${numberSection++}. Communication des données personnelles",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Aucune donnée personnelle ne sera communiquée à des tiers, sauf obligation légale. Les données pourront être divulguées en application d'une loi, d'un règlement, ou suite à une décision d'une autorité compétente.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section: Users'rights
                      Text(
                        "${numberSection++}. Droits des utilisateurs",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez des droits suivants :",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "- Droit d’accès : obtenir confirmation que vos données sont traitées et en obtenir une copie.\n"
                        "- Droit de rectification : faire corriger des informations inexactes ou incomplètes.\n"
                        "- Droit à l’effacement (droit à l’oubli) : demander la suppression de vos données, sous réserve des obligations légales de conservation.\n"
                        "- Droit à la limitation du traitement : demander la suspension du traitement de vos données.\n"
                        "- Droit d’opposition : vous opposer à un traitement (notamment prospection).\n"
                        "- Droit à la portabilité : recevoir vos données dans un format structuré et réutilisable.\n"
                        "- Droit de définir des directives post-mortem : indiquer le sort de vos données après votre décès.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: GlobalColors.secondColor,
                            fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          ),
                          children: [
                            TextSpan(
                              text: 'Pour exercer l’un de ces droits contactez notre DPO ; voir section 11. ci-dessous ou en cas de litige, vous pouvez également saisir la',
                            ),
                            TextSpan(text: " "),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: MyHoverUrlNavigatorWidget(url: 'https://www.cnil.fr/', text: "CNIL", color: GlobalColors.secondColor,),
                            ),
                            TextSpan(text: "."),
                          ]
                        )
                      ),
                      const SizedBox(height: 30.0),  

                      // Section DPO
                      Text(
                        "${numberSection++}. Délégué à la protection des données (DPO)",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${GlobalPersonalData.dpoGender}. ${GlobalPersonalData.dpoName} veille au respect de vos droits relatifs à la protection de vos données personnelles. "
                        "Pour toute question, réclamation ou exercice de vos droits RGPD, vous pouvez le contacter :",
                        style: TextStyle(
                          fontSize: isMobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        GlobalPersonalData.headOfficeAddress,
                        style: TextStyle(
                          fontSize: isMobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      Text(
                        "E-mail : ${GlobalPersonalData.dpoEmail}",
                        style: TextStyle(
                          fontSize: isMobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      Text(
                        "Tél. : ${GlobalPersonalData.dpoPhone}",
                        style: TextStyle(
                          fontSize: isMobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30), 

                      // Section: Modifications of Policy
                      Text(
                        "${numberSection++}. Modification des CGU et de la politique de confidentialité",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "En cas de modification substantielle des présentes conditions, l'éditeur s'engage à en informer les utilisateurs avant la mise en ligne.",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 

                      // Section : Glossary.
                      Text(
                        "${numberSection++}. Lexique",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: isMobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDefinition(
                              "Éditeur",
                              "la personne physique ou morale responsable de la publication et de la gestion du site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Site",
                              "ensemble des pages et services accessibles à l’adresse https://${GlobalPersonalData.website}."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Utilisateur",
                              "toute personne physique qui visite et/ou utilise les services du Site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Informations d’identité",
                              "données nominatives recueillies via le formulaire de contact (nom, prénom, adresse e-mail, téléphone)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Cookie",
                              "petit fichier stocké sur le terminal de l’Utilisateur pour mémoriser des informations ou collecter des données."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Données pseudonymisées",
                              "données traitées pour supprimer l’identification directe de l’Utilisateur (adresses IP tronquées)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Données anonymes",
                              "données définitivement dépourvues d’identifiants personnels."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Données techniques",
                              "logs et informations automatiques de connexion (adresse IP, type de navigateur, fournisseur d’accès)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Consentement",
                              "accord préalable de l’Utilisateur pour le traitement de ses données (art. 6.1 a RGPD)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Clauses contractuelles types (CCT)",
                              "garanties juridiques encadrant les transferts de données hors Union européenne (art. 46 RGPD)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "RGPD",
                              "Règlement Général sur la Protection des Données (UE) 2016/679."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "DPO",
                              "Délégué à la Protection des Données, interlocuteur pour toute question et l’exercice des droits."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "CGU  ",
                              "Conditions Générales d’Utilisation, document définissant les modalités d’accès et d’utilisation du Site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "CNIL",
                              "Commission Nationale de l’Informatique et des Libertés, autorité française de contrôle."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Session",
                              "période de navigation pendant laquelle un cookie de session est actif (suppression à la fermeture du navigateur)."
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Last update
                      Text(
                        "Dernière mise à jour : ${GlobalDates.lastUpdate}",
                        style: TextStyle(
                          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                          fontStyle: FontStyle.italic
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
      floatingActionButton: _showBackToTopButton
      ? MyBackToTopButtonWidget(controller: _pageScrollController)
      : null,  
    );
  }

  // Helper to build table cells
  Widget _buildCell(String text, {bool isHeader = false}) {
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isMobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: GlobalColors.secondColor,
        ),
      ),
    );
  }

 // Helper for the definitions
  Widget _buildDefinition(String term, String definition) {
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$term : ",
            style: TextStyle(
              fontSize: isMobile 
                  ? GlobalSize.mobileSizeText 
                  : GlobalSize.webSizeText,
              color: GlobalColors.secondColor,
            ),
          ),
          TextSpan(
            text: definition,
            style: TextStyle(
              fontSize: isMobile 
                  ? GlobalSize.mobileSizeText 
                  : GlobalSize.webSizeText,
              color: GlobalColors.secondColor,
            ),
          ),
        ],
      ),
    );
  }

  // Helper for the chip
  Widget _buildBullet(String text) {
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.scale(
              scale: 2.0,
              child: const Text(
                "•",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.secondColor,
                ),
              ),
            ),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: isMobile 
                  ? GlobalSize.mobileSizeText 
                  : GlobalSize.webSizeText,
              color: GlobalColors.secondColor,
            ),
          ),
        ],
      ),
    );
  }
}

