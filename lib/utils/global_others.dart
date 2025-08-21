import 'package:flutter/material.dart';
import '../utils/global_routes.dart';

class SessionCookieController {
  static bool delayShown = false;
}

class GlobalPersonalData {
  GlobalPersonalData._(); // private constructor to prevent instantiation
  // Company
  static const String companyPrefixName = 'SiO₂';
  static const String companyName = 'SiO₂ Rénovations';
  static const String legalForm = 'Entrepreneur individuel (EI)';
  static const String gender = 'M';
  static const String ceo = 'Germán Holguin';
  static const String siren = '123 456 789';
  static const String siret = '388 863 821 00038';
  static const String socialCapital = '€';
  static const String vatNumber = 'FR';
  static const String rcs = 'RCS';
  static const String headOfficeAddress = '3 ter Avenue Théodore Rousseau, 75007 Paris, France';
  static const String phone = '+(33) 6 46 34 12 03';
  static const String email = 'contact@sio2renovations.com';
  static const String website = 'www.sio2renovations.com';
  static String httpDomaine = domaine;
  static const String companyCreationDate = '15 septembre 2020';
  // Hosting
  static const String hostingProviderName = 'OVH SAS';
  static const String hostingProviderAddress = '2 Rue Kellermann, 59100 Roubaix, France';
  // Developer
  static const String developerCompanyName = 'Andrés Angulo';
  static const String developerCompanyWebsite = 'www.andres-angulo.com';
  // DPO
  static const String dpoGender = 'M';
  static const String dpoName = 'Germán Holguin';
  static const String dpoEmail = 'contact@sio2-renovations.com';
  static const String dpoPhone = '+(33) 6 46 34 12 03';
  // Insurance
  static const String insurerName = 'XXX';              
  static const String policyNumber = 'XXX';              
  static const String policyStartDate = 'XX/XX/XX';         
  static const String policyEndDate = 'XX/XX/XX';    
}

class GlobalData {
  // Landing screen
    // What Type Of Renovations Section extends
  static final List<Map<String, String?>> typeOfRenovationData =  [
    {"title": "Rénovation totale", "image": GlobalImages.totalRenovation, "routePath": '/projects'},
    {"title": "Rénovation de salle de bain", "image": GlobalImages.bathroom, "routePath": '/projects'},
    {"title": "Rénovation partielle", "image": GlobalImages.partialRenovation, "routePath": '/projects'},
    {"title": "Rénovation après sinistre", "image": GlobalImages.renovationAfterDisaster, "routePath": '/projects'},
    {"title": "Rénovation de cuisine", "image": GlobalImages.kitchen, "routePath": '/projects'},
  ];


  // Projects screen 
    // Title of menu and photos
 static final List<Map<String, String>> servicesData = [
    {"title": "TOUT VOIR", "image": GlobalImages.all},
    {"title": "PEINTURE", "image": GlobalImages.painter},
    {"title": "MENUISERIE", "image": GlobalImages.carpenter},
    {"title": "SOLS", "image": GlobalImages.tiler},
    {"title": "PLOMBERIE", "image": GlobalImages.plumber},
    {"title": "PLÂTRERIE", "image": GlobalImages.drywallInstaller},
    {"title": "MAÇONNERIE", "image": GlobalImages.mason},
    {"title": "ÉLECTRICITÉ", "image": "assets/images/electrician.jpg"},
  ];


  // Photow wall
  static final Map<String, List<String>> photosWall = _initPhotosWall();
  
  static Map<String, List<String>> _initPhotosWall() {  // Allows to convert to lowercase
    final rawData = {
      'peinture': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'menuiserie': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'sols': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,      
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'plomberie': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'plâtrerie': [
        GlobalImages.backgroundLanding,      
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'maçonnerie': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
      'électricité': [
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,      
        GlobalImages.backgroundLanding,
        GlobalImages.backgroundLanding,
      ],
    };
    
    return rawData.map((key, value) => MapEntry(key.toLowerCase(), value ));  // The function automatically transforms them to lowercase
  }
}

class GlobalImages {
  static const String image1 = 'assets/images/image1.jpeg';
  static const String image2 = 'assets/images/image2.jpeg';
  static const String image3 = 'assets/images/image3.jpeg';
  static const String image4 = 'assets/images/image4.jpeg';
  static const String image5 = 'assets/images/image5.jpeg';
  static const String image6 = 'assets/images/image6.jpeg';
  static const String image7 = 'assets/images/image7.jpeg';
  static const String image8 = 'assets/images/image8.jpeg';
  // Landing Screen
    // Welcome section
  static const List<String> landingCarouselImages = [
    GlobalImages.backgroundLanding,
    GlobalImages.bakcgroundQuote,
    GlobalImages.workTogetherSection,
  ];
    // Welcome section 
  static const String backgroundLanding = 'assets/images/building.webp';

    // Company profile section
  static const String imageCompanyProfileSection = 'assets/images/imageCompanyProfileSection.webp';
  
    // What type of renovations section
  static const String bathroom = 'assets/images/bathroom.webp';
  static const String kitchen = 'assets/images/kitchen.webp';
  static const String renovationAfterDisaster = 'assets/images/renovationAfterDisaster.webp';
  static const String totalRenovation = 'assets/images/totalRenovation.webp';
  static const String partialRenovation = 'assets/images/partialRenovation.webp';
  
    // Services section
  static const String carpenter = 'assets/images/carpenter.webp';
  static const String drywallInstaller = 'assets/images/drywallInstaller.webp';
  static const String electrician = 'assets/images/electrician.webp';
  static const String painter = 'assets/images/painter.webp';
  static const String plumber = 'assets/images/plumber.webp';
  static const String tiler = 'assets/images/tiler.webp';
  static const String mason = 'assets/images/mason.webp';

    // Work together section
  static const String workTogetherSection = 'assets/images/workTogether.webp';

    // Before - After
  static const String before = 'assets/images/before.webp';
  static const String after = 'assets/images/after.webp';

  static const String customGoogleMarker = 'assets/images/icons/customGoogleMarker.png';
  static const String backgroundFeedbackSection = 'assets/images/backgroundFeedbackSection.png';
  static const String backgroundWhyChooseUsSection = 'assets/images/backgroundWhyChooseUs.png';
  
  // About screen
  static const String ourHistory = 'assets/images/ourHistory.webp';
  static const String ourServices = 'assets/images/ourServices.webp';
  static const String contact = 'assets/images/contactAboutScreen.webp';

  // Projects screen
  static const String all = 'assets/images/all.webp';  
  static const String bakcgroundQuote = 'assets/images/contactServicesScreen.webp';  
  
  // Succes popup componenet
  static const String successAnimation = 'assets/animations/success.json';

  // Capcha widget
  static const String imageCaptha = 'assets/images/building.webp';
  static const String iconCaptcha = 'assets/icons/captcha.png';
}

class GlobalLogosAndIcons {
  static const String blackCompanyLogo = 'assets/black_logo.svg';
  static const String whiteCompanyLogo = 'assets/white_logo.svg';
  static const String splash = 'assets/rive/sio2_renovations_splash.riv';
  static const String engagement = 'assets/engagement.svg';
  static const String call = 'assets/call.svg';
  static const String structured = 'assets/structured.svg';
  static const String customer = 'assets/customer.svg';
  static const String quotationMarks = 'assets/quotationMarks.svg';
  static const String cookies = 'assets/cookie.svg';
}

class GlobalAnimations{
  static const String logoWebsiteInProgress = 'assets/rive/work_in_progress.riv';
  static const String engagementAnimation = 'assets/rive/engagement.riv';
}

class GlobalButtonsAndIcons {
  static const String cookiesButton = 'assets/button.svg';
  static const String iconCookieButton = 'assets/icon_button.svg';
  static const String contactButton = 'assets/rive/contact_button.riv';
  static const String contactButtonWithReverse = 'assets/rive/contact_button _with_reverse.riv';
  static const String contactButtonV2 = 'assets/rive/contact_button_v2.riv';
  static const String callUsButton = 'assets/rive/call_us_button.riv';
  static const String freeQuoteButton = 'assets/rive/free_quote_button.riv';
  static const String freeQuoteButtonV2 = 'assets/rive/free_quote_button_v2.riv';
}

class GlobalSize {
  static const double mobileTitle = 24.0; 
  static const double webTitle = 30.0; 
  static const double mobileSubTitle = 16.0; 
  static const double webSubTitle = 18.0; 
  static const double mobileSizeText = 14.0; 
  static const double webSizeText = 16.0;
  static const double mobileItalicText = 12.0;
  static const double webItalicText = 14.0;
  static const double mobileBigTitle = 36.0;
  static const double webBigTitle = 42.0;

  // Landing screen
    // Why choose us section 
  static const double mobileWhyChooseUsSectionTitle = 18.0; 
  static const double webWhyChooseUsSectionTitle = 20.0; 
    // Steps section
  static const double stepsSectionMobilebSubTitle = 20.0; 
  static const double stepsSectionWebSubTitle = 24.0; 
  static const double stepsSectionMobileTitleCard = 52.0;
  static const double stepsSectionWebTitleCard = 52.0;
  static const double stepsSectionMobileSubTitleCard = 22.0;
  static const double stepsSectionWebSubTitleCard = 22.0;
    // Key figures section
  static const double keyFiguresSectionMobileTitle = 36.0;
  static const double keyFiguresSectionWebTitle = 40.0;
  static const double keyFiguresSectionSuffixMobileTitle = 28.0;
  static const double keyFiguresSectionSuffixWebTitle = 32.0;
  static const double keyFiguresSectionMobileSubTitle = 16.0;
  static const double keyFiguresSectionWebSubTitle = 18.0;
  static const double keyFiguresSectionMobileDescription = 12.0;
  static const double keyFiguresSectionWebDescription = 14.0;
    // Footer
  static const double footerMobileTitle = 18.0; 
  static const double footerWebTitle = 20.0; 
  static const double footerMobileSubTitle = 12.0; 
  static const double footerWebSubTitle = 14.0; 
  static const double footerMobileText = 12.0;
  static const double footerWebText = 14.0;
  static const double footerMobileCopyright = 12.0;
  static const double footerWebCopyright = 14.0;

  // Projects screen
    // Welcome section
  static const double welcomeSectionMobileSubTitle = 26.0;
  static const double welcomeSectionWebSubTitle = 36.0;
  static const double welcomeSectionMobileTitle = 28.0;
  static const double welcomeSectionWebTitle = 40.0;
}

class GlobalScrollTargets {
  static final GlobalKey cookiesKey = GlobalKey();
}
