// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      cost: CartCost.fromJson(json['cost'] as Map<String, dynamic>),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
      checkoutUrl: json['checkoutUrl'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'items': instance.items,
      'cost': instance.cost,
      'totalQuantity': instance.totalQuantity,
      'checkoutUrl': instance.checkoutUrl,
      'note': instance.note,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['id'] as String,
      merchandise:
          CartMerchandise.fromJson(json['merchandise'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => CartAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      discountAllocations: (json['discountAllocations'] as List<dynamic>?)
          ?.map(
              (e) => CartDiscountAllocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'merchandise': instance.merchandise,
      'quantity': instance.quantity,
      'attributes': instance.attributes,
      'discountAllocations': instance.discountAllocations,
    };

CartMerchandise _$CartMerchandiseFromJson(Map<String, dynamic> json) =>
    CartMerchandise(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] == null
          ? null
          : ProductImage.fromJson(json['image'] as Map<String, dynamic>),
      price: Money.fromJson(json['price'] as Map<String, dynamic>),
      compareAtPrice: json['compareAtPrice'] == null
          ? null
          : Money.fromJson(json['compareAtPrice'] as Map<String, dynamic>),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      selectedOptions: (json['selectedOptions'] as List<dynamic>)
          .map((e) => SelectedOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartMerchandiseToJson(CartMerchandise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'compareAtPrice': instance.compareAtPrice,
      'product': instance.product,
      'selectedOptions': instance.selectedOptions,
    };

CartAttribute _$CartAttributeFromJson(Map<String, dynamic> json) =>
    CartAttribute(
      key: json['key'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$CartAttributeToJson(CartAttribute instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

CartDiscountAllocation _$CartDiscountAllocationFromJson(
        Map<String, dynamic> json) =>
    CartDiscountAllocation(
      allocatedAmount:
          Money.fromJson(json['allocatedAmount'] as Map<String, dynamic>),
      target:
          CartDiscountTarget.fromJson(json['target'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartDiscountAllocationToJson(
        CartDiscountAllocation instance) =>
    <String, dynamic>{
      'allocatedAmount': instance.allocatedAmount,
      'target': instance.target,
    };

CartDiscountTarget _$CartDiscountTargetFromJson(Map<String, dynamic> json) =>
    CartDiscountTarget(
      type: json['type'] as String,
      subtotalAmount: json['subtotalAmount'] as String?,
      totalAmount: json['totalAmount'] as String?,
    );

Map<String, dynamic> _$CartDiscountTargetToJson(CartDiscountTarget instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subtotalAmount': instance.subtotalAmount,
      'totalAmount': instance.totalAmount,
    };

CartCost _$CartCostFromJson(Map<String, dynamic> json) => CartCost(
      subtotalAmount:
          Money.fromJson(json['subtotalAmount'] as Map<String, dynamic>),
      totalAmount: Money.fromJson(json['totalAmount'] as Map<String, dynamic>),
      totalTaxAmount:
          Money.fromJson(json['totalTaxAmount'] as Map<String, dynamic>),
      totalDutyAmount:
          Money.fromJson(json['totalDutyAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartCostToJson(CartCost instance) => <String, dynamic>{
      'subtotalAmount': instance.subtotalAmount,
      'totalAmount': instance.totalAmount,
      'totalTaxAmount': instance.totalTaxAmount,
      'totalDutyAmount': instance.totalDutyAmount,
    };
