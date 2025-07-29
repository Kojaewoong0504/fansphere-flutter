import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/auth_response.dart';
import '../services/api_client.dart';
import '../services/token_storage.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final TokenStorage _tokenStorage = TokenStorage.instance;

  AuthState _state = AuthState.initial;
  User? _user;
  String? _errorMessage;

  // Getters
  AuthState get state => _state;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  // Initialize auth state on app start
  Future<void> initialize() async {
    _setState(AuthState.loading);

    try {
      // Check if user has stored tokens
      final isLoggedIn = await _tokenStorage.isLoggedIn();
      
      if (!isLoggedIn) {
        _setState(AuthState.unauthenticated);
        return;
      }

      // Check if token needs refresh
      final needsRefresh = await _tokenStorage.needsTokenRefresh();
      
      if (needsRefresh) {
        await _refreshToken();
      } else {
        // Load stored user data and set auth token
        await _loadStoredUserData();
      }
    } catch (e) {
      print('Auth initialization error: $e');
      await _handleAuthError(e);
    }
  }

  // Login with email and password
  Future<void> login(String email, String password) async {
    _setState(AuthState.loading);
    _clearError();

    try {
      final loginResponse = await _apiClient.login(email, password);
      
      // Store tokens and user data
      await _tokenStorage.storeTokens(
        accessToken: loginResponse.token.accessToken,
        refreshToken: loginResponse.token.refreshToken,
        tokenType: loginResponse.token.tokenType,
        expiresIn: loginResponse.token.expiresIn,
      );
      
      await _tokenStorage.storeUserData(loginResponse.user.toJson());
      
      // Set API client auth token
      _apiClient.setAuthToken(loginResponse.token.accessToken);
      
      // Update state
      _user = loginResponse.user;
      _setState(AuthState.authenticated);
      
      print('✅ Login successful: ${_user?.email}');
    } catch (e) {
      print('❌ Login error: $e');
      await _handleAuthError(e);
    }
  }

  // Logout user
  Future<void> logout() async {
    _setState(AuthState.loading);

    try {
      // Get refresh token for logout request
      final refreshToken = await _tokenStorage.getRefreshToken();
      
      if (refreshToken != null) {
        try {
          await _apiClient.logout(refreshToken);
        } catch (e) {
          // Continue with logout even if API call fails
          print('Logout API call failed: $e');
        }
      }
      
      // Clear stored data
      await _tokenStorage.clearAll();
      _apiClient.clearAuthToken();
      
      // Update state
      _user = null;
      _setState(AuthState.unauthenticated);
      
      print('✅ Logout successful');
    } catch (e) {
      print('❌ Logout error: $e');
      // Even if logout fails, clear local data
      await _tokenStorage.clearAll();
      _apiClient.clearAuthToken();
      _user = null;
      _setState(AuthState.unauthenticated);
    }
  }

  // Refresh access token
  Future<void> _refreshToken() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }
      
      final refreshResponse = await _apiClient.refreshToken(refreshToken);
      
      // Update stored tokens
      await _tokenStorage.updateAccessToken(
        accessToken: refreshResponse.accessToken,
        refreshToken: refreshResponse.refreshToken,
        expiresIn: refreshResponse.expiresIn,
      );
      
      // Set new auth token
      _apiClient.setAuthToken(refreshResponse.accessToken);
      
      // Load user data if not already loaded
      if (_user == null) {
        await _loadStoredUserData();
      } else {
        _setState(AuthState.authenticated);
      }
      
      print('✅ Token refresh successful');
    } catch (e) {
      print('❌ Token refresh failed: $e');
      await _handleAuthError(e);
    }
  }

  // Load stored user data
  Future<void> _loadStoredUserData() async {
    try {
      final userData = await _tokenStorage.getUserData();
      final accessToken = await _tokenStorage.getAccessToken();
      
      if (userData != null && accessToken != null) {
        _user = User.fromJson(userData);
        _apiClient.setAuthToken(accessToken);
        _setState(AuthState.authenticated);
        print('✅ Stored user data loaded: ${_user?.email}');
      } else {
        throw Exception('No stored user data found');
      }
    } catch (e) {
      print('❌ Failed to load stored user data: $e');
      await _handleAuthError(e);
    }
  }

  // Get current user from API (refresh user data)
  Future<void> refreshUser() async {
    if (_state != AuthState.authenticated) return;

    try {
      final user = await _apiClient.getCurrentUser();
      await _tokenStorage.storeUserData(user.toJson());
      _user = user;
      notifyListeners();
      print('✅ User data refreshed: ${user.email}');
    } catch (e) {
      print('❌ Failed to refresh user data: $e');
      // Don't change auth state for user refresh failures
    }
  }

  // Handle authentication errors
  Future<void> _handleAuthError(dynamic error) async {
    String errorMessage = '인증 오류가 발생했습니다.';
    
    if (error is UnauthorizedException) {
      errorMessage = '인증에 실패했습니다. 다시 로그인해주세요.';
      // Clear stored data for auth errors
      await _tokenStorage.clearAll();
      _apiClient.clearAuthToken();
      _user = null;
    } else if (error is NetworkException) {
      errorMessage = error.message;
    } else if (error is ValidationException) {
      errorMessage = error.message;
    } else if (error is RateLimitException) {
      errorMessage = error.message;
    } else if (error is ApiException) {
      errorMessage = error.message;
    } else if (error is Exception) {
      errorMessage = error.toString();
    }

    _errorMessage = errorMessage;
    _setState(AuthState.error);
  }

  // Set state and notify listeners
  void _setState(AuthState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  // Clear error message
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Clear error and reset to unauthenticated state
  void clearError() {
    _clearError();
    if (_state == AuthState.error) {
      _setState(AuthState.unauthenticated);
    }
  }

  // Check and refresh token if needed (call before important API requests)
  Future<bool> ensureTokenValid() async {
    if (_state != AuthState.authenticated) return false;

    try {
      final needsRefresh = await _tokenStorage.needsTokenRefresh();
      if (needsRefresh) {
        await _refreshToken();
      }
      return _state == AuthState.authenticated;
    } catch (e) {
      print('❌ Token validation failed: $e');
      return false;
    }
  }

  // Debug: Get token info
  Future<Map<String, dynamic>> getTokenInfo() async {
    return await _tokenStorage.getTokenInfo();
  }
}