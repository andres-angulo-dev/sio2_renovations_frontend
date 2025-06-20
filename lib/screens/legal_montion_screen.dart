import 'package:flutter/material.dart';
import 'package:sio2_renovations_frontend/components/footer.dart';
import 'package:sio2_renovations_frontend/components/my_hover_route_navigator.dart';
import 'package:sio2_renovations_frontend/components/my_hover_url_navigator.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';


class LegalMontionScreen extends StatefulWidget {
  const LegalMontionScreen({super.key});

  @override  
  LegalMontionScreenState createState() => LegalMontionScreenState();
}

class LegalMontionScreenState extends State<LegalMontionScreen> with SingleTickerProviderStateMixin {
  String currentItem = 'Mentions légales';
  bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not


  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the device is mobile based on screen width.
    final bool mobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);}, // receive whether the dropdown menu is open or not and update the variable
      ), 
      endDrawer: mobile && !_isDesktopMenuOpen
        ? DrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
        ) 
        : null, // Drawer visible on mobile devices only.
      backgroundColor: GlobalColors.firstColor, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              // Padding adds margins on the sides (mimicking a centered A4 layout).
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Center(
                child: ConstrainedBox(
                  // Constrain the maximum width for better readability on large screens.
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left.
                    children: [
                      // Page Title centered at the top.

                      Text(
                        "MENTIONS LÉGALES", // Page title.
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.orangeColor,
                        ),
                      ),

                      const SizedBox(height: 30.0), // Vertical spacing.

                      // Section 1: Presentation of the Site and its Operation.
                      Text(
                        "1. Présentation du Site et de l'Exploitation",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between title and content.
                      // Subsection 1.1: Publisher Identity.
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
                        "les utilisateurs du site sont informés des différents intervenants impliqués dans sa conception et sa gestion :\n\n"
                        "SIO2 Rénovations\n"
                        "Entrepreneur individuel – German Holguin\n"
                        "3 ter Avenue Théodore Rousseau, 75007 Paris\n"
                        "Tél.: +(33) 6 46 34 12 03\n"
                        "Mail: contact@sio2renovations.com\n"
                        "Site Web: www.sio2renovations.com\n"
                        "Siret: 38886382100038",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Subsection 1.2: Publication Director.
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
                        "Le directeur de la publication du site est Monsieur German Holguin.\n"
                        "Mail: contact@sio2renovations.com\n"
                        "Tél.: +(33) 6 46 34 12 03",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Subsection 1.3: Hosting Details.
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
                        "Le site est hébergé par OVH SAS 2, rue Kellermann 59100 Roubaix, France",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Subsection 1.4: Site Design.
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
                              text: 'Le site a été conçu par Andrés Angulo Site Web:',
                            ),
                            TextSpan(text: " "),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: MyHoverUrlNavigator(url: 'https://www.andres-angulo.com/', text: "www.andres-angulo.com")
                            ),
                            TextSpan(text: "."),
                          ]
                        )
                      ),
                      const SizedBox(height: 30.0),

                      // Section 2: Conditions of Use.
                      Text(
                        "2. Conditions Générales d'Utilisation",
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

                      // Section 3: Description of Services Provided.
                      Text(
                        "3. Description des Services Fournis",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Le site a pour objectif de fournir des informations relatives aux activités de SIO2 Rénovations. "
                        "Les informations sont fournies à titre indicatif et peuvent être modifiées sans préavis. "
                        "L'éditeur s'efforce de garantir la précision des données, sans pouvoir être tenu responsable des omissions ou erreurs.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section 4: Contractual and Technical Limitations.
                      Text(
                        "4. Limitations Contractuelles et Techniques",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                      const SizedBox(height: 24.0),
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
                        "SIO2 Rénovations ne pourra être tenu responsable des dommages directs ou indirects, incluant la perte de marché ou d'opportunités, résultant de l'utilisation ou de l'impossibilité d'accéder au site.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section 5: Intellectual Property.
                      Text(
                        "5. Propriété Intellectuelle",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Tous les contenus présents sur ce site (textes, images, graphismes, logos, icônes, sons et logiciels) sont la propriété exclusive de SIO2 Rénovations ou font l'objet d'autorisations spécifiques. "
                        "Toute reproduction ou modification est strictement interdite sans l'accord écrit préalable de SIO2 Rénovations. "
                        "Toute exploitation non autorisée sera poursuivie conformément aux dispositions légales en vigueur.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section 6: Limitation of Liability.
                      Text(
                        "6. Limitations de Responsabilité",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "SIO2 Rénovations ne pourra être tenu responsable des dommages matériels causés au matériel de l'utilisateur lors de l'accès au site. "
                        "L'éditeur décline toute responsabilité concernant d'éventuels bugs, incompatibilités ou erreurs de contenu sur le site.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Section 7: Management of Personal Data.
                      Text(
                        "7. Gestion des Données Personnelles",
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

                      // Section 8: Hyperlinks and Cookies.
                      Text(
                        "8. Liens Hypertextes et Cookies",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "8.1 Liens Hypertextes",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Le site peut contenir des liens vers d'autres sites externes. SIO2 Rénovations n'exerce aucun contrôle sur le contenu de ces sites et décline toute responsabilité en cas de contenu illicite ou inapproprié.",                  
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Subsection 1.4: Site Design.
                      Text(
                        "8.2 Gestion des Cookies",
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
                      const SizedBox(height: 30.0),

                      // Section 9: Applicable Law and Jurisdiction.
                      Text(
                        "9. Droit Applicable et Juridiction",
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

                      // Section 10: Legal Framework.
                      Text(
                        "10. Cadre Légal",
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

                      // Section 11: Glossary.
                      Text(
                        "11. Lexique",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSubTitle : GlobalSize.webSubTitle,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.secondColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Utilisateur : Toute personne accédant et naviguant sur le site.\n"
                        "Informations personnelles : Les données permettant d'identifier directement ou indirectement un individu.",
                        style: TextStyle(
                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                          color: GlobalColors.secondColor,
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
      ) 
    );
  }
}
