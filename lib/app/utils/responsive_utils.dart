import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375; // Using iPhone 8 width as base
    return baseSize * scale.clamp(0.8, 1.4); // Limit scaling
  }

  static double getResponsiveSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375;
    return baseSize * scale.clamp(0.8, 1.6);
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double basePadding = 16.0;
    if (screenWidth > 600) {
      basePadding = 24.0;
    }
    if (screenWidth > 900) {
      basePadding = 32.0;
    }
    return EdgeInsets.all(basePadding);
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
}
