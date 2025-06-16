import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../components/footer.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_rive_button.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin {
  late AnimationController _historyAnimationController;
  late Animation<Offset> _historySlideAnimation;
  late Animation<double> _historyFadeAnimation;

  late AnimationController _servicesAnimationController;
  late Animation<Offset> _servicesSlideAnimation;
  late Animation<double> _servicesFadeAnimation;

  late AnimationController _contactAnimationController;
  late Animation<Offset> _contactSlideController;
  late Animation<double> _contactFadeAnimation;

  final bool mobile = false;
  String currentItem = 'À propos';
  String currentSubItem = 'Qui sommes nous ?';
  bool _show = false;
  bool _showHistorySection = false;
  bool _showServicesSection = false;
  bool _showEngagementSection = false;
  bool _showContactButtonSection = false;
  
  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        _show = true;
      });
    });

    // handle animation in history section
    _historyAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _historySlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _historyAnimationController, 
        curve: Curves.easeInOut,
        )
      );

      _historyFadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _historyAnimationController, 
        curve: Curves.easeInOut
        )
      );

      _historyAnimationController.forward();

      // handle animation in services section
      _servicesAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );

      _servicesSlideAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _servicesAnimationController,
        curve: Curves.easeInOut,
      ));

      _servicesFadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _servicesAnimationController,
        curve: Curves.easeInOut,
      ));

      // handle animation in contact section
      _contactAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );

      _contactSlideController = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _contactAnimationController, 
        curve: Curves.easeInOut,
      ));

      _contactFadeAnimation = Tween<double>(
        begin: 0.0, 
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _contactAnimationController, 
        curve: Curves.easeInOut,
      ));
  }

  @override   
  void dispose() {
    _historyAnimationController.dispose();
    _servicesAnimationController.dispose();
    _contactAnimationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        currentSubItem: currentSubItem,
      ),
      endDrawer: mobile 
        ? DrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
          currentSubItem: currentSubItem,
        ) 
        : null,
      backgroundColor: GlobalColors.firstColor,
      body: LayoutBuilder(
        builder: (context, contraints) {
          final availableHeight = contraints.maxHeight;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: availableHeight,
                  width: screenWidth, // Take full width
                  child: Stack(
                    children: [
                      // Background Image
                      Container(
                        height: availableHeight,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/immeuble.jpeg'), 
                            fit: BoxFit.cover, // Cover the entire space
                          )
                        ),
                      ),
                      Positioned(
                        top: 200,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _historyAnimationController, 
                          builder: (context, child) {
                            return FadeTransition(
                              opacity: _historyFadeAnimation,
                              child: SlideTransition(
                                position: _historySlideAnimation,
                                child: child,
                              ),
                            );
                          },      
                            child: Container(
                              padding: EdgeInsets.all(40.0),
                              width: mobile ? screenWidth : screenWidth *0.32,
                              color: GlobalColors.firstColor.withValues(alpha: 0.4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\"Faites de votre vie un rêve, et d’un rêve, une réalité.\"",
                                    style: TextStyle(
                                      fontFamily: 'DancingScript',
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    "Antoine de Saint-Exupéry",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            )
                        )
                      ),
                      // bottom rectangle shape 
                      Positioned(
                        bottom: 0,
                        height: 150.0,
                        width: screenWidth,
                        child: Container(
                          color: Colors.white,
                          )
                      ),
                      // White container centered at the bottom of the image
                      Positioned(
                        bottom: 0, // Align at the bottom
                        left: mobile ? null : screenWidth * 0.25 , // Center horizontally 
                        child: Container(
                          height: 300.0,
                          // width: screenWidth * 0.5, 
                          width: mobile ? screenWidth : screenWidth * 0.5, 
                          padding: const EdgeInsets.all(60.0), // Add padding inside the container
                          decoration: BoxDecoration(
                            color: Colors.white, // White background
                          ),
                          child:  AnimatedOpacity(
                            opacity: _show ? 1.0 : 0.0, 
                            duration: const Duration(milliseconds: 1500),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                                crossAxisAlignment: CrossAxisAlignment.center, // Center content
                                children: [
                                  // Title
                                  Text(
                                    "QUI SOMMES-NOUS ?",
                                    style: TextStyle(
                                      fontSize: 30, // Adjust font size
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors.thirdColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20), // Space between
                                  Text(
                                    "Entreprise générale du bâtiment à Paris, tous corps d’état, spécialisée dans la rénovation partielle, complète, et la remise en état après sinistre.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ) 
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100.0),
                SizedBox(
                  height: 600,
                  width: screenWidth,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 2,
                        // child: Container(
                          // color: Colors.green,
                          child: Center(
                            child: Container(
                              width: 1500,
                              height: 1000,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/immeuble.jpeg'),
                                  fit: BoxFit.cover,
                                )
                              ),
                            )
                          )
                        // )
                      ),
                      Expanded(
                        child: VisibilityDetector(
                          key: const Key('section_history'), 
                          onVisibilityChanged: (info) {
                            if (info.visibleFraction > 0.3) {
                              setState(() {
                                _showHistorySection = true;
                              });
                            }
                          },
                          child: AnimatedOpacity(
                            opacity: _showHistorySection ? 1.0 : 0.0, 
                            duration: const Duration(milliseconds: 1500),
                            child: Center(
                              child: Container(
                                height: 600,
                                width: 1000,
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "NOTRE HISTOIRE !",
                                      style: TextStyle(
                                        fontSize: 30, // Adjust font size
                                        fontWeight: FontWeight.bold,
                                        color: GlobalColors.thirdColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20), // Space between
                                    Text(
                                      "SIO2 Rénovations est le fruit de la fusion entre deux familles partageant plus de 30 ans d’expérience dans le bâtiment.\n\nNous mettons ce savoir-faire à votre service, que ce soit pour rénover un studio, un appartement, une maison entière ou un local commercial. Capables de prendre en charge des projets de toutes tailles, nous répondons aussi bien aux petits travaux de rénovation qu’aux défis les plus ambitieux.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ) 
                          ), 
                        ), 
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 140.0),
                VisibilityDetector(
                  key: const Key('section_services'), 
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3 && !_showServicesSection) {
                      setState(() {
                        _showServicesSection = true;
                      });
                      _servicesAnimationController.forward();
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _servicesAnimationController, 
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _servicesFadeAnimation,
                        child: SlideTransition(
                          position: _servicesSlideAnimation,
                          child: child,
                        ) 
                      );
                    },
                    child: Container(
                      width: 1000,
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      // padding: EdgeInsets.all(200.0),
                      // color: Colors.orange,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "NOS SERVICES DE RENOVATIONS",
                            style: TextStyle(
                              fontSize: 30, // Adjust font size
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.thirdColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20), // Space between
                          Text(
                            "Que vous souhaitiez rénover votre électricité, plomberie, peinture, poser du carrelage, du parquet, ou bien plus encore, SIO2 Rénovations est là pour vous offrir des conseils personnalisés, une expertise éprouvée et un service clé en main.\n\n"
                            "Le succès de chaque projet de rénovation repose sur une organisation solide. C’est pourquoi nous vous accompagnons à chaque étape, de la planification à la livraison, à Paris et en l’Île-de-France. Notre objectif : transformer votre intérieur en un espace unique, moderne et chaleureux.\n\n"
                            "Nous mettons un point d’honneur à confier vos travaux à nos équipes sélectionnées pour leur sérieux et leur souci du détail. En restant agiles face aux imprévus de chantier, nous assurons un service au juste prix et dans le respect des délais.\n\n"
                            "Enfin, nous proposons à nos clients un compte rendu d’activité régulier pour avertir en temps réel des avancées de l’ensemble des travaux de rénovation réalisés ou en cours de réalisation.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ), 
                  ),  
                ),
                const SizedBox(height: 160.0),
                Container(
                  height: 600,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/immeuble.jpeg'), // Replace with your image path
                      fit: BoxFit.cover, // Cover the entire space
                    )
                  ),
                ),
                const SizedBox(height: 160.0),
                Container(
                  width: 1200,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(24.0),
                  // color: Colors.orange,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "POURQUOI NOUS FAIRE CONFIANCE ?",
                        style: TextStyle(
                          fontSize: 30, // Adjust font size
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.thirdColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: mobile ? 50.0 : 20.0), // Space between
                      VisibilityDetector(
                        key: const Key('engagement_section'), 
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.3 && !_showEngagementSection) {
                            setState(() {
                              _showEngagementSection = true;
                            });
                          }
                        },
                        child: AnimatedOpacity(
                          opacity: _showEngagementSection ? 1.0 : 0.0, 
                          duration: const Duration(milliseconds: 2000),
                          child: mobile 
                          ? Column(
                              children: [
                                Text(
                                  "Transparence",
                                  style: TextStyle(
                                    fontSize: 24, // Adjust font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                Text(
                                  "Nous analysons minutieusement vos besoins pour vous proposer une offre chiffrée et détaillée. Nos clients bénéficient également de rapports réguliers et d’une mise à jour en temps réel sur l’avancée des travaux.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 50), // Space between
                                Text(
                                  "Communication",
                                  style: TextStyle(
                                    fontSize: 24, // Adjust font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                Text(
                                  "À chaque étape de votre projet, du conseil à la réalisation, nous sommes à vos côtés. Vous êtes en contact direct avec un interlocuteur unique, toujours disponible et attentif à vos demandes.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 50), // Space between
                                Text(
                                  "Qualité",
                                  style: TextStyle(
                                    fontSize: 24, // Adjust font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                Text(
                                  "Notre entreprise est reconnue pour son travail méticuleux, son professionnalisme et sa ponctualité Notre objectif est de fournir le plus haut niveau d’exigence et de savoir-faire à chaque projet, quelle qu’en soit sa taille.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 50), // Space between
                                Text(
                                  "Satisfaction",
                                  style: TextStyle(
                                    fontSize: 24, // Adjust font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                Text(
                                  "Nous accordons beaucoup d’importance à la satisfaction de nos clients dans le but d’entretenir une relation de confiance sur le long terme. En tant que petite entreprise, nous valorisons aussi les recommandations de nos clients. Nous ne voulons pas seulement vous satisfaire : nous voulons que vous partagiez votre expérience positive avec vos proches.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )    
                          : SizedBox(
                            height: 900,
                            width: 900,
                            child: RiveAnimation.asset(GlobalAnimations.engagementAnimation),
                          )
                        ) 
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100.0),
                SizedBox(
                  height: 600,
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VisibilityDetector(
                              key: const Key('section_contact'), 
                              onVisibilityChanged: (info) {
                                if (info.visibleFraction > 0.3) {
                                  _contactAnimationController.forward();
                                }
                              },
                              child: AnimatedBuilder(
                                animation: _contactAnimationController,
                                builder: (context, child) {
                                  return FadeTransition(
                                    opacity: _contactFadeAnimation,
                                    child: SlideTransition(
                                      position: _contactSlideController,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    width: 1000,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "TRANFORMONS VOS IDÉES EN RÉALITÉ",
                                          style: TextStyle(
                                            fontSize: 30, // Adjust font size
                                            fontWeight: FontWeight.bold,
                                            color: GlobalColors.thirdColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20), // Space between
                                        Text(
                                          "Vous avez un projet en tête ? Chez SIO2 Rénovations, nous sommes là pour vous accompagner à chaque étape, de l'idée initiale à la réalisation finale.Que ce soit pour rénover un appartement, moderniser une maison, ou redonner vie à un local commercial, notre expertise est à votre disposition.\n"
                                          "Contactez-nous dès aujourd’hui pour discuter de vos projets de rénovation et découvrir comment nous pouvons concrétiser vos idées. Situés à Paris et actifs dans toute l'Île-de-France, Nous nous engageons à comprendre vos besoins afin de concevoir un espace unique et personnalisé.\n\nEnsemble, donnons vie à vos envies et faisons de votre intérieur un lieu où il fait bon vivre.",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ) 
                              )
                            ),
                            const SizedBox(height: 10), // Space between
                            VisibilityDetector(
                              key: const Key('section_contactButton'), 
                              onVisibilityChanged: (info) {
                                if (info.visibleFraction > 0.3 && !_showContactButtonSection) {
                                  setState(() {
                                    _showContactButtonSection = true;
                                  });
                                }
                              },
                              child: SizedBox(
                                height: 100, // Fixed size to allow visibility detection
                                width: 150,  // Corresponds to the size of the MyButtonRive
                                child: _showContactButtonSection ? MyRiveButton(
                                  onPressed: () => Navigator.pushNamed(context, ('/contact')), 
                                  buttonPath: GlobalButtonsAndIcons.contactButtonWithReverse, 
                                ) 
                                : Container(color: Colors.transparent), // Empty widget visible
                              ),
                            )                          
                          ],
                        )
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 1500,
                            height: 1000,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/immeuble.jpeg'),
                                fit: BoxFit.cover,
                              )
                            ),
                          )
                        )
                      ),
                    ]
                  )
                ),
                SizedBox(height: mobile ? 160.0 : 160.0),
                FooterComponent(),
              ],
            ),
          );
        }
      )
    );
  }
}
    