import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static const double _borderRadius = 16.0;
  static const double _borderRadiusSmall = 8.0;
  static const double _borderRadiusLarge = 24.0;
  
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.creamBackground,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: _dividerTheme,
      snackBarTheme: _snackBarTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      bottomSheetTheme: _bottomSheetTheme,
      dialogTheme: _dialogTheme,
    );
  }
  
  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _textThemeDark,
      appBarTheme: _appBarThemeDark,
      bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonThemeDark,
      textButtonTheme: _textButtonTheme,
      cardTheme: _cardThemeDark,
      chipTheme: _chipThemeDark,
      inputDecorationTheme: _inputDecorationThemeDark,
      dividerTheme: _dividerThemeDark,
      snackBarTheme: _snackBarThemeDark,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      bottomSheetTheme: _bottomSheetThemeDark,
      dialogTheme: _dialogThemeDark,
    );
  }
  
  // Color Schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primaryPurple,
    onPrimary: AppColors.textOnPrimary,
    secondary: AppColors.secondaryCyan,
    onSecondary: AppColors.textOnPrimary,
    tertiary: AppColors.accentElectric,
    onTertiary: AppColors.textOnAccent,
    error: AppColors.error,
    onError: AppColors.pureWhite,
    surface: AppColors.creamBackground,
    onSurface: AppColors.textPrimary,
    outline: AppColors.cardBorder,
    shadow: AppColors.shadowMedium,
    scrim: AppColors.shadowDark,
    inverseSurface: AppColors.darkSurface,
    onInverseSurface: AppColors.pureWhite,
    inversePrimary: AppColors.accentElectric,
  );
  
  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryPurpleLight,
    onPrimary: AppColors.neutralBlack,
    secondary: AppColors.secondaryCyanLight,
    onSecondary: AppColors.neutralBlack,
    tertiary: AppColors.accentElectricLight,
    onTertiary: AppColors.neutralBlack,
    error: AppColors.error,
    onError: AppColors.pureWhite,
    surface: AppColors.darkBackground,
    onSurface: AppColors.pureWhite,
    outline: AppColors.cardBorderDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.neutralBlack,
    inverseSurface: AppColors.creamBackground,
    onInverseSurface: AppColors.neutralBlack,
    inversePrimary: AppColors.primaryPurple,
  );
  
  // Text Themes
  static TextTheme get _textTheme {
    return const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }
  
  static TextTheme get _textThemeDark {
    return _textTheme.apply(
      bodyColor: AppColors.pureWhite,
      displayColor: AppColors.pureWhite,
    );
  }
  
  // Component Themes
  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: AppColors.creamBackground,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: AppTextStyles.headlineSmall,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
  
  static AppBarTheme get _appBarThemeDark {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.pureWhite,
      titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: AppColors.pureWhite),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
  
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.primaryPurple,
      unselectedItemColor: AppColors.neutralMedium,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
      elevation: 8,
    );
  }
  
  static BottomNavigationBarThemeData get _bottomNavigationBarThemeDark {
    return const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.cardBackgroundDark,
      selectedItemColor: AppColors.primaryPurpleLight,
      unselectedItemColor: AppColors.lightGray,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
      elevation: 8,
    );
  }
  
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: AppColors.textOnPrimary,
        textStyle: AppTextStyles.spotifyButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
        shadowColor: AppColors.shadowMedium,
      ),
    );
  }
  
  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryPurple,
        textStyle: AppTextStyles.spotifyButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        side: const BorderSide(color: AppColors.primaryPurple, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }
  
  static OutlinedButtonThemeData get _outlinedButtonThemeDark {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryPurpleLight,
        textStyle: AppTextStyles.spotifyButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        side: const BorderSide(color: AppColors.primaryPurpleLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }
  
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondaryCyan,
        textStyle: AppTextStyles.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusSmall),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
  
  static CardThemeData get _cardTheme {
    return CardThemeData(
      color: AppColors.cardBackground,
      elevation: 4,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      margin: const EdgeInsets.all(8),
    );
  }
  
  static CardThemeData get _cardThemeDark {
    return CardThemeData(
      color: AppColors.cardBackgroundDark,
      elevation: 4,
      shadowColor: AppColors.shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      margin: const EdgeInsets.all(8),
    );
  }
  
  static ChipThemeData get _chipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.neutralLight,
      labelStyle: AppTextStyles.labelMedium,
      selectedColor: AppColors.accentElectric,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusLarge),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
  
  static ChipThemeData get _chipThemeDark {
    return ChipThemeData(
      backgroundColor: AppColors.neutralDark,
      labelStyle: AppTextStyles.labelMedium.onPrimary,
      selectedColor: AppColors.primaryPurpleLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusLarge),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
  
  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutralLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: AppTextStyles.bodyMedium.secondary,
      hintStyle: AppTextStyles.bodyMedium.tertiary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
  
  static InputDecorationTheme get _inputDecorationThemeDark {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackgroundDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.cardBorderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.cardBorderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.primaryPurpleLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: AppTextStyles.bodyMedium.onPrimary,
      hintStyle: AppTextStyles.bodyMedium.tertiary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
  
  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.cardBorder,
      thickness: 1,
      space: 16,
    );
  }
  
  static DividerThemeData get _dividerThemeDark {
    return const DividerThemeData(
      color: AppColors.neutralMedium,
      thickness: 1,
      space: 16,
    );
  }
  
  static SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppColors.neutralBlack,
      contentTextStyle: AppTextStyles.bodyMedium.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusSmall),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
  
  static SnackBarThemeData get _snackBarThemeDark {
    return SnackBarThemeData(
      backgroundColor: AppColors.neutralLight,
      contentTextStyle: AppTextStyles.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusSmall),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
  
  static FloatingActionButtonThemeData get _floatingActionButtonTheme {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentElectric,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
    );
  }
  
  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_borderRadiusLarge),
        ),
      ),
      elevation: 8,
    );
  }
  
  static BottomSheetThemeData get _bottomSheetThemeDark {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.cardBackgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_borderRadiusLarge),
        ),
      ),
      elevation: 8,
    );
  }
  
  static DialogThemeData get _dialogTheme {
    return DialogThemeData(
      backgroundColor: AppColors.cardBackground,
      titleTextStyle: AppTextStyles.headlineSmall,
      contentTextStyle: AppTextStyles.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusLarge),
      ),
      elevation: 24,
    );
  }
  
  static DialogThemeData get _dialogThemeDark {
    return DialogThemeData(
      backgroundColor: AppColors.cardBackgroundDark,
      titleTextStyle: AppTextStyles.headlineSmall.onPrimary,
      contentTextStyle: AppTextStyles.bodyMedium.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadiusLarge),
      ),
      elevation: 24,
    );
  }
}

// Custom Theme Extensions
extension ThemeDataExtensions on ThemeData {
  /// Modern Music Hub specific colors
  Color get primaryPurple => AppColors.primaryPurple;
  Color get primaryPurpleLight => AppColors.primaryPurpleLight;
  Color get secondaryCyan => AppColors.secondaryCyan;
  Color get accentElectric => AppColors.accentElectric;
  Color get accentAmber => AppColors.accentAmber;
  Color get darkBackground => AppColors.darkBackground;
  
  /// Modern Music Hub specific gradients
  LinearGradient get primaryGradient => AppGradients.primaryToLight;
  LinearGradient get cyanGradient => AppGradients.cyanTheme;
  LinearGradient get electricGradient => AppGradients.electricTheme;
  LinearGradient get amberGradient => AppGradients.amberTheme;
  RadialGradient get primaryRadial => AppGradients.primaryRadial;
  RadialGradient get electricRadial => AppGradients.electricRadial;
}