import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User model that matches Shopify's Customer structure
/// This will make it easy to integrate with real Shopify APIs later
@JsonSerializable()
class User {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool emailVerified;
  final bool acceptsMarketing;
  final String? defaultAddressId;
  final List<Address>? addresses;
  final List<Order>? orders;

  const User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.emailVerified = false,
    this.acceptsMarketing = false,
    this.defaultAddressId,
    this.addresses,
    this.orders,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Get full name of the user
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return email.split('@').first;
  }

  /// Get initials for avatar display
  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    } else if (firstName != null) {
      return firstName![0].toUpperCase();
    } else if (lastName != null) {
      return lastName![0].toUpperCase();
    }
    return email[0].toUpperCase();
  }

  /// Check if user has completed profile
  bool get hasCompleteProfile {
    return firstName != null && lastName != null && phone != null;
  }

  /// Get default address
  Address? get defaultAddress {
    if (defaultAddressId == null || addresses == null) return null;
    return addresses!.firstWhere(
      (address) => address.id == defaultAddressId,
      orElse: () => addresses!.first,
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? emailVerified,
    bool? acceptsMarketing,
    String? defaultAddressId,
    List<Address>? addresses,
    List<Order>? orders,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emailVerified: emailVerified ?? this.emailVerified,
      acceptsMarketing: acceptsMarketing ?? this.acceptsMarketing,
      defaultAddressId: defaultAddressId ?? this.defaultAddressId,
      addresses: addresses ?? this.addresses,
      orders: orders ?? this.orders,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullName: $fullName)';
  }
}

/// Address model for user addresses
@JsonSerializable()
class Address {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? province;
  final String? country;
  final String? zip;
  final String? phone;
  final bool isDefault;

  const Address({
    required this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.province,
    this.country,
    this.zip,
    this.phone,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return '';
  }

  String get fullAddress {
    final parts = <String>[];
    if (address1 != null) parts.add(address1!);
    if (address2 != null) parts.add(address2!);
    if (city != null) parts.add(city!);
    if (province != null) parts.add(province!);
    if (zip != null) parts.add(zip!);
    if (country != null) parts.add(country!);
    return parts.join(', ');
  }

  Address copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? province,
    String? country,
    String? zip,
    String? phone,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      province: province ?? this.province,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      phone: phone ?? this.phone,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Order model for user orders
@JsonSerializable()
class Order {
  final String id;
  final String orderNumber;
  final String status;
  final double totalPrice;
  final String currency;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<OrderItem> items;
  final Address? shippingAddress;
  final Address? billingAddress;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
    this.updatedAt,
    required this.items,
    this.shippingAddress,
    this.billingAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

/// Order item model
@JsonSerializable()
class OrderItem {
  final String id;
  final String productId;
  final String productTitle;
  final String? variantTitle;
  final int quantity;
  final double price;
  final String? imageUrl;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    this.variantTitle,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  double get totalPrice => price * quantity;
}
