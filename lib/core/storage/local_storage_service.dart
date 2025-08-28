import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

/// Local storage service for managing app data persistence
/// Uses SharedPreferences for simple key-value storage and Hive for complex objects
class LocalStorageService {
  final SharedPreferences _prefs;
  static const String _userBox = 'user_box';
  static const String _cartBox = 'cart_box';
  static const String _productsBox = 'products_box';
  static const String _collectionsBox = 'collections_box';

  LocalStorageService(this._prefs);

  /// Initialize Hive boxes
  static Future<void> initializeBoxes() async {
    await Hive.openBox(_userBox);
    await Hive.openBox(_cartBox);
    await Hive.openBox(_productsBox);
    await Hive.openBox(_collectionsBox);
  }

  // MARK: - SharedPreferences Methods

  /// Save string value
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Get string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Save boolean value
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Get boolean value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Save integer value
  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Get integer value
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Save double value
  Future<bool> saveDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// Get double value
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// Save string list
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Get string list
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Remove value
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Clear all data
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  // MARK: - Auth Token Management

  /// Save auth token
  Future<bool> saveAuthToken(String token) async {
    return await saveString(AppConstants.authTokenKey, token);
  }

  /// Get auth token
  String? getAuthToken() {
    return getString(AppConstants.authTokenKey);
  }

  /// Remove auth token
  Future<bool> removeAuthToken() async {
    return await remove(AppConstants.authTokenKey);
  }

  /// Check if user is logged in
  bool get isLoggedIn {
    final token = getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // MARK: - User Data Management

  /// Save user data
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await saveString(AppConstants.userDataKey, jsonEncode(userData));
  }

  /// Get user data
  Map<String, dynamic>? getUserData() {
    final userDataString = getString(AppConstants.userDataKey);
    if (userDataString != null) {
      try {
        return jsonDecode(userDataString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Remove user data
  Future<bool> removeUserData() async {
    return await remove(AppConstants.userDataKey);
  }

  // MARK: - Cart Data Management

  /// Save cart data
  Future<bool> saveCartData(Map<String, dynamic> cartData) async {
    return await saveString(AppConstants.cartDataKey, jsonEncode(cartData));
  }

  /// Get cart data
  Map<String, dynamic>? getCartData() {
    final cartDataString = getString(AppConstants.cartDataKey);
    if (cartDataString != null) {
      try {
        return jsonDecode(cartDataString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Remove cart data
  Future<bool> removeCartData() async {
    return await remove(AppConstants.cartDataKey);
  }

  // MARK: - Theme Management

  /// Save theme mode
  Future<bool> saveThemeMode(String themeMode) async {
    return await saveString(AppConstants.themeKey, themeMode);
  }

  /// Get theme mode
  String? getThemeMode() {
    return getString(AppConstants.themeKey);
  }

  // MARK: - Language Management

  /// Save language
  Future<bool> saveLanguage(String language) async {
    return await saveString(AppConstants.languageKey, language);
  }

  /// Get language
  String? getLanguage() {
    return getString(AppConstants.languageKey);
  }

  // MARK: - Hive Methods

  /// Save object to Hive box
  Future<void> saveToBox(String boxName, String key, dynamic value) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  /// Get object from Hive box
  dynamic getFromBox(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  /// Remove object from Hive box
  Future<void> removeFromBox(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  /// Clear Hive box
  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  /// Get all keys from Hive box
  List<dynamic> getBoxKeys(String boxName) {
    final box = Hive.box(boxName);
    return box.keys.toList();
  }

  /// Get all values from Hive box
  List<dynamic> getBoxValues(String boxName) {
    final box = Hive.box(boxName);
    return box.values.toList();
  }

  // MARK: - User Box Methods

  /// Save user to Hive
  Future<void> saveUser(String userId, Map<String, dynamic> userData) async {
    await saveToBox(_userBox, userId, userData);
  }

  /// Get user from Hive
  Map<String, dynamic>? getUser(String userId) {
    return getFromBox(_userBox, userId);
  }

  /// Remove user from Hive
  Future<void> removeUser(String userId) async {
    await removeFromBox(_userBox, userId);
  }

  /// Get all users
  List<Map<String, dynamic>> getAllUsers() {
    final users = getBoxValues(_userBox);
    return users.whereType<Map<String, dynamic>>().toList();
  }

  // MARK: - Cart Box Methods

  /// Save cart to Hive
  Future<void> saveCart(String cartId, Map<String, dynamic> cartData) async {
    await saveToBox(_cartBox, cartId, cartData);
  }

  /// Get cart from Hive
  Map<String, dynamic>? getCart(String cartId) {
    return getFromBox(_cartBox, cartId);
  }

  /// Remove cart from Hive
  Future<void> removeCart(String cartId) async {
    await removeFromBox(_cartBox, cartId);
  }

  /// Get all carts
  List<Map<String, dynamic>> getAllCarts() {
    final carts = getBoxValues(_cartBox);
    return carts.whereType<Map<String, dynamic>>().toList();
  }

  // MARK: - Products Box Methods

  /// Save product to Hive
  Future<void> saveProduct(String productId, Map<String, dynamic> productData) async {
    await saveToBox(_productsBox, productId, productData);
  }

  /// Get product from Hive
  Map<String, dynamic>? getProduct(String productId) {
    return getFromBox(_productsBox, productId);
  }

  /// Remove product from Hive
  Future<void> removeProduct(String productId) async {
    await removeFromBox(_productsBox, productId);
  }

  /// Get all products
  List<Map<String, dynamic>> getAllProducts() {
    final products = getBoxValues(_productsBox);
    return products.whereType<Map<String, dynamic>>().toList();
  }

  // MARK: - Collections Box Methods

  /// Save collection to Hive
  Future<void> saveCollection(String collectionId, Map<String, dynamic> collectionData) async {
    await saveToBox(_collectionsBox, collectionId, collectionData);
  }

  /// Get collection from Hive
  Map<String, dynamic>? getCollection(String collectionId) {
    return getFromBox(_collectionsBox, collectionId);
  }

  /// Remove collection from Hive
  Future<void> removeCollection(String collectionId) async {
    await removeFromBox(_collectionsBox, collectionId);
  }

  /// Get all collections
  List<Map<String, dynamic>> getAllCollections() {
    final collections = getBoxValues(_collectionsBox);
    return collections.whereType<Map<String, dynamic>>().toList();
  }

  // MARK: - Utility Methods

  /// Get storage size (approximate)
  Future<int> getStorageSize() async {
    int size = 0;
    
    // SharedPreferences size
    final keys = _prefs.getKeys();
    for (final key in keys) {
      final value = _prefs.get(key);
      if (value is String) {
        size += value.length;
      }
    }
    
    // Hive boxes size
    final boxes = [_userBox, _cartBox, _productsBox, _collectionsBox];
    for (final boxName in boxes) {
      final box = Hive.box(boxName);
      for (final key in box.keys) {
        final value = box.get(key);
        if (value is String) {
          size += value.length;
        } else if (value is Map) {
          size += jsonEncode(value).length;
        }
      }
    }
    
    return size;
  }

  /// Clear all storage
  Future<void> clearAllStorage() async {
    await clear();
    await clearBox(_userBox);
    await clearBox(_cartBox);
    await clearBox(_productsBox);
    await clearBox(_collectionsBox);
  }

  /// Export all data (for backup/debugging)
  Map<String, dynamic> exportAllData() {
    final data = <String, dynamic>{};
    
    // Export SharedPreferences data
    final prefsData = <String, dynamic>{};
    final keys = _prefs.getKeys();
    for (final key in keys) {
      prefsData[key] = _prefs.get(key);
    }
    data['shared_preferences'] = prefsData;
    
    // Export Hive data
    final hiveData = <String, dynamic>{};
    final boxes = [_userBox, _cartBox, _productsBox, _collectionsBox];
    for (final boxName in boxes) {
      final box = Hive.box(boxName);
      final boxData = <String, dynamic>{};
      for (final key in box.keys) {
        boxData[key.toString()] = box.get(key);
      }
      hiveData[boxName] = boxData;
    }
    data['hive'] = hiveData;
    
    return data;
  }
}
