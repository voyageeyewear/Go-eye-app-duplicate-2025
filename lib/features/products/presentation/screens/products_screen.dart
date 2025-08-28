import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

/// Products screen placeholder
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag,
              size: 64,
              color: AppConstants.textSecondary,
            ),
            SizedBox(height: AppConstants.spacingL),
            Text(
              'Products Screen',
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
