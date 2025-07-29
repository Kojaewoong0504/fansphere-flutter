import 'package:fansphere/ui/login/widgets/social_login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MyApp',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                '간편하게 로그인하고 시작하세요',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              SocialLoginButton(
                icon: Icons.chat_bubble, // 나중에 카카오톡 아이콘
                text: '카카오로 계속하기',
                color: const Color(0xFFFEE500),
                textColor: Colors.black,
                onPressed: () {
                  // context.read<LoginBloc>().add(KakaoLoginRequested());
                },
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.person,
                text: '네이버로 계속하기',
                color: const Color(0xFF03C75A),
                textColor: Colors.white,
                onPressed: () {
                  // context.read<LoginBloc>().add(NaverLoginRequested());
                },
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.g_mobiledata,
                text: 'Google로 계속하기',
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  // context.read<LoginBloc>().add(GoogleLoginRequested());
                },
                border: BorderSide(color: Colors.grey.shade300),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.apple,
                text: 'Apple로 계속하기',
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  // context.read<LoginBloc>().add(AppleLoginRequested());
                },
              ),

              const SizedBox(height: 24),
              // 이메일 로그인 링크
              TextButton(
                onPressed: () => context.push('/email-login'),
                child: const Text(
                  '이메일로 로그인 / 회원가입',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
