import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Loading screen widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                boxShadow: AppConstants.shadowMedium,
              ),
              child: const Icon(
                Icons.remove_red_eye,
                color: AppConstants.textInverse,
                size: 40,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacingL),
            
            // App name
            Text(
              'GoEye',
              style: AppConstants.headline2.copyWith(
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacingM),
            
            // Loading indicator
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.accentColor),
              ),
            ),
            
            const SizedBox(height: AppConstants.spacingL),
            
            // Loading text
            Text(
              'Loading...',
              style: AppConstants.body2.copyWith(
                color: AppConstants.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
