import 'package:dio/dio.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/user.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Request interceptor for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🔥 Request: ${options.method} ${options.path}');
          print('🔥 Headers: ${options.headers}');
          if (options.data != null) {
            print('🔥 Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response: ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('❌ Error: ${error.response?.statusCode} ${error.requestOptions.path}');
          print('❌ Error Data: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }

  // Set authorization token for authenticated requests
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear authorization token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Login with email and password
  Future<LoginResponse> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _dio.post('/auth/login', data: request.toJson());
      
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Refresh access token
  Future<RefreshTokenResponse> refreshToken(String refreshToken) async {
    try {
      final request = RefreshTokenRequest(refreshToken: refreshToken);
      final response = await _dio.post('/auth/refresh', data: request.toJson());
      
      return RefreshTokenResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Logout user
  Future<void> logout(String refreshToken, {bool revokeAll = false}) async {
    try {
      final request = LogoutRequest(
        refreshToken: refreshToken,
        revokeAll: revokeAll,
      );
      await _dio.post('/auth/logout', data: request.toJson());
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Get current user profile
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Handle Dio exceptions and convert to custom exceptions
  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('연결 시간이 초과되었습니다. 네트워크 상태를 확인해주세요.');
      
      case DioExceptionType.connectionError:
        return NetworkException('네트워크 연결에 실패했습니다. 인터넷 연결을 확인해주세요.');
      
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        
        switch (statusCode) {
          case 400:
            return BadRequestException(_extractErrorMessage(responseData) ?? '잘못된 요청입니다.');
          case 401:
            return UnauthorizedException(_extractErrorMessage(responseData) ?? '인증에 실패했습니다.');
          case 403:
            return ForbiddenException(_extractErrorMessage(responseData) ?? '접근 권한이 없습니다.');
          case 404:
            return NotFoundException(_extractErrorMessage(responseData) ?? '요청한 리소스를 찾을 수 없습니다.');
          case 422:
            return ValidationException(_extractErrorMessage(responseData) ?? '입력 정보를 확인해주세요.');
          case 429:
            return RateLimitException('요청이 너무 많습니다. 잠시 후 다시 시도해주세요.');
          case 500:
            return ServerException('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
          default:
            return GeneralApiException('알 수 없는 오류가 발생했습니다. (${statusCode})');
        }
      
      case DioExceptionType.cancel:
        return GeneralApiException('요청이 취소되었습니다.');
      
      default:
        return GeneralApiException('알 수 없는 오류가 발생했습니다.');
    }
  }

  // Extract error message from response data
  String? _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return null;
    
    try {
      if (responseData is Map<String, dynamic>) {
        // Try to parse as ApiErrorResponse
        final errorResponse = ApiErrorResponse.fromJson(responseData);
        return errorResponse.detail;
      }
    } catch (e) {
      // If parsing fails, try to extract string message
      if (responseData is Map<String, dynamic> && responseData['detail'] != null) {
        return responseData['detail'].toString();
      }
    }
    
    return null;
  }
}

// Custom exception classes
abstract class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
}

class GeneralApiException extends ApiException {
  const GeneralApiException(String message) : super(message);
  
  @override
  String toString() => 'GeneralApiException: $message';
}

class NetworkException extends ApiException {
  const NetworkException(String message) : super(message);
  
  @override
  String toString() => 'NetworkException: $message';
}

class BadRequestException extends ApiException {
  const BadRequestException(String message) : super(message);
  
  @override
  String toString() => 'BadRequestException: $message';
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(String message) : super(message);
  
  @override
  String toString() => 'UnauthorizedException: $message';
}

class ForbiddenException extends ApiException {
  const ForbiddenException(String message) : super(message);
  
  @override
  String toString() => 'ForbiddenException: $message';
}

class NotFoundException extends ApiException {
  const NotFoundException(String message) : super(message);
  
  @override
  String toString() => 'NotFoundException: $message';
}

class ValidationException extends ApiException {
  const ValidationException(String message) : super(message);
  
  @override
  String toString() => 'ValidationException: $message';
}

class RateLimitException extends ApiException {
  const RateLimitException(String message) : super(message);
  
  @override
  String toString() => 'RateLimitException: $message';
}

class ServerException extends ApiException {
  const ServerException(String message) : super(message);
  
  @override
  String toString() => 'ServerException: $message';
}