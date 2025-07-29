import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Dark theme optimized Purple/Blue
  static const Color primaryPurple = Color(0xFF8B5CF6); // Vibrant purple
  static const Color primaryPurpleLight = Color(0xFFA78BFA); // Light purple
  static const Color primaryPurpleDark = Color(0xFF7C3AED); // Dark purple
  
  // Secondary Colors - Cyan/Teal for contrast
  static const Color secondaryCyan = Color(0xFF06B6D4); // Modern cyan
  static const Color secondaryCyanLight = Color(0xFF22D3EE); // Light cyan
  static const Color secondaryCyanDark = Color(0xFF0891B2); // Dark cyan
  
  // Background Colors
  static const Color creamBackground = Color(0xFFF8F3F0); // Keep for light theme
  static const Color darkBackground = Color(0xFF0F0F0F); // Ultra dark background
  static const Color darkSurface = Color(0xFF1A1A1A); // Surface color
  static const Color lightGray = Color(0xFFB3B3B3);
  static const Color pureWhite = Color(0xFFFFFFFF);
  
  // Accent Colors - Neon/Electric
  static const Color accentElectric = Color(0xFF10B981); // Electric green
  static const Color accentElectricLight = Color(0xFF34D399); // Light electric
  static const Color accentElectricDark = Color(0xFF059669); // Dark electric
  
  // Modern Accent - Orange/Amber for warmth
  static const Color accentAmber = Color(0xFFF59E0B); // Modern amber
  static const Color accentAmberLight = Color(0xFFFBBF24); // Light amber
  static const Color accentAmberDark = Color(0xFFD97706); // Dark amber
  
  // Neutral Colors
  static const Color neutralLight = Color(0xFFF5F5F5);
  static const Color neutralMedium = Color(0xFF9E9E9E);
  static const Color neutralDark = Color(0xFF424242);
  static const Color neutralBlack = Color(0xFF212121);
  
  // Dark theme specific colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE0E0E0);
  static const Color darkTextTertiary = Color(0xFFBDBDBD);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Gradient Colors - Modern dark theme gradients
  static const List<Color> primaryGradient = [
    primaryPurple,
    primaryPurpleLight,
  ];
  
  static const List<Color> cyanGradient = [
    secondaryCyan,
    secondaryCyanLight,
  ];
  
  static const List<Color> electricGradient = [
    accentElectric,
    accentElectricLight,
  ];
  
  static const List<Color> amberGradient = [
    accentAmber,
    accentAmberLight,
  ];
  
  static const List<Color> naturalGradient = [
    creamBackground,
    neutralLight,
  ];
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Interactive States
  static const Color hoverOverlay = Color(0x0D000000);
  static const Color pressedOverlay = Color(0x1A000000);
  static const Color focusedOverlay = Color(0x1F000000);
  
  // Card and Surface Colors
  static const Color cardBackground = pureWhite;
  static const Color cardBackgroundDark = Color(0xFF1F1F1F); // Darker card background
  static const Color cardBorder = Color(0xFFE0E0E0);
  static const Color cardBorderDark = Color(0xFF3A3A3A); // Subtle dark border
  static const Color surfaceBackground = creamBackground;
  static const Color surfaceBackgroundDark = darkSurface;
  
  // Text Colors
  static const Color textPrimary = neutralBlack;
  static const Color textSecondary = neutralDark;
  static const Color textTertiary = neutralMedium;
  static const Color textDisabled = lightGray;
  static const Color textOnPrimary = pureWhite;
  static const Color textOnAccent = pureWhite;
}

class AppGradients {
  static const LinearGradient primaryToLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: AppColors.primaryGradient,
  );
  
  static const LinearGradient cyanTheme = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: AppColors.cyanGradient,
  );
  
  static const LinearGradient electricTheme = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: AppColors.electricGradient,
  );
  
  static const LinearGradient amberTheme = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: AppColors.amberGradient,
  );
  
  static const LinearGradient naturalTheme = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: AppColors.naturalGradient,
  );
  
  static const RadialGradient primaryRadial = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      AppColors.primaryPurpleLight,
      AppColors.primaryPurple,
    ],
  );
  
  static const RadialGradient electricRadial = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      AppColors.accentElectricLight,
      AppColors.accentElectric,
    ],
  );
}