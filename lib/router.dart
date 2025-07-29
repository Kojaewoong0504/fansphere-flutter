import 'package:fansphere/ui/auth/forgot_password_screen.dart';
import 'package:fansphere/ui/auth/register_screen.dart';
import 'package:fansphere/ui/login/email_login_screen.dart';
import 'package:fansphere/ui/login/social_login_screen.dart';
import 'package:fansphere/ui/home/home_screen.dart';
import 'package:fansphere/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isAuthenticated = authProvider.isAuthenticated;
    final isLoading = authProvider.isLoading;
    
    // 로딩 중이면 리디렉션하지 않음
    if (isLoading) return null;
    
    // 인증된 상태에서 로그인 페이지에 있으면 홈으로 이동
    if (isAuthenticated && (state.uri.path == '/' || state.uri.path == '/login' || state.uri.path == '/email-login')) {
      return '/home';
    }
    
    // 인증되지 않은 상태에서 홈에 있으면 로그인 페이지로 이동
    if (!isAuthenticated && state.uri.path == '/home') {
      return '/';
    }
    
    return null;
  },
  routes: [
    // Auth routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SocialLoginScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const SocialLoginScreen(),
    ),
    GoRoute(
      path: '/email-login',
      builder: (context, state) => const EmailLoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    
    // Main app routes
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
