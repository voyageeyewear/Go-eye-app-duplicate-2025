import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../network/api_client.dart';
import '../storage/local_storage_service.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/services/product_service.dart';
import '../../shared/services/cart_service.dart';
import '../../shared/services/user_service.dart';

/// Global GetIt instance for dependency injection
final GetIt getIt = GetIt.instance;

/// Configure dependency injection for the app
/// This makes it easy to swap mock services with real Shopify APIs later
@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Register core services
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<LocalStorageService>(LocalStorageService(sharedPreferences));
  getIt.registerSingleton<ApiClient>(ApiClient());
  
  // Register feature services
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<ProductService>(ProductService());
  getIt.registerSingleton<CartService>(CartService());
  getIt.registerSingleton<UserService>(UserService());
  
  // Initialize all injectable services
  // await $initGetIt(getIt); // Commented out until injectable generation is fixed
}

/// Service locator for easy access to services throughout the app
class ServiceLocator {
  /// Get authentication service
  static AuthService get authService => getIt<AuthService>();
  
  /// Get product service
  static ProductService get productService => getIt<ProductService>();
  
  /// Get cart service
  static CartService get cartService => getIt<CartService>();
  
  /// Get user service
  static UserService get userService => getIt<UserService>();
  
  /// Get local storage service
  static LocalStorageService get localStorage => getIt<LocalStorageService>();
  
  /// Get API client
  static ApiClient get apiClient => getIt<ApiClient>();
  
  /// Reset all services (useful for testing)
  static void reset() {
    getIt.reset();
  }
}
