import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Soft Purple/Lavender (Kawaii theme)
  static const Color primary = Color(0xFF8B7CF6);
  static const Color primaryLight = Color(0xFFB4A7FF);
  static const Color primaryDark = Color(0xFF6B5DD3);
  static const Color primarySurface = Color(0xFFF3F0FF);
  
  // Secondary Colors - Soft Pink
  static const Color secondary = Color(0xFFFF8FAB);
  static const Color secondaryLight = Color(0xFFFFB5C5);
  static const Color secondaryDark = Color(0xFFE56B8A);
  
  // Accent Colors - Soft Mint
  static const Color accent = Color(0xFF7DD3C0);
  static const Color accentLight = Color(0xFFA8E6D8);
  static const Color accentDark = Color(0xFF5BB5A2);
  
  // Light Mode Background Colors
  static const Color background = Color(0xFFFAF9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F3FF);
  
  // Dark Mode Background Colors
  static const Color backgroundDark = Color(0xFF121018);
  static const Color surfaceDark = Color(0xFF1E1A2E);
  static const Color surfaceVariantDark = Color(0xFF2A2540);
  static const Color cardDark = Color(0xFF252136);
  
  // Light Mode Text Colors
  static const Color textPrimary = Color(0xFF2D2942);
  static const Color textSecondary = Color(0xFF6E6B7B);
  static const Color textTertiary = Color(0xFFA5A3AE);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Dark Mode Text Colors
  static const Color textPrimaryDark = Color(0xFFF5F3FF);
  static const Color textSecondaryDark = Color(0xFFB8B5C5);
  static const Color textTertiaryDark = Color(0xFF8A8698);
  
  // Mood Colors (Gradient friendly)
  static const Color moodVeryPositive = Color(0xFF7DD3C0);
  static const Color moodPositive = Color(0xFF9BE8D8);
  static const Color moodNeutral = Color(0xFFFFD93D);
  static const Color moodLow = Color(0xFFFFB07B);
  static const Color moodVeryLow = Color(0xFFFF8FAB);
  
  // Mood Color Aliases
  static const Color moodGreat = moodVeryPositive;
  static const Color moodGood = moodPositive;
  static const Color textLight = textTertiary;
  
  // Status Colors
  static const Color success = Color(0xFF7DD3C0);
  static const Color warning = Color(0xFFFFD93D);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF74C0FC);
  
  // Utility Colors
  static const Color divider = Color(0xFFEEEBF5);
  static const Color dividerDark = Color(0xFF3A3550);
  static const Color disabled = Color(0xFFD1CFD9);
  static const Color disabledDark = Color(0xFF4A4560);
  static const Color shadow = Color(0x1A8B7CF6);
  
  // Gradient Presets
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFA78BFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient primaryGradientDark = LinearGradient(
    colors: [primaryDark, Color(0xFF8B7CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFFFFB8C9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFF9EECD9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFAF9FF), Color(0xFFF3F0FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient backgroundGradientDark = LinearGradient(
    colors: [Color(0xFF1E1A2E), Color(0xFF121018)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Mood Gradient
  static LinearGradient moodGradient(double score) {
    if (score > 0.75) {
      return const LinearGradient(
        colors: [moodVeryPositive, Color(0xFFB8F0E6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (score > 0.55) {
      return const LinearGradient(
        colors: [moodPositive, Color(0xFFC8F5E8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (score > 0.45) {
      return const LinearGradient(
        colors: [moodNeutral, Color(0xFFFFE566)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (score > 0.25) {
      return const LinearGradient(
        colors: [moodLow, Color(0xFFFFC799)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [moodVeryLow, Color(0xFFFFB5C5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
  
  // Get mood color from score
  static Color getMoodColor(double score) {
    if (score > 0.75) return moodVeryPositive;
    if (score > 0.55) return moodPositive;
    if (score > 0.45) return moodNeutral;
    if (score > 0.25) return moodLow;
    return moodVeryLow;
  }
  
  // Get mood label from score
  static String getMoodLabel(double score) {
    if (score > 0.75) return 'Great';
    if (score > 0.55) return 'Good';
    if (score > 0.45) return 'Okay';
    if (score > 0.25) return 'Low';
    return 'Tough';
  }
}
