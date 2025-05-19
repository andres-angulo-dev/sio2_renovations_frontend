import 'package:flutter/material.dart';

class GlobalSizes {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isMobileScreen(BuildContext context) {
    return screenWidth(context) < 803;
  }

  static bool isExtraSmallScreen(BuildContext context) {
    return screenWidth(context) < 587;
  }

  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 1021;
  }

  static bool isCustomServicesSection(BuildContext context) {
    return screenWidth(context) < 1879;
  }
}

