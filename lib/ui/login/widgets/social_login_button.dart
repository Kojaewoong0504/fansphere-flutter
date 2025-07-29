import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final BorderSide? border;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // Berry 디자인 시스템의 버튼 높이
      child: ElevatedButton.icon(
        icon: Icon(
          icon, 
          color: textColor,
          size: 20,
        ),
        label: Text(
          text, 
          style: AppTextStyles.titleMedium.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Berry 디자인 시스템의 둥근 모서리
          ),
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          side: border,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
