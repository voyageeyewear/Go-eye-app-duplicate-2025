import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

/// Product model that matches Shopify's Product structure
/// This will make it easy to integrate with real Shopify APIs later
@JsonSerializable()
class Product {
  final String id;
  final String title;
  final String? description;
  final String? handle;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String vendor;
  final List<String> tags;
  final List<String> productType;
  final List<ProductImage> images;
  final List<ProductVariant> variants;
  final List<ProductOption> options;
  final bool availableForSale;
  final String? seoTitle;
  final String? seoDescription;
  final List<Collection>? collections;

  const Product({
    required this.id,
    required this.title,
    this.description,
    this.handle,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.vendor,
    required this.tags,
    required this.productType,
    required this.images,
    required this.variants,
    required this.options,
    required this.availableForSale,
    this.seoTitle,
    this.seoDescription,
    this.collections,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Get the main product image
  ProductImage? get mainImage {
    if (images.isEmpty) return null;
    return images.firstWhere(
      (image) => image.altText?.toLowerCase().contains('main') == true,
      orElse: () => images.first,
    );
  }

  /// Get the first available variant
  ProductVariant? get firstVariant {
    if (variants.isEmpty) return null;
    return variants.firstWhere(
      (variant) => variant.availableForSale,
      orElse: () => variants.first,
    );
  }

  /// Get the price range
  PriceRange get priceRange {
    if (variants.isEmpty) {
      return const PriceRange(minVariantPrice: Money(amount: 0, currencyCode: 'USD'));
    }

    final prices = variants
        .where((v) => v.availableForSale)
        .map((v) => v.price.amount)
        .toList();

    if (prices.isEmpty) {
      return PriceRange(minVariantPrice: variants.first.price);
    }

    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);

    return PriceRange(
      minVariantPrice: Money(amount: minPrice, currencyCode: variants.first.price.currencyCode),
      maxVariantPrice: Money(amount: maxPrice, currencyCode: variants.first.price.currencyCode),
    );
  }

  /// Check if product is on sale
  bool get isOnSale {
    return variants.any((variant) => variant.compareAtPrice != null && 
        variant.compareAtPrice!.amount > variant.price.amount);
  }

  /// Get discount percentage
  double? get discountPercentage {
    if (!isOnSale) return null;
    
    final variant = variants.firstWhere(
      (v) => v.compareAtPrice != null && v.compareAtPrice!.amount > v.price.amount,
    );
    
    final originalPrice = variant.compareAtPrice!.amount;
    final salePrice = variant.price.amount;
    return ((originalPrice - salePrice) / originalPrice * 100).roundToDouble();
  }

  /// Get available variants count
  int get availableVariantsCount {
    return variants.where((variant) => variant.availableForSale).length;
  }

  /// Get total variants count
  int get totalVariantsCount => variants.length;

  Product copyWith({
    String? id,
    String? title,
    String? description,
    String? handle,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    String? vendor,
    List<String>? tags,
    List<String>? productType,
    List<ProductImage>? images,
    List<ProductVariant>? variants,
    List<ProductOption>? options,
    bool? availableForSale,
    String? seoTitle,
    String? seoDescription,
    List<Collection>? collections,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      handle: handle ?? this.handle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      vendor: vendor ?? this.vendor,
      tags: tags ?? this.tags,
      productType: productType ?? this.productType,
      images: images ?? this.images,
      variants: variants ?? this.variants,
      options: options ?? this.options,
      availableForSale: availableForSale ?? this.availableForSale,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      collections: collections ?? this.collections,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, priceRange: $priceRange)';
  }
}

/// Product variant model
@JsonSerializable()
class ProductVariant {
  final String id;
  final String title;
  final Money price;
  final Money? compareAtPrice;
  final bool availableForSale;
  final int quantityAvailable;
  final List<SelectedOption> selectedOptions;
  final ProductImage? image;
  final double weight;
  final String weightUnit;

  const ProductVariant({
    required this.id,
    required this.title,
    required this.price,
    this.compareAtPrice,
    required this.availableForSale,
    required this.quantityAvailable,
    required this.selectedOptions,
    this.image,
    required this.weight,
    required this.weightUnit,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  /// Check if variant is on sale
  bool get isOnSale {
    return compareAtPrice != null && compareAtPrice!.amount > price.amount;
  }

  /// Get discount percentage
  double? get discountPercentage {
    if (!isOnSale) return null;
    return ((compareAtPrice!.amount - price.amount) / compareAtPrice!.amount * 100).roundToDouble();
  }

  /// Get formatted price
  String get formattedPrice => price.formatted;

  /// Get formatted compare at price
  String? get formattedCompareAtPrice => compareAtPrice?.formatted;

  ProductVariant copyWith({
    String? id,
    String? title,
    Money? price,
    Money? compareAtPrice,
    bool? availableForSale,
    int? quantityAvailable,
    List<SelectedOption>? selectedOptions,
    ProductImage? image,
    double? weight,
    String? weightUnit,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      compareAtPrice: compareAtPrice ?? this.compareAtPrice,
      availableForSale: availableForSale ?? this.availableForSale,
      quantityAvailable: quantityAvailable ?? this.quantityAvailable,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      image: image ?? this.image,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Product image model
@JsonSerializable()
class ProductImage {
  final String id;
  final String url;
  final String? altText;
  final int width;
  final int height;

  const ProductImage({
    required this.id,
    required this.url,
    this.altText,
    required this.width,
    required this.height,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);

  ProductImage copyWith({
    String? id,
    String? url,
    String? altText,
    int? width,
    int? height,
  }) {
    return ProductImage(
      id: id ?? this.id,
      url: url ?? this.url,
      altText: altText ?? this.altText,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductImage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Product option model
@JsonSerializable()
class ProductOption {
  final String id;
  final String name;
  final List<String> values;

  const ProductOption({
    required this.id,
    required this.name,
    required this.values,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) => _$ProductOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionToJson(this);

  ProductOption copyWith({
    String? id,
    String? name,
    List<String>? values,
  }) {
    return ProductOption(
      id: id ?? this.id,
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductOption && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Selected option model
@JsonSerializable()
class SelectedOption {
  final String name;
  final String value;

  const SelectedOption({
    required this.name,
    required this.value,
  });

  factory SelectedOption.fromJson(Map<String, dynamic> json) => _$SelectedOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SelectedOptionToJson(this);

  SelectedOption copyWith({
    String? name,
    String? value,
  }) {
    return SelectedOption(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedOption && other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}

/// Money model for prices
@JsonSerializable()
class Money {
  final double amount;
  final String currencyCode;

  const Money({
    required this.amount,
    required this.currencyCode,
  });

  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);
  Map<String, dynamic> toJson() => _$MoneyToJson(this);

  /// Get formatted price string
  String get formatted {
    switch (currencyCode) {
      case 'USD':
        return '\$${amount.toStringAsFixed(2)}';
      case 'EUR':
        return '€${amount.toStringAsFixed(2)}';
      case 'GBP':
        return '£${amount.toStringAsFixed(2)}';
      default:
        return '${amount.toStringAsFixed(2)} $currencyCode';
    }
  }

  Money copyWith({
    double? amount,
    String? currencyCode,
  }) {
    return Money(
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Money && other.amount == amount && other.currencyCode == currencyCode;
  }

  @override
  int get hashCode => amount.hashCode ^ currencyCode.hashCode;
}

/// Price range model
@JsonSerializable()
class PriceRange {
  final Money minVariantPrice;
  final Money? maxVariantPrice;

  const PriceRange({
    required this.minVariantPrice,
    this.maxVariantPrice,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => _$PriceRangeFromJson(json);
  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);

  /// Get formatted price range
  String get formatted {
    if (maxVariantPrice == null || minVariantPrice.amount == maxVariantPrice!.amount) {
      return minVariantPrice.formatted;
    }
    return '${minVariantPrice.formatted} - ${maxVariantPrice!.formatted}';
  }

  PriceRange copyWith({
    Money? minVariantPrice,
    Money? maxVariantPrice,
  }) {
    return PriceRange(
      minVariantPrice: minVariantPrice ?? this.minVariantPrice,
      maxVariantPrice: maxVariantPrice ?? this.maxVariantPrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PriceRange && 
           other.minVariantPrice == minVariantPrice && 
           other.maxVariantPrice == maxVariantPrice;
  }

  @override
  int get hashCode => minVariantPrice.hashCode ^ maxVariantPrice.hashCode;
}

/// Collection model
@JsonSerializable()
class Collection {
  final String id;
  final String title;
  final String? description;
  final String? handle;
  final ProductImage? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Collection({
    required this.id,
    required this.title,
    this.description,
    this.handle,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  Collection copyWith({
    String? id,
    String? title,
    String? description,
    String? handle,
    ProductImage? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      handle: handle ?? this.handle,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Collection && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
