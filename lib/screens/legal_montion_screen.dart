// import 'package:flutter/material.dart';
// import '../components/my_app_bar_component.dart';
// import '../components/drawer_component.dart';
// import '../utils/global_colors.dart';

// class LegalMontionScreen extends StatelessWidget {
//   const LegalMontionScreen({super.key});

//   // This variable becomes dynamic within build(), so we don't use a constant here.
//   // final bool mobile = false;

//   @override
//   Widget build(BuildContext context) {
//     // Determine if the device is mobile or not, based on screen width.
//     final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;

//     return Scaffold(
//       appBar: MyAppBar(),
//       // Shows endDrawer on mobile devices only.
//       endDrawer: mobile ? DrawerComponent() : null,
//       backgroundColor: GlobalColors.primaryColor,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             Text(
//               'Mentions Légales',
//               style: TextStyle(
//                 fontSize: mobile ? 24.0 : 28.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 1: Présentation du site et de l'éditeur
//             Text(
//               '1. Présentation du Site',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Conformément à l’article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique, nous informons les utilisateurs du site de l’identité des intervenants impliqués dans sa conception et sa gestion.',
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             Text(
//               'ÉDITEUR:\n'
//               'SIO2 Rénovations\n'
//               'Entrepreneur individuel – German Holguin\n'
//               '3 ter Avenue Théodore Rousseau, 75007 Paris\n'
//               'Tél.: +(33) 6 46 34 12 03\n'
//               'Mail: contact@sio2renovations.com\n'
//               'Site Web: www.sio2renovations.com\n'
//               'Siret: 38886382100038',
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             Text(
//               'Concepteur et Responsable du Contenu du Site:\n'
//               'Andrés Angulo - www.andres-angulo.com',
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 2: Hébergement
//             Text(
//               '2. Hébergement',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Le site est hébergé par OVH SAS\n'
//               '2 rue Kellermann\n'
//               '59100 Roubaix, France',
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 3: Conditions Générales d'Utilisation
//             Text(
//               '3. Conditions Générales d’Utilisation',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Le site est accessible en continu, sous réserve d'interruptions pour maintenance technique. Les présentes mentions légales peuvent être modifiées et il est conseillé à l'utilisateur de les consulter régulièrement.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 4: Description des Services
//             Text(
//               '4. Description des Services',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Le site vise à fournir des informations sur l'ensemble des activités de SIO2 Rénovations. Les données affichées sont fournies à titre indicatif et peuvent être modifiées sans préavis.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 5: Propriété Intellectuelle
//             Text(
//               '5. Propriété Intellectuelle',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Tous les contenus présents sur ce site (textes, images, logos, etc.) sont protégés par le droit d'auteur. Toute reproduction est strictement interdite sans autorisation préalable.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 6: Limitation de Responsabilité
//             Text(
//               '6. Limitation de Responsabilité',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "SIO2 Rénovations ne saura être tenu responsable des dommages directs ou indirects résultant de l'utilisation du site ou de l'impossibilité d'y accéder en cas de maintenance ou d'interruptions involontaires.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 7: Données Personnelles
//             Text(
//               '7. Gestion des Données Personnelles',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Les données personnelles sont collectées dans le strict cadre des services offerts sur ce site. L'utilisateur dispose d'un droit d'accès, de modification et de suppression des données le concernant. Aucune information personnelle n'est transférée à des tiers sans consentement.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 8: Liens Hypertextes et Cookies
//             Text(
//               '8. Liens Hypertextes et Cookies',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Le site contient des liens vers d'autres pages et sites. La navigation sur le site peut entraîner l'installation de cookies pour faciliter l'expérience utilisateur. Le refus des cookies peut réduire l'accès à certaines fonctionnalités.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 9: Droit Applicable et Juridiction
//             Text(
//               '9. Droit Applicable et Juridiction',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Tout litige relatif à l'utilisation de ce site est soumis au droit français. Les tribunaux compétents de Paris auront compétence exclusive en cas de litige.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 10: Cadre Légal
//             Text(
//               '10. Cadre Légal',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Ce site est régi par la loi n° 78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés, ainsi que par la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 11: Lexique
//             Text(
//               '11. Lexique',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Utilisateur : Toute personne accédant et naviguant sur le site.\nInformations personnelles : Les données permettant l'identification directe ou indirecte d'une personne.",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 12: Coordonnées de l'Éditeur
//             Text(
//               '12. Coordonnées de l\'Éditeur',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "SIO2 Rénovations – Entrepreneur individuel – German Holguin\n3 ter Avenue Théodore Rousseau, 75007 Paris\nTél. : +(33) 6 46 34 12 03\nMail : contact@sio2renovations.com\nSite Web : www.sio2renovations.com\nSiret : 38886382100038",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 13: Concepteur et Responsable du Contenu
//             Text(
//               '13. Concepteur et Responsable du Contenu',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "Andrés Angulo – www.andres-angulo.com",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Section 14: Hébergement
//             Text(
//               '14. Hébergement',
//               style: TextStyle(
//                 fontSize: mobile ? 18.0 : 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               "OVH SAS\n2 rue Kellermann\n59100 Roubaix, France",
//               style: TextStyle(
//                 fontSize: mobile ? 14.0 : 16.0,
//                 color: GlobalColors.secondaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';

class LegalMontionScreen extends StatelessWidget {
  const LegalMontionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the device is mobile based on screen width.
    final bool mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: const MyAppBar(), 
      endDrawer: mobile ? const DrawerComponent() : null, // Drawer visible on mobile devices only.
      backgroundColor: GlobalColors.primaryColor, 
      body: SingleChildScrollView(
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
                    fontSize: mobile ? 24.0 : 28.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.orangeColor,
                  ),
                ),
                
                const SizedBox(height: 30.0), // Vertical spacing.

                // Section 1: Presentation of the Site and its Operation.
                Text(
                  "1. Présentation du Site et de l'Exploitation",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0), // Spacing between title and content.
                // Subsection 1.1: Publisher Identity.
                Text(
                  "1.1 Identité de l'Éditeur",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
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
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Subsection 1.2: Publication Director.
                Text(
                  "1.2 Directeur de Publication",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le directeur de la publication du site est Monsieur German Holguin.\n"
                  "Mail: contact@sio2renovations.com\n"
                  "Tél.: +(33) 6 46 34 12 03",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Subsection 1.3: Hosting Details.
                Text(
                  "1.3 Hébergement",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site est hébergé par OVH SAS 2, rue Kellermann 59100 Roubaix, France",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Subsection 1.4: Site Design.
                Text(
                  "1.4 Conception du Site",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site a été conçu par Andrés Angulo Site Web: www.andres-angulo.com",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 2: Conditions of Use.
                Text(
                  "2. Conditions Générales d'Utilisation",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site est normalement accessible en continu aux utilisateurs. Des interruptions temporaires peuvent intervenir pour maintenance technique ou mise à jour. "
                  "L'éditeur se réserve le droit de modifier ces mentions légales à tout moment. Il est recommandé à l'utilisateur de consulter régulièrement cette page.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 3: Description of Services Provided.
                Text(
                  "3. Description des Services Fournis",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site a pour objectif de fournir des informations relatives aux activités de SIO2 Rénovations. "
                  "Les informations sont fournies à titre indicatif et peuvent être modifiées sans préavis. "
                  "L'éditeur s'efforce de garantir la précision des données, sans pouvoir être tenu responsable des omissions ou erreurs.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 4: Contractual and Technical Limitations.
                Text(
                  "4. Limitations Contractuelles et Techniques",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "4.1 Données Techniques",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site utilise la technologie JavaScript pour son fonctionnement. L'éditeur décline toute responsabilité pour tout dommage matériel lié à l'utilisation du site, notamment en cas d'utilisation d'équipements obsolètes ou non sécurisés.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Subsection 1.4: Site Design.
                Text(
                  "4.2 Responsabilité de l'Éditeur",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "SIO2 Rénovations ne pourra être tenu responsable des dommages directs ou indirects, incluant la perte de marché ou d'opportunités, résultant de l'utilisation ou de l'impossibilité d'accéder au site.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 5: Intellectual Property.
                Text(
                  "5. Propriété Intellectuelle",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Tous les contenus présents sur ce site (textes, images, graphismes, logos, icônes, sons et logiciels) sont la propriété exclusive de SIO2 Rénovations ou font l'objet d'autorisations spécifiques. "
                  "Toute reproduction ou modification est strictement interdite sans l'accord écrit préalable de SIO2 Rénovations. "
                  "Toute exploitation non autorisée sera poursuivie conformément aux dispositions légales en vigueur.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 6: Limitation of Liability.
                Text(
                  "6. Limitations de Responsabilité",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "SIO2 Rénovations ne pourra être tenu responsable des dommages matériels causés au matériel de l'utilisateur lors de l'accès au site. "
                  "L'éditeur décline toute responsabilité concernant d'éventuels bugs, incompatibilités ou erreurs de contenu sur le site.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 7: Management of Personal Data.
                Text(
                  "7. Gestion des Données Personnelles",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Les informations personnelles recueillies sur ce site sont utilisées exclusivement pour fournir les services proposés. "
                  "L'utilisateur dispose d'un droit d'accès, de rectification et d'opposition concernant ses données personnelles, "
                  "qu'il peut exercer en adressant une demande écrite à l'éditeur accompagnée d'une pièce d'identité.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 8: Hyperlinks and Cookies.
                Text(
                  "8. Liens Hypertextes et Cookies",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "8.1 Liens Hypertextes",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Le site peut contenir des liens vers d'autres sites externes. SIO2 Rénovations n'exerce aucun contrôle sur le contenu de ces sites et décline toute responsabilité en cas de contenu illicite ou inapproprié.",                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Subsection 1.4: Site Design.
                Text(
                  "8.2 Gestion des Cookies",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "La navigation sur ce site peut entraîner l'installation de cookies sur l'ordinateur de l'utilisateur. Ces cookies facilitent la navigation et permettent de mesurer la fréquentation. Le refus des cookies peut limiter l'accès à certaines fonctionnalités du site. L'utilisateur peut configurer son navigateur pour refuser les cookies.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 9: Applicable Law and Jurisdiction.
                Text(
                  "9. Droit Applicable et Juridiction",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Tout litige relatif à l'utilisation de ce site est soumis au droit français. Les tribunaux compétents de Paris sont exclusivement responsables de tout différend.",                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 10: Legal Framework.
                Text(
                  "10. Cadre Légal",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Ce site est régi par la loi n° 78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés, ainsi que par la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),

                // Section 11: Glossary.
                Text(
                  "11. Lexique",
                  style: TextStyle(
                    fontSize: mobile ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Utilisateur : Toute personne accédant et naviguant sur le site.\n"
                  "Informations personnelles : Les données permettant d'identifier directement ou indirectement un individu.",
                  style: TextStyle(
                    fontSize: mobile ? 14.0 : 16.0,
                    color: GlobalColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
