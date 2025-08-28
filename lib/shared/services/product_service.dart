import '../models/product_model.dart';
import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage_service.dart';

/// Product service that handles product-related operations
/// Currently uses mock data but structured to easily integrate with Shopify APIs later
class ProductService {
  final ApiClient _apiClient;
  final LocalStorageService _storage;

  // Mock product data for development
  static final List<Map<String, dynamic>> _mockProducts = [
    {
      'id': 'product_1',
      'title': 'Classic Aviator Sunglasses',
      'description': 'Timeless aviator sunglasses with premium metal frame and UV400 protection lenses.',
      'handle': 'classic-aviator-sunglasses',
      'createdAt': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'status': 'ACTIVE',
      'vendor': 'GoEye',
      'tags': ['sunglasses', 'aviator', 'classic', 'metal'],
      'productType': ['eyewear', 'sunglasses'],
      'images': [
        {
          'id': 'img_1',
          'url': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=400&fit=crop',
          'altText': 'Classic Aviator Sunglasses',
          'width': 400,
          'height': 400,
        },
        {
          'id': 'img_2',
          'url': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=400&fit=crop',
          'altText': 'Classic Aviator Sunglasses Side View',
          'width': 400,
          'height': 400,
        },
      ],
      'variants': [
        {
          'id': 'variant_1',
          'title': 'Gold / 58mm',
          'price': {'amount': 129.99, 'currencyCode': 'USD'},
          'compareAtPrice': {'amount': 159.99, 'currencyCode': 'USD'},
          'availableForSale': true,
          'quantityAvailable': 25,
          'selectedOptions': [
            {'name': 'Color', 'value': 'Gold'},
            {'name': 'Size', 'value': '58mm'},
          ],
          'weight': 45.0,
          'weightUnit': 'g',
        },
        {
          'id': 'variant_2',
          'title': 'Silver / 58mm',
          'price': {'amount': 129.99, 'currencyCode': 'USD'},
          'availableForSale': true,
          'quantityAvailable': 18,
          'selectedOptions': [
            {'name': 'Color', 'value': 'Silver'},
            {'name': 'Size', 'value': '58mm'},
          ],
          'weight': 45.0,
          'weightUnit': 'g',
        },
      ],
      'options': [
        {
          'id': 'option_1',
          'name': 'Color',
          'values': ['Gold', 'Silver'],
        },
        {
          'id': 'option_2',
          'name': 'Size',
          'values': ['58mm'],
        },
      ],
      'availableForSale': true,
      'seoTitle': 'Classic Aviator Sunglasses - GoEye',
      'seoDescription': 'Timeless aviator sunglasses with premium metal frame and UV400 protection lenses.',
    },
    {
      'id': 'product_2',
      'title': 'Round Retro Sunglasses',
      'description': 'Vintage-inspired round sunglasses with acetate frame and polarized lenses.',
      'handle': 'round-retro-sunglasses',
      'createdAt': DateTime.now().subtract(const Duration(days: 25)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'status': 'ACTIVE',
      'vendor': 'GoEye',
      'tags': ['sunglasses', 'round', 'retro', 'acetate'],
      'productType': ['eyewear', 'sunglasses'],
      'images': [
        {
          'id': 'img_3',
          'url': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&h=400&fit=crop',
          'altText': 'Round Retro Sunglasses',
          'width': 400,
          'height': 400,
        },
      ],
      'variants': [
        {
          'id': 'variant_3',
          'title': 'Tortoise / 55mm',
          'price': {'amount': 89.99, 'currencyCode': 'USD'},
          'availableForSale': true,
          'quantityAvailable': 32,
          'selectedOptions': [
            {'name': 'Color', 'value': 'Tortoise'},
            {'name': 'Size', 'value': '55mm'},
          ],
          'weight': 38.0,
          'weightUnit': 'g',
        },
        {
          'id': 'variant_4',
          'title': 'Black / 55mm',
          'price': {'amount': 89.99, 'currencyCode': 'USD'},
          'availableForSale': true,
          'quantityAvailable': 28,
          'selectedOptions': [
            {'name': 'Color', 'value': 'Black'},
            {'name': 'Size', 'value': '55mm'},
          ],
          'weight': 38.0,
          'weightUnit': 'g',
        },
      ],
      'options': [
        {
          'id': 'option_3',
          'name': 'Color',
          'values': ['Tortoise', 'Black'],
        },
        {
          'id': 'option_4',
          'name': 'Size',
          'values': ['55mm'],
        },
      ],
      'availableForSale': true,
      'seoTitle': 'Round Retro Sunglasses - GoEye',
      'seoDescription': 'Vintage-inspired round sunglasses with acetate frame and polarized lenses.',
    },
    {
      'id': 'product_3',
      'title': 'Cat Eye Sunglasses',
      'description': 'Elegant cat eye sunglasses with crystal embellishments and gradient lenses.',
      'handle': 'cat-eye-sunglasses',
      'createdAt': DateTime.now().subtract(const Duration(days: 20)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'status': 'ACTIVE',
      'vendor': 'GoEye',
      'tags': ['sunglasses', 'cat-eye', 'elegant', 'crystal'],
      'productType': ['eyewear', 'sunglasses'],
      'images': [
        {
          'id': 'img_5',
          'url': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=400&fit=crop',
          'altText': 'Cat Eye Sunglasses',
          'width': 400,
          'height': 400,
        },
      ],
      'variants': [
        {
          'id': 'variant_5',
          'title': 'Rose Gold / 52mm',
          'price': {'amount': 149.99, 'currencyCode': 'USD'},
          'compareAtPrice': {'amount': 179.99, 'currencyCode': 'USD'},
          'availableForSale': true,
          'quantityAvailable': 15,
          'selectedOptions': [
            {'name': 'Color', 'value': 'Rose Gold'},
            {'name': 'Size', 'value': '52mm'},
          ],
          'weight': 42.0,
          'weightUnit': 'g',
        },
      ],
      'options': [
        {
          'id': 'option_5',
          'name': 'Color',
          'values': ['Rose Gold'],
        },
        {
          'id': 'option_6',
          'name': 'Size',
          'values': ['52mm'],
        },
      ],
      'availableForSale': true,
      'seoTitle': 'Cat Eye Sunglasses - GoEye',
      'seoDescription': 'Elegant cat eye sunglasses with crystal embellishments and gradient lenses.',
    },
  ];

  // Mock collections data
  static final List<Map<String, dynamic>> _mockCollections = [
    {
      'id': 'collection_1',
      'title': 'Sunglasses',
      'description': 'Discover our collection of stylish and protective sunglasses.',
      'handle': 'sunglasses',
      'image': {
        'id': 'collection_img_1',
        'url': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=400&fit=crop',
        'altText': 'Sunglasses Collection',
        'width': 400,
        'height': 400,
      },
      'createdAt': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': 'collection_2',
      'title': 'New Arrivals',
      'description': 'Latest additions to our eyewear collection.',
      'handle': 'new-arrivals',
      'image': {
        'id': 'collection_img_2',
        'url': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&h=400&fit=crop',
        'altText': 'New Arrivals',
        'width': 400,
        'height': 400,
      },
      'createdAt': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': 'collection_3',
      'title': 'Sale',
      'description': 'Great deals on selected eyewear.',
      'handle': 'sale',
      'image': {
        'id': 'collection_img_3',
        'url': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=400&fit=crop',
        'altText': 'Sale Collection',
        'width': 400,
        'height': 400,
      },
      'createdAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
  ];

  ProductService()
      : _apiClient = ServiceLocator.apiClient,
        _storage = ServiceLocator.localStorage;

  // MARK: - Product Methods

  /// Get all products with optional filtering
  Future<List<Product>> getProducts({
    int? first,
    String? after,
    String? query,
    List<String>? productTypes,
    List<String>? vendors,
    List<String>? tags,
    bool? availableForSale,
    String? sortKey,
    bool? reverse,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      List<Map<String, dynamic>> filteredProducts = List.from(_mockProducts);

      // Apply filters
      if (query != null && query.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return product['title'].toString().toLowerCase().contains(query.toLowerCase()) ||
                 product['description'].toString().toLowerCase().contains(query.toLowerCase()) ||
                 product['tags'].any((tag) => tag.toString().toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }

      if (productTypes != null && productTypes.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return productTypes.any((type) => product['productType'].contains(type));
        }).toList();
      }

      if (vendors != null && vendors.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return vendors.contains(product['vendor']);
        }).toList();
      }

      if (tags != null && tags.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return tags.any((tag) => product['tags'].contains(tag));
        }).toList();
      }

      if (availableForSale != null) {
        filteredProducts = filteredProducts.where((product) {
          return product['availableForSale'] == availableForSale;
        }).toList();
      }

      // Apply sorting
      if (sortKey != null) {
        switch (sortKey) {
          case 'TITLE':
            filteredProducts.sort((a, b) => a['title'].compareTo(b['title']));
            break;
          case 'PRICE':
            filteredProducts.sort((a, b) {
              final aPrice = a['variants'][0]['price']['amount'];
              final bPrice = b['variants'][0]['price']['amount'];
              return aPrice.compareTo(bPrice);
            });
            break;
          case 'CREATED_AT':
            filteredProducts.sort((a, b) => a['createdAt'].compareTo(b['createdAt']));
            break;
          case 'UPDATED_AT':
            filteredProducts.sort((a, b) => a['updatedAt'].compareTo(b['updatedAt']));
            break;
        }

        if (reverse == true) {
          filteredProducts = filteredProducts.reversed.toList();
        }
      }

      // Apply pagination
      if (first != null && first > 0) {
        filteredProducts = filteredProducts.take(first).toList();
      }

      // Convert to Product objects
      final products = filteredProducts.map((json) => Product.fromJson(json)).toList();

      // Cache products locally
      await _cacheProducts(products);

      return products;
    } catch (e) {
      // Return cached products if available
      return await _getCachedProducts();
    }
  }

  /// Get product by ID
  Future<Product?> getProductById(String productId) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final productJson = _mockProducts.firstWhere(
        (product) => product['id'] == productId,
        orElse: () => throw Exception('Product not found'),
      );

      return Product.fromJson(productJson);
    } catch (e) {
      // Try to get from cache
      return await _getCachedProduct(productId);
    }
  }

  /// Get product by handle
  Future<Product?> getProductByHandle(String handle) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final productJson = _mockProducts.firstWhere(
        (product) => product['handle'] == handle,
        orElse: () => throw Exception('Product not found'),
      );

      return Product.fromJson(productJson);
    } catch (e) {
      return null;
    }
  }

  /// Search products
  Future<List<Product>> searchProducts({
    required String query,
    int? first,
    String? after,
    List<String>? productTypes,
    List<String>? vendors,
    List<String>? tags,
    bool? availableForSale,
  }) async {
    return await getProducts(
      query: query,
      first: first,
      after: after,
      productTypes: productTypes,
      vendors: vendors,
      tags: tags,
      availableForSale: availableForSale,
      sortKey: 'RELEVANCE',
    );
  }

  /// Get products on sale
  Future<List<Product>> getProductsOnSale({int? first, String? after}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final saleProducts = _mockProducts.where((product) {
        return product['variants'].any((variant) => variant['compareAtPrice'] != null);
      }).toList();

      if (first != null && first > 0) {
        saleProducts.take(first).toList();
      }

      return saleProducts.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get new arrivals
  Future<List<Product>> getNewArrivals({int? first, String? after}) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final newProducts = _mockProducts.where((product) {
        final createdAt = DateTime.parse(product['createdAt']);
        return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)));
      }).toList();

      if (first != null && first > 0) {
        newProducts.take(first).toList();
      }

      return newProducts.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  // MARK: - Collection Methods

  /// Get all collections
  Future<List<Collection>> getCollections({
    int? first,
    String? after,
    String? query,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      List<Map<String, dynamic>> filteredCollections = List.from(_mockCollections);

      if (query != null && query.isNotEmpty) {
        filteredCollections = filteredCollections.where((collection) {
          return collection['title'].toString().toLowerCase().contains(query.toLowerCase()) ||
                 collection['description'].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      if (first != null && first > 0) {
        filteredCollections = filteredCollections.take(first).toList();
      }

      return filteredCollections.map((json) => Collection.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get collection by ID
  Future<Collection?> getCollectionById(String collectionId) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      final collectionJson = _mockCollections.firstWhere(
        (collection) => collection['id'] == collectionId,
        orElse: () => throw Exception('Collection not found'),
      );

      return Collection.fromJson(collectionJson);
    } catch (e) {
      return null;
    }
  }

  /// Get collection by handle
  Future<Collection?> getCollectionByHandle(String handle) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));

      final collectionJson = _mockCollections.firstWhere(
        (collection) => collection['handle'] == handle,
        orElse: () => throw Exception('Collection not found'),
      );

      return Collection.fromJson(collectionJson);
    } catch (e) {
      return null;
    }
  }

  /// Get products in collection
  Future<List<Product>> getProductsInCollection({
    required String collectionId,
    int? first,
    String? after,
    String? sortKey,
    bool? reverse,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      // For mock data, return all products (in real app, this would filter by collection)
      return await getProducts(
        first: first,
        after: after,
        sortKey: sortKey,
        reverse: reverse,
      );
    } catch (e) {
      return [];
    }
  }

  // MARK: - Caching Methods

  /// Cache products locally
  Future<void> _cacheProducts(List<Product> products) async {
    try {
      for (final product in products) {
        await _storage.saveProduct(product.id, product.toJson());
      }
    } catch (e) {
      // Ignore caching errors
    }
  }

  /// Get cached products
  Future<List<Product>> _getCachedProducts() async {
    try {
      final productsData = _storage.getAllProducts();
      return productsData.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get cached product by ID
  Future<Product?> _getCachedProduct(String productId) async {
    try {
      final productData = _storage.getProduct(productId);
      if (productData != null) {
        return Product.fromJson(productData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear product cache
  Future<void> clearProductCache() async {
    try {
      await _storage.clearBox('products_box');
    } catch (e) {
      // Ignore cache clearing errors
    }
  }
}
