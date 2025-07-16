class GlobalDates {
  // Privaty policy screen
  static const String lastUpdate = '1er août 2025'; 
}

class GlobalPersonalData {
  GlobalPersonalData._(); // private constructor to prevent instantiation
  // Company
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
  static const String backgroundLanding = 'assets/images/immeuble.jpeg';
  static const String customGoogleMarker = 'assets/images/customGoogleMarker.png';
  static const String backgroundFeedbackSection = 'assets/images/backgroundFeedbackSection.png';
  static const String backgroundWhyChooseUsSection = 'assets/images/backgroundWhyChooseUs.png';
  static const String backgroundWorkTogetherSection = 'assets/images/AdobeStock_544852100bis.jpg';
  static const List<String> landingCarouselImages = [
    GlobalImages.backgroundLanding,
    GlobalImages.bakcgroundQuote,
    GlobalImages.backgroundWorkTogetherSection,
  ];
  
  // Projects screen
  static const String bakcgroundQuote = 'assets/images/iStock-871105006.webp';  
  
  // CapchaComponent
  static const String imageCaptha = 'assets/images/immeuble.jpeg';
  static const String iconCaptcha = 'assets/icons/captcha.png';

  static const Map<String, List<String>> photosByService = {
    'PEINTURE': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'MENUISERIE': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'SOLS': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,      
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'PLOMBERIE': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'CHAUFFAGE': [
      GlobalImages.backgroundLanding,      
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'MAÇONNERIE': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
    'ÉLECTRICITÉ': [
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,      
      GlobalImages.backgroundLanding,
      GlobalImages.backgroundLanding,
    ],
  };
}

class GlobalLogo {
  static const String blackLogo = 'assets/black_logo.svg';
  static const String whiteLogo = 'assets/white_logo.svg';
  static const String logoSplash = 'assets/rive/sio2_renovations_splash.riv';
  static const String logoEngagement = 'assets/engagement.svg';
  static const String logoCall = 'assets/call.svg';
  static const String logoStructured = 'assets/structured.svg';
  static const String logoCustomer = 'assets/customer.svg';
  static const String logoDots = 'assets/dots.svg';
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


