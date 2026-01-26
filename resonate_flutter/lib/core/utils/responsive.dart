import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive utility class for handling different screen sizes
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Returns appropriate value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// Returns appropriate value based on orientation
  static T orientation<T>(
    BuildContext context, {
    required T portrait,
    required T landscape,
  }) {
    return isLandscape(context) ? landscape : portrait;
  }

  /// Get responsive padding
  static EdgeInsets screenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: value(context, mobile: 20.w, tablet: 40.w, desktop: 80.w),
      vertical: value(context, mobile: 16.h, tablet: 24.h, desktop: 32.h),
    );
  }

  /// Get responsive grid column count
  static int gridColumns(BuildContext context) {
    return value(context, mobile: 2, tablet: 3, desktop: 4);
  }

  /// Get responsive card width
  static double cardWidth(BuildContext context) {
    final width = screenWidth(context);
    if (isDesktop(context)) return (width - 200) / 4;
    if (isTablet(context)) return (width - 120) / 3;
    return width - 40;
  }
}

/// Extension for responsive sizing
extension ResponsiveExtension on num {
  /// Responsive width that adapts to screen size
  double rw(BuildContext context) {
    final baseWidth = 390.0; // Design width
    final scale = Responsive.screenWidth(context) / baseWidth;
    return this * scale.clamp(0.8, 1.5);
  }

  /// Responsive height that adapts to screen size
  double rh(BuildContext context) {
    final baseHeight = 844.0; // Design height
    final scale = Responsive.screenHeight(context) / baseHeight;
    return this * scale.clamp(0.8, 1.5);
  }
}
