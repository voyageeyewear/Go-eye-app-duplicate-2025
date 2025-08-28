import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

/// Cart screen placeholder
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 64,
              color: AppConstants.textSecondary,
            ),
            SizedBox(height: AppConstants.spacingL),
            Text(
              'Cart Screen',
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
