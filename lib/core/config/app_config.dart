import 'package:flutter/foundation.dart';

/// App configuration class that manages different environments
/// and API configurations for easy switching between mock and real APIs
class AppConfig {
  static const String _appName = 'GoEye';
  static const String _appVersion = '1.0.0';
  
  // API Configuration
  static const String _baseUrl = 'https://api.shopify.com';
  static const String _storefrontApiVersion = '2024-01';
  static const String _adminApiVersion = '2024-01';
  
  // Mock API Configuration (for development)
  static const String _mockBaseUrl = 'https://mockapi.io/projects';
  
  // Feature flags
  static const bool _useMockData = true; // Set to false when ready for real Shopify integration
  static const bool _enableLogging = true;
  static const bool _enableAnalytics = false;
  
  // UI Configuration
  static const double _defaultPadding = 16.0;
  static const double _defaultRadius = 8.0;
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Getter methods
  static String get appName => _appName;
  static String get appVersion => _appVersion;
  static String get baseUrl => _useMockData ? _mockBaseUrl : _baseUrl;
  static String get storefrontApiVersion => _storefrontApiVersion;
  static String get adminApiVersion => _adminApiVersion;
  static bool get useMockData => _useMockData;
  static bool get enableLogging => _enableLogging;
  static bool get enableAnalytics => _enableAnalytics;
  static double get defaultPadding => _defaultPadding;
  static double get defaultRadius => _defaultRadius;
  static Duration get defaultAnimationDuration => _defaultAnimationDuration;
  
  /// Returns the appropriate API endpoint based on environment
  static String getApiEndpoint(String path) {
    return '$baseUrl/$path';
  }
  
  /// Returns Shopify Storefront API endpoint
  static String getStorefrontApiEndpoint() {
    return '$_baseUrl/storefront/$_storefrontApiVersion';
  }
  
  /// Returns Shopify Admin API endpoint
  static String getAdminApiEndpoint() {
    return '$_baseUrl/admin/$_adminApiVersion';
  }
  
  /// Check if running in debug mode
  static bool get isDebugMode => kDebugMode;
  
  /// Check if running in release mode
  static bool get isReleaseMode => kReleaseMode;
  
  /// Check if running in profile mode
  static bool get isProfileMode => kProfileMode;
}
