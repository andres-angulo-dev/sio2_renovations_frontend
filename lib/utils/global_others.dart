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
    {"title": "ÉLÉCTRICITÉ", "image": GlobalImages.electrician},
  ];


  // Photow wall
  static final Map<String, List<String>> photosWall = _initPhotosWall();
  
  static Map<String, List<String>> _initPhotosWall() {  // Allows to convert to lowercase
    final rawData = {
      'all': [
        GlobalImages.image1,
        GlobalImages.image2,
        GlobalImages.image3,
        GlobalImages.image4,
        GlobalImages.image5,
        GlobalImages.image6,
        GlobalImages.image7,
        GlobalImages.image8,
        GlobalImages.image9,
        GlobalImages.image10,
        GlobalImages.image11,
        GlobalImages.image12,
        GlobalImages.image13,
        GlobalImages.image14,
        GlobalImages.image15,
        GlobalImages.image16,
        GlobalImages.image17,
        GlobalImages.image18,
        GlobalImages.image19,
        GlobalImages.image20,
        GlobalImages.image21,
        GlobalImages.image22,
        GlobalImages.image23,
        GlobalImages.image24,
        GlobalImages.image25,
        GlobalImages.image26,
        GlobalImages.image27,
        GlobalImages.image28,
        GlobalImages.image29,
        GlobalImages.image30,
        GlobalImages.image31,
        GlobalImages.image32,
        GlobalImages.image33,
        GlobalImages.image34,
        GlobalImages.image35,
        GlobalImages.image36,
        GlobalImages.image37,
        GlobalImages.image38,
        GlobalImages.image39,
        GlobalImages.image40,
        GlobalImages.image41,
        GlobalImages.image42,
        GlobalImages.image43,
        GlobalImages.image44,
        GlobalImages.image45,
        GlobalImages.image46,
        GlobalImages.image47,
        GlobalImages.image48,
        GlobalImages.image49,
        GlobalImages.image50,
        GlobalImages.image51,
        GlobalImages.image52,
        GlobalImages.image53,
        GlobalImages.image54,
        GlobalImages.image55,
        // GlobalImages.image56,
        // GlobalImages.image57,
      ]

      // 'peinture': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'menuiserie': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'sols': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,      
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'plomberie': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'plâtrerie': [
      //   GlobalImages.backgroundLanding,      
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'maçonnerie': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
      // 'Éléctricité': [
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,      
      //   GlobalImages.backgroundLanding,
      //   GlobalImages.backgroundLanding,
      // ],
    };
    
    return rawData.map((key, value) => MapEntry(key.toLowerCase(), value ));  // The function automatically transforms them to lowercase
  }
}

class GlobalImages {
  static const String image1 = 'assets/images/projects/image1.webp';
  static const String image2 = 'assets/images/projects/image2.webp';
  static const String image3 = 'assets/images/projects/image3.webp';
  static const String image4 = 'assets/images/projects/image4.webp';
  static const String image5 = 'assets/images/projects/image5.webp';
  static const String image6 = 'assets/images/projects/image6.webp';
  static const String image7 = 'assets/images/projects/image7.webp';
  static const String image8 = 'assets/images/projects/image8.webp';
  static const String image9 = 'assets/images/projects/image9.webp';
  static const String image10 = 'assets/images/projects/image10.webp';
  static const String image11 = 'assets/images/projects/image11.webp';
  static const String image12 = 'assets/images/projects/image12.webp';
  static const String image13 = 'assets/images/projects/image13.webp';
  static const String image14 = 'assets/images/projects/image14.webp';
  static const String image15 = 'assets/images/projects/image15.webp';
  static const String image16 = 'assets/images/projects/image16.webp';
  static const String image17 = 'assets/images/projects/image17.webp';
  static const String image18 = 'assets/images/projects/image18.webp';
  static const String image19 = 'assets/images/projects/image19.webp';
  static const String image20 = 'assets/images/projects/image20.webp';
  static const String image21 = 'assets/images/projects/image21.webp';
  static const String image22 = 'assets/images/projects/image22.webp';
  static const String image23 = 'assets/images/projects/image23.webp';
  static const String image24 = 'assets/images/projects/image24.webp';
  static const String image25 = 'assets/images/projects/image25.webp';
  static const String image26 = 'assets/images/projects/image26.webp';
  static const String image27 = 'assets/images/projects/image27.webp';
  static const String image28 = 'assets/images/projects/image28.webp';
  static const String image29 = 'assets/images/projects/image29.webp';
  static const String image30 = 'assets/images/projects/image30.webp';
  static const String image31 = 'assets/images/projects/image31.webp';
  static const String image32 = 'assets/images/projects/image32.webp';
  static const String image33 = 'assets/images/projects/image33.webp';
  static const String image34 = 'assets/images/projects/image34.webp';
  static const String image35 = 'assets/images/projects/image35.webp';
  static const String image36 = 'assets/images/projects/image36.webp';
  static const String image37 = 'assets/images/projects/image37.webp';
  static const String image38 = 'assets/images/projects/image38.webp';
  static const String image39 = 'assets/images/projects/image39.webp';
  static const String image40 = 'assets/images/projects/image40.webp';
  static const String image41 = 'assets/images/projects/image41.webp';
  static const String image42 = 'assets/images/projects/image42.webp';
  static const String image43 = 'assets/images/projects/image43.webp';
  static const String image44 = 'assets/images/projects/image44.webp';
  static const String image45 = 'assets/images/projects/image45.webp';
  static const String image46 = 'assets/images/projects/image46.webp';
  static const String image47 = 'assets/images/projects/image47.webp';
  static const String image48 = 'assets/images/projects/image48.webp';
  static const String image49 = 'assets/images/projects/image49.webp';
  static const String image50 = 'assets/images/projects/image50.webp';
  static const String image51 = 'assets/images/projects/image51.webp';
  static const String image52 = 'assets/images/projects/image52.webp';
  static const String image53 = 'assets/images/projects/image53.webp';
  static const String image54 = 'assets/images/projects/image54.webp';
  static const String image55 = 'assets/images/projects/image55.webp';
  static const String image56 = 'assets/images/projects/image56.webp';
  static const String image57 = 'assets/images/projects/image57.webp';

  // Landing Screen
    // Welcome section
  static const List<String> landingCarouselImages = [
    GlobalImages.landingScreenImage1,
    GlobalImages.landingScreenImage2,
    GlobalImages.landingScreenImage3,
    GlobalImages.landingScreenImage4,
    GlobalImages.landingScreenImage5,
    GlobalImages.landingScreenImage6,
  ];

    // Welcome section 
  static const String landingScreenImage1 = 'assets/images/landingScreenImage1.webp';
  static const String landingScreenImage2 = 'assets/images/landingScreenImage2.webp';
  static const String landingScreenImage3 = 'assets/images/landingScreenImage3.webp';
  static const String landingScreenImage4 = 'assets/images/landingScreenImage4.webp';
  static const String landingScreenImage5 = 'assets/images/landingScreenImage5.webp';
  static const String landingScreenImage6 = 'assets/images/landingScreenImage6.webp';

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

    // Why choose us section
  static const String backgroundWhyChooseUsSection = 'assets/images/backgroundWhyChooseUs.png';

    // Work together section
  static const String workTogetherSection = 'assets/images/workTogether.webp';

    // Key figures section (Google Map)
  static const String customGoogleMarker = 'assets/icons/customGoogleMarker.png';

    // Before - After section
  static const String before = 'assets/images/before.webp';
  static const String after = 'assets/images/after.webp';

    // Customer feedback section 
  static const String backgroundFeedbackSection = 'assets/images/backgroundFeedbackSection.png';

  // About screen
  static const String aboutScreenWelcomeImage= 'assets/images/aboutScreenWelcomeImage.webp';  
  static const String ourHistory = 'assets/images/ourHistory.webp';
  static const String ourServices = 'assets/images/ourServices.webp';
  static const String contact = 'assets/images/contactAboutScreen.webp';

  // Projects screen
  static const String projectsScreenWelcomeImage= 'assets/images/projectsScreenWelcomeImage.webp';  
  static const String all = 'assets/images/all.webp';  
  static const String bakcgroundQuote = 'assets/images/contactServicesScreen.webp';  

  // Partners screen
  static const String partnersScreenWelcomeImage= 'assets/images/partnersScreenWelcomeImage.webp';  

  // Contact screen
  static const String contactScreenWelcomeImage= 'assets/images/contactScreenWelcomeImage.webp';  

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
