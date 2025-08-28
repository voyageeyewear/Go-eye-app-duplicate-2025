import 'dart:convert';
import 'dart:math';
import '../models/user_model.dart';
import '../../core/config/app_config.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage_service.dart';

/// Authentication service that handles user login, signup, and session management
/// Currently uses mock data but structured to easily integrate with Shopify APIs later
class AuthService {
  final ApiClient _apiClient;
  final LocalStorageService _storage;
  
  // Mock user data for development
  static const List<Map<String, dynamic>> _mockUsers = [
    {
      'id': 'user_1',
      'email': 'john.doe@example.com',
      'firstName': 'John',
      'lastName': 'Doe',
      'phone': '+1234567890',
      'emailVerified': true,
      'acceptsMarketing': true,
    },
    {
      'id': 'user_2',
      'email': 'jane.smith@example.com',
      'firstName': 'Jane',
      'lastName': 'Smith',
      'phone': '+0987654321',
      'emailVerified': true,
      'acceptsMarketing': false,
    },
  ];

  AuthService()
      : _apiClient = ServiceLocator.apiClient,
        _storage = ServiceLocator.localStorage;

  // MARK: - Authentication Methods

  /// Sign in with email and password
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.error(AppConstants.invalidCredentials);
      }

      // Find mock user
      final mockUser = _mockUsers.firstWhere(
        (user) => user['email'] == email,
        orElse: () => throw Exception('User not found'),
      );

      // Mock password validation (in real app, this would be server-side)
      if (password != 'password123') {
        return AuthResult.error(AppConstants.invalidCredentials);
      }

      // Create user object
      final user = User.fromJson(mockUser);
      
      // Generate mock token
      final token = _generateMockToken(user.id);
      
      // Save to local storage
      await _storage.saveAuthToken(token);
      await _storage.saveUserData(user.toJson());
      
      // Update API client with token
      _apiClient.setAuthToken(token);

      return AuthResult.success(user, token);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Sign up with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    String? firstName,
    String? lastName,
    String? phone,
    bool acceptsMarketing = false,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.error('Email and password are required');
      }

      if (password != confirmPassword) {
        return AuthResult.error('Passwords do not match');
      }

      if (password.length < 6) {
        return AuthResult.error(AppConstants.weakPassword);
      }

      // Check if user already exists
      final existingUser = _mockUsers.any((user) => user['email'] == email);
      if (existingUser) {
        return AuthResult.error(AppConstants.emailAlreadyExists);
      }

      // Create new user
      final newUser = {
        'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'emailVerified': false,
        'acceptsMarketing': acceptsMarketing,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      final user = User.fromJson(newUser);
      
      // Generate mock token
      final token = _generateMockToken(user.id);
      
      // Save to local storage
      await _storage.saveAuthToken(token);
      await _storage.saveUserData(user.toJson());
      
      // Update API client with token
      _apiClient.setAuthToken(token);

      return AuthResult.success(user, token);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      // Remove from local storage
      await _storage.removeAuthToken();
      await _storage.removeUserData();
      
      // Remove token from API client
      _apiClient.removeAuthToken();
    } catch (e) {
      // Log error but don't throw
      print('Error during sign out: $e');
    }
  }

  /// Get current user
  User? getCurrentUser() {
    try {
      final userData = _storage.getUserData();
      if (userData != null) {
        return User.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    return _storage.isLoggedIn && getCurrentUser() != null;
  }

  /// Refresh auth token
  Future<AuthResult> refreshToken() async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser == null) {
        return AuthResult.error('No user found');
      }

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Generate new token
      final newToken = _generateMockToken(currentUser.id);
      
      // Save new token
      await _storage.saveAuthToken(newToken);
      
      // Update API client
      _apiClient.setAuthToken(newToken);

      return AuthResult.success(currentUser, newToken);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Update user profile
  Future<AuthResult> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    bool? acceptsMarketing,
  }) async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser == null) {
        return AuthResult.error('No user found');
      }

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Update user data
      final updatedUser = currentUser.copyWith(
        firstName: firstName ?? currentUser.firstName,
        lastName: lastName ?? currentUser.lastName,
        phone: phone ?? currentUser.phone,
        acceptsMarketing: acceptsMarketing ?? currentUser.acceptsMarketing,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());

      return AuthResult.success(updatedUser, _storage.getAuthToken());
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Change password
  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock validation
      if (currentPassword != 'password123') {
        return AuthResult.error('Current password is incorrect');
      }

      if (newPassword != confirmNewPassword) {
        return AuthResult.error('New passwords do not match');
      }

      if (newPassword.length < 6) {
        return AuthResult.error(AppConstants.weakPassword);
      }

      // In a real app, this would update the password on the server
      return AuthResult.success(getCurrentUser(), _storage.getAuthToken());
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Request password reset
  Future<AuthResult> requestPasswordReset({required String email}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Mock validation
      if (email.isEmpty) {
        return AuthResult.error('Email is required');
      }

      // Check if user exists
      final userExists = _mockUsers.any((user) => user['email'] == email);
      if (!userExists) {
        return AuthResult.error('No account found with this email');
      }

      // In a real app, this would send a reset email
      return AuthResult.success(null, null);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Reset password with token
  Future<AuthResult> resetPassword({
    required String token,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock validation
      if (token.isEmpty) {
        return AuthResult.error('Reset token is required');
      }

      if (newPassword != confirmNewPassword) {
        return AuthResult.error('Passwords do not match');
      }

      if (newPassword.length < 6) {
        return AuthResult.error(AppConstants.weakPassword);
      }

      // In a real app, this would validate the token and update the password
      return AuthResult.success(null, null);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  /// Verify email
  Future<AuthResult> verifyEmail({required String token}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock validation
      if (token.isEmpty) {
        return AuthResult.error('Verification token is required');
      }

      final currentUser = getCurrentUser();
      if (currentUser == null) {
        return AuthResult.error('No user found');
      }

      // Update user to verified
      final updatedUser = currentUser.copyWith(
        emailVerified: true,
        updatedAt: DateTime.now(),
      );

      // Save updated user data
      await _storage.saveUserData(updatedUser.toJson());

      return AuthResult.success(updatedUser, _storage.getAuthToken());
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  // MARK: - Helper Methods

  /// Generate mock JWT token
  String _generateMockToken(String userId) {
    final header = base64Url.encode(utf8.encode(jsonEncode({
      'alg': 'HS256',
      'typ': 'JWT',
    })));

    final payload = base64Url.encode(utf8.encode(jsonEncode({
      'sub': userId,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp': (DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch ~/ 1000),
      'iss': 'go-eye-app',
    })));

    final signature = base64Url.encode(utf8.encode('mock-signature-${Random().nextInt(1000000)}'));

    return '$header.$payload.$signature';
  }

  /// Initialize auth state (called on app startup)
  Future<void> initializeAuth() async {
    try {
      final token = _storage.getAuthToken();
      if (token != null) {
        _apiClient.setAuthToken(token);
        
        // Validate token (in real app, this would verify with server)
        final user = getCurrentUser();
        if (user == null) {
          // Token is invalid, clear it
          await signOut();
        }
      }
    } catch (e) {
      // Clear invalid auth state
      await signOut();
    }
  }
}

/// Result class for authentication operations
class AuthResult {
  final User? user;
  final String? token;
  final String? error;
  final bool isSuccess;

  const AuthResult._({
    this.user,
    this.token,
    this.error,
    required this.isSuccess,
  });

  factory AuthResult.success(User? user, String? token) {
    return AuthResult._(
      user: user,
      token: token,
      isSuccess: true,
    );
  }

  factory AuthResult.error(String error) {
    return AuthResult._(
      error: error,
      isSuccess: false,
    );
  }
}
