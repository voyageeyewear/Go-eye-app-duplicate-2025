import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../config/app_config.dart';
import '../constants/app_constants.dart';

/// API client for handling HTTP requests
/// This can be easily configured to work with Shopify APIs later
class ApiClient {
  late final Dio _dio;
  late final Logger _logger;

  ApiClient() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  /// Setup request and response interceptors
  void _setupInterceptors() {
    // Request interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (AppConfig.enableLogging) {
            _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
            _logger.d('REQUEST DATA: ${options.data}');
          }
          
          // Add auth token if available
          final token = _getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (AppConfig.enableLogging) {
            _logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            _logger.d('RESPONSE DATA: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (AppConfig.enableLogging) {
            _logger.e('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
            _logger.e('ERROR MESSAGE: ${error.message}');
            _logger.e('ERROR DATA: ${error.response?.data}');
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Get auth token from local storage
  String? _getAuthToken() {
    // This will be implemented when we add local storage
    // For now, return null
    return null;
  }

  /// Make a GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Make a PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Handle API errors
  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ApiException(
          message: AppConstants.networkError,
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _getErrorMessage(error.response?.data, statusCode);
        throw ApiException(
          message: message,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        throw ApiException(
          message: 'Request was cancelled',
          statusCode: null,
        );
      case DioExceptionType.connectionError:
        throw ApiException(
          message: AppConstants.networkError,
          statusCode: null,
        );
      case DioExceptionType.badCertificate:
        throw ApiException(
          message: 'Bad certificate',
          statusCode: null,
        );
      case DioExceptionType.unknown:
      default:
        throw ApiException(
          message: AppConstants.unknownError,
          statusCode: error.response?.statusCode,
        );
    }
  }

  /// Get error message from response data
  String _getErrorMessage(dynamic data, int? statusCode) {
    if (data is Map<String, dynamic>) {
      // Try to get error message from common response formats
      if (data.containsKey('message')) {
        return data['message'];
      }
      if (data.containsKey('error')) {
        return data['error'];
      }
      if (data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is List && errors.isNotEmpty) {
          return errors.first.toString();
        }
        if (errors is Map && errors.isNotEmpty) {
          return errors.values.first.toString();
        }
      }
    }

    // Return default error messages based on status code
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 422:
        return 'Validation error';
      case 429:
        return 'Too many requests';
      case 500:
        return AppConstants.serverError;
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return AppConstants.unknownError;
    }
  }

  /// Update base URL (useful when switching between mock and real APIs)
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  /// Add auth token to requests
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove auth token from requests
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// Get the underlying Dio instance
  Dio get dio => _dio;
}

/// Custom API exception class
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode)';
  }
}
