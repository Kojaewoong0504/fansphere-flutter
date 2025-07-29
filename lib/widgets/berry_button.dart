import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';

enum BerryButtonType {
  primary,
  secondary,
  cyan,
  accent,
  outline,
}

enum BerryButtonSize {
  small,
  medium,
  large,
}

class BerryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BerryButtonType type;
  final BerryButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;
  
  const BerryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = BerryButtonType.primary,
    this.size = BerryButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
  });
  
  factory BerryButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    BerryButtonSize size = BerryButtonSize.medium,
    Widget? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return BerryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: BerryButtonType.primary,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
  
  factory BerryButton.cyan({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    BerryButtonSize size = BerryButtonSize.medium,
    Widget? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return BerryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: BerryButtonType.cyan,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
  
  factory BerryButton.outline({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    BerryButtonSize size = BerryButtonSize.medium,
    Widget? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return BerryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: BerryButtonType.outline,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: _buildButtonContent(),
      ),
    );
  }
  
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        height: _getButtonHeight() - 32,
        width: _getButtonHeight() - 32,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
        ),
      );
    }
    
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }
    
    return Text(text);
  }
  
  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      textStyle: _getTextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        side: _getBorderSide(),
      ),
      padding: padding ?? _getPadding(),
      elevation: _getElevation(),
      shadowColor: AppColors.shadowMedium,
      minimumSize: Size(0, _getButtonHeight()),
    );
  }
  
  Color _getBackgroundColor() {
    switch (type) {
      case BerryButtonType.primary:
        return AppColors.primaryPurple;
      case BerryButtonType.secondary:
        return AppColors.neutralLight;
      case BerryButtonType.cyan:
        return AppColors.secondaryCyan;
      case BerryButtonType.accent:
        return AppColors.accentElectric;
      case BerryButtonType.outline:
        return Colors.transparent;
    }
  }
  
  Color _getTextColor() {
    switch (type) {
      case BerryButtonType.primary:
      case BerryButtonType.cyan:
      case BerryButtonType.accent:
        return AppColors.textOnPrimary;
      case BerryButtonType.secondary:
        return AppColors.textPrimary;
      case BerryButtonType.outline:
        return AppColors.primaryPurple;
    }
  }
  
  TextStyle _getTextStyle() {
    switch (size) {
      case BerryButtonSize.small:
        return AppTextStyles.labelMedium;
      case BerryButtonSize.medium:
        return AppTextStyles.labelLarge;
      case BerryButtonSize.large:
        return AppTextStyles.titleMedium;
    }
  }
  
  double _getBorderRadius() {
    switch (size) {
      case BerryButtonSize.small:
        return 8.0;
      case BerryButtonSize.medium:
        return 16.0;
      case BerryButtonSize.large:
        return 20.0;
    }
  }
  
  BorderSide _getBorderSide() {
    if (type == BerryButtonType.outline) {
      return const BorderSide(
        color: AppColors.primaryPurple,
        width: 1.5,
      );
    }
    return BorderSide.none;
  }
  
  EdgeInsets _getPadding() {
    switch (size) {
      case BerryButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case BerryButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case BerryButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    }
  }
  
  double _getElevation() {
    switch (type) {
      case BerryButtonType.primary:
      case BerryButtonType.cyan:
      case BerryButtonType.accent:
        return 2.0;
      case BerryButtonType.secondary:
        return 1.0;
      case BerryButtonType.outline:
        return 0.0;
    }
  }
  
  double _getButtonHeight() {
    switch (size) {
      case BerryButtonSize.small:
        return 40.0;
      case BerryButtonSize.medium:
        return 48.0;
      case BerryButtonSize.large:
        return 56.0;
    }
  }
}