import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/providers/app_providers.dart';
import '../widgets/auth_text_field.dart';

/// Login screen with modern UI design
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _isLoginMode = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptsMarketing = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacingXXL),
                
                // App logo and title
                _buildHeader(),
                
                const SizedBox(height: AppConstants.spacingXXL),
                
                // Form fields
                _buildFormFields(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Submit button
                _buildSubmitButton(),
                
                const SizedBox(height: AppConstants.spacingL),
                
                // Toggle mode button
                _buildToggleModeButton(),
                
                const SizedBox(height: AppConstants.spacingXXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App logo
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            boxShadow: AppConstants.shadowLarge,
          ),
          child: const Icon(
            Icons.remove_red_eye,
            color: AppConstants.textInverse,
            size: 50,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingL),
        
        // App name
        Text(
          'GoEye',
          style: AppConstants.headline1.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingS),
        
        // Subtitle
        Text(
          _isLoginMode ? 'Welcome back!' : 'Create your account',
          style: AppConstants.headline4.copyWith(
            color: AppConstants.textSecondary,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingS),
        
        // Description
        Text(
          _isLoginMode 
            ? 'Sign in to continue shopping'
            : 'Join us and discover amazing eyewear',
          style: AppConstants.body2.copyWith(
            color: AppConstants.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Email field
        AuthTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        
        const SizedBox(height: AppConstants.spacingM),
        
        // Password field
        AuthTextField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Enter your password',
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: AppConstants.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        
        // Sign up specific fields
        if (!_isLoginMode) ...[
          const SizedBox(height: AppConstants.spacingM),
          
          // Confirm password field
          AuthTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Confirm your password',
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: AppConstants.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          // First name field
          AuthTextField(
            controller: _firstNameController,
            label: 'First Name',
            hint: 'Enter your first name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          // Last name field
          AuthTextField(
            controller: _lastNameController,
            label: 'Last Name',
            hint: 'Enter your last name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          // Phone field
          AuthTextField(
            controller: _phoneController,
            label: 'Phone (Optional)',
            hint: 'Enter your phone number',
            keyboardType: TextInputType.phone,
          ),
          
          const SizedBox(height: AppConstants.spacingM),
          
          // Marketing checkbox
          Row(
            children: [
              Checkbox(
                value: _acceptsMarketing,
                onChanged: (value) {
                  setState(() {
                    _acceptsMarketing = value ?? false;
                  });
                },
                activeColor: AppConstants.accentColor,
              ),
              Expanded(
                child: Text(
                  'I want to receive marketing emails about new products and offers',
                  style: AppConstants.body2.copyWith(
                    color: AppConstants.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
        
        // Forgot password (login mode only)
        if (_isLoginMode) ...[
          const SizedBox(height: AppConstants.spacingM),
          
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to forgot password screen
              },
              child: Text(
                'Forgot Password?',
                style: AppConstants.body2.copyWith(
                  color: AppConstants.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: AppConstants.textInverse,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppConstants.textInverse),
                ),
              )
            : Text(
                _isLoginMode ? 'Sign In' : 'Create Account',
                style: AppConstants.button,
              ),
      ),
    );
  }

  Widget _buildToggleModeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLoginMode ? "Don't have an account? " : 'Already have an account? ',
          style: AppConstants.body2.copyWith(
            color: AppConstants.textSecondary,
          ),
        ),
        TextButton(
          onPressed: _toggleMode,
          child: Text(
            _isLoginMode ? 'Sign Up' : 'Sign In',
            style: AppConstants.body2.copyWith(
              color: AppConstants.accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _clearForm();
    });
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _acceptsMarketing = false;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isLoginMode) {
        await _handleSignIn();
      } else {
        await _handleSignUp();
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSignIn() async {
    final userNotifier = ref.read(currentUserProvider.notifier);
    await userNotifier.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  Future<void> _handleSignUp() async {
    final userNotifier = ref.read(currentUserProvider.notifier);
    await userNotifier.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      acceptsMarketing: _acceptsMarketing,
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
    );
  }
}
