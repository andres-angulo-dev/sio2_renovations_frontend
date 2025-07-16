import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_back_to_top_button.dart';
import '../components/my_hover_route_navigator.dart';
import '../components/my_hover_url_navigator.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';


class LegalMontionScreen extends StatefulWidget {
  const LegalMontionScreen({super.key});

  @override  
  LegalMontionScreenState createState() => LegalMontionScreenState();
}

class LegalMontionScreenState extends State<LegalMontionScreen> with SingleTickerProviderStateMixin {
  // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  String currentItem = 'Mentions légales';
  bool _showBackToTopButton = false;
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

  @override  
  void initState() {
    super.initState();
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
    // Determine if the device is mobile based on screen width.
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
        : null, // Drawer visible on mobile devices only.
      backgroundColor: GlobalColors.firstColor, 
      body: SingleChildScrollView(
        controller: _pageScrollController,
        child: Column(
          children: [
            SingleChildScrollView(
              // Padding adds margins on the sides (mimicking a centered A4 layout)
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Center(
                child: ConstrainedBox(
                  // Constrain the maximum width for better readability on large screens
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                    children: [
                      // Page title
                      Text(
                        "MENTIONS LÉGALES", 
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.orangeColor,
                        ),
                      ),
                      const SizedBox(height: 30.0), // Vertical spacing

                      // Section : Presentation of the Site and its Operation
                      Text(
                        "${numberSection++}. Présentation du Site et de l'Exploitation",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between title and content
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [     
                            // Subsection 1
                            Text(
                              "1.1 Identité de l'Éditeur",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "En application de l’article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique, "
                              "les utilisateurs du site sont informés des différents intervenants impliqués dans sa conception et sa gestion :",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${GlobalPersonalData.companyName}\n"
                              "${GlobalPersonalData.legalForm} – ${GlobalPersonalData.ceo}\n"
                              "${GlobalPersonalData.headOfficeAddress}\n"
                              "Tél. : ${GlobalPersonalData.phone}\n"
                              "E-mail : ${GlobalPersonalData.email}\n"
                              "Site Web : ${GlobalPersonalData.website}\n"
                              "Siret : ${GlobalPersonalData.siret}",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Subsection 2
                            Text(
                              "1.2 Directeur de Publication",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Le directeur de la publication du site est ${GlobalPersonalData.gender}. ${GlobalPersonalData.ceo}.\n"
                              "E-mail : ${GlobalPersonalData.email}\n"
                              "Tél. : ${GlobalPersonalData.phone}",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Subsection 3
                            Text(
                              "1.3 Hébergement",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Le site est hébergé par : ${GlobalPersonalData.hostingProviderName} ${GlobalPersonalData.hostingProviderAddress}",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Subsection 4
                            Text(
                              "1.4 Conception du Site",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: GlobalColors.secondColor,
                                  fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Le site a été conçu par ${GlobalPersonalData.developerCompanyName} Site Web :',
                                  ),
                                  TextSpan(text: " "),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: MyHoverUrlNavigator(url: 'https://${GlobalPersonalData.developerCompanyWebsite}/', text: GlobalPersonalData.developerCompanyWebsite)
                                  ),
                                  TextSpan(text: "."),
                                ]
                              )
                            ),
                          ]
                        )
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Conditions of Use.
                      Text(
                        "${numberSection++}. Conditions Générales d'Utilisation (CGU)",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Le site est normalement accessible en continu aux utilisateurs. Des interruptions temporaires peuvent intervenir pour maintenance technique ou mise à jour. "
                        "L'éditeur se réserve le droit de modifier ces mentions légales à tout moment. Il est recommandé à l'utilisateur de consulter régulièrement cette page.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Description of Services Provided.
                      Text(
                        "${numberSection++}. Description des Services Fournis",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Le site a pour objectif de fournir des informations relatives aux activités de ${GlobalPersonalData.companyName}. "
                        "Les informations sont fournies à titre indicatif et peuvent être modifiées sans préavis. "
                        "L'éditeur s'efforce de garantir la précision des données, sans pouvoir être tenu responsable des omissions ou erreurs.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Contractual and Technical Limitations.
                      Text(
                        "${numberSection++}. Limitations Contractuelles et Techniques",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "4.1 Données Techniques",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Le site utilise la technologie JavaScript pour son fonctionnement. L'éditeur décline toute responsabilité pour tout dommage matériel lié à l'utilisation du site, notamment en cas d'utilisation d'équipements obsolètes ou non sécurisés.",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Subsection 1.4: Site Design.
                            Text(
                              "4.2 Responsabilité de l'Éditeur",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${GlobalPersonalData.companyName} ne pourra être tenu responsable des dommages directs ou indirects, incluant la perte de marché ou d'opportunités, résultant de l'utilisation ou de l'impossibilité d'accéder au site.",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Intellectual Property.
                      Text(
                        "${numberSection++}. Propriété intellectuelle",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.w600,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 5.1 Contenus exclusifs
                            Text(
                              "5.1 Contenus exclusifs",
                              style: TextStyle(
                                fontSize: mobile
                                    ? GlobalSize.mobileSizeText
                                    : GlobalSize.webSizeText,
                                fontWeight: FontWeight.w600,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "L’ensemble des contenus (textes, graphismes, logos, icônes, sons, logiciels) "
                              "ainsi que certaines photographies originales présentes sur ce site sont la propriété "
                              "exclusive de ${GlobalPersonalData.companyName}." 
                              "Toute reproduction, représentation ou adaptation de ces éléments, en tout ou partie, est interdite sans "
                              "accord écrit préalable de ${GlobalPersonalData.companyName}.",
                              style: TextStyle(
                                fontSize: mobile
                                    ? GlobalSize.mobileSizeText
                                    : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "5.2 Photographies sous licence et non contractuelles",
                              style: TextStyle(
                                fontSize: mobile
                                    ? GlobalSize.mobileSizeText
                                    : GlobalSize.webSizeText,
                                fontWeight: FontWeight.w600,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Certaines photographies et illustrations utilisées sur ce site proviennent de "
                              "bibliothèques d’images en ligne, sous licence, et sont fournies à titre purement illustratif."
                              "En raison de nos 30 années d’expérience et du volume important de réalisations, il "
                              "nous est matériellement impossible de numériser l’intégralité de nos chantiers. "
                              "Ces visuels offrent simplement un aperçu illustratif de la qualité de nos interventions.",
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
                      const SizedBox(height: 30.0),

                      // Section : Limitation of Liability.
                      Text(
                        "${numberSection++}. Limitations de Responsabilité",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${GlobalPersonalData.companyName} ne pourra être tenu responsable des dommages matériels causés au matériel de l'utilisateur lors de l'accès au site. "
                        "L'éditeur décline toute responsabilité concernant d'éventuels bugs, incompatibilités ou erreurs de contenu sur le site.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      
                      
                      // Section : CGV and intervention conditions
                      Text(
                        "${numberSection++}. Conditions d’intervention et garanties légales",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Tous les devis et contrats émis par ${GlobalPersonalData.companyName} sont soumis à nos "
                        "Conditions Générales de Vente, disponibles sur simple demande via notre formulaire en ligne (type de demande « Autre ») ou directement à ${GlobalPersonalData.email}.",
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Text(
                      //   "Assurances",
                      //   style: TextStyle(
                      //     fontSize: mobile 
                      //         ? GlobalSize.mobileSizeText 
                      //         : GlobalSize.webSizeText,
                      //     fontWeight: FontWeight.w600,
                      //     color: GlobalColors.secondColor,
                      //   ),
                      // ),
                      // const SizedBox(height: 8.0),
                      // Padding(
                      //   padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       _buildBullet(
                      //         "Assurance responsabilité civile professionnelle et décennale souscrite auprès de ${GlobalPersonalData.insurerName}, police n° ${GlobalPersonalData.policyNumber}, valable du ${GlobalPersonalData.policyStartDate} au ${GlobalPersonalData.policyEndDate}."
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 20.0),
                      Text(
                        "Garanties",
                        style: TextStyle(
                          fontSize: mobile 
                              ? GlobalSize.mobileSizeText 
                              : GlobalSize.webSizeText,
                          fontWeight: FontWeight.w600,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Garantie de parfait achèvement : 1 an à compter de la réception des travaux."
                            ),
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Garantie biennale (articles 1792-3 et suivants du Code civil) : 2 ans sur les équipements."
                            ),
                            const SizedBox(height: 8.0),
                            _buildBullet(
                              "Garantie décennale (article 1792-4-1 du Code civil) : 10 ans sur les ouvrages."
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Management of Personal Data.
                      Text(
                        "${numberSection++}. Gestion des Données Personnelles",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Les informations personnelles recueillies sur ce site sont utilisées exclusivement pour fournir les services proposés. "
                        "L'utilisateur dispose d'un droit d'accès, de rectification et d'opposition concernant ses données personnelles, "
                        "qu'il peut exercer en adressant une demande écrite à l'éditeur accompagnée d'une pièce d'identité.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Hyperlinks and Cookies.
                      Text(
                        "${numberSection++}. Liens Hypertextes et Cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Subsection 1
                            Text(
                              "9.1 Liens Hypertextes",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Le site peut contenir des liens vers d'autres sites externes. ${GlobalPersonalData.companyName} n'exerce aucun contrôle sur le contenu de ces sites et décline toute responsabilité en cas de contenu illicite ou inapproprié.",                  
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Subsection 2
                            Text(
                              "9.2 Gestion des Cookies",
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                  color: GlobalColors.secondColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "La navigation sur ce site peut entraîner l'installation de cookies sur l'ordinateur de l'utilisateur. Certains cookies permettent la navigation et d'autres de mesurer la fréquentation par exemple. Le refus des cookies peut limiter l'accès à certaines fonctionnalités du site. L'utilisateur peut configurer et refuser les cookies. Pour en savoir plus, veuillez consulter notre page de ",
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: MyHoverRouteNavigator(routeName: '/privacyPolicy', text: 'politique de confidentialité')
                                  ),
                                  TextSpan(
                                    text: '.',
                                  )
                                ]
                              )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Applicable Law and Jurisdiction.
                      Text(
                        "${numberSection++}. Droit Applicable et Juridiction",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Tout litige relatif à l\'utilisation du Site sera soumis au droit français. Les tribunaux compétents de Paris auront juridiction exclusive.\nClause d’arbitrage : Tout différend sera réglé selon une procédure d\'arbitrage convenue par les parties.',                  style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Legal Framework.
                      Text(
                        "${numberSection++}. Cadre Légal",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Ce site est régi par la loi n° 78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés, ainsi que par la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section : Glossary.
                      Text(
                        "${numberSection++}. Lexique",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(left: mobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDefinition(
                              "Éditeur",
                              "La personne physique ou morale responsable de la publication et de la gestion du site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Site",
                              "L’ensemble des pages et services accessibles à l’adresse https://${GlobalPersonalData.website}."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Utilisateur",
                              "Toute personne physique qui visite et/ou utilise les services du Site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Données personnelles",
                              "Toute information se rapportant à une personne physique identifiée ou identifiable."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Données techniques",
                              "Informations collectées automatiquement lors de la navigation (adresse IP, navigateur, fournisseur d’accès, etc.)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Cookie",
                              "Petit fichier déposé sur votre terminal pour mémoriser des informations (préférences, statistiques, etc.)."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "RGPD",
                              "Règlement Général sur la Protection des Données (UE) 2016/679."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "CGU",
                              "Conditions Générales d’Utilisation, définissant les modalités d’accès et d’utilisation du Site."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Devis",
                              "Document précontractuel, estimatif et descriptif des prestations proposées."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Contrat",
                              "Accord formel liant l’éditeur et le client, définissant les obligations et conditions des travaux."
                            ),
                            const SizedBox(height: 8),
                            _buildDefinition(
                              "Siret",
                              "Numéro unique d’identification de l’entreprise."
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        'Il est strictement interdit de reproduire, copier, distribuer ou modifier tout contenu de ce site sans l’accord préalable et écrit de SIO2 Rénovations. '
                        'Cela inclut textes, photographies, images, icônes, illustrations, logo ect..\n'
                        'Toute utilisation non autorisée de ces éléments fera l’objet de poursuites judiciaires.\n\n'
                        'Ce site a été optimisé pour les tablettes, les mobiles et les smartphones et ordinateur de bureau.',
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                          fontStyle: FontStyle.italic,
                        )
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
            FooterComponent(),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton
      ? MyBackToTopButton(controller: _pageScrollController)
      : null,
    );
  }

  // Helper for the definitions
  Widget _buildDefinition(String term, String definition) {
    bool mobile = GlobalScreenSizes.isMobileScreen(context);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$term : ",
            style: TextStyle(
              fontSize: mobile 
                  ? GlobalSize.mobileSizeText 
                  : GlobalSize.webSizeText,
              color: GlobalColors.secondColor,
            ),
          ),
          TextSpan(
            text: definition,
            style: TextStyle(
              fontSize: mobile 
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
    bool mobile = GlobalScreenSizes.isMobileScreen(context);

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
              fontSize: mobile 
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
