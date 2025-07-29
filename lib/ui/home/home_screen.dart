import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FanSphere'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!authProvider.isAuthenticated) {
            // 인증되지 않은 경우 로그인 화면으로 리디렉션
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = authProvider.user;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 환영 메시지
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '환영합니다! 👋',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        if (user != null) ...[
                          Text(
                            '${user.fullName} (${user.email})',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '사용자명: ${user.username}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                user.isVerified 
                                    ? Icons.verified 
                                    : Icons.pending,
                                color: user.isVerified 
                                    ? Colors.green 
                                    : Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user.isVerified ? '인증됨' : '인증 대기중',
                                style: TextStyle(
                                  color: user.isVerified 
                                      ? Colors.green 
                                      : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // 기능 버튼들
                Text(
                  '기능',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.refresh),
                        title: const Text('사용자 정보 새로고침'),
                        onTap: () => authProvider.refreshUser(),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text('토큰 정보 보기'),
                        onTap: () => _showTokenInfo(context, authProvider),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('로그아웃'),
                        onTap: () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthProvider>().logout();
                context.go('/login');
              },
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }

  void _showTokenInfo(BuildContext context, AuthProvider authProvider) async {
    final tokenInfo = await authProvider.getTokenInfo();
    
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('토큰 정보'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTokenInfoRow('로그인 상태', tokenInfo['is_logged_in']?.toString() ?? 'false'),
                  _buildTokenInfoRow('토큰 만료', tokenInfo['is_expired']?.toString() ?? 'true'),
                  _buildTokenInfoRow('만료 시간', tokenInfo['expires_at'] ?? 'N/A'),
                  _buildTokenInfoRow('토큰 타입', tokenInfo['token_type'] ?? 'N/A'),
                  const SizedBox(height: 8),
                  const Text(
                    '액세스 토큰:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _formatToken(tokenInfo['access_token']),
                    style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildTokenInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _formatToken(dynamic token) {
    if (token == null) return 'N/A';
    
    final tokenString = token.toString();
    if (tokenString.isEmpty) return 'N/A';
    
    const maxLength = 50;
    if (tokenString.length <= maxLength) {
      return tokenString;
    }
    
    return '${tokenString.substring(0, maxLength)}...';
  }
}