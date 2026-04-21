import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  static double sp(double size) {
    return size.sp;
  }

  static double w(double size) {
    return size.w;
  }

  static double h(double size) {
    return size.h;
  }

  static double r(double size) {
    return size.r;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    if (isMobile(context)) {
      return EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h);
    } else {
      return EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h);
    }
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  static double getGridAspectRatio(BuildContext context) {
    if (isMobile(context)) {
      return 0.7;
    } else if (isTablet(context)) {
      return 0.75;
    } else {
      return 0.8;
    }
  }
}
