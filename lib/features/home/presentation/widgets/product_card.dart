import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/models/product_model.dart';

/// Product card widget for displaying products in lists
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/products/${product.id}');
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: AppConstants.shadowSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            _buildProductImage(),
            
            // Product info
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title
                  Text(
                    product.title,
                    style: AppConstants.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: AppConstants.spacingS),
                  
                  // Price
                  _buildPrice(),
                  
                  const SizedBox(height: AppConstants.spacingM),
                  
                  // Add to cart button
                  _buildAddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final mainImage = product.mainImage;
    
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusM),
          topRight: Radius.circular(AppConstants.radiusM),
        ),
        color: AppConstants.backgroundSecondary,
      ),
      child: Stack(
        children: [
          // Product image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppConstants.radiusM),
              topRight: Radius.circular(AppConstants.radiusM),
            ),
            child: mainImage != null
                ? CachedNetworkImage(
                    imageUrl: mainImage.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(
                      color: AppConstants.backgroundSecondary,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppConstants.backgroundSecondary,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppConstants.textSecondary,
                        size: 40,
                      ),
                    ),
                  )
                : Container(
                    color: AppConstants.backgroundSecondary,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppConstants.textSecondary,
                      size: 40,
                    ),
                  ),
          ),
          
          // Sale badge
          if (product.isOnSale)
            Positioned(
              top: AppConstants.spacingS,
              left: AppConstants.spacingS,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingS,
                  vertical: AppConstants.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.errorColor,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Text(
                  'SALE',
                  style: AppConstants.caption.copyWith(
                    color: AppConstants.textInverse,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          
          // Favorite button
          Positioned(
            top: AppConstants.spacingS,
            right: AppConstants.spacingS,
            child: Container(
              decoration: BoxDecoration(
                color: AppConstants.textInverse.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Add to favorites
                },
                icon: const Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: AppConstants.textSecondary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    final priceRange = product.priceRange;
    
    return Row(
      children: [
        // Current price
        Text(
          priceRange.formatted,
          style: AppConstants.body1.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        
        const SizedBox(width: AppConstants.spacingS),
        
        // Compare at price (if on sale)
        if (product.isOnSale && product.discountPercentage != null) ...[
          Text(
            priceRange.maxVariantPrice?.formatted ?? '',
            style: AppConstants.body2.copyWith(
              color: AppConstants.textSecondary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          
          const SizedBox(width: AppConstants.spacingS),
          
          // Discount percentage
          Text(
            '-${product.discountPercentage!.toInt()}%',
            style: AppConstants.caption.copyWith(
              color: AppConstants.errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: AppConstants.textInverse,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusS),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 16,
            ),
            const SizedBox(width: AppConstants.spacingXS),
            Text(
              'Add to Cart',
              style: AppConstants.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppConstants.textInverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
