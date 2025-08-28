import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/sync_service.dart';

// Collection item model
class CollectionItem {
  final String id;
  final String title;
  final String subtitle;
  final String? imagePath;
  final IconData? icon;
  final bool isVisible;

  CollectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.icon,
    this.isVisible = true,
  });

  CollectionItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imagePath,
    IconData? icon,
    bool? isVisible,
  }) {
    return CollectionItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      icon: icon ?? this.icon,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Product category model
class ProductCategory {
  final String id;
  final String label;
  final IconData icon;
  final String? imagePath;
  final bool isVisible;

  ProductCategory({
    required this.id,
    required this.label,
    required this.icon,
    this.imagePath,
    this.isVisible = true,
  });

  ProductCategory copyWith({
    String? id,
    String? label,
    IconData? icon,
    String? imagePath,
    bool? isVisible,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      imagePath: imagePath ?? this.imagePath,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Video item model
class VideoItem {
  final String id;
  final String title;
  final String videoUrl;
  final bool isVisible;
  final LinearGradient? backgroundGradient;

  VideoItem({
    required this.id,
    required this.title,
    required this.videoUrl,
    this.isVisible = true,
    this.backgroundGradient,
  });

  VideoItem copyWith({
    String? id,
    String? title,
    String? videoUrl,
    bool? isVisible,
    LinearGradient? backgroundGradient,
  }) {
    return VideoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      isVisible: isVisible ?? this.isVisible,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }
}

// Header customization state
class HeaderCustomizationState {
  // Promotional banner
  final bool showPromotionalBanner;
  final String promotionalBannerText;
  final Color promotionalBannerBackgroundColor;
  final Color promotionalBannerTextColor;
  final double promotionalBannerFontSize;
  final String promotionalBannerFontFamily;

  // Header customization
  final Color headerBackgroundColor;
  final Color headerTextColor;
  final Color headerIconColor;
  final double headerIconSize;
  final bool showHeaderLogo;
  final bool showHeaderIcons;

  // Collections section
  final String collectionsSectionTitle;
  final double collectionsSectionTitleFontSize;
  final String collectionsSectionTitleFontFamily;
  final List<CollectionItem> collections;

  // Product categories section
  final String productCategoriesSectionTitle;
  final double productCategoriesSectionTitleFontSize;
  final String productCategoriesSectionTitleFontFamily;
  final List<ProductCategory> productCategories;
  
  // Product Category Cards customization
  final bool showProductCategoryCards;
  final String productCategoryCardsTitle;
  final double productCategoryCardsTitleFontSize;
  final String productCategoryCardsTitleFontFamily;
  final List<CategoryCard> eyeglassesCategoryCards;
  final List<CategoryCard> sunglassesCategoryCards;

  // Eyeglasses section font customization
  final double eyeglassesSectionFontSize;
  final String eyeglassesSectionFontFamily;

  // Video carousel section
  final bool showVideoCarousel;
  final String videoCarouselTitle;
  final String videoCarouselSubtitle;
  final double videoCarouselTitleFontSize;
  final String videoCarouselTitleFontFamily;
  final double videoCarouselSubtitleFontSize;
  final String videoCarouselSubtitleFontFamily;
  final List<VideoItem> videos;

  // Today's mood section
  final bool showTodaysMoodSection;
  final String todaysMoodTitle;
  final String todaysMoodSubtitle;
  final double todaysMoodTitleFontSize;
  final String todaysMoodTitleFontFamily;
  final double todaysMoodSubtitleFontSize;
  final String todaysMoodSubtitleFontFamily;
  final String todaysMoodButtonText;
  final double todaysMoodButtonFontSize;
  final Color todaysMoodButtonColor;
  final String todaysMoodMenTitle;
  final String todaysMoodWomenTitle;
  final Color mensCategoryCardColor;
  final Color womensCategoryCardColor;
  final List<StyleCard> mensStyleCards;
  final List<StyleCard> womensStyleCards;

  // Most Loved section
  final bool showMostLovedSection;
  final String mostLovedTitle;
  final String mostLovedSubtitle;
  final double mostLovedTitleFontSize;
  final String mostLovedTitleFontFamily;
  final double mostLovedSubtitleFontSize;
  final String mostLovedSubtitleFontFamily;
  final List<ProductItem> mostLovedProducts;
  
  // Instagram Showcase section
  final bool showInstagramShowcase;
  final String instagramShowcaseTitle;
  final String instagramShowcaseSubtitle;
  final double instagramShowcaseTitleFontSize;
  final String instagramShowcaseTitleFontFamily;
  final double instagramShowcaseSubtitleFontSize;
  final String instagramShowcaseSubtitleFontFamily;
  final List<InstagramItem> instagramItems;
  
  // Video Categories section
  final bool showVideoCategories;
  final String videoCategoriesTitle;
  final String videoCategoriesSubtitle;
  final double videoCategoriesTitleFontSize;
  final String videoCategoriesTitleFontFamily;
  final double videoCategoriesSubtitleFontSize;
  final String videoCategoriesSubtitleFontFamily;
  final List<VideoCategoryItem> videoCategories;

  HeaderCustomizationState({
    required this.showPromotionalBanner,
    required this.promotionalBannerText,
    required this.promotionalBannerBackgroundColor,
    required this.promotionalBannerTextColor,
    required this.promotionalBannerFontSize,
    required this.promotionalBannerFontFamily,
    required this.headerBackgroundColor,
    required this.headerTextColor,
    required this.headerIconColor,
    required this.headerIconSize,
    required this.showHeaderLogo,
    required this.showHeaderIcons,
    required this.collectionsSectionTitle,
    required this.collectionsSectionTitleFontSize,
    required this.collectionsSectionTitleFontFamily,
    required this.collections,
    required this.productCategoriesSectionTitle,
    required this.productCategoriesSectionTitleFontSize,
    required this.productCategoriesSectionTitleFontFamily,
    required this.productCategories,
    required this.showProductCategoryCards,
    required this.productCategoryCardsTitle,
    required this.productCategoryCardsTitleFontSize,
    required this.productCategoryCardsTitleFontFamily,
    required this.eyeglassesCategoryCards,
    required this.sunglassesCategoryCards,
    required this.eyeglassesSectionFontSize,
    required this.eyeglassesSectionFontFamily,
    required this.showVideoCarousel,
    required this.videoCarouselTitle,
    required this.videoCarouselSubtitle,
    required this.videoCarouselTitleFontSize,
    required this.videoCarouselTitleFontFamily,
    required this.videoCarouselSubtitleFontSize,
    required this.videoCarouselSubtitleFontFamily,
    required this.videos,
    required this.showTodaysMoodSection,
    required this.todaysMoodTitle,
    required this.todaysMoodSubtitle,
    required this.todaysMoodTitleFontSize,
    required this.todaysMoodTitleFontFamily,
    required this.todaysMoodSubtitleFontSize,
    required this.todaysMoodSubtitleFontFamily,
    required this.todaysMoodButtonText,
    required this.todaysMoodButtonFontSize,
    required this.todaysMoodButtonColor,
    required this.todaysMoodMenTitle,
    required this.todaysMoodWomenTitle,
    required this.mensCategoryCardColor,
    required this.womensCategoryCardColor,
    required this.mensStyleCards,
    required this.womensStyleCards,
    required this.showMostLovedSection,
    required this.mostLovedTitle,
    required this.mostLovedSubtitle,
    required this.mostLovedTitleFontSize,
    required this.mostLovedTitleFontFamily,
    required this.mostLovedSubtitleFontSize,
    required this.mostLovedSubtitleFontFamily,
    required this.mostLovedProducts,
    required this.showInstagramShowcase,
    required this.instagramShowcaseTitle,
    required this.instagramShowcaseSubtitle,
    required this.instagramShowcaseTitleFontSize,
    required this.instagramShowcaseTitleFontFamily,
    required this.instagramShowcaseSubtitleFontSize,
    required this.instagramShowcaseSubtitleFontFamily,
    required this.instagramItems,
    required this.showVideoCategories,
    required this.videoCategoriesTitle,
    required this.videoCategoriesSubtitle,
    required this.videoCategoriesTitleFontSize,
    required this.videoCategoriesTitleFontFamily,
    required this.videoCategoriesSubtitleFontSize,
    required this.videoCategoriesSubtitleFontFamily,
    required this.videoCategories,
  });

  HeaderCustomizationState copyWith({
    bool? showPromotionalBanner,
    String? promotionalBannerText,
    Color? promotionalBannerBackgroundColor,
    Color? promotionalBannerTextColor,
    double? promotionalBannerFontSize,
    String? promotionalBannerFontFamily,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? headerIconColor,
    double? headerIconSize,
    bool? showHeaderLogo,
    bool? showHeaderIcons,
    String? collectionsSectionTitle,
    double? collectionsSectionTitleFontSize,
    String? collectionsSectionTitleFontFamily,
    List<CollectionItem>? collections,
    String? productCategoriesSectionTitle,
    double? productCategoriesSectionTitleFontSize,
    String? productCategoriesSectionTitleFontFamily,
    List<ProductCategory>? productCategories,
    bool? showProductCategoryCards,
    String? productCategoryCardsTitle,
    double? productCategoryCardsTitleFontSize,
    String? productCategoryCardsTitleFontFamily,
    List<CategoryCard>? eyeglassesCategoryCards,
    List<CategoryCard>? sunglassesCategoryCards,
    double? eyeglassesSectionFontSize,
    String? eyeglassesSectionFontFamily,
    bool? showVideoCarousel,
    String? videoCarouselTitle,
    String? videoCarouselSubtitle,
    double? videoCarouselTitleFontSize,
    String? videoCarouselTitleFontFamily,
    double? videoCarouselSubtitleFontSize,
    String? videoCarouselSubtitleFontFamily,
    List<VideoItem>? videos,
    bool? showTodaysMoodSection,
    String? todaysMoodTitle,
    String? todaysMoodSubtitle,
    double? todaysMoodTitleFontSize,
    String? todaysMoodTitleFontFamily,
    double? todaysMoodSubtitleFontSize,
    String? todaysMoodSubtitleFontFamily,
    String? todaysMoodButtonText,
    double? todaysMoodButtonFontSize,
    Color? todaysMoodButtonColor,
    String? todaysMoodMenTitle,
    String? todaysMoodWomenTitle,
    Color? mensCategoryCardColor,
    Color? womensCategoryCardColor,
    List<StyleCard>? mensStyleCards,
    List<StyleCard>? womensStyleCards,
    bool? showMostLovedSection,
    String? mostLovedTitle,
    String? mostLovedSubtitle,
    double? mostLovedTitleFontSize,
    String? mostLovedTitleFontFamily,
    double? mostLovedSubtitleFontSize,
    String? mostLovedSubtitleFontFamily,
    List<ProductItem>? mostLovedProducts,
    bool? showInstagramShowcase,
    String? instagramShowcaseTitle,
    String? instagramShowcaseSubtitle,
    double? instagramShowcaseTitleFontSize,
    String? instagramShowcaseTitleFontFamily,
    double? instagramShowcaseSubtitleFontSize,
    String? instagramShowcaseSubtitleFontFamily,
    List<InstagramItem>? instagramItems,
    bool? showVideoCategories,
    String? videoCategoriesTitle,
    String? videoCategoriesSubtitle,
    double? videoCategoriesTitleFontSize,
    String? videoCategoriesTitleFontFamily,
    double? videoCategoriesSubtitleFontSize,
    String? videoCategoriesSubtitleFontFamily,
    List<VideoCategoryItem>? videoCategories,
  }) {
    return HeaderCustomizationState(
      showPromotionalBanner: showPromotionalBanner ?? this.showPromotionalBanner,
      promotionalBannerText: promotionalBannerText ?? this.promotionalBannerText,
      promotionalBannerBackgroundColor: promotionalBannerBackgroundColor ?? this.promotionalBannerBackgroundColor,
      promotionalBannerTextColor: promotionalBannerTextColor ?? this.promotionalBannerTextColor,
      promotionalBannerFontSize: promotionalBannerFontSize ?? this.promotionalBannerFontSize,
      promotionalBannerFontFamily: promotionalBannerFontFamily ?? this.promotionalBannerFontFamily,
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      headerIconSize: headerIconSize ?? this.headerIconSize,
      showHeaderLogo: showHeaderLogo ?? this.showHeaderLogo,
      showHeaderIcons: showHeaderIcons ?? this.showHeaderIcons,
      collectionsSectionTitle: collectionsSectionTitle ?? this.collectionsSectionTitle,
      collectionsSectionTitleFontSize: collectionsSectionTitleFontSize ?? this.collectionsSectionTitleFontSize,
      collectionsSectionTitleFontFamily: collectionsSectionTitleFontFamily ?? this.collectionsSectionTitleFontFamily,
      collections: collections ?? this.collections,
      productCategoriesSectionTitle: productCategoriesSectionTitle ?? this.productCategoriesSectionTitle,
      productCategoriesSectionTitleFontSize: productCategoriesSectionTitleFontSize ?? this.productCategoriesSectionTitleFontSize,
      productCategoriesSectionTitleFontFamily: productCategoriesSectionTitleFontFamily ?? this.productCategoriesSectionTitleFontFamily,
      productCategories: productCategories ?? this.productCategories,
      showProductCategoryCards: showProductCategoryCards ?? this.showProductCategoryCards,
      productCategoryCardsTitle: productCategoryCardsTitle ?? this.productCategoryCardsTitle,
      productCategoryCardsTitleFontSize: productCategoryCardsTitleFontSize ?? this.productCategoryCardsTitleFontSize,
      productCategoryCardsTitleFontFamily: productCategoryCardsTitleFontFamily ?? this.productCategoryCardsTitleFontFamily,
      eyeglassesCategoryCards: eyeglassesCategoryCards ?? this.eyeglassesCategoryCards,
      sunglassesCategoryCards: sunglassesCategoryCards ?? this.sunglassesCategoryCards,
      eyeglassesSectionFontSize: eyeglassesSectionFontSize ?? this.eyeglassesSectionFontSize,
      eyeglassesSectionFontFamily: eyeglassesSectionFontFamily ?? this.eyeglassesSectionFontFamily,
      showVideoCarousel: showVideoCarousel ?? this.showVideoCarousel,
      videoCarouselTitle: videoCarouselTitle ?? this.videoCarouselTitle,
      videoCarouselSubtitle: videoCarouselSubtitle ?? this.videoCarouselSubtitle,
      videoCarouselTitleFontSize: videoCarouselTitleFontSize ?? this.videoCarouselTitleFontSize,
      videoCarouselTitleFontFamily: videoCarouselTitleFontFamily ?? this.videoCarouselTitleFontFamily,
      videoCarouselSubtitleFontSize: videoCarouselSubtitleFontSize ?? this.videoCarouselSubtitleFontSize,
      videoCarouselSubtitleFontFamily: videoCarouselSubtitleFontFamily ?? this.videoCarouselSubtitleFontFamily,
      videos: videos ?? this.videos,
      showTodaysMoodSection: showTodaysMoodSection ?? this.showTodaysMoodSection,
      todaysMoodTitle: todaysMoodTitle ?? this.todaysMoodTitle,
      todaysMoodSubtitle: todaysMoodSubtitle ?? this.todaysMoodSubtitle,
      todaysMoodTitleFontSize: todaysMoodTitleFontSize ?? this.todaysMoodTitleFontSize,
      todaysMoodTitleFontFamily: todaysMoodTitleFontFamily ?? this.todaysMoodTitleFontFamily,
      todaysMoodSubtitleFontSize: todaysMoodSubtitleFontSize ?? this.todaysMoodSubtitleFontSize,
      todaysMoodSubtitleFontFamily: todaysMoodSubtitleFontFamily ?? this.todaysMoodSubtitleFontFamily,
      todaysMoodButtonText: todaysMoodButtonText ?? this.todaysMoodButtonText,
      todaysMoodButtonFontSize: todaysMoodButtonFontSize ?? this.todaysMoodButtonFontSize,
      todaysMoodButtonColor: todaysMoodButtonColor ?? this.todaysMoodButtonColor,
      todaysMoodMenTitle: todaysMoodMenTitle ?? this.todaysMoodMenTitle,
      todaysMoodWomenTitle: todaysMoodWomenTitle ?? this.todaysMoodWomenTitle,
      mensCategoryCardColor: mensCategoryCardColor ?? this.mensCategoryCardColor,
      womensCategoryCardColor: womensCategoryCardColor ?? this.womensCategoryCardColor,
      mensStyleCards: mensStyleCards ?? this.mensStyleCards,
      womensStyleCards: womensStyleCards ?? this.womensStyleCards,
      showMostLovedSection: showMostLovedSection ?? this.showMostLovedSection,
      mostLovedTitle: mostLovedTitle ?? this.mostLovedTitle,
      mostLovedSubtitle: mostLovedSubtitle ?? this.mostLovedSubtitle,
      mostLovedTitleFontSize: mostLovedTitleFontSize ?? this.mostLovedTitleFontSize,
      mostLovedTitleFontFamily: mostLovedTitleFontFamily ?? this.mostLovedTitleFontFamily,
      mostLovedSubtitleFontSize: mostLovedSubtitleFontSize ?? this.mostLovedSubtitleFontSize,
      mostLovedSubtitleFontFamily: mostLovedSubtitleFontFamily ?? this.mostLovedSubtitleFontFamily,
      mostLovedProducts: mostLovedProducts ?? this.mostLovedProducts,
      showInstagramShowcase: showInstagramShowcase ?? this.showInstagramShowcase,
      instagramShowcaseTitle: instagramShowcaseTitle ?? this.instagramShowcaseTitle,
      instagramShowcaseSubtitle: instagramShowcaseSubtitle ?? this.instagramShowcaseSubtitle,
      instagramShowcaseTitleFontSize: instagramShowcaseTitleFontSize ?? this.instagramShowcaseTitleFontSize,
      instagramShowcaseTitleFontFamily: instagramShowcaseTitleFontFamily ?? this.instagramShowcaseTitleFontFamily,
      instagramShowcaseSubtitleFontSize: instagramShowcaseSubtitleFontSize ?? this.instagramShowcaseSubtitleFontSize,
      instagramShowcaseSubtitleFontFamily: instagramShowcaseSubtitleFontFamily ?? this.instagramShowcaseSubtitleFontFamily,
      instagramItems: instagramItems ?? this.instagramItems,
      showVideoCategories: showVideoCategories ?? this.showVideoCategories,
      videoCategoriesTitle: videoCategoriesTitle ?? this.videoCategoriesTitle,
      videoCategoriesSubtitle: videoCategoriesSubtitle ?? this.videoCategoriesSubtitle,
      videoCategoriesTitleFontSize: videoCategoriesTitleFontSize ?? this.videoCategoriesTitleFontSize,
      videoCategoriesTitleFontFamily: videoCategoriesTitleFontFamily ?? this.videoCategoriesTitleFontFamily,
      videoCategoriesSubtitleFontSize: videoCategoriesSubtitleFontSize ?? this.videoCategoriesSubtitleFontSize,
      videoCategoriesSubtitleFontFamily: videoCategoriesSubtitleFontFamily ?? this.videoCategoriesSubtitleFontFamily,
      videoCategories: videoCategories ?? this.videoCategories,
    );
  }
}

class StyleCard {
  final String id;
  final String title;
  final String? imagePath;
  final bool isVisible;

  StyleCard({
    required this.id,
    required this.title,
    this.imagePath,
    required this.isVisible,
  });

  StyleCard copyWith({
    String? id,
    String? title,
    String? imagePath,
    bool? isVisible,
  }) {
    return StyleCard(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Product item model
class ProductItem {
  final String id;
  final String title;
  final String? imagePath;
  final bool isVisible;

  ProductItem({
    required this.id,
    required this.title,
    this.imagePath,
    required this.isVisible,
  });

  ProductItem copyWith({
    String? id,
    String? title,
    String? imagePath,
    bool? isVisible,
  }) {
    return ProductItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Instagram item model
class InstagramItem {
  final String id;
  final String title;
  final String? imagePath;
  final String? videoUrl;
  final String itemType; // 'image' or 'video'
  final bool isVisible;

  InstagramItem({
    required this.id,
    required this.title,
    this.imagePath,
    this.videoUrl,
    required this.itemType,
    required this.isVisible,
  });

  InstagramItem copyWith({
    String? id,
    String? title,
    String? imagePath,
    String? videoUrl,
    String? itemType,
    bool? isVisible,
  }) {
    return InstagramItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      videoUrl: videoUrl ?? this.videoUrl,
      itemType: itemType ?? this.itemType,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Video Category Item model
class VideoCategoryItem {
  final String id;
  final String title;
  final String? videoUrl;
  final bool isVisible;

  VideoCategoryItem({
    required this.id,
    required this.title,
    this.videoUrl,
    this.isVisible = true,
  });

  VideoCategoryItem copyWith({
    String? id,
    String? title,
    String? videoUrl,
    bool? isVisible,
  }) {
    return VideoCategoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Category Card model for product category cards
class CategoryCard {
  final String id;
  final String title;
  final IconData? icon; // Make icon nullable as imagePath will be primary
  final String? imagePath;
  final bool isVisible;

  CategoryCard({
    required this.id,
    required this.title,
    this.icon,
    this.imagePath,
    this.isVisible = true,
  });

  CategoryCard copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? imagePath,
    bool? isVisible,
  }) {
    return CategoryCard(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      imagePath: imagePath ?? this.imagePath,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// Header customization notifier
class HeaderCustomizationNotifier extends StateNotifier<HeaderCustomizationState> {
  final SyncService _syncService = SyncService();
  
  HeaderCustomizationNotifier()
      : super(HeaderCustomizationState(
          showPromotionalBanner: false,
          promotionalBannerText: '',
          promotionalBannerBackgroundColor: Colors.transparent,
          promotionalBannerTextColor: Colors.black,
          promotionalBannerFontSize: 16.0,
          promotionalBannerFontFamily: 'Roboto',
          headerBackgroundColor: const Color(0xFF1E2A3A),
          headerTextColor: Colors.white,
          headerIconColor: Colors.white,
          headerIconSize: 24.0,
          showHeaderLogo: true,
          showHeaderIcons: true,
          collectionsSectionTitle: 'Collections to Explore',
          collectionsSectionTitleFontSize: 24.0,
          collectionsSectionTitleFontFamily: 'Roboto',
          collections: [
            CollectionItem(
              id: 'collection1',
              title: 'Ms fierceness...',
              subtitle: 'Fierce and bold eyewear for the confident woman',
              isVisible: true,
            ),
            CollectionItem(
              id: 'collection2',
              title: 'Visionary',
              subtitle: 'Mastering the art of luxury eyewear',
              isVisible: true,
            ),
          ],
          productCategoriesSectionTitle: 'Product Categories',
          productCategoriesSectionTitleFontSize: 24.0,
          productCategoriesSectionTitleFontFamily: 'Roboto',
          productCategories: [
            ProductCategory(id: 'men_eyeglasses', label: 'Men', icon: Icons.person, isVisible: true),
            ProductCategory(id: 'women_eyeglasses', label: 'Women', icon: Icons.person_outline, isVisible: true),
            ProductCategory(id: 'kids_eyeglasses', label: 'Kids', icon: Icons.child_care, isVisible: true),
            ProductCategory(id: 'essentials_eyeglasses', label: 'Essentials', icon: Icons.style, isVisible: true),
          ],
          showProductCategoryCards: true,
          productCategoryCardsTitle: 'Eyeglasses & Sunglasses',
          productCategoryCardsTitleFontSize: 24.0,
          productCategoryCardsTitleFontFamily: 'Roboto',
          eyeglassesCategoryCards: [
            CategoryCard(id: 'men_eyeglasses', title: 'Men', icon: Icons.person, isVisible: true),
            CategoryCard(id: 'women_eyeglasses', title: 'Women', icon: Icons.person_outline, isVisible: true),
            CategoryCard(id: 'kids_eyeglasses', title: 'Kids', icon: Icons.child_care, isVisible: true),
            CategoryCard(id: 'essentials_eyeglasses', title: 'Essentials', icon: Icons.style, isVisible: true),
          ],
          sunglassesCategoryCards: [
            CategoryCard(id: 'sunglasses', title: 'Sunglasses', icon: Icons.sunny, isVisible: true),
            CategoryCard(id: 'kids_sunglasses', title: 'Kids Sunglasses', icon: Icons.child_care, isVisible: true),
            CategoryCard(id: 'essentials_sunglasses', title: 'Essentials', icon: Icons.style, isVisible: true),
          ],
          eyeglassesSectionFontSize: 24.0,
          eyeglassesSectionFontFamily: 'Roboto',
          showVideoCarousel: true,
          videoCarouselTitle: 'Watch Our Story',
          videoCarouselSubtitle: 'Discover how we started and where we are going',
          videoCarouselTitleFontSize: 36.0,
          videoCarouselTitleFontFamily: 'Roboto',
          videoCarouselSubtitleFontSize: 18.0,
          videoCarouselSubtitleFontFamily: 'Roboto',
          videos: [],
          showTodaysMoodSection: true,
          todaysMoodTitle: 'Today\'s mood',
          todaysMoodSubtitle: 'Discover every look, for every style',
          todaysMoodTitleFontSize: 24.0,
          todaysMoodTitleFontFamily: 'Cursive',
          todaysMoodSubtitleFontSize: 16.0,
          todaysMoodSubtitleFontFamily: 'Roboto',
          todaysMoodButtonText: 'Look',
          todaysMoodButtonFontSize: 14.0,
          todaysMoodButtonColor: const Color(0xFF333333),
          todaysMoodMenTitle: 'Men',
          todaysMoodWomenTitle: 'Women',
          mensCategoryCardColor: const Color(0xFFE6E6FA),
          womensCategoryCardColor: const Color(0xFFFFE4E1),
          mensStyleCards: [
            StyleCard(id: 'mens_style1', title: 'CEO Look', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            StyleCard(id: 'mens_style2', title: 'Casual Wear', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            StyleCard(id: 'mens_style3', title: 'Athletic L', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
          ],
          womensStyleCards: [
            StyleCard(id: 'womens_style1', title: 'Boss Lady', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            StyleCard(id: 'womens_style2', title: 'Glam Queen', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            StyleCard(id: 'womens_style3', title: 'Athletic L', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
          ],
          showMostLovedSection: true,
          mostLovedTitle: 'Most Loved',
          mostLovedSubtitle: 'Customers favourite listed every 15 days',
          mostLovedTitleFontSize: 24.0,
          mostLovedTitleFontFamily: 'Roboto',
          mostLovedSubtitleFontSize: 16.0,
          mostLovedSubtitleFontFamily: 'Roboto',
          mostLovedProducts: [
            ProductItem(id: 'product1', title: 'RICKER', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            ProductItem(id: 'product2', title: 'COMMANDER', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
            ProductItem(id: 'product3', title: 'ARISTO', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
          ],
          showInstagramShowcase: true,
          instagramShowcaseTitle: 'Follow Us',
          instagramShowcaseSubtitle: 'Stay updated with our latest collections and offers',
          instagramShowcaseTitleFontSize: 24.0,
          instagramShowcaseTitleFontFamily: 'Roboto',
          instagramShowcaseSubtitleFontSize: 16.0,
          instagramShowcaseSubtitleFontFamily: 'Roboto',
          instagramItems: [],
          showVideoCategories: true,
          videoCategoriesTitle: 'Video Categories',
          videoCategoriesSubtitle: 'Explore our video content by category',
          videoCategoriesTitleFontSize: 24.0,
          videoCategoriesTitleFontFamily: 'Roboto',
          videoCategoriesSubtitleFontSize: 16.0,
          videoCategoriesSubtitleFontFamily: 'Roboto',
          videoCategories: [
            VideoCategoryItem(id: 'pilot_videos', title: 'PILOT', videoUrl: 'https://goeye.in/cdn/shop/files/final_pilot.gif?v=1753091621?retry=1', isVisible: true),
            VideoCategoryItem(id: 'zflex_videos', title: 'Z-FLEX', videoUrl: 'https://goeye.in/cdn/shop/files/final_zflex.gif?v=1753091621?retry=1', isVisible: true),
            VideoCategoryItem(id: 'active_videos', title: 'ACTIVE', videoUrl: 'https://goeye.in/cdn/shop/files/final_active.gif?v=1753091621?retry=1', isVisible: true),
            VideoCategoryItem(id: 'glam_videos', title: 'GLAM', videoUrl: 'https://goeye.in/cdn/shop/files/final_glam.gif?v=1753091621?retry=1', isVisible: true),
            VideoCategoryItem(id: 'clipon_videos', title: 'CLIP-ON', videoUrl: 'https://goeye.in/cdn/shop/files/final_clipon.gif?v=1753091621?retry=1', isVisible: true),
            VideoCategoryItem(id: 'air_videos', title: 'AIR', videoUrl: 'https://goeye.in/cdn/shop/files/final_air.gif?v=1753091621?retry=1', isVisible: true),
          ],
        )) {
    _loadCustomizationData();
    _initializeSync();
  }

  // Initialize sync service
  void _initializeSync() {
    // Set up callback to reload data when synced
    _syncService.setOnDataSyncedCallback(() {
      print('🔄 Sync callback triggered - reloading data...');
      reloadFromStorage();
    });
    
    // Start periodic sync with web backend
    _syncService.startSync();
    
    // Check if backend is available
    _syncService.isBackendAvailable().then((available) {
      if (available) {
        print('✅ Web backend is available - sync enabled');
      } else {
        print('⚠️ Web backend not available - using local storage only');
      }
    });
  }

  // Force refresh the UI with latest data
  Future<void> forceRefresh() async {
    print('🔄 Force refresh triggered');
    await reloadFromStorage();
    // Force a state update to trigger UI rebuild
    state = state.copyWith();
    print('✅ Force refresh completed');
  }

  // Load saved customization data
  Future<void> _loadCustomizationData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString('header_customization_data');
      
      if (savedData != null) {
        final Map<String, dynamic> data = json.decode(savedData);
        state = _createStateFromMap(data);
        print('✅ Loaded customization data from local storage');
      } else {
        print('⚠️ No saved customization data found');
      }
    } catch (e) {
      print('Error loading customization data: $e');
    }
  }

  // Reload data from storage (for sync updates)
  Future<void> reloadFromStorage() async {
    print('🔄 Reloading data from storage...');
    await _loadCustomizationData();
    print('✅ Data reloaded from storage');
  }

  // Save customization data
  Future<void> _saveCustomizationData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = _createMapFromState(state);
      await prefs.setString('header_customization_data', json.encode(data));
      
      // Also upload to web backend for sync
      await _syncService.uploadCustomizations(data);
    } catch (e) {
      print('Error saving customization data: $e');
    }
  }

  // Convert state to map for storage
  Map<String, dynamic> _createMapFromState(HeaderCustomizationState state) {
    return {
      'showPromotionalBanner': state.showPromotionalBanner,
      'promotionalBannerText': state.promotionalBannerText,
      'promotionalBannerBackgroundColor': state.promotionalBannerBackgroundColor.value,
      'promotionalBannerTextColor': state.promotionalBannerTextColor.value,
      'promotionalBannerFontSize': state.promotionalBannerFontSize,
      'promotionalBannerFontFamily': state.promotionalBannerFontFamily,
      'headerBackgroundColor': state.headerBackgroundColor.value,
      'headerTextColor': state.headerTextColor.value,
      'headerIconColor': state.headerIconColor.value,
      'headerIconSize': state.headerIconSize,
      'showHeaderLogo': state.showHeaderLogo,
      'showHeaderIcons': state.showHeaderIcons,
      'collectionsSectionTitle': state.collectionsSectionTitle,
      'collectionsSectionTitleFontSize': state.collectionsSectionTitleFontSize,
      'collectionsSectionTitleFontFamily': state.collectionsSectionTitleFontFamily,
      'collections': state.collections.map((c) => {
        'id': c.id,
        'title': c.title,
        'subtitle': c.subtitle,
        'imagePath': c.imagePath,
        'isVisible': c.isVisible,
      }).toList(),
      'productCategoriesSectionTitle': state.productCategoriesSectionTitle,
      'productCategoriesSectionTitleFontSize': state.productCategoriesSectionTitleFontSize,
      'productCategoriesSectionTitleFontFamily': state.productCategoriesSectionTitleFontFamily,
      'productCategories': state.productCategories.map((c) => {
        'id': c.id,
        'label': c.label,
        'icon': c.icon.codePoint,
        'isVisible': c.isVisible,
      }).toList(),
      'showProductCategoryCards': state.showProductCategoryCards,
      'productCategoryCardsTitle': state.productCategoryCardsTitle,
      'productCategoryCardsTitleFontSize': state.productCategoryCardsTitleFontSize,
      'productCategoryCardsTitleFontFamily': state.productCategoryCardsTitleFontFamily,
             'eyeglassesCategoryCards': state.eyeglassesCategoryCards.map((c) => {
         'id': c.id,
         'title': c.title,
         'icon': c.icon?.codePoint,
         'imagePath': c.imagePath,
         'isVisible': c.isVisible,
       }).toList(),
             'sunglassesCategoryCards': state.sunglassesCategoryCards.map((c) => {
         'id': c.id,
         'title': c.title,
         'icon': c.icon?.codePoint,
         'imagePath': c.imagePath,
         'isVisible': c.isVisible,
       }).toList(),
      'eyeglassesSectionFontSize': state.eyeglassesSectionFontSize,
      'eyeglassesSectionFontFamily': state.eyeglassesSectionFontFamily,
      'showVideoCarousel': state.showVideoCarousel,
      'videoCarouselTitle': state.videoCarouselTitle,
      'videoCarouselSubtitle': state.videoCarouselSubtitle,
      'videoCarouselTitleFontSize': state.videoCarouselTitleFontSize,
      'videoCarouselTitleFontFamily': state.videoCarouselTitleFontFamily,
      'videoCarouselSubtitleFontSize': state.videoCarouselSubtitleFontSize,
      'videoCarouselSubtitleFontFamily': state.videoCarouselSubtitleFontFamily,
      'videos': state.videos.map((v) => {
        'id': v.id,
        'title': v.title,
        'videoUrl': v.videoUrl,
        'isVisible': v.isVisible,
      }).toList(),
      'showTodaysMoodSection': state.showTodaysMoodSection,
      'todaysMoodTitle': state.todaysMoodTitle,
      'todaysMoodSubtitle': state.todaysMoodSubtitle,
      'todaysMoodTitleFontSize': state.todaysMoodTitleFontSize,
      'todaysMoodTitleFontFamily': state.todaysMoodTitleFontFamily,
      'todaysMoodSubtitleFontSize': state.todaysMoodSubtitleFontSize,
      'todaysMoodSubtitleFontFamily': state.todaysMoodSubtitleFontFamily,
      'todaysMoodButtonText': state.todaysMoodButtonText,
      'todaysMoodButtonFontSize': state.todaysMoodButtonFontSize,
      'todaysMoodButtonColor': state.todaysMoodButtonColor.value,
      'todaysMoodMenTitle': state.todaysMoodMenTitle,
      'todaysMoodWomenTitle': state.todaysMoodWomenTitle,
      'mensCategoryCardColor': state.mensCategoryCardColor.value,
      'womensCategoryCardColor': state.womensCategoryCardColor.value,
      'mensStyleCards': state.mensStyleCards.map((s) => {
        'id': s.id,
        'title': s.title,
        'imagePath': s.imagePath,
        'isVisible': s.isVisible,
      }).toList(),
      'womensStyleCards': state.womensStyleCards.map((s) => {
        'id': s.id,
        'title': s.title,
        'imagePath': s.imagePath,
        'isVisible': s.isVisible,
      }).toList(),
      'showMostLovedSection': state.showMostLovedSection,
      'mostLovedTitle': state.mostLovedTitle,
      'mostLovedSubtitle': state.mostLovedSubtitle,
      'mostLovedTitleFontSize': state.mostLovedTitleFontSize,
      'mostLovedTitleFontFamily': state.mostLovedTitleFontFamily,
      'mostLovedSubtitleFontSize': state.mostLovedSubtitleFontSize,
      'mostLovedSubtitleFontFamily': state.mostLovedSubtitleFontFamily,
      'mostLovedProducts': state.mostLovedProducts.map((p) => {
        'id': p.id,
        'title': p.title,
        'imagePath': p.imagePath,
        'isVisible': p.isVisible,
      }).toList(),
      'showInstagramShowcase': state.showInstagramShowcase,
      'instagramShowcaseTitle': state.instagramShowcaseTitle,
      'instagramShowcaseSubtitle': state.instagramShowcaseSubtitle,
      'instagramShowcaseTitleFontSize': state.instagramShowcaseTitleFontSize,
      'instagramShowcaseTitleFontFamily': state.instagramShowcaseTitleFontFamily,
      'instagramShowcaseSubtitleFontSize': state.instagramShowcaseSubtitleFontSize,
      'instagramShowcaseSubtitleFontFamily': state.instagramShowcaseSubtitleFontFamily,
      'instagramItems': state.instagramItems.map((i) => {
        'id': i.id,
        'title': i.title,
        'imagePath': i.imagePath,
        'videoUrl': i.videoUrl,
        'itemType': i.itemType,
        'isVisible': i.isVisible,
      }).toList(),
      'showVideoCategories': state.showVideoCategories,
      'videoCategoriesTitle': state.videoCategoriesTitle,
      'videoCategoriesSubtitle': state.videoCategoriesSubtitle,
      'videoCategoriesTitleFontSize': state.videoCategoriesTitleFontSize,
      'videoCategoriesTitleFontFamily': state.videoCategoriesTitleFontFamily,
      'videoCategoriesSubtitleFontSize': state.videoCategoriesSubtitleFontSize,
      'videoCategoriesSubtitleFontFamily': state.videoCategoriesSubtitleFontFamily,
      'videoCategories': state.videoCategories.map((c) => {
        'id': c.id,
        'title': c.title,
        'videoUrl': c.videoUrl,
        'isVisible': c.isVisible,
      }).toList(),
    };
  }

  // Create state from map
  HeaderCustomizationState _createStateFromMap(Map<String, dynamic> data) {
    return HeaderCustomizationState(
      showPromotionalBanner: data['showPromotionalBanner'] ?? false,
      promotionalBannerText: data['promotionalBannerText'] ?? '',
      promotionalBannerBackgroundColor: Color(data['promotionalBannerBackgroundColor'] ?? 0xFFFFFFFF),
      promotionalBannerTextColor: Color(data['promotionalBannerTextColor'] ?? 0xFF000000),
      promotionalBannerFontSize: data['promotionalBannerFontSize']?.toDouble() ?? 16.0,
      promotionalBannerFontFamily: data['promotionalBannerFontFamily'] ?? 'Roboto',
      headerBackgroundColor: Color(data['headerBackgroundColor'] ?? 0xFF1E2A3A),
      headerTextColor: Color(data['headerTextColor'] ?? 0xFFFFFFFF),
      headerIconColor: Color(data['headerIconColor'] ?? 0xFFFFFFFF),
      headerIconSize: data['headerIconSize']?.toDouble() ?? 24.0,
      showHeaderLogo: data['showHeaderLogo'] ?? true,
      showHeaderIcons: data['showHeaderIcons'] ?? true,
      collectionsSectionTitle: data['collectionsSectionTitle'] ?? 'Collections to Explore',
      collectionsSectionTitleFontSize: data['collectionsSectionTitleFontSize']?.toDouble() ?? 24.0,
      collectionsSectionTitleFontFamily: data['collectionsSectionTitleFontFamily'] ?? 'Roboto',
      collections: (data['collections'] as List<dynamic>?)?.map((c) => CollectionItem(
        id: c['id'],
        title: c['title'],
        subtitle: c['subtitle'],
        imagePath: c['imagePath'],
        isVisible: c['isVisible'] ?? true,
      )).toList() ?? [],
      productCategoriesSectionTitle: data['productCategoriesSectionTitle'] ?? 'Product Categories',
      productCategoriesSectionTitleFontSize: data['productCategoriesSectionTitleFontSize']?.toDouble() ?? 24.0,
      productCategoriesSectionTitleFontFamily: data['productCategoriesSectionTitleFontFamily'] ?? 'Roboto',
      productCategories: (data['productCategories'] as List<dynamic>?)?.map((c) => ProductCategory(
        id: c['id'],
        label: c['label'],
        icon: IconData(c['icon'], fontFamily: 'MaterialIcons'),
        isVisible: c['isVisible'] ?? true,
      )).toList() ?? [],
      showProductCategoryCards: data['showProductCategoryCards'] ?? true,
      productCategoryCardsTitle: data['productCategoryCardsTitle'] ?? 'Eyeglasses & Sunglasses',
      productCategoryCardsTitleFontSize: data['productCategoryCardsTitleFontSize']?.toDouble() ?? 24.0,
      productCategoryCardsTitleFontFamily: data['productCategoryCardsTitleFontFamily'] ?? 'Roboto',
             eyeglassesCategoryCards: (data['eyeglassesCategoryCards'] as List<dynamic>?)?.map((c) => CategoryCard(
         id: c['id'],
         title: c['title'],
         icon: c['icon'] != null ? IconData(c['icon'], fontFamily: 'MaterialIcons') : null,
         imagePath: c['imagePath'],
         isVisible: c['isVisible'] ?? true,
       )).toList() ?? [],
             sunglassesCategoryCards: (data['sunglassesCategoryCards'] as List<dynamic>?)?.map((c) => CategoryCard(
         id: c['id'],
         title: c['title'],
         icon: c['icon'] != null ? IconData(c['icon'], fontFamily: 'MaterialIcons') : null,
         imagePath: c['imagePath'],
         isVisible: c['isVisible'] ?? true,
       )).toList() ?? [],
      eyeglassesSectionFontSize: data['eyeglassesSectionFontSize']?.toDouble() ?? 24.0,
      eyeglassesSectionFontFamily: data['eyeglassesSectionFontFamily'] ?? 'Roboto',
      showVideoCarousel: data['showVideoCarousel'] ?? true,
      videoCarouselTitle: data['videoCarouselTitle'] ?? 'Watch our story',
      videoCarouselSubtitle: data['videoCarouselSubtitle'] ?? 'Discover our journey',
      videoCarouselTitleFontSize: data['videoCarouselTitleFontSize']?.toDouble() ?? 24.0,
      videoCarouselTitleFontFamily: data['videoCarouselTitleFontFamily'] ?? 'Roboto',
      videoCarouselSubtitleFontSize: data['videoCarouselSubtitleFontSize']?.toDouble() ?? 16.0,
      videoCarouselSubtitleFontFamily: data['videoCarouselSubtitleFontFamily'] ?? 'Roboto',
      videos: (data['videos'] as List<dynamic>?)?.map((v) => VideoItem(
        id: v['id'],
        title: v['title'],
        videoUrl: v['videoUrl'],
        isVisible: v['isVisible'] ?? true,
      )).toList() ?? [],
      showTodaysMoodSection: data['showTodaysMoodSection'] ?? true,
      todaysMoodTitle: data['todaysMoodTitle'] ?? 'Today\'s mood',
      todaysMoodSubtitle: data['todaysMoodSubtitle'] ?? 'Discover every look, for every style',
      todaysMoodTitleFontSize: data['todaysMoodTitleFontSize']?.toDouble() ?? 24.0,
      todaysMoodTitleFontFamily: data['todaysMoodTitleFontFamily'] ?? 'Cursive',
      todaysMoodSubtitleFontSize: data['todaysMoodSubtitleFontSize']?.toDouble() ?? 16.0,
      todaysMoodSubtitleFontFamily: data['todaysMoodSubtitleFontFamily'] ?? 'Roboto',
      todaysMoodButtonText: data['todaysMoodButtonText'] ?? 'Look',
      todaysMoodButtonFontSize: data['todaysMoodButtonFontSize']?.toDouble() ?? 14.0,
      todaysMoodButtonColor: Color(data['todaysMoodButtonColor'] ?? 0xFF333333),
      todaysMoodMenTitle: data['todaysMoodMenTitle'] ?? 'Men',
      todaysMoodWomenTitle: data['todaysMoodWomenTitle'] ?? 'Women',
      mensCategoryCardColor: Color(data['mensCategoryCardColor'] ?? 0xFFE6E6FA),
      womensCategoryCardColor: Color(data['womensCategoryCardColor'] ?? 0xFFFFE4E1),
      mensStyleCards: (data['mensStyleCards'] as List<dynamic>?)?.map((s) => StyleCard(
        id: s['id'],
        title: s['title'],
        imagePath: s['imagePath'],
        isVisible: s['isVisible'] ?? true,
      )).toList() ?? [],
      womensStyleCards: (data['womensStyleCards'] as List<dynamic>?)?.map((s) => StyleCard(
        id: s['id'],
        title: s['title'],
        imagePath: s['imagePath'],
        isVisible: s['isVisible'] ?? true,
      )).toList() ?? [],
      showMostLovedSection: data['showMostLovedSection'] ?? true,
      mostLovedTitle: data['mostLovedTitle'] ?? 'Most Loved',
      mostLovedSubtitle: data['mostLovedSubtitle'] ?? 'Customers favourite listed every 15 days',
      mostLovedTitleFontSize: data['mostLovedTitleFontSize']?.toDouble() ?? 24.0,
      mostLovedTitleFontFamily: data['mostLovedTitleFontFamily'] ?? 'Roboto',
      mostLovedSubtitleFontSize: data['mostLovedSubtitleFontSize']?.toDouble() ?? 16.0,
      mostLovedSubtitleFontFamily: data['mostLovedSubtitleFontFamily'] ?? 'Roboto',
      mostLovedProducts: (data['mostLovedProducts'] as List<dynamic>?)?.map((p) => ProductItem(
        id: p['id'],
        title: p['title'],
        imagePath: p['imagePath'],
        isVisible: p['isVisible'] ?? true,
      )).toList() ?? [],
      showInstagramShowcase: data['showInstagramShowcase'] ?? true,
      instagramShowcaseTitle: data['instagramShowcaseTitle'] ?? 'Follow Us',
      instagramShowcaseSubtitle: data['instagramShowcaseSubtitle'] ?? 'Stay updated with our latest collections and offers',
      instagramShowcaseTitleFontSize: data['instagramShowcaseTitleFontSize']?.toDouble() ?? 24.0,
      instagramShowcaseTitleFontFamily: data['instagramShowcaseTitleFontFamily'] ?? 'Roboto',
      instagramShowcaseSubtitleFontSize: data['instagramShowcaseSubtitleFontSize']?.toDouble() ?? 16.0,
      instagramShowcaseSubtitleFontFamily: data['instagramShowcaseSubtitleFontFamily'] ?? 'Roboto',
      instagramItems: (data['instagramItems'] as List<dynamic>?)?.map((i) => InstagramItem(
        id: i['id'],
        title: i['title'],
        imagePath: i['imagePath'],
        videoUrl: i['videoUrl'],
        itemType: i['itemType'],
        isVisible: i['isVisible'] ?? true,
      )).toList() ?? [],
      showVideoCategories: data['showVideoCategories'] ?? true,
      videoCategoriesTitle: data['videoCategoriesTitle'] ?? 'Video Categories',
      videoCategoriesSubtitle: data['videoCategoriesSubtitle'] ?? 'Explore our video content by category',
      videoCategoriesTitleFontSize: data['videoCategoriesTitleFontSize']?.toDouble() ?? 24.0,
      videoCategoriesTitleFontFamily: data['videoCategoriesTitleFontFamily'] ?? 'Roboto',
      videoCategoriesSubtitleFontSize: data['videoCategoriesSubtitleFontSize']?.toDouble() ?? 16.0,
      videoCategoriesSubtitleFontFamily: data['videoCategoriesSubtitleFontFamily'] ?? 'Roboto',
      videoCategories: (data['videoCategories'] as List<dynamic>?)?.map((c) => VideoCategoryItem(
        id: c['id'],
        title: c['title'],
        videoUrl: c['videoUrl'],
        isVisible: c['isVisible'] ?? true,
      )).toList() ?? [],
    );
  }

  // Header customization methods
  void updateHeaderBackgroundColor(Color color) {
    state = state.copyWith(headerBackgroundColor: color);
    _saveCustomizationData();
  }

  void updateHeaderTextColor(Color color) {
    state = state.copyWith(headerTextColor: color);
    _saveCustomizationData();
  }

  void updateHeaderIconColor(Color color) {
    state = state.copyWith(headerIconColor: color);
    _saveCustomizationData();
  }

  void updateHeaderIconSize(double size) {
    state = state.copyWith(headerIconSize: size);
    _saveCustomizationData();
  }

  void toggleHeaderLogo(bool value) {
    state = state.copyWith(showHeaderLogo: value);
    _saveCustomizationData();
  }

  void toggleHeaderIcons(bool value) {
    state = state.copyWith(showHeaderIcons: value);
    _saveCustomizationData();
  }

  // Banner customization methods
  void togglePromotionalBanner(bool value) {
    state = state.copyWith(showPromotionalBanner: value);
    _saveCustomizationData();
  }

  void updatePromotionalBannerText(String text) {
    state = state.copyWith(promotionalBannerText: text);
    _saveCustomizationData();
  }

  void updatePromotionalBannerBackgroundColor(Color color) {
    state = state.copyWith(promotionalBannerBackgroundColor: color);
    _saveCustomizationData();
  }

  void updatePromotionalBannerTextColor(Color color) {
    state = state.copyWith(promotionalBannerTextColor: color);
    _saveCustomizationData();
  }

  void updatePromotionalBannerFontSize(double size) {
    state = state.copyWith(promotionalBannerFontSize: size);
    _saveCustomizationData();
  }

  void updatePromotionalBannerFontFamily(String family) {
    state = state.copyWith(promotionalBannerFontFamily: family);
    _saveCustomizationData();
  }

  // Collections customization methods
  void updateCollectionsSectionTitle(String title) {
    state = state.copyWith(collectionsSectionTitle: title);
    _saveCustomizationData();
  }

  void updateCollectionsSectionTitleFontSize(double size) {
    state = state.copyWith(collectionsSectionTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateCollectionsSectionTitleFontFamily(String family) {
    state = state.copyWith(collectionsSectionTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateCollection(String id, CollectionItem updatedCollection) {
    var updatedCollections = state.collections.map((collection) {
      return collection.id == id ? updatedCollection : collection;
    }).toList();
    state = state.copyWith(collections: updatedCollections);
    _saveCustomizationData();
  }

  void addCollection(CollectionItem collection) {
    var updatedCollections = List<CollectionItem>.from(state.collections)..add(collection);
    state = state.copyWith(collections: updatedCollections);
    _saveCustomizationData();
  }

  void removeCollection(String id) {
    var updatedCollections = state.collections.where((collection) => collection.id != id).toList();
    state = state.copyWith(collections: updatedCollections);
    _saveCustomizationData();
  }

  void toggleCollectionVisibility(String id, bool isVisible) {
    var updatedCollections = state.collections.map((collection) {
      return collection.id == id ? collection.copyWith(isVisible: isVisible) : collection;
    }).toList();
    state = state.copyWith(collections: updatedCollections);
    _saveCustomizationData();
  }

  // Product categories customization methods
  void updateProductCategory(String id, ProductCategory updatedCategory) {
    var updatedProductCategories = state.productCategories.map((category) {
      return category.id == id ? updatedCategory : category;
    }).toList();
    state = state.copyWith(productCategories: updatedProductCategories);
    _saveCustomizationData();
  }

  void toggleProductCategoryVisibility(String id, bool isVisible) {
    var updatedProductCategories = state.productCategories.map((category) {
      return category.id == id ? category.copyWith(isVisible: isVisible) : category;
    }).toList();
    state = state.copyWith(productCategories: updatedProductCategories);
    _saveCustomizationData();
  }

  void updateProductCategoriesSectionTitle(String title) {
    state = state.copyWith(productCategoriesSectionTitle: title);
    _saveCustomizationData();
  }

  void updateProductCategoriesSectionTitleFontSize(double size) {
    state = state.copyWith(productCategoriesSectionTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateProductCategoriesSectionTitleFontFamily(String family) {
    state = state.copyWith(productCategoriesSectionTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateProductCategories(List<ProductCategory> categories) {
    state = state.copyWith(productCategories: categories);
    _saveCustomizationData();
  }

  // Eyeglasses section font customization
  void updateEyeglassesSectionFontSize(double size) {
    state = state.copyWith(eyeglassesSectionFontSize: size);
    _saveCustomizationData();
  }

  void updateEyeglassesSectionFontFamily(String family) {
    state = state.copyWith(eyeglassesSectionFontFamily: family);
    _saveCustomizationData();
  }

  // Video carousel methods
  void toggleVideoCarousel(bool show) {
    state = state.copyWith(showVideoCarousel: show);
    _saveCustomizationData();
  }

  void updateVideoCarouselTitle(String title) {
    state = state.copyWith(videoCarouselTitle: title);
    _saveCustomizationData();
  }

  void updateVideoCarouselSubtitle(String subtitle) {
    state = state.copyWith(videoCarouselSubtitle: subtitle);
    _saveCustomizationData();
  }

  void updateVideoCarouselTitleFontSize(double fontSize) {
    state = state.copyWith(videoCarouselTitleFontSize: fontSize);
    _saveCustomizationData();
  }

  void updateVideoCarouselTitleFontFamily(String fontFamily) {
    state = state.copyWith(videoCarouselTitleFontFamily: fontFamily);
    _saveCustomizationData();
  }

  void updateVideoCarouselSubtitleFontSize(double fontSize) {
    state = state.copyWith(videoCarouselSubtitleFontSize: fontSize);
    _saveCustomizationData();
  }

  void updateVideoCarouselSubtitleFontFamily(String fontFamily) {
    state = state.copyWith(videoCarouselSubtitleFontFamily: fontFamily);
    _saveCustomizationData();
  }

  void addVideo(VideoItem video) {
    final updatedVideos = List<VideoItem>.from(state.videos)..add(video);
    state = state.copyWith(videos: updatedVideos);
    _saveCustomizationData();
  }

  void removeVideo(String videoId) {
    final updatedVideos = state.videos.where((video) => video.id != videoId).toList();
    state = state.copyWith(videos: updatedVideos);
    _saveCustomizationData();
  }

  void updateVideo(VideoItem updatedVideo) {
    final updatedVideos = state.videos.map((video) {
      return video.id == updatedVideo.id ? updatedVideo : video;
    }).toList();
    state = state.copyWith(videos: updatedVideos);
    _saveCustomizationData();
  }

  void toggleVideoVisibility(String videoId) {
    final updatedVideos = state.videos.map((video) {
      if (video.id == videoId) {
        return video.copyWith(isVisible: !video.isVisible);
      }
      return video;
    }).toList();
    state = state.copyWith(videos: updatedVideos);
    _saveCustomizationData();
  }

  // Today's mood section methods
  void toggleTodaysMoodSection(bool value) {
    state = state.copyWith(showTodaysMoodSection: value);
    _saveCustomizationData();
  }

  void updateTodaysMoodTitle(String title) {
    state = state.copyWith(todaysMoodTitle: title);
    _saveCustomizationData();
  }

  void updateTodaysMoodSubtitle(String subtitle) {
    state = state.copyWith(todaysMoodSubtitle: subtitle);
    _saveCustomizationData();
  }

  void updateTodaysMoodTitleFontSize(double size) {
    state = state.copyWith(todaysMoodTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateTodaysMoodTitleFontFamily(String family) {
    state = state.copyWith(todaysMoodTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateTodaysMoodSubtitleFontSize(double size) {
    state = state.copyWith(todaysMoodSubtitleFontSize: size);
    _saveCustomizationData();
  }

  void updateTodaysMoodSubtitleFontFamily(String family) {
    state = state.copyWith(todaysMoodSubtitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateTodaysMoodButtonText(String text) {
    state = state.copyWith(todaysMoodButtonText: text);
    _saveCustomizationData();
  }

  void updateTodaysMoodButtonFontSize(double size) {
    state = state.copyWith(todaysMoodButtonFontSize: size);
    _saveCustomizationData();
  }

  void updateTodaysMoodButtonColor(Color color) {
    state = state.copyWith(todaysMoodButtonColor: color);
    _saveCustomizationData();
  }

  void updateTodaysMoodMenTitle(String title) {
    state = state.copyWith(todaysMoodMenTitle: title);
    _saveCustomizationData();
  }

  void updateTodaysMoodWomenTitle(String title) {
    state = state.copyWith(todaysMoodWomenTitle: title);
    _saveCustomizationData();
  }

  void updateMensStyleCards(List<StyleCard> cards) {
    state = state.copyWith(mensStyleCards: cards);
    _saveCustomizationData();
  }

  void updateWomensStyleCards(List<StyleCard> cards) {
    state = state.copyWith(womensStyleCards: cards);
    _saveCustomizationData();
  }

  void updateMensCategoryCardColor(Color color) {
    state = state.copyWith(mensCategoryCardColor: color);
    _saveCustomizationData();
  }

  void updateWomensCategoryCardColor(Color color) {
    state = state.copyWith(womensCategoryCardColor: color);
    _saveCustomizationData();
  }

  void updateMostLovedProducts(List<ProductItem> products) {
    state = state.copyWith(mostLovedProducts: products);
    _saveCustomizationData();
  }

  void toggleMostLovedSection(bool value) {
    state = state.copyWith(showMostLovedSection: value);
    _saveCustomizationData();
  }

  void updateMostLovedTitle(String title) {
    state = state.copyWith(mostLovedTitle: title);
    _saveCustomizationData();
  }

  void updateMostLovedSubtitle(String subtitle) {
    state = state.copyWith(mostLovedSubtitle: subtitle);
    _saveCustomizationData();
  }

  void updateMostLovedTitleFontSize(double size) {
    state = state.copyWith(mostLovedTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateMostLovedTitleFontFamily(String family) {
    state = state.copyWith(mostLovedTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateMostLovedSubtitleFontSize(double size) {
    state = state.copyWith(mostLovedSubtitleFontSize: size);
    _saveCustomizationData();
  }

  void updateMostLovedSubtitleFontFamily(String family) {
    state = state.copyWith(mostLovedSubtitleFontFamily: family);
    _saveCustomizationData();
  }

  void addMostLovedProduct(ProductItem product) {
    var updatedProducts = List<ProductItem>.from(state.mostLovedProducts)..add(product);
    state = state.copyWith(mostLovedProducts: updatedProducts);
    _saveCustomizationData();
  }

  void removeMostLovedProduct(String id) {
    var updatedProducts = state.mostLovedProducts.where((product) => product.id != id).toList();
    state = state.copyWith(mostLovedProducts: updatedProducts);
    _saveCustomizationData();
  }

  void updateMostLovedProduct(String id, ProductItem updatedProduct) {
    var updatedProducts = state.mostLovedProducts.map((product) {
      return product.id == id ? updatedProduct : product;
    }).toList();
    state = state.copyWith(mostLovedProducts: updatedProducts);
    _saveCustomizationData();
  }

  void toggleMostLovedProductVisibility(String id, bool isVisible) {
    var updatedProducts = state.mostLovedProducts.map((product) {
      return product.id == id ? product.copyWith(isVisible: isVisible) : product;
    }).toList();
    state = state.copyWith(mostLovedProducts: updatedProducts);
    _saveCustomizationData();
  }

  // Instagram Showcase methods
  void toggleInstagramShowcase(bool value) {
    state = state.copyWith(showInstagramShowcase: value);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseTitle(String title) {
    state = state.copyWith(instagramShowcaseTitle: title);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseSubtitle(String subtitle) {
    state = state.copyWith(instagramShowcaseSubtitle: subtitle);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseTitleFontSize(double size) {
    state = state.copyWith(instagramShowcaseTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseTitleFontFamily(String family) {
    state = state.copyWith(instagramShowcaseTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseSubtitleFontSize(double size) {
    state = state.copyWith(instagramShowcaseSubtitleFontSize: size);
    _saveCustomizationData();
  }

  void updateInstagramShowcaseSubtitleFontFamily(String family) {
    state = state.copyWith(instagramShowcaseSubtitleFontFamily: family);
    _saveCustomizationData();
  }

  void addInstagramItem(InstagramItem item) {
    final updatedItems = List<InstagramItem>.from(state.instagramItems)..add(item);
    state = state.copyWith(instagramItems: updatedItems);
    _saveCustomizationData();
  }

  void removeInstagramItem(String itemId) {
    final updatedItems = state.instagramItems.where((item) => item.id != itemId).toList();
    state = state.copyWith(instagramItems: updatedItems);
    _saveCustomizationData();
  }

  void updateInstagramItem(InstagramItem updatedItem) {
    final updatedItems = state.instagramItems.map((item) {
      return item.id == updatedItem.id ? updatedItem : item;
    }).toList();
    state = state.copyWith(instagramItems: updatedItems);
    _saveCustomizationData();
  }

  void toggleInstagramItemVisibility(String itemId, bool isVisible) {
    final updatedItems = state.instagramItems.map((item) {
      return item.id == itemId ? item.copyWith(isVisible: isVisible) : item;
    }).toList();
    state = state.copyWith(instagramItems: updatedItems);
    _saveCustomizationData();
  }

  // Video Categories methods
  void toggleVideoCategories(bool value) {
    state = state.copyWith(showVideoCategories: value);
    _saveCustomizationData();
  }

  void updateVideoCategoriesTitle(String title) {
    state = state.copyWith(videoCategoriesTitle: title);
    _saveCustomizationData();
  }

  void updateVideoCategoriesSubtitle(String subtitle) {
    state = state.copyWith(videoCategoriesSubtitle: subtitle);
    _saveCustomizationData();
  }

  void updateVideoCategoriesTitleFontSize(double size) {
    state = state.copyWith(videoCategoriesTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateVideoCategoriesTitleFontFamily(String family) {
    state = state.copyWith(videoCategoriesTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateVideoCategoriesSubtitleFontSize(double size) {
    state = state.copyWith(videoCategoriesSubtitleFontSize: size);
    _saveCustomizationData();
  }

  void updateVideoCategoriesSubtitleFontFamily(String family) {
    state = state.copyWith(videoCategoriesSubtitleFontFamily: family);
    _saveCustomizationData();
  }

  void addVideoCategory(VideoCategoryItem category) {
    final updatedCategories = List<VideoCategoryItem>.from(state.videoCategories)..add(category);
    state = state.copyWith(videoCategories: updatedCategories);
    _saveCustomizationData();
  }

  void removeVideoCategory(String categoryId) {
    final updatedCategories = state.videoCategories.where((category) => category.id != categoryId).toList();
    state = state.copyWith(videoCategories: updatedCategories);
    _saveCustomizationData();
  }

  void updateVideoCategory(String id, VideoCategoryItem updatedCategory) {
    final updatedCategories = state.videoCategories.map((category) {
      return category.id == id ? updatedCategory : category;
    }).toList();
    state = state.copyWith(videoCategories: updatedCategories);
    _saveCustomizationData();
  }

  void toggleVideoCategoryVisibility(String id, bool isVisible) {
    final updatedCategories = state.videoCategories.map((category) {
      return category.id == id ? category.copyWith(isVisible: isVisible) : category;
    }).toList();
    state = state.copyWith(videoCategories: updatedCategories);
    _saveCustomizationData();
  }

  // Product Category Cards customization methods
  void toggleProductCategoryCards(bool value) {
    state = state.copyWith(showProductCategoryCards: value);
    _saveCustomizationData();
  }

  void updateProductCategoryCardsTitle(String title) {
    state = state.copyWith(productCategoryCardsTitle: title);
    _saveCustomizationData();
  }

  void updateProductCategoryCardsTitleFontSize(double size) {
    state = state.copyWith(productCategoryCardsTitleFontSize: size);
    _saveCustomizationData();
  }

  void updateProductCategoryCardsTitleFontFamily(String family) {
    state = state.copyWith(productCategoryCardsTitleFontFamily: family);
    _saveCustomizationData();
  }

  void updateEyeglassesCategoryCards(List<CategoryCard> cards) {
    state = state.copyWith(eyeglassesCategoryCards: cards);
    _saveCustomizationData();
  }

  void updateSunglassesCategoryCards(List<CategoryCard> cards) {
    state = state.copyWith(sunglassesCategoryCards: cards);
    _saveCustomizationData();
  }

  void updateEyeglassesCategoryCard(String id, CategoryCard updatedCard) {
    var updatedEyeglassesCards = state.eyeglassesCategoryCards.map((card) {
      return card.id == id ? updatedCard : card;
    }).toList();
    state = state.copyWith(eyeglassesCategoryCards: updatedEyeglassesCards);
    _saveCustomizationData();
  }

  void updateSunglassesCategoryCard(String id, CategoryCard updatedCard) {
    var updatedSunglassesCards = state.sunglassesCategoryCards.map((card) {
      return card.id == id ? updatedCard : card;
    }).toList();
    state = state.copyWith(sunglassesCategoryCards: updatedSunglassesCards);
    _saveCustomizationData();
  }

  void addEyeglassesCategoryCard(CategoryCard card) {
    var updatedEyeglassesCards = List<CategoryCard>.from(state.eyeglassesCategoryCards)..add(card);
    state = state.copyWith(eyeglassesCategoryCards: updatedEyeglassesCards);
    _saveCustomizationData();
  }

  void addSunglassesCategoryCard(CategoryCard card) {
    var updatedSunglassesCards = List<CategoryCard>.from(state.sunglassesCategoryCards)..add(card);
    state = state.copyWith(sunglassesCategoryCards: updatedSunglassesCards);
    _saveCustomizationData();
  }

  void removeEyeglassesCategoryCard(String id) {
    var updatedEyeglassesCards = state.eyeglassesCategoryCards.where((card) => card.id != id).toList();
    state = state.copyWith(eyeglassesCategoryCards: updatedEyeglassesCards);
    _saveCustomizationData();
  }

  void removeSunglassesCategoryCard(String id) {
    var updatedSunglassesCards = state.sunglassesCategoryCards.where((card) => card.id != id).toList();
    state = state.copyWith(sunglassesCategoryCards: updatedSunglassesCards);
    _saveCustomizationData();
  }

  void toggleEyeglassesCategoryCardVisibility(String id, bool isVisible) {
    var updatedEyeglassesCards = state.eyeglassesCategoryCards.map((card) {
      return card.id == id ? card.copyWith(isVisible: isVisible) : card;
    }).toList();
    state = state.copyWith(eyeglassesCategoryCards: updatedEyeglassesCards);
    _saveCustomizationData();
  }

  void toggleSunglassesCategoryCardVisibility(String id, bool isVisible) {
    var updatedSunglassesCards = state.sunglassesCategoryCards.map((card) {
      return card.id == id ? card.copyWith(isVisible: isVisible) : card;
    }).toList();
    state = state.copyWith(sunglassesCategoryCards: updatedSunglassesCards);
    _saveCustomizationData();
  }

  void resetToDefault() {
    state = HeaderCustomizationState(
      showPromotionalBanner: false,
      promotionalBannerText: '',
      promotionalBannerBackgroundColor: Colors.transparent,
      promotionalBannerTextColor: Colors.black,
      promotionalBannerFontSize: 16.0,
      promotionalBannerFontFamily: 'Roboto',
      headerBackgroundColor: const Color(0xFF1E2A3A),
      headerTextColor: Colors.white,
      headerIconColor: Colors.white,
      headerIconSize: 24.0,
      showHeaderLogo: true,
      showHeaderIcons: true,
      collectionsSectionTitle: 'Collections to Explore',
      collectionsSectionTitleFontSize: 24.0,
      collectionsSectionTitleFontFamily: 'Roboto',
      collections: [
        CollectionItem(
          id: 'collection1',
          title: 'Ms fierceness...',
          subtitle: 'Fierce and bold eyewear for the confident woman',
          isVisible: true,
        ),
        CollectionItem(
          id: 'collection2',
          title: 'Visionary',
          subtitle: 'Mastering the art of luxury eyewear',
          isVisible: true,
        ),
      ],
      productCategoriesSectionTitle: 'Product Categories',
      productCategoriesSectionTitleFontSize: 24.0,
      productCategoriesSectionTitleFontFamily: 'Roboto',
      productCategories: [
        ProductCategory(id: 'men_eyeglasses', label: 'Men', icon: Icons.person, isVisible: true),
        ProductCategory(id: 'women_eyeglasses', label: 'Women', icon: Icons.person_outline, isVisible: true),
        ProductCategory(id: 'kids_eyeglasses', label: 'Kids', icon: Icons.child_care, isVisible: true),
        ProductCategory(id: 'essentials_eyeglasses', label: 'Essentials', icon: Icons.style, isVisible: true),
      ],
      showProductCategoryCards: true,
      productCategoryCardsTitle: 'Eyeglasses & Sunglasses',
      productCategoryCardsTitleFontSize: 24.0,
      productCategoryCardsTitleFontFamily: 'Roboto',
      eyeglassesCategoryCards: [
        CategoryCard(id: 'men_eyeglasses', title: 'Men', icon: Icons.person, isVisible: true),
        CategoryCard(id: 'women_eyeglasses', title: 'Women', icon: Icons.person_outline, isVisible: true),
        CategoryCard(id: 'kids_eyeglasses', title: 'Kids', icon: Icons.child_care, isVisible: true),
        CategoryCard(id: 'essentials_eyeglasses', title: 'Essentials', icon: Icons.style, isVisible: true),
      ],
      sunglassesCategoryCards: [
        CategoryCard(id: 'sunglasses', title: 'Sunglasses', icon: Icons.sunny, isVisible: true),
        CategoryCard(id: 'kids_sunglasses', title: 'Kids Sunglasses', icon: Icons.child_care, isVisible: true),
        CategoryCard(id: 'essentials_sunglasses', title: 'Essentials', icon: Icons.style, isVisible: true),
      ],
      eyeglassesSectionFontSize: 24.0,
      eyeglassesSectionFontFamily: 'Roboto',
      showVideoCarousel: true,
      videoCarouselTitle: 'Watch Our Story',
      videoCarouselSubtitle: 'Discover how we started and where we are going',
      videoCarouselTitleFontSize: 36.0,
      videoCarouselTitleFontFamily: 'Roboto',
      videoCarouselSubtitleFontSize: 18.0,
      videoCarouselSubtitleFontFamily: 'Roboto',
      videos: [],
      showTodaysMoodSection: true,
      todaysMoodTitle: 'Today\'s mood',
      todaysMoodSubtitle: 'Discover every look, for every style',
      todaysMoodTitleFontSize: 24.0,
      todaysMoodTitleFontFamily: 'Cursive',
      todaysMoodSubtitleFontSize: 16.0,
      todaysMoodSubtitleFontFamily: 'Roboto',
      todaysMoodButtonText: 'Look',
      todaysMoodButtonFontSize: 14.0,
      todaysMoodButtonColor: const Color(0xFF333333),
      todaysMoodMenTitle: 'Men',
      todaysMoodWomenTitle: 'Women',
      mensCategoryCardColor: const Color(0xFFE6E6FA),
      womensCategoryCardColor: const Color(0xFFFFE4E1),
      mensStyleCards: [
        StyleCard(id: 'mens_style1', title: 'CEO Look', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        StyleCard(id: 'mens_style2', title: 'Casual Wear', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        StyleCard(id: 'mens_style3', title: 'Athletic L', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
      ],
      womensStyleCards: [
        StyleCard(id: 'womens_style1', title: 'Boss Lady', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        StyleCard(id: 'womens_style2', title: 'Glam Queen', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        StyleCard(id: 'womens_style3', title: 'Athletic L', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
      ],
      showMostLovedSection: true,
      mostLovedTitle: 'Most Loved',
      mostLovedSubtitle: 'Customers favourite listed every 15 days',
      mostLovedTitleFontSize: 24.0,
      mostLovedTitleFontFamily: 'Roboto',
      mostLovedSubtitleFontSize: 16.0,
      mostLovedSubtitleFontFamily: 'Roboto',
      mostLovedProducts: [
        ProductItem(id: 'product1', title: 'RICKER', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        ProductItem(id: 'product2', title: 'COMMANDER', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
        ProductItem(id: 'product3', title: 'ARISTO', imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200', isVisible: true),
      ],
      showInstagramShowcase: true,
      instagramShowcaseTitle: 'Follow Us',
      instagramShowcaseSubtitle: 'Stay updated with our latest collections and offers',
      instagramShowcaseTitleFontSize: 24.0,
      instagramShowcaseTitleFontFamily: 'Roboto',
      instagramShowcaseSubtitleFontSize: 16.0,
      instagramShowcaseSubtitleFontFamily: 'Roboto',
      instagramItems: [],
      showVideoCategories: true,
      videoCategoriesTitle: 'Video Categories',
      videoCategoriesSubtitle: 'Explore our video content by category',
      videoCategoriesTitleFontSize: 24.0,
      videoCategoriesTitleFontFamily: 'Roboto',
      videoCategoriesSubtitleFontSize: 16.0,
      videoCategoriesSubtitleFontFamily: 'Roboto',
      videoCategories: [
        VideoCategoryItem(id: 'pilot_videos', title: 'PILOT', videoUrl: 'https://goeye.in/cdn/shop/files/final_pilot.gif?v=1753091621?retry=1', isVisible: true),
        VideoCategoryItem(id: 'zflex_videos', title: 'Z-FLEX', videoUrl: 'https://goeye.in/cdn/shop/files/final_zflex.gif?v=1753091621?retry=1', isVisible: true),
        VideoCategoryItem(id: 'active_videos', title: 'ACTIVE', videoUrl: 'https://goeye.in/cdn/shop/files/final_active.gif?v=1753091621?retry=1', isVisible: true),
        VideoCategoryItem(id: 'glam_videos', title: 'GLAM', videoUrl: 'https://goeye.in/cdn/shop/files/final_glam.gif?v=1753091621?retry=1', isVisible: true),
        VideoCategoryItem(id: 'clipon_videos', title: 'CLIP-ON', videoUrl: 'https://goeye.in/cdn/shop/files/final_clipon.gif?v=1753091621?retry=1', isVisible: true),
        VideoCategoryItem(id: 'air_videos', title: 'AIR', videoUrl: 'https://goeye.in/cdn/shop/files/final_air.gif?v=1753091621?retry=1', isVisible: true),
      ],
    );
    _saveCustomizationData();
  }

  // Clear all saved customization data
  Future<void> clearSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('header_customization_data');
    } catch (e) {
      print('Error clearing saved data: $e');
    }
  }
}

// Provider
final headerCustomizationProvider = StateNotifierProvider<HeaderCustomizationNotifier, HeaderCustomizationState>((ref) {
  return HeaderCustomizationNotifier();
});
