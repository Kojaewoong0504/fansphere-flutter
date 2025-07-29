import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenTypeKey = 'token_type';
  static const String _expiresAtKey = 'expires_at';
  static const String _userDataKey = 'user_data';

  static TokenStorage? _instance;
  static TokenStorage get instance {
    _instance ??= TokenStorage._();
    return _instance!;
  }

  TokenStorage._();

  // Store authentication tokens
  Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

    await Future.wait([
      prefs.setString(_accessTokenKey, accessToken),
      prefs.setString(_refreshTokenKey, refreshToken),
      prefs.setString(_tokenTypeKey, tokenType),
      prefs.setString(_expiresAtKey, expiresAt.toIso8601String()),
    ]);
  }

  // Store user data
  Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, json.encode(userData));
  }

  // Get access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Get token type
  Future<String?> getTokenType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenTypeKey);
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      try {
        return json.decode(userDataString) as Map<String, dynamic>;
      } catch (e) {
        print('Error parsing user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if access token is expired
  Future<bool> isAccessTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiresAtString = prefs.getString(_expiresAtKey);
    
    if (expiresAtString == null) return true;
    
    try {
      final expiresAt = DateTime.parse(expiresAtString);
      // Consider token expired if it expires within 5 minutes
      final now = DateTime.now();
      final fiveMinuteBuffer = Duration(minutes: 5);
      return now.isAfter(expiresAt.subtract(fiveMinuteBuffer));
    } catch (e) {
      print('Error parsing expiration date: $e');
      return true;
    }
  }

  // Check if refresh token exists
  Future<bool> hasRefreshToken() async {
    final refreshToken = await getRefreshToken();
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  // Check if user is logged in (has valid tokens)
  Future<bool> isLoggedIn() async {
    final hasRefresh = await hasRefreshToken();
    final accessToken = await getAccessToken();
    return hasRefresh && accessToken != null && accessToken.isNotEmpty;
  }

  // Update access token (for token refresh)
  Future<void> updateAccessToken({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

    await Future.wait([
      prefs.setString(_accessTokenKey, accessToken),
      prefs.setString(_refreshTokenKey, refreshToken),
      prefs.setString(_expiresAtKey, expiresAt.toIso8601String()),
    ]);
  }

  // Clear all stored data (logout)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_accessTokenKey),
      prefs.remove(_refreshTokenKey),
      prefs.remove(_tokenTypeKey),
      prefs.remove(_expiresAtKey),
      prefs.remove(_userDataKey),
    ]);
  }

  // Get all token info for debugging
  Future<Map<String, dynamic>> getTokenInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'access_token': prefs.getString(_accessTokenKey),
      'refresh_token': prefs.getString(_refreshTokenKey),
      'token_type': prefs.getString(_tokenTypeKey),
      'expires_at': prefs.getString(_expiresAtKey),
      'is_expired': await isAccessTokenExpired(),
      'is_logged_in': await isLoggedIn(),
    };
  }

  // Check if tokens need refresh (access token expired but refresh token exists)
  Future<bool> needsTokenRefresh() async {
    final isExpired = await isAccessTokenExpired();
    final hasRefresh = await hasRefreshToken();
    return isExpired && hasRefresh;
  }
}