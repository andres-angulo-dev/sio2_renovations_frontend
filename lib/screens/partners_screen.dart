import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_back_to_top_button.dart';
import '../components/professional_contact_form.dart';
import '../components/footer.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override 
  PartnersScreenState createState() => PartnersScreenState();
}

class PartnersScreenState extends State<PartnersScreen> {
  // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;
  
  
  String currentItem = 'À propos';
  String currenSubItem = 'Partenaires';
  bool _showTitleScreen = false;
  bool _showBackToTopButton = false;


  @override  
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _showTitleScreen = true;
      });
    });

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
    super.dispose();
  }

  @override  
  Widget build(BuildContext context) {
    final mobile = GlobalScreenSizes.isMobileScreen(context);
    final screenWidth = GlobalScreenSizes.screenWidth(context);

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem, 
        onItemSelected: updateCurrentItem,
        currentSubItem: currenSubItem,
      ),
      endDrawer: mobile 
      ? DrawerComponent(
        currentItem: currentItem, 
        onItemSelected: updateCurrentItem,
        currentSubItem: currenSubItem,
      )
      : null,
      backgroundColor: GlobalColors.firstColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final avalaibleHeight = 800.0;

          return SingleChildScrollView(
            controller: _pageScrollController,
            child: Column(
              children: [
                // Welcome section
                SizedBox(
                  height: avalaibleHeight,
                  width: screenWidth, // Take full width
                  child: Stack(
                    children: [
                      // Background Image
                      Container(
                        height: avalaibleHeight,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(GlobalImages.backgroundLanding),
                            fit: BoxFit.cover, // Cover the entire space
                          )
                        ),
                      ), 
                      // bottom rectangle shape 
                      Positioned(
                        bottom: 0.0,
                        height: 150.0,
                        width: GlobalScreenSizes.screenWidth(context),
                        child: Container(
                          color: GlobalColors.firstColor,
                        ),
                      ),
                      // White container centered at the bottom of the image
                      Positioned(
                        bottom: 0.0,
                        left: mobile ? null : screenWidth * 0.25, // Center horizontally 
                        child: Container(
                          height: 300.0,
                          width: mobile ? screenWidth : screenWidth * 0.5,
                          padding: GlobalScreenSizes.isCustomSize(context, 326.0) ? const EdgeInsetsDirectional.symmetric(horizontal: 20.0) : const EdgeInsets.all(60.0), // Add padding inside the container
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor,
                          ),
                          child: AnimatedOpacity(
                            opacity: _showTitleScreen ? 1.0 : 0.0, 
                            duration: const Duration(milliseconds: 1500),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                                crossAxisAlignment: CrossAxisAlignment.center, // Center content
                                children: [
                                  // Title
                                  Text(
                                    "PARTENAIRES",
                                    style: TextStyle(
                                      fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors.thirdColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20), // Space between
                                  // Description
                                  Text(
                                    "Ensemble, plus forts, plus loin",
                                    style: TextStyle(
                                      fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                      color: GlobalColors.secondColor
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                              )
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
                // Description section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 1000.0, minHeight: 500.0),
                    padding: EdgeInsets.symmetric(horizontal: mobile ? 16.0 : 32.0, vertical: mobile ? 28.0 : 42.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: GlobalColors.thirdColor,
                      ),
                      color: GlobalColors.fourthColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Align(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Text(
                            "REJOIGNEZ UN RESEAU OÙ LE SAVOIR-FAIRE FAIT DIFFÉRENCE",
                            style: TextStyle(
                              fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle, 
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.thirdColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20), // Space between
                          // Sub title
                          RichText(
                            textAlign: TextAlign.center,
                            text : TextSpan(
                              style: TextStyle(
                                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                color: GlobalColors.secondColor
                              ),
                              children: [
                                TextSpan(
                                  text: 'Parce qu’un projet d’exception ne se réalise jamais seul. ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                TextSpan(
                                  text: "Chez "
                                ),
                                TextSpan(
                                  text: 'SIO2 Rénovations ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                TextSpan(
                                  text: 
                                    'nous croyons à la force du collectif. C’est en nous entourant de partenaires passionnés et exigeants (architectes, cuisinistes, bureaux d’études, fournisseurs spécialisés ect...) que nous donnons vie à des projets uniques, cohérents et durables.'
                                    'Chaque collaboration est guidée par les mêmes valeurs qui nous animent : l’écoute, l’engagement, la confiance, la précision et le savoir-faire. Ce sont elles qui font la différence sur nos chantiers, et qui transforment une rénovation en une vraie réussite partagée.\n\n'
                                ), 
                                  TextSpan(
                                  text: 'Rejoignez un réseau où chaque détail compte et chaque talent fait la différence.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                    )
                  ), 
                ),
                SizedBox(height: 100.0),
                // Contact form section
                Container(
                  width: screenWidth,
                  color: GlobalColors.fourthColor,
                  padding: EdgeInsets.symmetric(horizontal: mobile ? 16.0 : 32.0, vertical: mobile ? 28.0 : 42.0),
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    child: Wrap(
                      spacing: 30.0,
                      runSpacing: 40.0,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 800.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Shrink to fit content
                              children: [
                                // Title
                                Text(
                                  "VOUS SOUHAITEZ COLLABORER AVEC NOUS ?",
                                  style: TextStyle(
                                    fontSize: mobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.thirdColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                // Sub title
                                Text(
                                  "Si vous avez un savoir-faire et une expertise qui peut enrichir nos projets, n'hésitez pas à compléter ce formulaire",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: GlobalColors.secondColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20), // Space between
                                // Description
                                Text(
                                  "Nous réalisons nos projets en interne, avec une maîtrise globale du chantier, de la conception à la livraison. Nous aimons collaborer avec des professionnels passionnés qui partagent notre exigence et notre sens du détail. Architectes, cuisinistes, décorateurs, fabricants spécialisés ect... Nous serions ravis d’en discuter avec vous. Remplissez le formulaire pour rejoindre notre réseau de partenaires exigeants et engagés.",
                                  style: TextStyle(
                                    fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                    color: GlobalColors.secondColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        ),
                        if (!GlobalScreenSizes.isCustomSize(context, 1727.0)) Container(
                          height: 600.0,
                          width: 3.0,
                          color: GlobalColors.orangeColor.withValues(alpha: 0.3),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 800.0),
                          child: Center(
                            child: ProfessionalContactForm(
                              formKey: _formKey, 
                              firstNameController: _firstNameController, 
                              lastNameController: _lastNameController, 
                              emailController: _emailController, 
                              phoneController: _phoneController,
                              companyController: _companyController, 
                              messageController: _messageController, 
                              isSending: _isSending, 
                              onSend: () => {},
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ),
                SizedBox(height: 160.0),
                // Footer
                const FooterComponent(),
              ],
            ),
          );
        }
      ),
      floatingActionButton: _showBackToTopButton
      ? MyBackToTopButton(
        controller: _pageScrollController
      )
      : null,
    );
  }
}