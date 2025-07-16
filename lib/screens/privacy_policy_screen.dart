import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_hover_route_navigator.dart';
import '../components/my_back_to_top_button.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';


/// PrivacyPolicyScreen displays the privacy policy and cookie management details.
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override 
  PrivacyPolicyScreenState createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
    // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  String currentItem = 'Politique de confidentialité';
    bool _showBackToTopButton = false;
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

  @override 
  void initState() {
    super.initState( );
        // Handle back to top button 
    _pageScrollController.addListener(_pageScrollListener); // Adds an event listener that captures scrolling
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
    final bool mobile = GlobalScreenSizes.isMobileScreen(context);
    int numberSection = 1;

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);}, // receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click) 
      ),
      endDrawer: mobile // && !_isDesktopMenuOpen (only for NavItem with click)
        ? DrawerComponent(
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
                          fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.orangeColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Who We Are
                      Text(
                        "${numberSection++}. Qui Sommes-Nous ?",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
                              child: MyHoverRouteNavigator(routeName: '/legalMontions', text: 'mentions légales')
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
                      const SizedBox(height: 30.0)  ,

                      // Section: Collection of Identity Data
                      Text(
                        "${numberSection++}. Collecte des données d'identité",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "La consultation du Site s'effectue librement, sans inscription préalable. Aucune donnée nominative (nom, prénom, adresse, etc.) n'est collectée lors de la simple consultation du Site.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Nature of Collected Data
                      Text(
                        "${numberSection++}. Nature des données collectées",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Dans le cadre de l’utilisation du Site, l’Éditeur peut collecter :\n"
                        "- Vos coordonnées via le formulaire de contact.\n"
                        "- Des informations pour Google Analytics pour des mesures statistiques.\n"
                        "- Les avis et témoignages que vous déposez sur le site.",
                        style: TextStyle(
                        fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText ,

                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Contact Forms
                      Text(
                        "${numberSection++}. Formulaires de contact",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Toutes les données que vous partagez sur le formulaire de la page Contact sont "
                            "centralisées et traitées exclusivement par ${GlobalPersonalData.companyName}. Elles servent à répondre à "
                            "vos requêtes (devis, informations techniques, suivi client…) et sont accessibles uniquement "
                            "aux membres de notre équipe habilités et à nos prestataires techniques, dans le strict respect "
                            "de la confidentialité.",
                            style: TextStyle(
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Conformément au RGPD, vous pouvez à tout moment :",
                            style: TextStyle(
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                            "de votre dernier échange avec nous.",
                            style: TextStyle(
                              fontSize: mobile
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
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1. Accédez au formulaire sur la page Contact",
                                  style: TextStyle(
                                    fontSize: mobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "2. Choisissez le type de demande « Autre »",
                                  style: TextStyle(
                                    fontSize: mobile
                                        ? GlobalSize.mobileSizeText
                                        : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "3. Décrivez précisément votre requête",
                                  style: TextStyle(
                                    fontSize: mobile
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
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30)  ,

                      // Section: Reviews and Testimonials
                      Text(
                        "${numberSection++}. Avis et témoignages",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
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
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Si vous souhaitez faire évoluer votre témoignage (correction de texte) ou en réclamer la "
                            "suppression, il suffit de repasser par le formulaire de la page Contact en choisissant « Autre », "
                            "puis de mentionner :",
                            style: TextStyle(
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0)  ,

                      // Section: Cookie
                      Text(
                        "${numberSection++}. Cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${GlobalPersonalData.companyName} utilise des cookies afin d’optimiser votre expérience sur son site web. Ces cookies nous permettent \n"
                        "d’améliorer la navigation, de personnaliser l’affichage, de diffuser des publicités ciblées et de recueillir des données \n"
                        "indispensables pour un suivi précis des performances du site. Pour en savoir plus sur les différents types de cookies utilisés,\n" 
                        "veuillez consulter la section \"Gestion des cookies\" ci-dessous.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0)  ,

                      // Section: Cookie Management
                      Text(
                        "${numberSection++}. Gestion des Cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vous pouvez définir vos préférences concernant la collecte et l’utilisation de vos données. Choisissez comment nous devons collecter et traiter ces informations pour vous offrir une expérience sur-mesure tout en garantissant le respect de votre vie privée.",
                            style: TextStyle(
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                                          fontSize: mobile
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
                      const SizedBox(height: 30.0),
                      // Section: Cookie Retention Period
                      Text(
                        "${numberSection++}. Durée de conservation des cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
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
                              fontSize: mobile
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
                                _buildCell("Marketing"),
                                _buildCell("Publicités personnalisées"),
                                _buildCell("6 mois après dépôt"),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
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
                                        fontSize: mobile
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
                                        fontSize: mobile
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
                                          "Vous pouvez à tout moment modifier vos choix via notre bandeau de gestion des cookies.",
                                      style: TextStyle(
                                        fontSize: mobile
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
                              fontSize: mobile
                                  ? GlobalSize.mobileSizeText
                                  : GlobalSize.webSizeText,
                              color: GlobalColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0)  ,

                      // Section: User Right to Refuse Cookies
                      Text(
                        "${numberSection++}. Droit de l'Utilisateur de refuser les cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Lors de l'accès au Site, votre consentement est demandé pour l'installation des cookies. Si vous refusez, seuls les cookies strictement nécessaires seront générés.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Embedded Content
                      Text(
                        "${numberSection++}. Contenu embarqué depuis d'autres sites",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Les articles du Site peuvent inclure des contenus intégrés (vidéos, images, articles, etc.) provenant d'autres sites. Ces contenus se comportent comme si vous visitiez ces sites directement. Toutefois, certains contenus (comme les vidéos YouTube en mode confidentialité avancée) n'installent pas de cookies sur le Site.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Data Retention for Technical Data
                      Text(
                        "${numberSection++}. Durée de conservation des données techniques",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Les données techniques sont conservées pour la durée strictement nécessaire à l'accomplissement des finalités décrites ci-dessus.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Data Communication
                      Text(
                        "${numberSection++}. Communication des données personnelles",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Aucune donnée personnelle ne sera communiquée à des tiers, sauf obligation légale. Les données pourront être divulguées en application d'une loi, d'un règlement, ou suite à une décision d'une autorité compétente.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      // Section DPO
                      Text(
                        "${numberSection++}. Délégué à la protection des données (DPO)",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${GlobalPersonalData.dpoGender}. ${GlobalPersonalData.dpoName} veille au respect de vos droits relatifs à la protection de vos données personnelles. "
                        "Pour toute question, réclamation ou exercice de vos droits RGPD, vous pouvez le contacter :",
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        GlobalPersonalData.headOfficeAddress,
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      Text(
                        "E-mail : ${GlobalPersonalData.dpoEmail}",
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      Text(
                        "Tél. : ${GlobalPersonalData.dpoPhone}",
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30)  , 


                      // Section: Modifications of Policy
                      Text(
                        "${numberSection++}. Modification des CGU et de la politique de confidentialité",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "En cas de modification substantielle des présentes conditions, l'éditeur s'engage à en informer les utilisateurs avant la mise en ligne.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Lexicon
                      Text(
                        "${numberSection++}. Lexique",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "L’éditeur : La personne, physique ou morale, qui édite les services de communication en ligne.\n"
                        "Le site : L’ensemble des pages Internet et services en ligne proposés par l’Éditeur.\n"
                        "L’utilisateur : La personne utilisant le Site et ses services.\n"
                        "Informations personnelles: Données qui permettent d'identifier directement ou indirectement un individu.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), 
 
                      // Section: Last update
                      Text(
                        "Dernière mise à jour : ${GlobalDates.lastUpdate}",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
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
      ? MyBackToTopButton(controller: _pageScrollController)
      : null,  
    );
  }

  // Helper to build table cells
  Widget _buildCell(String text, {bool isHeader = false}) {
    bool mobile = GlobalScreenSizes.isMobileScreen(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: GlobalColors.secondColor,
        ),
      ),
    );
  }
}

