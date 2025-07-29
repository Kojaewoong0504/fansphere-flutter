import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Font Family - Spotify-inspired with system fallbacks
  static const String _primaryFontFamily = 'SF Pro Display';
  static const String _secondaryFontFamily = 'SF Pro Text';
  
  // Display Styles - Large Headers
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
    height: 1.12,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.16,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.22,
  );
  
  // Headline Styles - Section Headers
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.25,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.29,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.33,
  );
  
  // Title Styles - Card titles, important labels
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.27,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
    height: 1.43,
  );
  
  // Body Styles - Main content text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
    height: 1.43,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
    height: 1.33,
  );
  
  // Label Styles - Buttons, tags, small labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
    height: 1.43,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.33,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
    height: 1.45,
  );
  
  // Custom Berry-themed Styles
  static const TextStyle modernTitle = TextStyle(
    fontFamily: _primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.primaryPurple,
    height: 1.2,
  );
  
  static const TextStyle modernSubtitle = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.accentElectric,
    height: 1.4,
  );
  
  static const TextStyle spotifyButton = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
    color: AppColors.textOnPrimary,
    height: 1.43,
  );
  
  // Specialty Text Styles
  static const TextStyle caption = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textTertiary,
    height: 1.6,
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: AppColors.textSecondary,
    height: 1.6,
  );
}

// Text Style Extensions for easy color modifications
extension AppTextStyleExtensions on TextStyle {
  TextStyle get onPrimary => copyWith(color: AppColors.textOnPrimary);
  TextStyle get onAccent => copyWith(color: AppColors.textOnAccent);
  TextStyle get secondary => copyWith(color: AppColors.darkTextSecondary);
  TextStyle get tertiary => copyWith(color: AppColors.darkTextTertiary);
  TextStyle get disabled => copyWith(color: AppColors.textDisabled);
  TextStyle get primaryPurple => copyWith(color: AppColors.primaryPurple);
  TextStyle get primaryPurpleLight => copyWith(color: AppColors.primaryPurpleLight);
  TextStyle get secondaryCyan => copyWith(color: AppColors.secondaryCyan);
  TextStyle get accentElectric => copyWith(color: AppColors.accentElectric);
  TextStyle get accentAmber => copyWith(color: AppColors.accentAmber);
  
  // Dark theme optimized colors
  TextStyle get darkPrimary => copyWith(color: AppColors.darkTextPrimary);
  TextStyle get darkSecondary => copyWith(color: AppColors.darkTextSecondary);
  TextStyle get darkTertiary => copyWith(color: AppColors.darkTextTertiary);
}