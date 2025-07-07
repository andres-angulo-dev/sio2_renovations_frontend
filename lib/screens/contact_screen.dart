import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../components/my_back_to_top_button.dart';
import '../components/customer_contact_form.dart';
import '../components/opening_hours_component.dart';
import '../components/success_popup_component.dart';
import '../components/footer.dart';
import '../services/contact_form_service.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key,});

  @override  
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  // Scroll controller for the left and right button in horizontal menu
  final ScrollController _scrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  // Scroll controller for the back to top button and appBar 
  final ScrollController _pageScrollController = ScrollController(); // syntax to instantiate immediately otherwise declaration with late and Instantiation in initState 
  final GlobalKey _rightBlockKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _requestTypeController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<List<String>> _typeWork = ValueNotifier([]);
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  double? _rightBlockHeight;
  double? _rightBlockWidht;
  bool _isSending = false;
  String currentItem = 'Contact';
  bool _showTitleScreen = false;
  bool _showBackToTopButton = false;
  bool _isHovered = false;
  bool _showNumber = false;
  bool _showTypeWorkError = false;
  bool _showTextAfterMessageSending = false;
  num _startLeftBlockHeight = 0;
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)

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

  void _resetForm() {
    _formKey.currentState?.reset();  // allows the visual errors of the form to disappear (Reset the state of form)
    _requestTypeController.clear(); // Empty the entered value
    _lastNameController.clear();
    _firstNameController.clear(); 
    _companyController.clear();
    _emailController.clear();
    _phoneController.clear(); 
    _typeWork.value = []; // Empty a list
    _startDateController.clear();
    _addressController.clear();
    _messageController.clear();
  }

  Future<void> _showSuccessPopup() async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping background
      barrierLabel: 'Success', // Label for accessibility (screen readers)
      barrierColor: Colors.black54, // Semi-transparent dark background
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return SuccessPopupComponent(resetForm: _resetForm);
      },
      transitionBuilder: (context, animation, _, child) {
        return ScaleTransition(  // Animation at the entrance and exit popover
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack), // Scale + easeOutBack effect
          child: child,
        );
      },
    );

    // If the user clicked OK → result == true
    if (result == true) setState(() => _showTextAfterMessageSending = true);
  }

  // Check the selection of typeWork before sending it to the backend
  void handleSubmit() async {
    setState(() => _showTypeWorkError = false); // Reset the variable on each click of the "Envoyer" button of the form
  
    if (!_formKey.currentState!.validate()) return; // If it is not valid, we exit the function

    // Check if a selection of typeWork has been made correctly when requestType is 'Renovation project ....'
    if (_requestTypeController.text == 'Projet de rénovation (devis, estimations...)' && _typeWork.value.isEmpty) {
      setState(() => _showTypeWorkError = true); // Triggers the display of the error in the customer contact form child
      return;
    }

    await ContactFormService.submitContactForm(
      formKey: _formKey, 
      context: context, 
      requestTypeController: _requestTypeController,
      lastNameController: _lastNameController, 
      firstNameController: _firstNameController, 
      companyController: _companyController, 
      emailController: _emailController, 
      phoneController: _phoneController, 
      typeWork: _typeWork.value,
      startDateController: _startDateController,
      addressController: _addressController,
      messageController: _messageController, 
      showSuccessDialog: _showSuccessPopup, // Call SuccesPopupComponent and inside call _resetForm
      setIsSending: (value) {
        setState(() => _isSending = value);
      }
    );
  }

  @override  
  void dispose() {
    _scrollController.dispose();
    _pageScrollController.removeListener(_pageScrollListener);
    _pageScrollController.dispose();
    _requestTypeController.dispose(); // Dispose All the TextEditingController
    _lastNameController.dispose();
    _firstNameController.dispose(); 
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose(); 
    _typeWork.dispose(); // Dispose ValueNotifier
    _startDateController.dispose();
    _addressController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = GlobalScreenSizes.isMobileScreen(context);
    final screenWidth = GlobalScreenSizes.screenWidth(context);

    // Calculate automatically  the heigh of Form container 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _rightBlockKey.currentContext?.findRenderObject() as RenderBox?;
      
      // For the height only once when we arrive on the page
      if (box != null && _startLeftBlockHeight == 0) {
        final height = box.size.height;
        _rightBlockHeight = height;
        _startLeftBlockHeight++;
      }

      // // Update each time the heigh of form container changes
      // if (box != null && _startLeftBlockHeight == 0) {
      //   final height = box.size.height;
      //   setState(() => _rightBlockHeight = height);
      // }
      
      // For the widht 
      if (box != null) {
        final widht = box.size.width;
        _rightBlockWidht = widht;
      }

    });
    

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
                                    "CONTACT",
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
                                    "Une question, un projet ? SiO2 Rénovations est à votre écoute.",
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
                // Form section
                Container(
                  padding: EdgeInsets.symmetric(horizontal: mobile ? 16.0 : 32.0, vertical: mobile ? 28.0 : 42.0),
                  child: Wrap(
                    spacing: 100.0,
                    runSpacing: 50.0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      // Contact details part
                      Container(
                        color: GlobalColors.fiveColor.withValues(alpha: 0.2),
                        width: GlobalScreenSizes.isCustomSize(context, 1935) ? _rightBlockWidht : 300.0,
                        padding: EdgeInsets.all(20.0),
                        constraints: BoxConstraints(minHeight: GlobalScreenSizes.isCustomSize(context, 1935) ? 0.0 : _rightBlockHeight ?? 600.0),
                        child: Column(
                          crossAxisAlignment: GlobalScreenSizes.isCustomSize(context, 1935) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              'Nous joindre',
                              style: TextStyle(
                                fontSize: GlobalSize.footerWebTitle,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.secondColor,
                              ),
                              textAlign: GlobalScreenSizes.isCustomSize(context, 1935) ? TextAlign.center : TextAlign.start,
                            ),
                            const SizedBox(height: 6.0),
                            // Divider
                            Container(
                              height: 3.0,
                              width: 200.0,
                              color: GlobalColors.secondColor,
                            ),
                            const SizedBox(height: 20.0),
                            // Phone
                            Row(
                              mainAxisAlignment: GlobalScreenSizes.isCustomSize(context, 1935) ? MainAxisAlignment.center : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: GlobalSize.footerWebText,
                                  alignment: Alignment.center,
                                  child: Icon(Icons.phone, size: 20.0, color: GlobalColors.secondColor),
                                ),
                                const SizedBox(width: 5.0),
                                Flexible(
                                  child: MouseRegion(
                                    onEnter: (_) => setState(() => _isHovered = true),
                                    onExit: (_) => setState(() => _isHovered = false),
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () => setState(() => _showNumber = !_showNumber), 
                                      child: Text(
                                        _showNumber ? "+(33) 6 46 34 12 03" : "Afficher le numéro",
                                        style: TextStyle(
                                          color: _isHovered ? GlobalColors.hoverHyperLinkColor : GlobalColors.secondColor,
                                          fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                                        ),
                                      ),
                                    )
                                  ) 
                                ),
                              ],
                            ),
                            const SizedBox(height: 40.0),
                            // Schedule
                            OpeningHoursComponent(
                              mobileTextSize: GlobalSize.mobileSizeText,
                              webTextSize: GlobalSize.webSizeText,
                              widthDivider: 200.0,
                              heightDivider: 3.0,
                              color: GlobalColors.secondColor,
                              squareColor:  GlobalColors.secondColor,
                              responsiveThreshold: 1935,
                            ),
                          ],
                        )  
                      ),
                      // Form part
                      Container(
                        key: _rightBlockKey,
                        color: GlobalColors.fourthColor,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Title 
                            Container(
                              constraints: BoxConstraints(maxWidth: 800.0),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // Shrink to fit content
                                  children: [
                                    // Title
                                    Text(
                                      "FORMULAIRE DE CONTACT",
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
                                      "Un devis de rénovation ou juste besoin d’échanger ?",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: GlobalColors.secondColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20), // Space between
                                    // Description
                                    Text(
                                      "Remplissez simplement le formulaire ci-dessous, et nous vous recontacterons dans les plus brefs délais. Notre équipe est à votre écoute pour répondre à vos questions et vous accompagner à concrétiser vos projets, qu’il s’agisse d’un rafraîchissement léger ou d’une rénovation plus ambitieuse.\n" 
                                      'Faites le premier pas, on s’occupe du reste.',
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
                            const SizedBox(height: 50.0),
                            // Contact Form
                            Container(
                              constraints: BoxConstraints(maxWidth: 850.0),
                              child: Center(
                                child: CustomerContactForm(
                                  formKey: _formKey, 
                                  requestTypeController: _requestTypeController,
                                  lastNameController: _lastNameController, 
                                  firstNameController: _firstNameController, 
                                  companyController: _companyController, 
                                  emailController: _emailController, 
                                  phoneController: _phoneController,
                                  typeWork: _typeWork,
                                  showTypeWorkError: _showTypeWorkError,
                                  startDateController: _startDateController,
                                  addressController: _addressController,
                                  messageController: _messageController, 
                                  isSending: _isSending, 
                                  sendEmail: handleSubmit, // call ContactFormService and inside call SuccesPopupComponent
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
                const SizedBox(height: 20.0),
                // Text
                if (_showTextAfterMessageSending) 
                Align(
                  child: Text(
                    "Dans l'attente de notre retour, prenez le temps de découvrir nos réalisations en rénovation.",
                    style: TextStyle(
                      fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                      color: GlobalColors.secondColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 160.0),
                // Footer
                FooterComponent(),
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