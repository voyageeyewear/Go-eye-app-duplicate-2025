import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/models/product_model.dart';

/// Collection card widget for displaying collections
class CollectionCard extends StatelessWidget {
  final Collection collection;

  const CollectionCard({
    super.key,
    required this.collection,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to collection products
      },
      child: Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: AppConstants.shadowSmall,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Stack(
            children: [
              // Collection image
              _buildCollectionImage(),
              
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              
              // Collection info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Collection title
                      Text(
                        collection.title,
                        style: AppConstants.body1.copyWith(
                          color: AppConstants.textInverse,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Collection description
                      if (collection.description != null) ...[
                        const SizedBox(height: AppConstants.spacingXS),
                        Text(
                          collection.description!,
                          style: AppConstants.caption.copyWith(
                            color: AppConstants.textInverse.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionImage() {
    return collection.image != null
        ? CachedNetworkImage(
            imageUrl: collection.image!.url,
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
                Icons.collections,
                color: AppConstants.textSecondary,
                size: 40,
              ),
            ),
          )
        : Container(
            color: AppConstants.backgroundSecondary,
            child: const Icon(
              Icons.collections,
              color: AppConstants.textSecondary,
              size: 40,
            ),
          );
  }
}
