import '../models/user_model.dart';
import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage_service.dart';

/// User service that handles user profile and order management
/// Currently uses mock data but structured to easily integrate with Shopify APIs later
class UserService {
  final ApiClient _apiClient;
  final LocalStorageService _storage;

  UserService()
      : _apiClient = ServiceLocator.apiClient,
        _storage = ServiceLocator.localStorage;

  // MARK: - User Profile Methods

  /// Get user profile
  Future<User?> getUserProfile() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final userData = _storage.getUserData();
      if (userData != null) {
        return User.fromJson(userData);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  Future<User?> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phone,
    bool? acceptsMarketing,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      final currentUser = await getUserProfile();
      if (currentUser == null) {
        throw Exception('No user found');
      }

      final updatedUser = currentUser.copyWith(
        firstName: firstName ?? currentUser.firstName,
        lastName: lastName ?? currentUser.lastName,
        phone: phone ?? currentUser.phone,
        acceptsMarketing: acceptsMarketing ?? currentUser.acceptsMarketing,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());

      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  /// Get user addresses
  Future<List<Address>> getUserAddresses() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final user = await getUserProfile();
      return user?.addresses ?? [];
    } catch (e) {
      return [];
    }
  }

  /// Add user address
  Future<Address> addUserAddress({
    required String firstName,
    required String lastName,
    String? company,
    required String address1,
    String? address2,
    required String city,
    required String province,
    required String country,
    required String zip,
    String? phone,
    bool isDefault = false,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final user = await getUserProfile();
      if (user == null) {
        throw Exception('No user found');
      }

      final newAddress = Address(
        id: 'address_${DateTime.now().millisecondsSinceEpoch}',
        firstName: firstName,
        lastName: lastName,
        company: company,
        address1: address1,
        address2: address2,
        city: city,
        province: province,
        country: country,
        zip: zip,
        phone: phone,
        isDefault: isDefault,
      );

      List<Address> addresses = List.from(user.addresses ?? []);

      // If this is the default address, remove default from others
      if (isDefault) {
        addresses = addresses.map((address) => address.copyWith(isDefault: false)).toList();
      }

      addresses.add(newAddress);

      final updatedUser = user.copyWith(
        addresses: addresses,
        defaultAddressId: isDefault ? newAddress.id : user.defaultAddressId,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());

      return newAddress;
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  /// Update user address
  Future<Address> updateUserAddress({
    required String addressId,
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? province,
    String? country,
    String? zip,
    String? phone,
    bool? isDefault,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final user = await getUserProfile();
      if (user == null) {
        throw Exception('No user found');
      }

      final addresses = List<Address>.from(user.addresses ?? []);
      final addressIndex = addresses.indexWhere((address) => address.id == addressId);
      
      if (addressIndex == -1) {
        throw Exception('Address not found');
      }

      final currentAddress = addresses[addressIndex];
      final updatedAddress = currentAddress.copyWith(
        firstName: firstName ?? currentAddress.firstName,
        lastName: lastName ?? currentAddress.lastName,
        company: company ?? currentAddress.company,
        address1: address1 ?? currentAddress.address1,
        address2: address2 ?? currentAddress.address2,
        city: city ?? currentAddress.city,
        province: province ?? currentAddress.province,
        country: country ?? currentAddress.country,
        zip: zip ?? currentAddress.zip,
        phone: phone ?? currentAddress.phone,
        isDefault: isDefault ?? currentAddress.isDefault,
      );

      // If this is being set as default, remove default from others
      if (isDefault == true) {
        for (int i = 0; i < addresses.length; i++) {
          if (i != addressIndex) {
            addresses[i] = addresses[i].copyWith(isDefault: false);
          }
        }
      }

      addresses[addressIndex] = updatedAddress;

      final updatedUser = user.copyWith(
        addresses: addresses,
        defaultAddressId: isDefault == true ? updatedAddress.id : user.defaultAddressId,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());

      return updatedAddress;
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  /// Delete user address
  Future<void> deleteUserAddress({required String addressId}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final user = await getUserProfile();
      if (user == null) {
        throw Exception('No user found');
      }

      final addresses = List<Address>.from(user.addresses ?? []);
      final addressIndex = addresses.indexWhere((address) => address.id == addressId);
      
      if (addressIndex == -1) {
        throw Exception('Address not found');
      }

      final addressToDelete = addresses[addressIndex];
      addresses.removeAt(addressIndex);

      // If we deleted the default address, set the first remaining address as default
      String? newDefaultAddressId = user.defaultAddressId;
      if (addressToDelete.isDefault && addresses.isNotEmpty) {
        addresses[0] = addresses[0].copyWith(isDefault: true);
        newDefaultAddressId = addresses[0].id;
      } else if (addressToDelete.isDefault && addresses.isEmpty) {
        newDefaultAddressId = null;
      }

      final updatedUser = user.copyWith(
        addresses: addresses,
        defaultAddressId: newDefaultAddressId,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  /// Set default address
  Future<void> setDefaultAddress({required String addressId}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      final user = await getUserProfile();
      if (user == null) {
        throw Exception('No user found');
      }

      final addresses = List<Address>.from(user.addresses ?? []);
      final addressIndex = addresses.indexWhere((address) => address.id == addressId);
      
      if (addressIndex == -1) {
        throw Exception('Address not found');
      }

      // Remove default from all addresses
      for (int i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(isDefault: false);
      }

      // Set the specified address as default
      addresses[addressIndex] = addresses[addressIndex].copyWith(isDefault: true);

      final updatedUser = user.copyWith(
        addresses: addresses,
        defaultAddressId: addressId,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());
    } catch (e) {
      throw Exception('Failed to set default address: $e');
    }
  }

  // MARK: - Order Methods

  /// Get user orders
  Future<List<Order>> getUserOrders({
    int? first,
    String? after,
    String? query,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock order data
      final mockOrders = [
        {
          'id': 'order_1',
          'orderNumber': '#1001',
          'status': 'FULFILLED',
          'totalPrice': 259.98,
          'currency': 'USD',
          'createdAt': DateTime.now().subtract(const Duration(days: 15)).toIso8601String(),
          'updatedAt': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
          'items': [
            {
              'id': 'order_item_1',
              'productId': 'product_1',
              'productTitle': 'Classic Aviator Sunglasses',
              'variantTitle': 'Gold / 58mm',
              'quantity': 2,
              'price': 129.99,
              'imageUrl': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=100&h=100&fit=crop',
            },
          ],
          'shippingAddress': {
            'id': 'shipping_1',
            'firstName': 'John',
            'lastName': 'Doe',
            'address1': '123 Main St',
            'city': 'New York',
            'province': 'NY',
            'country': 'United States',
            'zip': '10001',
            'phone': '+1234567890',
          },
          'billingAddress': {
            'id': 'billing_1',
            'firstName': 'John',
            'lastName': 'Doe',
            'address1': '123 Main St',
            'city': 'New York',
            'province': 'NY',
            'country': 'United States',
            'zip': '10001',
            'phone': '+1234567890',
          },
        },
        {
          'id': 'order_2',
          'orderNumber': '#1002',
          'status': 'PROCESSING',
          'totalPrice': 89.99,
          'currency': 'USD',
          'createdAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
          'updatedAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
          'items': [
            {
              'id': 'order_item_2',
              'productId': 'product_2',
              'productTitle': 'Round Retro Sunglasses',
              'variantTitle': 'Tortoise / 55mm',
              'quantity': 1,
              'price': 89.99,
              'imageUrl': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=100&h=100&fit=crop',
            },
          ],
          'shippingAddress': {
            'id': 'shipping_2',
            'firstName': 'John',
            'lastName': 'Doe',
            'address1': '123 Main St',
            'city': 'New York',
            'province': 'NY',
            'country': 'United States',
            'zip': '10001',
            'phone': '+1234567890',
          },
          'billingAddress': {
            'id': 'billing_2',
            'firstName': 'John',
            'lastName': 'Doe',
            'address1': '123 Main St',
            'city': 'New York',
            'province': 'NY',
            'country': 'United States',
            'zip': '10001',
            'phone': '+1234567890',
          },
        },
      ];

      List<Map<String, dynamic>> filteredOrders = List.from(mockOrders);

      // Apply filters
      if (query != null && query.isNotEmpty) {
        filteredOrders = filteredOrders.where((order) {
          return order['orderNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
                 order['status'].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      // Apply pagination
      if (first != null && first > 0) {
        filteredOrders = filteredOrders.take(first).toList();
      }

      return filteredOrders.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final orders = await getUserOrders();
      return orders.firstWhere(
        (order) => order.id == orderId,
        orElse: () => throw Exception('Order not found'),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get order by number
  Future<Order?> getOrderByNumber(String orderNumber) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final orders = await getUserOrders();
      return orders.firstWhere(
        (order) => order.orderNumber == orderNumber,
        orElse: () => throw Exception('Order not found'),
      );
    } catch (e) {
      return null;
    }
  }

  // MARK: - Account Methods

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Clear all user data
      await _storage.removeUserData();
      await _storage.removeAuthToken();
      
      // Remove token from API client
      _apiClient.removeAuthToken();
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  /// Export user data
  Future<Map<String, dynamic>> exportUserData() async {
    try {
      final user = await getUserProfile();
      if (user == null) {
        throw Exception('No user found');
      }

      return {
        'user': user.toJson(),
        'addresses': user.addresses?.map((address) => address.toJson()).toList() ?? [],
        'orders': await getUserOrders(),
      };
    } catch (e) {
      throw Exception('Failed to export user data: $e');
    }
  }

  // MARK: - Utility Methods

  /// Check if user has complete profile
  Future<bool> hasCompleteProfile() async {
    try {
      final user = await getUserProfile();
      return user?.hasCompleteProfile ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Get user initials
  Future<String> getUserInitials() async {
    try {
      final user = await getUserProfile();
      return user?.initials ?? 'U';
    } catch (e) {
      return 'U';
    }
  }

  /// Get user full name
  Future<String> getUserFullName() async {
    try {
      final user = await getUserProfile();
      return user?.fullName ?? 'User';
    } catch (e) {
      return 'User';
    }
  }
}
