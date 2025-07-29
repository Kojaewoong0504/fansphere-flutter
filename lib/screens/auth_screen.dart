import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';
import '../widgets/berry_button.dart';
import '../widgets/berry_card.dart';
import '../widgets/berry_input.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    _emailController.dispose();
    _passwordController.dispose();
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
                            'Your Music Universe',
                            style: AppTextStyles.titleMedium.darkSecondary,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Login Form
                    BerryCard(
                      type: BerryCardType.elevated,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome Back',
                              style: AppTextStyles.headlineMedium.darkPrimary,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in to continue your musical journey',
                              style: AppTextStyles.bodyMedium.darkSecondary,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            
                            // Email Input
                            BerryInput.email(
                              controller: _emailController,
                              onChanged: (_) => _clearErrorIfPresent(),
                            ),
                            const SizedBox(height: 16),
                            
                            // Password Input
                            BerryInput.password(
                              controller: _passwordController,
                              onChanged: (_) => _clearErrorIfPresent(),
                            ),
                            const SizedBox(height: 24),
                            
                            // Error Display
                            Consumer<AuthProvider>(
                              builder: (context, authProvider, child) {
                                if (authProvider.state == AuthState.error && 
                                    authProvider.errorMessage != null) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.red.withValues(alpha: 0.3),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red.shade400,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                authProvider.errorMessage!,
                                                style: AppTextStyles.bodySmall.copyWith(
                                                  color: Colors.red.shade400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            
                            // Login Button
                            Consumer<AuthProvider>(
                              builder: (context, authProvider, child) {
                                return BerryButton.primary(
                                  text: 'Sign In',
                                  isFullWidth: true,
                                  isLoading: authProvider.isLoading,
                                  onPressed: authProvider.isLoading ? null : _handleLogin,
                                  icon: const Icon(Icons.login, size: 20),
                                );
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Secondary Actions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => _showSnackBar('Forgot password feature coming soon'),
                                  child: Text(
                                    'Forgot Password?',
                                    style: AppTextStyles.bodySmall.primaryPurple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sign Up Option
                    BerryCard(
                      type: BerryCardType.outlined,
                      child: Column(
                        children: [
                          Text(
                            'New to FanSphere?',
                            style: AppTextStyles.bodyMedium.darkSecondary,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          BerryButton.outline(
                            text: 'Create Account',
                            isFullWidth: true,
                            onPressed: () => _showSnackBar('Sign up feature coming soon'),
                            icon: const Icon(Icons.person_add, size: 20),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Demo Access
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/demo'),
                      child: Text(
                        'Explore Demo →',
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

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.login(email, password);
    
    if (mounted && authProvider.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _clearErrorIfPresent() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.state == AuthState.error) {
      authProvider.clearError();
    }
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