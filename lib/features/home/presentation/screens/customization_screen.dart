import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/header_customization_provider.dart';

class CustomizationScreen extends ConsumerStatefulWidget {
  const CustomizationScreen({super.key});

  @override
  ConsumerState<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends ConsumerState<CustomizationScreen> {
  @override
  Widget build(BuildContext context) {
    final headerState = ref.watch(headerCustomizationProvider);
    final notifier = ref.read(headerCustomizationProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with reset button
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Customization Panel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Reset All Customizations'),
                            content: const Text('Are you sure you want to reset all customizations to default? This action cannot be undone.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  notifier.resetToDefault();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('All customizations have been reset to default!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Reset All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Header preview
              _buildHeaderPreview(headerState),
              const SizedBox(height: 24),

              // Customization Sections
              _buildBannerCustomization(headerState, notifier),
              const SizedBox(height: 24),

              _buildHeaderCustomization(headerState, notifier),
              const SizedBox(height: 24),

              _buildCollectionsCustomization(headerState, notifier),
              const SizedBox(height: 24),
              
              // Category Cards Customization
              _buildCategoryCardsCustomization(headerState, notifier),
              const SizedBox(height: 24),
              
              _buildVideoCarouselCustomization(headerState, notifier),
              const SizedBox(height: 20),
              
              // Today's Mood Customization
              _buildTodaysMoodCustomization(headerState, notifier),
              
              // Most Loved customization
              _buildMostLovedCustomization(headerState, notifier),
              const SizedBox(height: 24),
              
              // Instagram Showcase customization
              _buildInstagramShowcaseCustomization(headerState, notifier),
              const SizedBox(height: 24),

              // Video Categories customization
              _buildVideoCategoriesCustomization(headerState, notifier),
              const SizedBox(height: 24),

              _buildProductCategoriesCustomization(headerState, notifier),
              const SizedBox(height: 24),

              _buildActionButtons(notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderPreview(HeaderCustomizationState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          if (state.showPromotionalBanner) _buildPromotionalBanner(state),
          _buildHeader(state),
        ],
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

  Widget _buildHeader(HeaderCustomizationState state) {
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
          _buildActionIcon(Icons.favorite_border),
          const SizedBox(width: 8),
          _buildActionIcon(Icons.person_outline),
          const SizedBox(width: 8),
          _buildActionIcon(Icons.shopping_cart_outlined),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Search products...',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Color(0xFF666666),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Promotional Banner',
      [
        _buildToggleSwitch(
          'Show Banner',
          state.showPromotionalBanner,
          (value) => notifier.togglePromotionalBanner(value),
        ),
        if (state.showPromotionalBanner) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Banner Text',
            state.promotionalBannerText,
            (value) => notifier.updatePromotionalBannerText(value),
          ),
          const SizedBox(height: 12),
          _buildColorSection(
            'Banner Background',
            state.promotionalBannerBackgroundColor,
            (color) => notifier.updatePromotionalBannerBackgroundColor(color),
          ),
          const SizedBox(height: 12),
          _buildColorSection(
            'Banner Text Color',
            state.promotionalBannerTextColor,
            (color) => notifier.updatePromotionalBannerTextColor(color),
          ),
        ],
      ],
    );
  }

  Widget _buildHeaderCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Header Customization',
      [
        _buildColorSection(
          'Header Background',
          state.headerBackgroundColor,
          (color) => notifier.updateHeaderBackgroundColor(color),
        ),
        const SizedBox(height: 12),
        _buildColorSection(
          'Header Text Color',
          state.headerTextColor,
          (color) => notifier.updateHeaderTextColor(color),
        ),
        const SizedBox(height: 12),
        _buildColorSection(
          'Header Icon Color',
          state.headerIconColor,
          (color) => notifier.updateHeaderIconColor(color),
        ),
        const SizedBox(height: 12),
        _buildToggleSwitch('Show Header Logo', state.showHeaderLogo, (value) => notifier.toggleHeaderLogo(value)),
        _buildToggleSwitch('Show Header Icons', state.showHeaderIcons, (value) => notifier.toggleHeaderIcons(value)),
      ],
    );
  }

  Widget _buildCollectionsCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Collections Section',
      [
        _buildTextField(
          'Section Title',
          state.collectionsSectionTitle,
          (value) => notifier.updateCollectionsSectionTitle(value),
        ),
        const SizedBox(height: 12),
        _buildFontSizeSlider(
          'Title Font Size',
          state.collectionsSectionTitleFontSize,
          (value) => notifier.updateCollectionsSectionTitleFontSize(value),
        ),
        const SizedBox(height: 12),
        _buildFontFamilyDropdown(
          'Title Font Family',
          state.collectionsSectionTitleFontFamily,
          (value) => notifier.updateCollectionsSectionTitleFontFamily(value),
        ),
        const SizedBox(height: 20),
        
        // Collections list
        const Text(
          'Collections',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        ...state.collections.map((collection) => _buildCollectionItem(collection, notifier)).toList(),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => _addNewCollection(notifier),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Collection'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
          ),
        ),
        const SizedBox(height: 20),
        
        // Eyeglasses Section Title Font
        const Text(
          'Eyeglasses Section Title Font',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        _buildFontSizeSlider(
          'Font Size',
          state.eyeglassesSectionFontSize,
          (value) => notifier.updateEyeglassesSectionFontSize(value),
        ),
        const SizedBox(height: 12),
        _buildFontFamilyDropdown(
          'Font Family',
          state.eyeglassesSectionFontFamily,
          (value) => notifier.updateEyeglassesSectionFontFamily(value),
        ),
      ],
    );
  }

  Widget _buildCollectionItem(CollectionItem collection, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  collection.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _editCollection(collection, notifier),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () => notifier.removeCollection(collection.id),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Image section for collections
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: collection.imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildSmartImage(collection.imagePath!),
                        )
                      : const Center(
                          child: Icon(
                            Icons.image,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate, size: 20),
                    onPressed: () => _uploadCollectionImage(collection, notifier),
                    tooltip: 'Upload Image',
                  ),
                  if (collection.imagePath != null)
                    IconButton(
                      icon: const Icon(Icons.delete_forever, size: 20, color: Colors.red),
                      onPressed: () => _removeCollectionImage(collection, notifier),
                      tooltip: 'Remove Image',
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildToggleSwitch(
            'Visible',
            collection.isVisible,
            (value) => notifier.toggleCollectionVisibility(collection.id, value),
          ),
        ],
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
              strokeWidth: 2,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image,
              size: 30,
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
              size: 30,
              color: Colors.grey,
            ),
          );
        },
      );
    }
  }

  Widget _buildCategoryCardsCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Category Cards (Eyeglasses & Sunglasses)',
      [
        _buildToggleSwitch(
          'Show Category Cards',
          state.showProductCategoryCards,
          (value) => notifier.toggleProductCategoryCards(value),
        ),
        const SizedBox(height: 12),
        _buildTextField(
          'Section Title',
          state.productCategoryCardsTitle,
          (value) => notifier.updateProductCategoryCardsTitle(value),
        ),
        const SizedBox(height: 12),
        _buildFontSizeSlider(
          'Title Font Size',
          state.productCategoryCardsTitleFontSize,
          (value) => notifier.updateProductCategoryCardsTitleFontSize(value),
        ),
        const SizedBox(height: 12),
        _buildFontFamilyDropdown(
          'Title Font Family',
          state.productCategoryCardsTitleFontFamily,
          (value) => notifier.updateProductCategoryCardsTitleFontFamily(value),
        ),
        const SizedBox(height: 20),
        
        // Eyeglasses Category Cards
        const Text(
          'Eyeglasses Category Cards',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        ...state.eyeglassesCategoryCards.map((card) => _buildCategoryCardItem(card, notifier, 'eyeglasses')).toList(),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => _addNewCategoryCard(notifier, 'eyeglasses'),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Eyeglasses Card'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
          ),
        ),
        const SizedBox(height: 20),
        
        // Sunglasses Category Cards
        const Text(
          'Sunglasses Category Cards',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        ...state.sunglassesCategoryCards.map((card) => _buildCategoryCardItem(card, notifier, 'sunglasses')).toList(),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => _addNewCategoryCard(notifier, 'sunglasses'),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Sunglasses Card'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCardItem(CategoryCard card, HeaderCustomizationNotifier notifier, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  card.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _editCategoryCard(card, notifier, type),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () => type == 'eyeglasses' 
                    ? notifier.removeEyeglassesCategoryCard(card.id)
                    : notifier.removeSunglassesCategoryCard(card.id),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Image section for category cards
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: card.imagePath != null && card.imagePath!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            card.imagePath!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  card.icon ?? Icons.image,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Icon(
                            card.icon ?? Icons.image,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate, size: 20),
                    onPressed: () => _uploadCategoryCardImage(card, notifier, type),
                    tooltip: 'Upload Image',
                  ),
                  if (card.imagePath != null && card.imagePath!.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete_forever, size: 20, color: Colors.red),
                      onPressed: () => _removeCategoryCardImage(card, notifier, type),
                      tooltip: 'Remove Image',
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildToggleSwitch(
            'Visible',
            card.isVisible,
            (value) => type == 'eyeglasses' 
                ? notifier.toggleEyeglassesCategoryCardVisibility(card.id, value)
                : notifier.toggleSunglassesCategoryCardVisibility(card.id, value),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCategoriesCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Product Categories',
      [
        _buildTextField(
          'Section Title',
          state.productCategoriesSectionTitle,
          (value) => notifier.updateProductCategoriesSectionTitle(value),
        ),
        const SizedBox(height: 12),
        _buildFontSizeSlider(
          'Title Font Size',
          state.productCategoriesSectionTitleFontSize,
          (value) => notifier.updateProductCategoriesSectionTitleFontSize(value),
        ),
        const SizedBox(height: 12),
        _buildFontFamilyDropdown(
          'Title Font Family',
          state.productCategoriesSectionTitleFontFamily,
          (value) => notifier.updateProductCategoriesSectionTitleFontFamily(value),
        ),
        const SizedBox(height: 20),
        
        // Product categories list
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        ...state.productCategories.map((category) => _buildCategoryItem(category, notifier)).toList(),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => _addNewCategory(notifier),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Category'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(ProductCategory category, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(category.icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => _editCategory(category, notifier),
              ),
              _buildToggleSwitch(
                'Visible',
                category.isVisible,
                (value) => notifier.toggleProductCategoryVisibility(category.id, value),
                small: true,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Image section for categories
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: category.imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _buildSmartImage(category.imagePath!),
                        )
                      : Center(
                          child: Icon(
                            category.icon,
                            size: 25,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate, size: 16),
                    onPressed: () => _uploadCategoryImage(category, notifier),
                    tooltip: 'Upload Image',
                  ),
                  if (category.imagePath != null)
                    IconButton(
                      icon: const Icon(Icons.delete_forever, size: 16, color: Colors.red),
                      onPressed: () => _removeCategoryImage(category, notifier),
                      tooltip: 'Remove Image',
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleSwitch(String label, bool value, Function(bool) onChanged, {bool small = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: small ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFFFF6B6B),
            activeTrackColor: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSection(String label, Color currentColor, Function(Color) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showColorPicker(currentColor, onChanged),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Icon(
              Icons.color_lens,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(HeaderCustomizationNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => notifier.resetToDefault(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Reset to Default'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveCustomization,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Save Design'),
          ),
        ),
      ],
    );
  }

  void _showColorPicker(Color currentColor, Function(Color) onChanged) {
    final colors = [
      const Color(0xFF1E2A3A),
      const Color(0xFFFF6B6B),
      const Color(0xFFF5F5F5),
      const Color(0xFF333333),
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
      Colors.lime,
      Colors.brown,
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final color = colors[index];
              final isSelected = color == currentColor;
              return GestureDetector(
                onTap: () {
                  onChanged(color);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey[300]!,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _addNewCollection(HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();
    final imagePathController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Collection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', '', (value) => titleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Subtitle', '', (value) => subtitleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Image Path', '', (value) => imagePathController.text = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newCollection = CollectionItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  subtitle: subtitleController.text,
                  imagePath: imagePathController.text,
                );
                notifier.addCollection(newCollection);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addNewCategory(HeaderCustomizationNotifier notifier) {
    final labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Label', '', (value) => labelController.text = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (labelController.text.isNotEmpty) {
                final newCategory = ProductCategory(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  label: labelController.text,
                  icon: Icons.style,
                  isVisible: true,
                );
                // Add to product categories list
                var updatedCategories = List<ProductCategory>.from(notifier.state.productCategories)..add(newCategory);
                notifier.updateProductCategories(updatedCategories);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCollection(CollectionItem collection, HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController(text: collection.title);
    final subtitleController = TextEditingController(text: collection.subtitle);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Collection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedCollection = collection.copyWith(
                  title: titleController.text,
                  subtitle: subtitleController.text,
                );
                notifier.updateCollection(collection.id, updatedCollection);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editCategory(ProductCategory category, HeaderCustomizationNotifier notifier) {
    final labelController = TextEditingController(text: category.label);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: TextField(
          controller: labelController,
          decoration: const InputDecoration(
            labelText: 'Label',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (labelController.text.isNotEmpty) {
                final updatedCategory = category.copyWith(
                  label: labelController.text,
                );
                notifier.updateProductCategory(category.id, updatedCategory);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveCustomization() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Customization saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Image upload and removal methods
  void _uploadCollectionImage(CollectionItem collection, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Collection Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose upload method:'),
            const SizedBox(height: 16),
            // Option 1: URL Input
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showUrlInputDialog(collection, notifier, true);
                },
                icon: const Icon(Icons.link),
                label: const Text('Enter Image URL'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Option 2: File Upload
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showFileUploadDialog(collection, notifier, true);
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _uploadCategoryImage(ProductCategory category, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Category Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose upload method:'),
            const SizedBox(height: 16),
            // Option 1: URL Input
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showUrlInputDialog(category, notifier, false);
                },
                icon: const Icon(Icons.link),
                label: const Text('Enter Image URL'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Option 2: File Upload
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showFileUploadDialog(category, notifier, false);
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showUrlInputDialog(dynamic item, HeaderCustomizationNotifier notifier, bool isCollection) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the URL of the image you want to use:'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'https://example.com/image.jpg',
                border: OutlineInputBorder(),
                labelText: 'Image URL',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: Make sure the URL points to a valid image file (jpg, png, gif, etc.)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                if (isCollection) {
                  final collection = item as CollectionItem;
                  final updatedCollection = collection.copyWith(imagePath: controller.text);
                  notifier.updateCollection(collection.id, updatedCollection);
                } else {
                  final category = item as ProductCategory;
                  final updatedCategory = category.copyWith(imagePath: controller.text);
                  notifier.updateProductCategory(category.id, updatedCategory);
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image URL added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add Image'),
          ),
        ],
      ),
    );
  }

  void _showFileUploadDialog(dynamic item, HeaderCustomizationNotifier notifier, bool isCollection) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Image File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose how to upload your image:'),
            const SizedBox(height: 16),
            // Gallery option
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _selectImageFromGallery(item, notifier, isCollection);
                },
                icon: const Icon(Icons.photo_library),
                label: const Text('Choose from Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Camera option
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _selectImageFromCamera(item, notifier, isCollection);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // File picker option
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _selectImageFromFile(item, notifier, isCollection);
                },
                icon: const Icon(Icons.folder_open),
                label: const Text('Browse Files'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Supported formats: JPG, PNG, GIF, WebP',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _selectImageFromGallery(CollectionItem? collection, HeaderCustomizationNotifier? notifier, bool isCollection) {
    // Simulate gallery selection
    _showImagePathDialog('assets/images/gallery_image.jpg', collection, notifier, isCollection);
  }

  void _selectImageFromCamera(CollectionItem? collection, HeaderCustomizationNotifier? notifier, bool isCollection) {
    // Simulate camera capture
    _showImagePathDialog('assets/images/camera_image.jpg', collection, notifier, isCollection);
  }

  void _selectImageFromFile(CollectionItem? collection, HeaderCustomizationNotifier? notifier, bool isCollection) {
    // Simulate file selection
    _showImagePathDialog('assets/images/file_image.jpg', collection, notifier, isCollection);
  }

  void _showImagePathDialog(String imagePath, CollectionItem? collection, HeaderCustomizationNotifier? notifier, bool isCollection) {
    final controller = TextEditingController(text: imagePath);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image Path'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selected image path:'),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter image path or URL',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (isCollection && collection != null && notifier != null) {
                final updatedCollection = collection.copyWith(imagePath: controller.text);
                notifier.updateCollection(collection.id, updatedCollection);
              }
              Navigator.pop(context);
            },
            child: const Text('Use'),
          ),
        ],
      ),
    );
  }

  void _removeCollectionImage(CollectionItem collection, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Image'),
        content: const Text('Are you sure you want to remove this image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCollection = collection.copyWith(imagePath: null);
              notifier.updateCollection(collection.id, updatedCollection);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _removeCategoryImage(ProductCategory category, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Image'),
        content: const Text('Are you sure you want to remove this image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCategory = category.copyWith(imagePath: null);
              notifier.updateProductCategory(category.id, updatedCategory);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(1)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: 12.0,
          max: 48.0,
          divisions: 36,
          label: value.toStringAsFixed(1),
          onChanged: onChanged,
          activeColor: const Color(0xFFFF6B6B),
        ),
      ],
    );
  }

  Widget _buildFontFamilyDropdown(String label, String value, Function(String) onChanged) {
    final fontFamilies = [
      'Roboto',
      'Arial',
      'Helvetica',
      'Times New Roman',
      'Georgia',
      'Verdana',
      'Courier New',
      'Impact',
      'Comic Sans MS',
      'Trebuchet MS',
      'Cursive',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: fontFamilies.map((font) {
            return DropdownMenuItem<String>(
              value: font,
              child: Text(
                font,
                style: TextStyle(fontFamily: font),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildVideoCarouselCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Video Carousel Section',
      [
        _buildToggleSwitch(
          'Show Video Carousel',
          state.showVideoCarousel,
          (value) => notifier.toggleVideoCarousel(value),
        ),
        if (state.showVideoCarousel) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Section Title',
            state.videoCarouselTitle,
            (value) => notifier.updateVideoCarouselTitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Title Font Size',
            state.videoCarouselTitleFontSize,
            (value) => notifier.updateVideoCarouselTitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Title Font Family',
            state.videoCarouselTitleFontFamily,
            (value) => notifier.updateVideoCarouselTitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Section Subtitle',
            state.videoCarouselSubtitle,
            (value) => notifier.updateVideoCarouselSubtitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Subtitle Font Size',
            state.videoCarouselSubtitleFontSize,
            (value) => notifier.updateVideoCarouselSubtitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Subtitle Font Family',
            state.videoCarouselSubtitleFontFamily,
            (value) => notifier.updateVideoCarouselSubtitleFontFamily(value),
          ),
          const SizedBox(height: 16),
          _buildVideosList(state, notifier),
        ],
      ],
    );
  }

  Widget _buildVideosList(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Videos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton.icon(
              onPressed: () => _addNewVideo(notifier),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Video'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF6B6B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (state.videos.isEmpty)
          const Text(
            'No videos added yet. Click "Add Video" to add your first video.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        else
          ...state.videos.map((video) => _buildVideoItem(video, notifier)).toList(),
      ],
    );
  }

  Widget _buildVideoItem(VideoItem video, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  video.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(
                  video.isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 16,
                ),
                onPressed: () => notifier.toggleVideoVisibility(video.id),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => _editVideo(video, notifier),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                onPressed: () => _removeVideo(video.id, notifier),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Video URL: ${video.videoUrl}', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _addNewVideo(HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController();
    final videoUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', '', (value) => titleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Video URL', '', (value) => videoUrlController.text = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newVideo = VideoItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  videoUrl: videoUrlController.text,
                );
                notifier.addVideo(newVideo);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editVideo(VideoItem video, HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController(text: video.title);
    final videoUrlController = TextEditingController(text: video.videoUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', video.title, (value) => titleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Video URL', video.videoUrl, (value) => videoUrlController.text = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedVideo = video.copyWith(
                  title: titleController.text,
                  videoUrl: videoUrlController.text,
                );
                notifier.updateVideo(updatedVideo);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removeVideo(String videoId, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Video'),
        content: const Text('Are you sure you want to remove this video?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.removeVideo(videoId);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysMoodCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Today\'s Mood Section',
      [
        _buildToggleSwitch(
          'Show Today\'s Mood Section',
          state.showTodaysMoodSection,
          (value) => notifier.toggleTodaysMoodSection(value),
        ),
        if (state.showTodaysMoodSection) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Section Title',
            state.todaysMoodTitle,
            (value) => notifier.updateTodaysMoodTitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Title Font Size',
            state.todaysMoodTitleFontSize,
            (value) => notifier.updateTodaysMoodTitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Title Font Family',
            state.todaysMoodTitleFontFamily,
            (value) => notifier.updateTodaysMoodTitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Section Subtitle',
            state.todaysMoodSubtitle,
            (value) => notifier.updateTodaysMoodSubtitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Subtitle Font Size',
            state.todaysMoodSubtitleFontSize,
            (value) => notifier.updateTodaysMoodSubtitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Subtitle Font Family',
            state.todaysMoodSubtitleFontFamily,
            (value) => notifier.updateTodaysMoodSubtitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Button Text',
            state.todaysMoodButtonText,
            (value) => notifier.updateTodaysMoodButtonText(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Button Font Size',
            state.todaysMoodButtonFontSize,
            (value) => notifier.updateTodaysMoodButtonFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildColorSection(
            'Button Color',
            state.todaysMoodButtonColor,
            (color) => notifier.updateTodaysMoodButtonColor(color),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Men\'s Category Title',
            state.todaysMoodMenTitle,
            (value) => notifier.updateTodaysMoodMenTitle(value),
          ),
          const SizedBox(height: 12),
          _buildColorSection(
            'Men\'s Category Color',
            state.mensCategoryCardColor,
            (color) => notifier.updateMensCategoryCardColor(color),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Women\'s Category Title',
            state.todaysMoodWomenTitle,
            (value) => notifier.updateTodaysMoodWomenTitle(value),
          ),
          const SizedBox(height: 12),
          _buildColorSection(
            'Women\'s Category Color',
            state.womensCategoryCardColor,
            (color) => notifier.updateWomensCategoryCardColor(color),
          ),
          const SizedBox(height: 20),
          
          // Men's Style Cards
          const Text(
            'Men\'s Style Cards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          _buildStyleCardsList(state.mensStyleCards, notifier, true),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _addNewStyleCard(notifier, true),
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Men\'s Style Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
            ),
          ),
          const SizedBox(height: 20),
          
          // Women's Style Cards
          const Text(
            'Women\'s Style Cards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          _buildStyleCardsList(state.womensStyleCards, notifier, false),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _addNewStyleCard(notifier, false),
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Women\'s Style Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMostLovedCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Most Loved Section',
      [
        _buildToggleSwitch(
          'Show Most Loved Section',
          state.showMostLovedSection,
          (value) => notifier.toggleMostLovedSection(value),
        ),
        if (state.showMostLovedSection) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Section Title',
            state.mostLovedTitle,
            (value) => notifier.updateMostLovedTitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Title Font Size',
            state.mostLovedTitleFontSize,
            (value) => notifier.updateMostLovedTitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Title Font Family',
            state.mostLovedTitleFontFamily,
            (value) => notifier.updateMostLovedTitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Section Subtitle',
            state.mostLovedSubtitle,
            (value) => notifier.updateMostLovedSubtitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Subtitle Font Size',
            state.mostLovedSubtitleFontSize,
            (value) => notifier.updateMostLovedSubtitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Subtitle Font Family',
            state.mostLovedSubtitleFontFamily,
            (value) => notifier.updateMostLovedSubtitleFontFamily(value),
          ),
          const SizedBox(height: 20),
          
          // Products list
          const Text(
            'Most Loved Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          ...state.mostLovedProducts.map((product) => _buildMostLovedProductItem(product, notifier)).toList(),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _addNewMostLovedProduct(notifier),
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Product'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInstagramShowcaseCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Instagram Showcase Section',
      [
        _buildToggleSwitch(
          'Show Instagram Showcase',
          state.showInstagramShowcase,
          (value) => notifier.toggleInstagramShowcase(value),
        ),
        if (state.showInstagramShowcase) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Section Title',
            state.instagramShowcaseTitle,
            (value) => notifier.updateInstagramShowcaseTitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Title Font Size',
            state.instagramShowcaseTitleFontSize,
            (value) => notifier.updateInstagramShowcaseTitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Title Font Family',
            state.instagramShowcaseTitleFontFamily,
            (value) => notifier.updateInstagramShowcaseTitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Section Subtitle',
            state.instagramShowcaseSubtitle,
            (value) => notifier.updateInstagramShowcaseSubtitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Subtitle Font Size',
            state.instagramShowcaseSubtitleFontSize,
            (value) => notifier.updateInstagramShowcaseSubtitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Subtitle Font Family',
            state.instagramShowcaseSubtitleFontFamily,
            (value) => notifier.updateInstagramShowcaseSubtitleFontFamily(value),
          ),
          const SizedBox(height: 16),
          _buildInstagramPostsList(state, notifier),
        ],
      ],
    );
  }

  Widget _buildInstagramPostsList(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Instagram Items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton.icon(
              onPressed: () => _addNewInstagramItem(notifier),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Item'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF6B6B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (state.instagramItems.isEmpty)
          const Text(
            'No Instagram items added yet. Click "Add Item" to add your first item.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        else
          ...state.instagramItems.map((item) => _buildInstagramItemWidget(item, notifier)).toList(),
      ],
    );
  }

  Widget _buildInstagramItemWidget(InstagramItem item, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Type: ${item.itemType.toUpperCase()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  item.isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 16,
                ),
                onPressed: () => notifier.toggleInstagramItemVisibility(item.id, !item.isVisible),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => _editInstagramItem(item, notifier),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                onPressed: () => _removeInstagramItem(item.id, notifier),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (item.itemType == 'image' && item.imagePath != null)
            Text('Image: ${item.imagePath}', style: const TextStyle(fontSize: 12)),
          if (item.itemType == 'video' && item.videoUrl != null)
            Text('Video: ${item.videoUrl}', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _addNewInstagramItem(HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController();
    final imagePathController = TextEditingController();
    final videoUrlController = TextEditingController();
    String selectedItemType = 'image';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Instagram Item'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Title', '', (value) => titleController.text = value),
              const SizedBox(height: 12),
              // Item Type Selection
              Row(
                children: [
                  const Text('Type: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedItemType,
                    items: const [
                      DropdownMenuItem(value: 'image', child: Text('Image')),
                      DropdownMenuItem(value: 'video', child: Text('Video')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedItemType = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (selectedItemType == 'image') ...[
                _buildTextField('Image Path (URL or asset path)', '', (value) => imagePathController.text = value),
              ] else ...[
                _buildTextField('Video URL', '', (value) => videoUrlController.text = value),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showVideoUploadOptions(videoUrlController),
                        icon: const Icon(Icons.upload, size: 16),
                        label: const Text('Upload Video'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B6B),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newItem = InstagramItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  imagePath: selectedItemType == 'image' && imagePathController.text.isNotEmpty 
                      ? imagePathController.text 
                      : null,
                  videoUrl: selectedItemType == 'video' && videoUrlController.text.isNotEmpty 
                      ? videoUrlController.text 
                      : null,
                  itemType: selectedItemType,
                  isVisible: true,
                );
                notifier.addInstagramItem(newItem);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editInstagramItem(InstagramItem item, HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController(text: item.title);
    final imagePathController = TextEditingController(text: item.imagePath ?? '');
    final videoUrlController = TextEditingController(text: item.videoUrl ?? '');
    String selectedItemType = item.itemType;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Instagram Item'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Title', item.title, (value) => titleController.text = value),
              const SizedBox(height: 12),
              // Item Type Selection
              Row(
                children: [
                  const Text('Type: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedItemType,
                    items: const [
                      DropdownMenuItem(value: 'image', child: Text('Image')),
                      DropdownMenuItem(value: 'video', child: Text('Video')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedItemType = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (selectedItemType == 'image') ...[
                _buildTextField('Image Path (URL or asset path)', item.imagePath ?? '', (value) => imagePathController.text = value),
              ] else ...[
                _buildTextField('Video URL', item.videoUrl ?? '', (value) => videoUrlController.text = value),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showVideoUploadOptions(videoUrlController),
                        icon: const Icon(Icons.upload, size: 16),
                        label: const Text('Upload Video'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B6B),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedItem = item.copyWith(
                  title: titleController.text,
                  imagePath: selectedItemType == 'image' && imagePathController.text.isNotEmpty 
                      ? imagePathController.text 
                      : null,
                  videoUrl: selectedItemType == 'video' && videoUrlController.text.isNotEmpty 
                      ? videoUrlController.text 
                      : null,
                  itemType: selectedItemType,
                );
                notifier.updateInstagramItem(updatedItem);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removeInstagramItem(String itemId, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Instagram Item'),
        content: const Text('Are you sure you want to remove this Instagram item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.removeInstagramItem(itemId);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleCardsList(List<StyleCard> styleCards, HeaderCustomizationNotifier notifier, bool isMens) {
    return Column(
      children: styleCards.map((card) => _buildStyleCardItem(card, notifier, isMens)).toList(),
    );
  }

  Widget _buildStyleCardItem(StyleCard card, HeaderCustomizationNotifier notifier, bool isMens) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: ${card.title}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Image: ${card.imagePath ?? 'No image'}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _editStyleCard(card, notifier, isMens),
                    icon: const Icon(Icons.edit, size: 16),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    onPressed: () => _uploadStyleCardImage(card, notifier, isMens),
                    icon: const Icon(Icons.add_photo_alternate, size: 16),
                    tooltip: 'Upload Image',
                  ),
                  if (card.imagePath != null && card.imagePath!.isNotEmpty)
                    IconButton(
                      onPressed: () => _removeStyleCardImage(card, notifier, isMens),
                      icon: const Icon(Icons.delete_forever, size: 16),
                      tooltip: 'Remove Image',
                    ),
                  IconButton(
                    onPressed: () => _removeStyleCard(card.id, notifier, isMens),
                    icon: const Icon(Icons.delete, size: 16),
                    tooltip: 'Remove',
                  ),
                  Switch(
                    value: card.isVisible,
                    onChanged: (value) => _toggleStyleCardVisibility(card.id, value, notifier, isMens),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Image preview section
          if (card.imagePath != null && card.imagePath!.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildSmartImage(card.imagePath!),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _addNewStyleCard(HeaderCustomizationNotifier notifier, bool isMens) {
    final titleController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New ${isMens ? 'Men\'s' : 'Women\'s'} Style Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 16),
              const Text('OR'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Simulate file upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('File upload feature will be implemented in production'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newCard = StyleCard(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  imagePath: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
                  isVisible: true,
                );
                if (isMens) {
                  final updatedCards = List<StyleCard>.from(notifier.state.mensStyleCards)..add(newCard);
                  notifier.updateMensStyleCards(updatedCards);
                } else {
                  final updatedCards = List<StyleCard>.from(notifier.state.womensStyleCards)..add(newCard);
                  notifier.updateWomensStyleCards(updatedCards);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editStyleCard(StyleCard card, HeaderCustomizationNotifier notifier, bool isMens) {
    final titleController = TextEditingController(text: card.title);
    final imageUrlController = TextEditingController(text: card.imagePath ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${isMens ? 'Men\'s' : 'Women\'s'} Style Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 16),
              const Text('OR'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Simulate file upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('File upload feature will be implemented in production'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedCard = card.copyWith(
                  title: titleController.text,
                  imagePath: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
                );
                if (isMens) {
                  final updatedCards = notifier.state.mensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                  notifier.updateMensStyleCards(updatedCards);
                } else {
                  final updatedCards = notifier.state.womensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                  notifier.updateWomensStyleCards(updatedCards);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removeStyleCard(String cardId, HeaderCustomizationNotifier notifier, bool isMens) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Style Card'),
        content: const Text('Are you sure you want to remove this style card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (isMens) {
                final updatedCards = notifier.state.mensStyleCards.where((c) => c.id != cardId).toList();
                notifier.updateMensStyleCards(updatedCards);
              } else {
                final updatedCards = notifier.state.womensStyleCards.where((c) => c.id != cardId).toList();
                notifier.updateWomensStyleCards(updatedCards);
              }
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _toggleStyleCardVisibility(String cardId, bool isVisible, HeaderCustomizationNotifier notifier, bool isMens) {
    if (isMens) {
      final updatedCards = notifier.state.mensStyleCards.map((c) => 
        c.id == cardId ? c.copyWith(isVisible: isVisible) : c
      ).toList();
      notifier.updateMensStyleCards(updatedCards);
    } else {
      final updatedCards = notifier.state.womensStyleCards.map((c) => 
        c.id == cardId ? c.copyWith(isVisible: isVisible) : c
      ).toList();
      notifier.updateWomensStyleCards(updatedCards);
    }
  }

  void _addNewMostLovedProduct(HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController();
    final imagePathController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', '', (value) => titleController.text = value),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Image Path', '', (value) => imagePathController.text = value),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showImageUploadOptions(imagePathController),
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF007BFF)),
                  tooltip: 'Upload Image',
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newProduct = ProductItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  imagePath: imagePathController.text.isNotEmpty ? imagePathController.text : null,
                  isVisible: true,
                );
                notifier.addMostLovedProduct(newProduct);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showImageUploadOptions(TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Upload from URL'),
              onTap: () {
                Navigator.pop(context);
                _showMostLovedUrlInputDialog(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('From Gallery'),
              onTap: () {
                Navigator.pop(context);
                _selectImageFromGallery(null, null, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _selectImageFromCamera(null, null, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('Browse Files'),
              onTap: () {
                Navigator.pop(context);
                _selectImageFromFile(null, null, false);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showMostLovedUrlInputDialog(TextEditingController controller) {
    final urlController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the URL of the image you want to use:'),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'https://example.com/image.jpg',
                labelText: 'Image URL',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: Make sure the URL points to a valid image file (jpg, png, gif, etc.)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isNotEmpty) {
                controller.text = urlController.text;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image URL added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add URL'),
          ),
        ],
      ),
    );
  }

  void _showVideoUploadOptions(TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Upload from URL'),
              onTap: () {
                Navigator.pop(context);
                _showVideoUrlInputDialog(controller);
              },
            ),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Upload from File'),
              onTap: () {
                Navigator.pop(context);
                _selectVideoFromFile(controller);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showVideoUrlInputDialog(TextEditingController controller) {
    final urlController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Video URL'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            hintText: 'Enter video URL (e.g., https://example.com/video.mp4)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isNotEmpty) {
                controller.text = urlController.text;
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _selectVideoFromFile(TextEditingController controller) {
    // Simulate file selection for demo purposes
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Video File'),
        content: const Text('This would open a file picker in a real app. For demo purposes, you can enter a video URL manually.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildMostLovedProductItem(ProductItem product, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    if (product.imagePath != null) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildSmartImage(product.imagePath!),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () => _editMostLovedProduct(product, notifier),
                    icon: const Icon(Icons.edit, size: 20),
                    color: const Color(0xFF007BFF),
                  ),
                  IconButton(
                    onPressed: () => _removeMostLovedProduct(product.id, notifier),
                    icon: const Icon(Icons.delete, size: 20),
                    color: const Color(0xFFFF6B6B),
                  ),
                  Switch(
                    value: product.isVisible,
                    onChanged: (value) => notifier.toggleMostLovedProductVisibility(product.id, value),
                    activeColor: const Color(0xFF007BFF),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editMostLovedProduct(ProductItem product, HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController(text: product.title);
    final imagePathController = TextEditingController(text: product.imagePath ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', product.title, (value) => titleController.text = value),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Image Path', product.imagePath ?? '', (value) => imagePathController.text = value),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showImageUploadOptions(imagePathController),
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF007BFF)),
                  tooltip: 'Upload Image',
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedProduct = product.copyWith(
                  title: titleController.text,
                  imagePath: imagePathController.text.isNotEmpty ? imagePathController.text : null,
                );
                notifier.updateMostLovedProduct(product.id, updatedProduct);
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _removeMostLovedProduct(String id, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Product'),
        content: const Text('Are you sure you want to remove this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.removeMostLovedProduct(id);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCategoriesCustomization(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return _buildSectionCard(
      'Video Categories Section',
      [
        _buildToggleSwitch(
          'Show Video Categories',
          state.showVideoCategories,
          (value) => notifier.toggleVideoCategories(value),
        ),
        if (state.showVideoCategories) ...[
          const SizedBox(height: 12),
          _buildTextField(
            'Section Title',
            state.videoCategoriesTitle,
            (value) => notifier.updateVideoCategoriesTitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Title Font Size',
            state.videoCategoriesTitleFontSize,
            (value) => notifier.updateVideoCategoriesTitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Title Font Family',
            state.videoCategoriesTitleFontFamily,
            (value) => notifier.updateVideoCategoriesTitleFontFamily(value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Section Subtitle',
            state.videoCategoriesSubtitle,
            (value) => notifier.updateVideoCategoriesSubtitle(value),
          ),
          const SizedBox(height: 12),
          _buildFontSizeSlider(
            'Subtitle Font Size',
            state.videoCategoriesSubtitleFontSize,
            (value) => notifier.updateVideoCategoriesSubtitleFontSize(value),
          ),
          const SizedBox(height: 12),
          _buildFontFamilyDropdown(
            'Subtitle Font Family',
            state.videoCategoriesSubtitleFontFamily,
            (value) => notifier.updateVideoCategoriesSubtitleFontFamily(value),
          ),
          const SizedBox(height: 16),
          _buildVideoCategoriesList(state, notifier),
        ],
      ],
    );
  }

  Widget _buildVideoCategoriesList(HeaderCustomizationState state, HeaderCustomizationNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Video Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton.icon(
              onPressed: () => _addNewVideoCategory(notifier),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Category'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF6B6B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (state.videoCategories.isEmpty)
          const Text(
            'No video categories added yet. Click "Add Category" to add your first category.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        else
          ...state.videoCategories.map((category) => _buildVideoCategoryItemWidget(category, notifier)).toList(),
      ],
    );
  }

  Widget _buildVideoCategoryItemWidget(VideoCategoryItem category, HeaderCustomizationNotifier notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  category.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(
                  category.isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 16,
                ),
                onPressed: () => notifier.toggleVideoCategoryVisibility(category.id, !category.isVisible),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => _editVideoCategory(category, notifier),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16),
                onPressed: () => _removeVideoCategory(category.id, notifier),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (category.videoUrl != null)
            Text('Video: ${category.videoUrl}', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _addNewVideoCategory(HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController();
    final videoUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Video Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', '', (value) => titleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Video URL', '', (value) => videoUrlController.text = value),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showVideoUploadOptions(videoUrlController),
                    icon: const Icon(Icons.upload, size: 16),
                    label: const Text('Upload Video'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newCategory = VideoCategoryItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  videoUrl: videoUrlController.text.isNotEmpty ? videoUrlController.text : null,
                  isVisible: true,
                );
                notifier.addVideoCategory(newCategory);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editVideoCategory(VideoCategoryItem category, HeaderCustomizationNotifier notifier) {
    final titleController = TextEditingController(text: category.title);
    final videoUrlController = TextEditingController(text: category.videoUrl ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Video Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', category.title, (value) => titleController.text = value),
            const SizedBox(height: 12),
            _buildTextField('Video URL', category.videoUrl ?? '', (value) => videoUrlController.text = value),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showVideoUploadOptions(videoUrlController),
                    icon: const Icon(Icons.upload, size: 16),
                    label: const Text('Upload Video'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedCategory = category.copyWith(
                  title: titleController.text,
                  videoUrl: videoUrlController.text.isNotEmpty ? videoUrlController.text : null,
                );
                notifier.updateVideoCategory(category.id, updatedCategory);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removeVideoCategory(String categoryId, HeaderCustomizationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Video Category'),
        content: const Text('Are you sure you want to remove this video category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.removeVideoCategory(categoryId);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  // Category Cards Helper Methods
  void _addNewCategoryCard(HeaderCustomizationNotifier notifier, String type) {
    final titleController = TextEditingController();
    final imageUrlController = TextEditingController();
    IconData selectedIcon = Icons.person;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New ${type == 'eyeglasses' ? 'Eyeglasses' : 'Sunglasses'} Category Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Or select an icon:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Icons.person,
                  Icons.person_outline,
                  Icons.child_care,
                  Icons.style,
                  Icons.sunny,
                  Icons.face,
                  Icons.accessibility,
                  Icons.emoji_people,
                ].map((icon) => GestureDetector(
                  onTap: () => selectedIcon = icon,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIcon == icon ? Colors.blue : Colors.grey,
                        width: selectedIcon == icon ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(icon, size: 24),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newCard = CategoryCard(
                  id: '${type}_${DateTime.now().millisecondsSinceEpoch}',
                  title: titleController.text,
                  icon: selectedIcon,
                  imagePath: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
                );
                
                if (type == 'eyeglasses') {
                  notifier.addEyeglassesCategoryCard(newCard);
                } else {
                  notifier.addSunglassesCategoryCard(newCard);
                }
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${type == 'eyeglasses' ? 'Eyeglasses' : 'Sunglasses'} category card added!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCategoryCard(CategoryCard card, HeaderCustomizationNotifier notifier, String type) {
    final titleController = TextEditingController(text: card.title);
    final imageUrlController = TextEditingController(text: card.imagePath ?? '');
    IconData selectedIcon = card.icon ?? Icons.person;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${type == 'eyeglasses' ? 'Eyeglasses' : 'Sunglasses'} Category Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Or select an icon:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Icons.person,
                  Icons.person_outline,
                  Icons.child_care,
                  Icons.style,
                  Icons.sunny,
                  Icons.face,
                  Icons.accessibility,
                  Icons.emoji_people,
                ].map((icon) => GestureDetector(
                  onTap: () => selectedIcon = icon,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIcon == icon ? Colors.blue : Colors.grey,
                        width: selectedIcon == icon ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(icon, size: 24),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedCard = card.copyWith(
                  title: titleController.text,
                  icon: selectedIcon,
                  imagePath: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
                );
                
                if (type == 'eyeglasses') {
                  notifier.updateEyeglassesCategoryCard(card.id, updatedCard);
                } else {
                  notifier.updateSunglassesCategoryCard(card.id, updatedCard);
                }
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${type == 'eyeglasses' ? 'Eyeglasses' : 'Sunglasses'} category card updated!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _uploadCategoryCardImage(CategoryCard card, HeaderCustomizationNotifier notifier, String type) {
    final imageUrlController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter image URL:'),
            const SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
                hintText: 'https://example.com/image.jpg',
              ),
            ),
            const SizedBox(height: 16),
            const Text('OR'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Simulate file upload
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File upload feature will be implemented in production'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (imageUrlController.text.isNotEmpty) {
                final updatedCard = card.copyWith(imagePath: imageUrlController.text);
                
                if (type == 'eyeglasses') {
                  notifier.updateEyeglassesCategoryCard(card.id, updatedCard);
                } else {
                  notifier.updateSunglassesCategoryCard(card.id, updatedCard);
                }
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _removeCategoryCardImage(CategoryCard card, HeaderCustomizationNotifier notifier, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Image'),
        content: const Text('Are you sure you want to remove this image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCard = card.copyWith(imagePath: null);
              
              if (type == 'eyeglasses') {
                notifier.updateEyeglassesCategoryCard(card.id, updatedCard);
              } else {
                notifier.updateSunglassesCategoryCard(card.id, updatedCard);
              }
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image removed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  // Style Cards Image Upload Helper Methods
  void _uploadStyleCardImage(StyleCard card, HeaderCustomizationNotifier notifier, bool isMens) {
    final imageUrlController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter image URL:'),
            const SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
                hintText: 'https://example.com/image.jpg',
              ),
            ),
            const SizedBox(height: 16),
            const Text('OR'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Simulate file upload
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File upload feature will be implemented in production'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (imageUrlController.text.isNotEmpty) {
                final updatedCard = card.copyWith(imagePath: imageUrlController.text);
                
                if (isMens) {
                  final updatedCards = notifier.state.mensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                  notifier.updateMensStyleCards(updatedCards);
                } else {
                  final updatedCards = notifier.state.womensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                  notifier.updateWomensStyleCards(updatedCards);
                }
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _removeStyleCardImage(StyleCard card, HeaderCustomizationNotifier notifier, bool isMens) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Image'),
        content: const Text('Are you sure you want to remove this image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCard = card.copyWith(imagePath: null);
              
              if (isMens) {
                final updatedCards = notifier.state.mensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                notifier.updateMensStyleCards(updatedCards);
              } else {
                final updatedCards = notifier.state.womensStyleCards.map((c) => c.id == card.id ? updatedCard : c).toList();
                notifier.updateWomensStyleCards(updatedCards);
              }
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image removed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
