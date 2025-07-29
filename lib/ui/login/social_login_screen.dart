import 'package:fansphere/ui/login/widgets/social_login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({super.key});

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkBackground,
              AppColors.primaryPurpleDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo Section
                    FadeTransition(
                      opacity: _logoAnimation,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primaryPurpleLight,
                                  AppColors.secondaryCyanLight,
                                  AppColors.accentElectricLight,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryPurple.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.music_note,
                              size: 60,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                AppColors.primaryPurpleLight,
                                AppColors.secondaryCyanLight,
                                AppColors.accentElectricLight,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              'FanSphere',
                              style: AppTextStyles.displayLarge.copyWith(
                                color: AppColors.pureWhite,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '음악과 함께하는 특별한 공간',
                            style: AppTextStyles.titleMedium.darkSecondary,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Welcome Text
                    Text(
                      '간편하게 로그인하고 시작하세요',
                      style: AppTextStyles.titleLarge.darkPrimary,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // Social Login Buttons
                    SocialLoginButton(
                      icon: Icons.chat_bubble,
                      text: '카카오로 계속하기',
                      color: const Color(0xFFFEE500),
                      textColor: Colors.black,
                      onPressed: () {
                        _showSnackBar('카카오 로그인 기능 준비중입니다');
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    SocialLoginButton(
                      icon: Icons.person,
                      text: '네이버로 계속하기',
                      color: const Color(0xFF03C75A),
                      textColor: Colors.white,
                      onPressed: () {
                        _showSnackBar('네이버 로그인 기능 준비중입니다');
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    SocialLoginButton(
                      icon: Icons.g_mobiledata,
                      text: 'Google로 계속하기',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        _showSnackBar('Google 로그인 기능 준비중입니다');
                      },
                      border: BorderSide(color: Colors.grey.shade300),
                    ),
                    const SizedBox(height: 16),
                    
                    SocialLoginButton(
                      icon: Icons.apple,
                      text: 'Apple로 계속하기',
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        _showSnackBar('Apple 로그인 기능 준비중입니다');
                      },
                    ),

                    const SizedBox(height: 32),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.cardBorderDark.withValues(alpha: 0.5),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '또는',
                            style: AppTextStyles.bodySmall.darkSecondary,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.cardBorderDark.withValues(alpha: 0.5),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Email Login Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryPurple.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => context.push('/email-login'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          '이메일로 로그인 / 회원가입',
                          style: AppTextStyles.titleMedium.primaryPurple,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Demo Access
                    TextButton(
                      onPressed: () => context.push('/demo'),
                      child: Text(
                        '디자인 시스템 데모 보기 →',
                        style: AppTextStyles.bodyMedium.secondaryCyan,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.primaryPurple,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
