// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      handle: json['handle'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String,
      vendor: json['vendor'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      productType: (json['productType'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
      options: (json['options'] as List<dynamic>)
          .map((e) => ProductOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableForSale: json['availableForSale'] as bool,
      seoTitle: json['seoTitle'] as String?,
      seoDescription: json['seoDescription'] as String?,
      collections: (json['collections'] as List<dynamic>?)
          ?.map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'handle': instance.handle,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': instance.status,
      'vendor': instance.vendor,
      'tags': instance.tags,
      'productType': instance.productType,
      'images': instance.images,
      'variants': instance.variants,
      'options': instance.options,
      'availableForSale': instance.availableForSale,
      'seoTitle': instance.seoTitle,
      'seoDescription': instance.seoDescription,
      'collections': instance.collections,
    };

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      id: json['id'] as String,
      title: json['title'] as String,
      price: Money.fromJson(json['price'] as Map<String, dynamic>),
      compareAtPrice: json['compareAtPrice'] == null
          ? null
          : Money.fromJson(json['compareAtPrice'] as Map<String, dynamic>),
      availableForSale: json['availableForSale'] as bool,
      quantityAvailable: (json['quantityAvailable'] as num).toInt(),
      selectedOptions: (json['selectedOptions'] as List<dynamic>)
          .map((e) => SelectedOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] == null
          ? null
          : ProductImage.fromJson(json['image'] as Map<String, dynamic>),
      weight: (json['weight'] as num).toDouble(),
      weightUnit: json['weightUnit'] as String,
    );

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'compareAtPrice': instance.compareAtPrice,
      'availableForSale': instance.availableForSale,
      'quantityAvailable': instance.quantityAvailable,
      'selectedOptions': instance.selectedOptions,
      'image': instance.image,
      'weight': instance.weight,
      'weightUnit': instance.weightUnit,
    };

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      id: json['id'] as String,
      url: json['url'] as String,
      altText: json['altText'] as String?,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'altText': instance.altText,
      'width': instance.width,
      'height': instance.height,
    };

ProductOption _$ProductOptionFromJson(Map<String, dynamic> json) =>
    ProductOption(
      id: json['id'] as String,
      name: json['name'] as String,
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductOptionToJson(ProductOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'values': instance.values,
    };

SelectedOption _$SelectedOptionFromJson(Map<String, dynamic> json) =>
    SelectedOption(
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$SelectedOptionToJson(SelectedOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

Money _$MoneyFromJson(Map<String, dynamic> json) => Money(
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$MoneyToJson(Money instance) => <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
    };

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
      minVariantPrice:
          Money.fromJson(json['minVariantPrice'] as Map<String, dynamic>),
      maxVariantPrice: json['maxVariantPrice'] == null
          ? null
          : Money.fromJson(json['maxVariantPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      'minVariantPrice': instance.minVariantPrice,
      'maxVariantPrice': instance.maxVariantPrice,
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      handle: json['handle'] as String?,
      image: json['image'] == null
          ? null
          : ProductImage.fromJson(json['image'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'handle': instance.handle,
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
