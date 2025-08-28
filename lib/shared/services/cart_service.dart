import 'dart:convert';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage_service.dart';

/// Cart service that handles shopping cart operations
/// Currently uses mock data but structured to easily integrate with Shopify APIs later
class CartService {
  final ApiClient _apiClient;
  final LocalStorageService _storage;
  
  static const String _cartIdKey = 'current_cart_id';

  CartService()
      : _apiClient = ServiceLocator.apiClient,
        _storage = ServiceLocator.localStorage;

  // MARK: - Cart Management

  /// Get current cart
  Future<Cart?> getCurrentCart() async {
    try {
      final cartId = _storage.getString(_cartIdKey);
      if (cartId == null) {
        return null;
      }

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Get cart from local storage
      final cartData = _storage.getCart(cartId);
      if (cartData != null) {
        return Cart.fromJson(cartData);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Create new cart
  Future<Cart> createCart() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final cartId = 'cart_${DateTime.now().millisecondsSinceEpoch}';
      
      final cart = Cart(
        id: cartId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        items: [],
        cost: const CartCost(
          subtotalAmount: Money(amount: 0, currencyCode: 'USD'),
          totalAmount: Money(amount: 0, currencyCode: 'USD'),
          totalTaxAmount: Money(amount: 0, currencyCode: 'USD'),
          totalDutyAmount: Money(amount: 0, currencyCode: 'USD'),
        ),
        totalQuantity: 0,
      );

      // Save cart ID and cart data
      await _storage.saveString(_cartIdKey, cartId);
      await _storage.saveCart(cartId, cart.toJson());

      return cart;
    } catch (e) {
      throw Exception('Failed to create cart: $e');
    }
  }

  /// Add item to cart
  Future<Cart> addToCart({
    required Product product,
    required ProductVariant variant,
    required int quantity,
    Map<String, String>? attributes,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      Cart cart = await getCurrentCart() ?? await createCart();

      // Check if item already exists in cart
      final existingItemIndex = cart.items.indexWhere(
        (item) => item.merchandise.id == variant.id,
      );

      List<CartItem> updatedItems = List.from(cart.items);

      if (existingItemIndex != -1) {
        // Update existing item quantity
        final existingItem = updatedItems[existingItemIndex];
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new item
        final cartItem = CartItem(
          id: 'cart_item_${DateTime.now().millisecondsSinceEpoch}',
          merchandise: CartMerchandise(
            id: variant.id,
            title: variant.title,
            image: variant.image,
            price: variant.price,
            compareAtPrice: variant.compareAtPrice,
            product: product,
            selectedOptions: variant.selectedOptions,
          ),
          quantity: quantity,
          attributes: attributes?.entries
              .map((entry) => CartAttribute(key: entry.key, value: entry.value))
              .toList(),
        );
        updatedItems.add(cartItem);
      }

      // Calculate new totals
      final subtotal = updatedItems.fold<double>(
        0,
        (sum, item) => sum + (item.merchandise.price.amount * item.quantity),
      );

      final totalQuantity = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      // Create updated cart
      final updatedCart = cart.copyWith(
        items: updatedItems,
        totalQuantity: totalQuantity,
        updatedAt: DateTime.now(),
        cost: CartCost(
          subtotalAmount: Money(amount: subtotal, currencyCode: 'USD'),
          totalAmount: Money(amount: subtotal, currencyCode: 'USD'), // No tax/duty for now
          totalTaxAmount: const Money(amount: 0, currencyCode: 'USD'),
          totalDutyAmount: const Money(amount: 0, currencyCode: 'USD'),
        ),
      );

      // Save updated cart
      await _storage.saveCart(cart.id, updatedCart.toJson());

      return updatedCart;
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  /// Update cart item quantity
  Future<Cart> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      Cart cart = await getCurrentCart() ?? await createCart();

      final itemIndex = cart.items.indexWhere((item) => item.id == cartItemId);
      if (itemIndex == -1) {
        throw Exception('Cart item not found');
      }

      List<CartItem> updatedItems = List.from(cart.items);

      if (quantity <= 0) {
        // Remove item if quantity is 0 or negative
        updatedItems.removeAt(itemIndex);
      } else {
        // Update quantity
        final item = updatedItems[itemIndex];
        updatedItems[itemIndex] = item.copyWith(quantity: quantity);
      }

      // Calculate new totals
      final subtotal = updatedItems.fold<double>(
        0,
        (sum, item) => sum + (item.merchandise.price.amount * item.quantity),
      );

      final totalQuantity = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      // Create updated cart
      final updatedCart = cart.copyWith(
        items: updatedItems,
        totalQuantity: totalQuantity,
        updatedAt: DateTime.now(),
        cost: CartCost(
          subtotalAmount: Money(amount: subtotal, currencyCode: 'USD'),
          totalAmount: Money(amount: subtotal, currencyCode: 'USD'),
          totalTaxAmount: const Money(amount: 0, currencyCode: 'USD'),
          totalDutyAmount: const Money(amount: 0, currencyCode: 'USD'),
        ),
      );

      // Save updated cart
      await _storage.saveCart(cart.id, updatedCart.toJson());

      return updatedCart;
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  /// Remove item from cart
  Future<Cart> removeFromCart({required String cartItemId}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      Cart cart = await getCurrentCart() ?? await createCart();

      final updatedItems = cart.items.where((item) => item.id != cartItemId).toList();

      // Calculate new totals
      final subtotal = updatedItems.fold<double>(
        0,
        (sum, item) => sum + (item.merchandise.price.amount * item.quantity),
      );

      final totalQuantity = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      // Create updated cart
      final updatedCart = cart.copyWith(
        items: updatedItems,
        totalQuantity: totalQuantity,
        updatedAt: DateTime.now(),
        cost: CartCost(
          subtotalAmount: Money(amount: subtotal, currencyCode: 'USD'),
          totalAmount: Money(amount: subtotal, currencyCode: 'USD'),
          totalTaxAmount: const Money(amount: 0, currencyCode: 'USD'),
          totalDutyAmount: const Money(amount: 0, currencyCode: 'USD'),
        ),
      );

      // Save updated cart
      await _storage.saveCart(cart.id, updatedCart.toJson());

      return updatedCart;
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  /// Clear cart
  Future<Cart> clearCart() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      Cart cart = await getCurrentCart() ?? await createCart();

      final updatedCart = cart.copyWith(
        items: [],
        totalQuantity: 0,
        updatedAt: DateTime.now(),
        cost: const CartCost(
          subtotalAmount: Money(amount: 0, currencyCode: 'USD'),
          totalAmount: Money(amount: 0, currencyCode: 'USD'),
          totalTaxAmount: Money(amount: 0, currencyCode: 'USD'),
          totalDutyAmount: Money(amount: 0, currencyCode: 'USD'),
        ),
      );

      // Save updated cart
      await _storage.saveCart(cart.id, updatedCart.toJson());

      return updatedCart;
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  /// Update cart note
  Future<Cart> updateCartNote({required String note}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      Cart cart = await getCurrentCart() ?? await createCart();

      final updatedCart = cart.copyWith(
        note: note,
        updatedAt: DateTime.now(),
      );

      // Save updated cart
      await _storage.saveCart(cart.id, updatedCart.toJson());

      return updatedCart;
    } catch (e) {
      throw Exception('Failed to update cart note: $e');
    }
  }

  /// Get cart item by variant ID
  CartItem? getCartItemByVariantId(String variantId) {
    try {
      final cartData = _storage.getCartData();
      if (cartData != null) {
        final cart = Cart.fromJson(cartData);
        return cart.getItemByVariantId(variantId);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if product variant is in cart
  bool isVariantInCart(String variantId) {
    return getCartItemByVariantId(variantId) != null;
  }

  /// Get quantity of variant in cart
  int getVariantQuantityInCart(String variantId) {
    final item = getCartItemByVariantId(variantId);
    return item?.quantity ?? 0;
  }

  /// Get cart total quantity
  int getCartTotalQuantity() {
    try {
      final cartData = _storage.getCartData();
      if (cartData != null) {
        final cart = Cart.fromJson(cartData);
        return cart.totalQuantity;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get cart total price
  double getCartTotalPrice() {
    try {
      final cartData = _storage.getCartData();
      if (cartData != null) {
        final cart = Cart.fromJson(cartData);
        return cart.totalPrice;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  /// Check if cart is empty
  bool get isCartEmpty {
    return getCartTotalQuantity() == 0;
  }

  /// Check if cart has items
  bool get hasCartItems {
    return getCartTotalQuantity() > 0;
  }

  // MARK: - Checkout Methods

  /// Create checkout URL
  Future<String?> createCheckoutUrl() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final cart = await getCurrentCart();
      if (cart == null || cart.isEmpty) {
        throw Exception('Cart is empty');
      }

      // In a real app, this would create a checkout session with Shopify
      // For now, return a mock checkout URL
      return 'https://checkout.shopify.com/mock-checkout-${cart.id}';
    } catch (e) {
      throw Exception('Failed to create checkout URL: $e');
    }
  }

  /// Apply discount code
  Future<Cart> applyDiscountCode({required String code}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      Cart cart = await getCurrentCart() ?? await createCart();

      // Mock discount logic (in real app, this would validate with Shopify)
      if (code.toUpperCase() == 'SAVE10') {
        final discountAmount = cart.subtotalPrice * 0.1;
        final newTotal = cart.subtotalPrice - discountAmount;

        final updatedCart = cart.copyWith(
          updatedAt: DateTime.now(),
          cost: cart.cost.copyWith(
            totalAmount: Money(amount: newTotal, currencyCode: 'USD'),
          ),
        );

        await _storage.saveCart(cart.id, updatedCart.toJson());
        return updatedCart;
      } else {
        throw Exception('Invalid discount code');
      }
    } catch (e) {
      throw Exception('Failed to apply discount code: $e');
    }
  }

  /// Remove discount code
  Future<Cart> removeDiscountCode() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      Cart cart = await getCurrentCart() ?? await createCart();

      final updatedCart = cart.copyWith(
        updatedAt: DateTime.now(),
        cost: cart.cost.copyWith(
          totalAmount: cart.subtotalAmount,
        ),
      );

      await _storage.saveCart(cart.id, updatedCart.toJson());
      return updatedCart;
    } catch (e) {
      throw Exception('Failed to remove discount code: $e');
    }
  }

  // MARK: - Utility Methods

  /// Initialize cart (called on app startup)
  Future<void> initializeCart() async {
    try {
      final cartId = _storage.getString(_cartIdKey);
      if (cartId != null) {
        // Validate cart exists
        final cartData = _storage.getCart(cartId);
        if (cartData == null) {
          // Cart doesn't exist, clear the ID
          await _storage.remove(_cartIdKey);
        }
      }
    } catch (e) {
      // Clear invalid cart state
      await _storage.remove(_cartIdKey);
    }
  }

  /// Clear cart data (for logout)
  Future<void> clearCartData() async {
    try {
      final cartId = _storage.getString(_cartIdKey);
      if (cartId != null) {
        await _storage.removeCart(cartId);
        await _storage.remove(_cartIdKey);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  /// Export cart data (for debugging)
  Map<String, dynamic>? exportCartData() {
    try {
      final cartId = _storage.getString(_cartIdKey);
      if (cartId != null) {
        return _storage.getCart(cartId);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
