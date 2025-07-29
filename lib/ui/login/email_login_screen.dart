import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../widgets/berry_button.dart';
import '../../widgets/berry_input.dart';
import '../../widgets/berry_card.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      
      final authProvider = context.read<AuthProvider>();
      await authProvider.login(email, password);
      
      // Navigate to home on successful login
      if (mounted && authProvider.isAuthenticated) {
        context.go('/home');
      }
    }
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
          child: Column(
            children: [
              // AppBar 영역
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundDark.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.pureWhite,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '이메일 로그인',
                      style: AppTextStyles.titleLarge.darkPrimary,
                    ),
                  ],
                ),
              ),
              
              // 메인 콘텐츠
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return BerryCard(
                            type: BerryCardType.elevated,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '계정으로 로그인',
                                    style: AppTextStyles.titleLarge.darkPrimary,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '이메일과 비밀번호를 입력해주세요',
                                    style: AppTextStyles.bodyMedium.darkSecondary,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),

                                  // 에러 메시지 표시
                                  if (authProvider.state == AuthState.error && 
                                      authProvider.errorMessage != null) ...[
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

                                  // 이메일 입력
                                  BerryInput.email(
                                    controller: _emailController,
                                    onChanged: (_) => _clearErrorIfPresent(authProvider),
                                  ),
                                  const SizedBox(height: 16),

                                  // 비밀번호 입력
                                  BerryInput.password(
                                    controller: _passwordController,
                                    onChanged: (_) => _clearErrorIfPresent(authProvider),
                                  ),
                                  const SizedBox(height: 24),

                                  // 로그인 버튼
                                  BerryButton.primary(
                                    text: '로그인',
                                    isFullWidth: true,
                                    isLoading: authProvider.isLoading,
                                    onPressed: authProvider.isLoading ? null : _submit,
                                    icon: const Icon(Icons.login, size: 20),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // 하단 링크
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: authProvider.isLoading
                                            ? null
                                            : () => context.push('/register'),
                                        child: Text(
                                          '회원가입',
                                          style: AppTextStyles.bodyMedium.primaryPurple,
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 16,
                                        color: AppColors.cardBorderDark,
                                      ),
                                      TextButton(
                                        onPressed: authProvider.isLoading
                                            ? null
                                            : () => context.push('/forgot-password'),
                                        child: Text(
                                          '비밀번호 찾기',
                                          style: AppTextStyles.bodyMedium.secondaryCyan,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearErrorIfPresent(AuthProvider authProvider) {
    if (authProvider.state == AuthState.error) {
      authProvider.clearError();
    }
  }
}
