import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

/// Product detail screen placeholder
class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.remove_red_eye,
              size: 64,
              color: AppConstants.textSecondary,
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              'Product Detail Screen',
              style: AppConstants.headline3,
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'Product ID: $productId',
              style: AppConstants.body2,
            ),
            const SizedBox(height: AppConstants.spacingM),
            const Text(
              'Coming soon...',
              style: AppConstants.body2,
            ),
          ],
        ),
      ),
    );
  }
}
