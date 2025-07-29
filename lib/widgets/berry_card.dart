import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';

enum BerryCardType {
  basic,
  elevated,
  outlined,
  gradient,
  music, // Spotify-inspired music card
}

class BerryCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final BerryCardType type;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  
  const BerryCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.type = BerryCardType.basic,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.gradientColors,
  });
  
  factory BerryCard.music({
    Key? key,
    required String title,
    String? artist,
    Widget? albumCover,
    VoidCallback? onTap,
    Widget? trailing,
    EdgeInsets? margin,
  }) {
    return BerryCard(
      key: key,
      type: BerryCardType.music,
      title: title,
      subtitle: artist,
      leading: albumCover,
      trailing: trailing,
      onTap: onTap,
      margin: margin,
      padding: const EdgeInsets.all(12),
    );
  }
  
  factory BerryCard.gradient({
    Key? key,
    Widget? child,
    String? title,
    String? subtitle,
    VoidCallback? onTap,
    List<Color>? gradientColors,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? width,
    double? height,
  }) {
    return BerryCard(
      key: key,
      type: BerryCardType.gradient,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      gradientColors: gradientColors ?? AppColors.primaryGradient,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: child,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          child: Container(
            decoration: _getDecoration(context),
            padding: padding ?? const EdgeInsets.all(16),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    if (child != null) {
      return child!;
    }
    
    if (type == BerryCardType.music) {
      return _buildMusicCardContent(context);
    }
    
    return _buildStandardContent(context);
  }
  
  Widget _buildMusicCardContent(BuildContext context) {
    return Row(
      children: [
        // Album Cover
        if (leading != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 56,
              height: 56,
              child: leading!,
            ),
          ),
          const SizedBox(width: 12),
        ],
        
        // Song Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: AppTextStyles.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall.secondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        
        // Trailing (Play button, more options, etc.)
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
  
  Widget _buildStandardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null || title != null || trailing != null)
          Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12),
              ],
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: _getTitleStyle(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing!,
              ],
            ],
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: _getSubtitleStyle(context),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
  
  BoxDecoration _getDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    switch (type) {
      case BerryCardType.basic:
        return BoxDecoration(
          color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
            width: 1,
          ),
        );
      
      case BerryCardType.elevated:
        return BoxDecoration(
          color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ],
        );
      
      case BerryCardType.outlined:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryPurple,
            width: 2,
          ),
        );
      
      case BerryCardType.gradient:
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors ?? AppColors.primaryGradient,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 12,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ],
        );
      
      case BerryCardType.music:
        return BoxDecoration(
          color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color: (isDark ? AppColors.cardBorderDark : AppColors.cardBorder).withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        );
    }
  }
  
  TextStyle _getTitleStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    switch (type) {
      case BerryCardType.gradient:
        return AppTextStyles.titleLarge.onPrimary;
      case BerryCardType.music:
        return isDark ? AppTextStyles.titleMedium.darkPrimary : AppTextStyles.titleMedium;
      default:
        return isDark ? AppTextStyles.titleLarge.darkPrimary : AppTextStyles.titleLarge;
    }
  }
  
  TextStyle _getSubtitleStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    switch (type) {
      case BerryCardType.gradient:
        return AppTextStyles.bodyMedium.onPrimary;
      case BerryCardType.music:
        return isDark ? AppTextStyles.bodySmall.darkSecondary : AppTextStyles.bodySmall.secondary;
      default:
        return isDark ? AppTextStyles.bodyMedium.darkSecondary : AppTextStyles.bodyMedium.secondary;
    }
  }
}

// Berry-shaped decorative container
class BerryShape extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double size;
  final VoidCallback? onTap;
  
  const BerryShape({
    super.key,
    required this.child,
    this.color,
    this.size = 80,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        size: Size(size, size),
        painter: _BerryShapePainter(
          color: color ?? AppColors.primaryPurple,
        ),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _BerryShapePainter extends CustomPainter {
  final Color color;
  
  const _BerryShapePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Create a berry-like shape (rounded with a slight indent at top)
    path.moveTo(center.dx, center.dy - radius);
    
    // Create curves to simulate berry shape
    path.quadraticBezierTo(
      center.dx + radius * 0.8, center.dy - radius * 0.3,
      center.dx + radius, center.dy + radius * 0.3,
    );
    
    path.quadraticBezierTo(
      center.dx + radius * 0.3, center.dy + radius,
      center.dx, center.dy + radius,
    );
    
    path.quadraticBezierTo(
      center.dx - radius * 0.3, center.dy + radius,
      center.dx - radius, center.dy + radius * 0.3,
    );
    
    path.quadraticBezierTo(
      center.dx - radius * 0.8, center.dy - radius * 0.3,
      center.dx, center.dy - radius,
    );
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}