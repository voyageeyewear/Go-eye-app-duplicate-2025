import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'cart_model.g.dart';

/// Cart model that matches Shopify's Cart structure
/// This will make it easy to integrate with real Shopify APIs later
@JsonSerializable()
class Cart {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CartItem> items;
  final CartCost cost;
  final int totalQuantity;
  final String? checkoutUrl;
  final String? note;

  const Cart({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.cost,
    required this.totalQuantity,
    this.checkoutUrl,
    this.note,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  /// Get total price
  double get totalPrice => cost.totalAmount.amount;

  /// Get formatted total price
  String get formattedTotalPrice => cost.totalAmount.formatted;

  /// Get subtotal price
  double get subtotalPrice => cost.subtotalAmount.amount;

  /// Get formatted subtotal price
  String get formattedSubtotalPrice => cost.subtotalAmount.formatted;

  /// Get tax amount
  double get taxAmount => cost.totalTaxAmount.amount;

  /// Get formatted tax amount
  String get formattedTaxAmount => cost.totalTaxAmount.formatted;

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Check if cart has items
  bool get isNotEmpty => items.isNotEmpty;

  /// Get unique products count
  int get uniqueProductsCount => items.length;

  /// Get item by product variant ID
  CartItem? getItemByVariantId(String variantId) {
    try {
      return items.firstWhere((item) => item.merchandise.id == variantId);
    } catch (e) {
      return null;
    }
  }

  /// Check if product variant is in cart
  bool hasVariant(String variantId) {
    return getItemByVariantId(variantId) != null;
  }

  /// Get quantity of a specific variant
  int getVariantQuantity(String variantId) {
    final item = getItemByVariantId(variantId);
    return item?.quantity ?? 0;
  }

  Cart copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CartItem>? items,
    CartCost? cost,
    int? totalQuantity,
    String? checkoutUrl,
    String? note,
  }) {
    return Cart(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      cost: cost ?? this.cost,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cart && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Cart(id: $id, totalQuantity: $totalQuantity, totalPrice: $formattedTotalPrice)';
  }
}

/// Cart item model
@JsonSerializable()
class CartItem {
  final String id;
  final CartMerchandise merchandise;
  final int quantity;
  final List<CartAttribute>? attributes;
  final List<CartDiscountAllocation>? discountAllocations;

  const CartItem({
    required this.id,
    required this.merchandise,
    required this.quantity,
    this.attributes,
    this.discountAllocations,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  /// Get total price for this item
  double get totalPrice => merchandise.price.amount * quantity;

  /// Get formatted total price
  String get formattedTotalPrice => (merchandise.price.amount * quantity).toStringAsFixed(2);

  /// Get discount amount
  double get discountAmount {
    if (discountAllocations == null || discountAllocations!.isEmpty) return 0;
    return discountAllocations!.fold(0.0, (sum, allocation) => sum + allocation.allocatedAmount.amount);
  }

  /// Get final price after discounts
  double get finalPrice => totalPrice - discountAmount;

  /// Get formatted final price
  String get formattedFinalPrice => finalPrice.toStringAsFixed(2);

  CartItem copyWith({
    String? id,
    CartMerchandise? merchandise,
    int? quantity,
    List<CartAttribute>? attributes,
    List<CartDiscountAllocation>? discountAllocations,
  }) {
    return CartItem(
      id: id ?? this.id,
      merchandise: merchandise ?? this.merchandise,
      quantity: quantity ?? this.quantity,
      attributes: attributes ?? this.attributes,
      discountAllocations: discountAllocations ?? this.discountAllocations,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Cart merchandise model (product variant)
@JsonSerializable()
class CartMerchandise {
  final String id;
  final String title;
  final ProductImage? image;
  final Money price;
  final Money? compareAtPrice;
  final Product product;
  final List<SelectedOption> selectedOptions;

  const CartMerchandise({
    required this.id,
    required this.title,
    this.image,
    required this.price,
    this.compareAtPrice,
    required this.product,
    required this.selectedOptions,
  });

  factory CartMerchandise.fromJson(Map<String, dynamic> json) => _$CartMerchandiseFromJson(json);
  Map<String, dynamic> toJson() => _$CartMerchandiseToJson(this);

  /// Check if merchandise is on sale
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

  CartMerchandise copyWith({
    String? id,
    String? title,
    ProductImage? image,
    Money? price,
    Money? compareAtPrice,
    Product? product,
    List<SelectedOption>? selectedOptions,
  }) {
    return CartMerchandise(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      compareAtPrice: compareAtPrice ?? this.compareAtPrice,
      product: product ?? this.product,
      selectedOptions: selectedOptions ?? this.selectedOptions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartMerchandise && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Cart attribute model
@JsonSerializable()
class CartAttribute {
  final String key;
  final String value;

  const CartAttribute({
    required this.key,
    required this.value,
  });

  factory CartAttribute.fromJson(Map<String, dynamic> json) => _$CartAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$CartAttributeToJson(this);

  CartAttribute copyWith({
    String? key,
    String? value,
  }) {
    return CartAttribute(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartAttribute && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}

/// Cart discount allocation model
@JsonSerializable()
class CartDiscountAllocation {
  final Money allocatedAmount;
  final CartDiscountTarget target;

  const CartDiscountAllocation({
    required this.allocatedAmount,
    required this.target,
  });

  factory CartDiscountAllocation.fromJson(Map<String, dynamic> json) => _$CartDiscountAllocationFromJson(json);
  Map<String, dynamic> toJson() => _$CartDiscountAllocationToJson(this);

  CartDiscountAllocation copyWith({
    Money? allocatedAmount,
    CartDiscountTarget? target,
  }) {
    return CartDiscountAllocation(
      allocatedAmount: allocatedAmount ?? this.allocatedAmount,
      target: target ?? this.target,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartDiscountAllocation && 
           other.allocatedAmount == allocatedAmount && 
           other.target == target;
  }

  @override
  int get hashCode => allocatedAmount.hashCode ^ target.hashCode;
}

/// Cart discount target model
@JsonSerializable()
class CartDiscountTarget {
  final String type;
  final String? subtotalAmount;
  final String? totalAmount;

  const CartDiscountTarget({
    required this.type,
    this.subtotalAmount,
    this.totalAmount,
  });

  factory CartDiscountTarget.fromJson(Map<String, dynamic> json) => _$CartDiscountTargetFromJson(json);
  Map<String, dynamic> toJson() => _$CartDiscountTargetToJson(this);

  CartDiscountTarget copyWith({
    String? type,
    String? subtotalAmount,
    String? totalAmount,
  }) {
    return CartDiscountTarget(
      type: type ?? this.type,
      subtotalAmount: subtotalAmount ?? this.subtotalAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartDiscountTarget && 
           other.type == type && 
           other.subtotalAmount == subtotalAmount && 
           other.totalAmount == totalAmount;
  }

  @override
  int get hashCode => type.hashCode ^ subtotalAmount.hashCode ^ totalAmount.hashCode;
}

/// Cart cost model
@JsonSerializable()
class CartCost {
  final Money subtotalAmount;
  final Money totalAmount;
  final Money totalTaxAmount;
  final Money totalDutyAmount;

  const CartCost({
    required this.subtotalAmount,
    required this.totalAmount,
    required this.totalTaxAmount,
    required this.totalDutyAmount,
  });

  factory CartCost.fromJson(Map<String, dynamic> json) => _$CartCostFromJson(json);
  Map<String, dynamic> toJson() => _$CartCostToJson(this);

  /// Get shipping cost (difference between total and subtotal)
  double get shippingCost {
    return totalAmount.amount - subtotalAmount.amount - totalTaxAmount.amount - totalDutyAmount.amount;
  }

  /// Get formatted shipping cost
  String get formattedShippingCost => shippingCost.toStringAsFixed(2);

  CartCost copyWith({
    Money? subtotalAmount,
    Money? totalAmount,
    Money? totalTaxAmount,
    Money? totalDutyAmount,
  }) {
    return CartCost(
      subtotalAmount: subtotalAmount ?? this.subtotalAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      totalTaxAmount: totalTaxAmount ?? this.totalTaxAmount,
      totalDutyAmount: totalDutyAmount ?? this.totalDutyAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartCost && 
           other.subtotalAmount == subtotalAmount && 
           other.totalAmount == totalAmount && 
           other.totalTaxAmount == totalTaxAmount && 
           other.totalDutyAmount == totalDutyAmount;
  }

  @override
  int get hashCode => subtotalAmount.hashCode ^ 
                      totalAmount.hashCode ^ 
                      totalTaxAmount.hashCode ^ 
                      totalDutyAmount.hashCode;
}
