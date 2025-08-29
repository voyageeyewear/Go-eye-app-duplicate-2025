import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../../shared/providers/header_customization_provider.dart';
import '../../../../shared/services/sync_service.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(headerCustomizationProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(state, ref),
              
              // Promotional Banner
              if (state.showPromotionalBanner) _buildPromotionalBanner(state),
              
              // Search Bar
              _buildSearchBar(),
              
              // Collections Section
              _buildCollectionsSection(state),
              
              // Eyeglasses Section
              _buildEyeglassesSection(state),
              
              // Sunglasses Section
              _buildSunglassesSection(state),
              
              // Video Carousel Section
              if (state.showVideoCarousel) _buildVideoCarouselSection(state),
              
              // Today's Mood Section
              if (state.showTodaysMoodSection) _buildTodaysMoodSection(state),
              
              // Most Loved Section
              if (state.showMostLovedSection) _buildMostLovedSection(state),
              
              // Instagram Showcase Section
              if (state.showInstagramShowcase) _buildInstagramShowcaseSection(state),
              
              // Video Categories Section
              if (state.showVideoCategories) _buildVideoCategoriesSection(state),
              
              // Bottom padding for safe area
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionalBanner(HeaderCustomizationState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: state.promotionalBannerBackgroundColor,
      child: Text(
        state.promotionalBannerText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: state.promotionalBannerTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildHeader(HeaderCustomizationState state, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: state.headerBackgroundColor,
      child: Row(
        children: [
          // Menu icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          
          // Free Lens button
          Expanded(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Free Lens',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Logo
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.remove_red_eye,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          
          // Action icons
          _buildActionIcon(Icons.favorite_border, state),
          const SizedBox(width: 8),
          _buildActionIcon(Icons.person_outline, state),
          const SizedBox(width: 8),
          _buildActionIcon(Icons.shopping_cart_outlined, state),
          const SizedBox(width: 8),
          // Debug sync button
          GestureDetector(
            onTap: () async {
              final syncService = SyncService();
              await syncService.forceSync();
              
              // Also force refresh the provider
              ref.read(headerCustomizationProvider.notifier).forceRefresh();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.sync,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, HeaderCustomizationState state) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }



  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color(0xFFFF6B6B),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: '🔍 Search for frames, lenses, or brands...',
                hintStyle: TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
                print('Search query: $value');
              },
              onTap: () {
                // TODO: Implement search focus functionality
                print('Search bar tapped');
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationLinks() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.style, 'Voyage Eyewear', false),
          _buildNavItem(Icons.remove_red_eye, 'Eyejack Eyewear', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFFFF6B6B) : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFFFF6B6B) : Colors.grey,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionsSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Reduced horizontal padding from 16 to 8
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8), // Add small left padding for title
            child: Text(
              state.collectionsSectionTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(height: 12), // Reduced from 16
          // Large collection images with horizontal scroll
          if (state.collections.isNotEmpty) ...[
            SizedBox(
              height: 270, // Match the height of collection cards
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced from 16 to 8
                itemCount: state.collections.where((c) => c.isVisible).length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final visibleCollections = state.collections.where((c) => c.isVisible).toList();
                  return _buildCollectionCard(visibleCollections[index]);
                },
              ),
            ),

          ],
        ],
      ),
    );
  }

  Widget _buildCollectionCard(CollectionItem collection) {
    return Container(
      width: 220, // Exact width as specified in the image
      height: 270, // Exact height as specified in the image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: collection.imagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildSmartImage(collection.imagePath!),
            )
          : Center(
              child: Icon(
                Icons.image,
                size: 50,
                color: Colors.grey,
              ),
            ),
    );
  }

  Widget _buildSmartImage(String imagePath) {
    // Check if the path is a URL (starts with http:// or https://)
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              color: const Color(0xFFFF6B6B),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          );
        },
      );
    } else {
      // Local asset path
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          );
        },
      );
    }
  }

  Widget _buildEyeglassesSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Eyeglasses',
              style: TextStyle(
                fontSize: state.eyeglassesSectionFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
                fontFamily: state.eyeglassesSectionFontFamily,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Category Cards
          if (state.showProductCategoryCards) ...[
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: state.eyeglassesCategoryCards.where((card) => card.isVisible).length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final visibleCards = state.eyeglassesCategoryCards.where((card) => card.isVisible).toList();
                  return _buildCategoryCardWidget(visibleCards[index]);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSunglassesSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Sunglasses',
              style: TextStyle(
                fontSize: state.eyeglassesSectionFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
                fontFamily: state.eyeglassesSectionFontFamily,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Category Cards
          if (state.showProductCategoryCards) ...[
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: state.sunglassesCategoryCards.where((card) => card.isVisible).length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final visibleCards = state.sunglassesCategoryCards.where((card) => card.isVisible).toList();
                  return _buildCategoryCardWidget(visibleCards[index]);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductCategory category) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 89.5, // Exact square size as shown in the reference (89.5 x 89.5)
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: category.imagePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildSmartImage(category.imagePath!),
                )
              : Center(
                  child: Icon(
                    category.icon,
                    size: 40,
                    color: Colors.grey[600],
                  ),
                ),
        ),
        const SizedBox(height: 8),
        Text(
          category.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCarouselSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Center(
            child: Text(
              state.videoCarouselTitle,
              style: TextStyle(
                fontSize: state.videoCarouselTitleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
                fontFamily: state.videoCarouselTitleFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          // Section Subtitle
          Center(
            child: Text(
              state.videoCarouselSubtitle,
              style: TextStyle(
                fontSize: state.videoCarouselSubtitleFontSize,
                color: const Color(0xFF666666),
                fontFamily: state.videoCarouselSubtitleFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Video Carousel
          if (state.videos.isNotEmpty) ...[
            SizedBox(
              height: 250, // Match the height of video cards
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.videos.where((v) => v.isVisible).length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final visibleVideos = state.videos.where((v) => v.isVisible).toList();
                  return _buildVideoCard(visibleVideos[index]);
                },
              ),
            ),
          ] else ...[
            // Default video cards when no videos are added
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _buildDefaultVideoCard(index);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVideoCard(VideoItem video) {
    return Container(
      width: 140, // Exact width as specified in image
      height: 250, // Exact height as specified in image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: video.backgroundGradient ?? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8B9D83), Color(0xFF1A1A1A)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Video Player
            if (video.videoUrl.isNotEmpty) ...[
              FutureBuilder<VideoPlayerController?>(
                future: _initializeVideoController(video.videoUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && 
                      snapshot.data != null) {
                    return VideoPlayer(snapshot.data!);
                  } else {
                    // Show gradient background while loading
                    return Container(
                      decoration: BoxDecoration(
                        gradient: video.backgroundGradient ?? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF8B9D83), Color(0xFF1A1A1A)],
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
            ] else ...[
              // Fallback gradient background if no video URL
              Container(
                decoration: BoxDecoration(
                  gradient: video.backgroundGradient ?? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF8B9D83), Color(0xFF1A1A1A)],
                  ),
                ),
              ),
            ],
            // Text overlay at bottom-left
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                video.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<VideoPlayerController?> _initializeVideoController(String videoUrl) async {
    try {
      // Handle different URL formats
      Uri uri;
      if (videoUrl.startsWith('http://') || videoUrl.startsWith('https://')) {
        uri = Uri.parse(videoUrl);
      } else if (videoUrl.startsWith('//')) {
        uri = Uri.parse('https:$videoUrl');
      } else {
        uri = Uri.parse('https://$videoUrl');
      }
      
      final controller = VideoPlayerController.networkUrl(uri);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      return controller;
    } catch (e) {
      print('Error initializing video for URL "$videoUrl": $e');
      return null;
    }
  }

  Widget _buildDefaultVideoCard(int index) {
    final videoData = [
      {
        'title': 'RICKER',
        'background': const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8B9D83), Color(0xFF5A5A5A)],
        ),
      },
      {
        'title': 'COMMANDER',
        'background': const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF2C2C2C)],
        ),
      },
      {
        'title': 'ARISTO',
        'background': const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3E2723), Color(0xFF1A1A1A)],
        ),
      },
    ];

    final data = videoData[index];
    
    return Container(
      width: 140, // Exact width as specified in image
      height: 250, // Exact height as specified in image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: data['background'] as LinearGradient,
      ),
      child: Stack(
        children: [
          // Video thumbnail placeholder (you can replace with actual video thumbnails)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  gradient: data['background'] as LinearGradient,
                ),
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ),
          // Text overlay at bottom-left
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              data['title'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysMoodSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.todaysMoodTitle,
                style: TextStyle(
                  fontSize: state.todaysMoodTitleFontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: state.todaysMoodTitleFontFamily,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: state.todaysMoodButtonColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  state.todaysMoodButtonText,
                  style: TextStyle(
                    fontSize: state.todaysMoodButtonFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            state.todaysMoodSubtitle,
            style: TextStyle(
              fontSize: state.todaysMoodSubtitleFontSize,
              color: const Color(0xFF666666),
              fontFamily: state.todaysMoodSubtitleFontFamily,
            ),
          ),
          const SizedBox(height: 24),
          
          // Men section
          _buildCategorySection(state.todaysMoodMenTitle, state.mensCategoryCardColor, state.mensStyleCards),
          const SizedBox(height: 20),
          _buildCategorySection(state.todaysMoodWomenTitle, state.womensCategoryCardColor, state.womensStyleCards),
        ],
      ),
    );
  }

  Widget _buildMostLovedSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            state.mostLovedTitle,
            style: TextStyle(
              fontSize: state.mostLovedTitleFontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
              fontFamily: state.mostLovedTitleFontFamily,
            ),
          ),
          const SizedBox(height: 8),
          // Section Subtitle
          Text(
            state.mostLovedSubtitle,
            style: TextStyle(
              fontSize: state.mostLovedSubtitleFontSize,
              color: const Color(0xFF666666),
              fontFamily: state.mostLovedSubtitleFontFamily,
            ),
          ),
          const SizedBox(height: 20),
          // Most Loved Carousel with Fade Animation
          if (state.mostLovedProducts.isNotEmpty) ...[
            SizedBox(
              height: 512, // Exact height from image
              child: _buildMostLovedCarousel(state),
            ),
          ] else ...[
            // Default product cards when no products are added
            SizedBox(
              height: 512,
              child: _buildDefaultMostLovedCarousel(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMostLovedCarousel(HeaderCustomizationState state) {
    final visibleProducts = state.mostLovedProducts.where((p) => p.isVisible).toList();
    
    return PageView.builder(
      itemCount: visibleProducts.length,
      itemBuilder: (context, index) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _buildMostLovedProductCard(visibleProducts[index], key: ValueKey(visibleProducts[index].id)),
        );
      },
    );
  }

  Widget _buildDefaultMostLovedCarousel() {
    final defaultProducts = [
      {
        'title': 'RICKER',
        'subtitle': 'Black and Gold Eyeglasses',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
      {
        'title': 'COMMANDER',
        'subtitle': 'Premium Metal Frames',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
      {
        'title': 'ARISTO',
        'subtitle': 'Classic Designer Frames',
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
    ];

    return PageView.builder(
      itemCount: defaultProducts.length,
      itemBuilder: (context, index) {
        final product = defaultProducts[index];
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _buildDefaultMostLovedProductCard(product, index, key: ValueKey(index)),
        );
      },
    );
  }

  Widget _buildMostLovedProductCard(ProductItem product, {Key? key}) {
    return Container(
      width: 382, // Exact width from image
      height: 512, // Exact height from image
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700), // Golden background
            Color(0xFFFFE55C),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background image or placeholder
          if (product.imagePath != null) ...[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildSmartImage(product.imagePath!),
              ),
            ),
          ] else ...[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDefaultMostLovedProductCard(Map<String, String> product, int index, {Key? key}) {
    return Container(
      width: 382, // Exact width from image
      height: 512, // Exact height from image
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700), // Golden background
            Color(0xFFFFE55C),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background image or placeholder
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.remove_red_eye,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstagramShowcaseSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            state.instagramShowcaseTitle,
            style: TextStyle(
              fontSize: state.instagramShowcaseTitleFontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
              fontFamily: state.instagramShowcaseTitleFontFamily,
            ),
          ),
          const SizedBox(height: 8),
          // Section Subtitle
          Text(
            state.instagramShowcaseSubtitle,
            style: TextStyle(
              fontSize: state.instagramShowcaseSubtitleFontSize,
              color: const Color(0xFF666666),
              fontFamily: state.instagramShowcaseSubtitleFontFamily,
            ),
          ),
          const SizedBox(height: 20),
          // Instagram Showcase Carousel with Fade Animation
          if (state.instagramItems.isNotEmpty) ...[
            SizedBox(
              height: 250, // Match the height of image cards
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.instagramItems.where((img) => img.isVisible).length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final visibleImages = state.instagramItems.where((img) => img.isVisible).toList();
                  return _buildInstagramShowcaseImageCard(visibleImages[index]);
                },
              ),
            ),
          ] else ...[
            // Default image cards when no images are added
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _buildDefaultInstagramShowcaseImageCard(index);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVideoCategoriesSection(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            state.videoCategoriesTitle,
            style: TextStyle(
              fontSize: state.videoCategoriesTitleFontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
              fontFamily: state.videoCategoriesTitleFontFamily,
            ),
          ),
          const SizedBox(height: 8),
          // Section Subtitle
          Text(
            state.videoCategoriesSubtitle,
            style: TextStyle(
              fontSize: state.videoCategoriesSubtitleFontSize,
              color: const Color(0xFF666666),
              fontFamily: state.videoCategoriesSubtitleFontFamily,
            ),
          ),
          const SizedBox(height: 20),
          // Video Categories Grid (2x3 layout)
          if (state.videoCategories.isNotEmpty) ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0, // Square cards
              ),
              itemCount: state.videoCategories.where((cat) => cat.isVisible).length,
              itemBuilder: (context, index) {
                final visibleCategories = state.videoCategories.where((cat) => cat.isVisible).toList();
                return _buildVideoCategoryCard(visibleCategories[index]);
              },
            ),
          ] else ...[
            // Default grid when no categories are added
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0, // Square cards
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildDefaultVideoCategoryCard(index);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstagramShowcaseImageCard(InstagramItem item) {
    return Container(
      width: 140, // Exact width as specified in image
      height: 250, // Exact height as specified in image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: item.itemType == 'video' && item.videoUrl != null
            ? _buildVideoPlayer(item.videoUrl!)
            : item.imagePath != null
                ? _buildSmartImage(item.imagePath!)
                : Center(
                    child: Icon(
                      item.itemType == 'video' ? Icons.video_library : Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
      ),
    );
  }

  Widget _buildVideoPlayer(String videoUrl) {
    return FutureBuilder<VideoPlayerController?>(
      future: _initializeVideoController(videoUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError || snapshot.data == null) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.video_library,
                size: 50,
                color: Colors.white,
              ),
            ),
          );
        }
        
        return VideoPlayer(snapshot.data!);
      },
    );
  }

  Widget _buildDefaultInstagramShowcaseImageCard(int index) {
    final imageData = [
      {
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
      {
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
      {
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
      },
    ];

    final data = imageData[index];
    
    return Container(
      width: 140, // Exact width as specified in image
      height: 250, // Exact height as specified in image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildSmartImage(data['image']!),
      ),
    );
  }

  Widget _buildVideoCategoryCard(VideoCategoryItem category) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 1), // Light pink border
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background video or placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: category.videoUrl != null
                ? _buildVideoOrGifContent(category.videoUrl!)
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey[100]!,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.video_library,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
          ),
          // Vertical text label on the right side
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoOrGifContent(String url) {
    // Check if the URL is a GIF
    if (url.toLowerCase().contains('.gif') || url.contains('gif')) {
      // Handle GIF files
      return Image.network(
        url,
        width: 180,
        height: 180,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                color: Colors.white,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.error,
                size: 40,
                color: Colors.white,
              ),
            ),
          );
        },
      );
    } else {
      // Handle regular video files
      return _buildVideoPlayer(url);
    }
  }

  Widget _buildDefaultVideoCategoryCard(int index) {
    final categories = [
      {'title': 'PILOT', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_pilot.gif?v=1753091621?retry=1'},
      {'title': 'Z-FLEX', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_zflex.gif?v=1753091621?retry=1'},
      {'title': 'ACTIVE', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_active.gif?v=1753091621?retry=1'},
      {'title': 'GLAM', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_glam.gif?v=1753091621?retry=1'},
      {'title': 'CLIP-ON', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_clipon.gif?v=1753091621?retry=1'},
      {'title': 'AIR', 'videoUrl': 'https://goeye.in/cdn/shop/files/final_air.gif?v=1753091621?retry=1'},
    ];

    final category = categories[index];
    
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 1), // Light pink border
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background video or placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: _buildVideoOrGifContent(category['videoUrl']!),
          ),
          // Vertical text label on the right side
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  category['title']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category, Color categoryColor, List<StyleCard> styleCards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header card and style cards in single horizontal line
        SizedBox(
          height: 120, // Same height as style cards
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: styleCards.where((card) => card.isVisible).length + 1, // +1 for category card
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Category card
                return _buildCategoryCard(category, categoryColor);
              } else {
                // Style cards
                final visibleCards = styleCards.where((card) => card.isVisible).toList();
                final styleCard = visibleCards[index - 1];
                return _buildStyleCard(styleCard.title, styleCard.imagePath);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String category, Color categoryColor) {
    return Container(
      width: 100, // Same width as style cards
      height: 120, // Same height as style cards
      decoration: BoxDecoration(
        color: categoryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Explore All",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF333333),
              ),
            ),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF333333),
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleCard(String title, String? imagePath) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          if (imagePath != null) ...[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildSmartImage(imagePath),
              ),
            ),
          ] else ...[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: const Icon(
                  Icons.image,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMensStyles() {
    return [
              {'title': 'CEO Look', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
        {'title': 'Casual Wear', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
        {'title': 'Athletic L', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
    ];
  }

  List<Map<String, String>> _getWomensStyles() {
    return [
              {'title': 'Boss Lady', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
        {'title': 'Glam Queen', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
        {'title': 'Athletic L', 'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200'},
    ];
  }

  Widget _buildCategoryCardWidget(CategoryCard card) {
    return Column(
      children: [
        // Card with image filling the entire area
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: card.imagePath != null && card.imagePath!.isNotEmpty
                ? Image.network(
                    card.imagePath!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          card.icon ?? Icons.image,
                          size: 32,
                          color: const Color(0xFF333333),
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[200],
                    child: Icon(
                      card.icon ?? Icons.image,
                      size: 32,
                      color: const Color(0xFF333333),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        // Text label below the card
        Text(
          card.title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
