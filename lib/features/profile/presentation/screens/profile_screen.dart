import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

/// Profile screen placeholder
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: AppConstants.textSecondary,
            ),
            SizedBox(height: AppConstants.spacingL),
            Text(
              'Profile Screen',
              style: AppConstants.headline3,
            ),
            SizedBox(height: AppConstants.spacingM),
            Text(
              'Coming soon...',
              style: AppConstants.body2,
            ),
          ],
        ),
      ),
    );
  }
}
