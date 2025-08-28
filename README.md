# GoEye - Flutter Shopify Mobile App

A complete Flutter mobile application for a Shopify store with modular architecture, designed for easy integration with real Shopify APIs later.

## 🚀 Features

### ✅ Implemented Features
- **Authentication System**: Complete login/signup with mock data
- **Modular Architecture**: Clean separation of concerns with dependency injection
- **State Management**: Riverpod for reactive state management
- **Navigation**: GoRouter for declarative routing
- **Local Storage**: Hive and SharedPreferences for data persistence
- **Network Layer**: Dio-based API client with interceptors
- **UI Components**: Modern, responsive design with Material 3
- **Product Management**: Product listing, details, and cart functionality
- **Cart System**: Add, remove, and manage cart items
- **User Management**: Profile management and order history
- **Theme Support**: Light/dark theme with customizable design system

### 🔄 Mock Data Structure
The app uses mock data that matches Shopify's API structure:
- **Products**: Full product catalog with variants, images, and pricing
- **Collections**: Product collections and categories
- **Cart**: Shopping cart with items and pricing
- **Users**: Customer profiles and authentication
- **Orders**: Order history and management

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/                    # Core functionality
│   ├── config/             # App configuration
│   ├── constants/          # App constants
│   ├── errors/             # Error handling
│   ├── network/            # Network layer
│   ├── storage/            # Local storage
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── auth/               # Authentication
│   ├── home/               # Home screen
│   ├── products/           # Product management
│   ├── cart/               # Shopping cart
│   ├── profile/            # User profile
│   └── checkout/           # Checkout process
└── shared/                 # Shared components
    ├── models/             # Data models
    ├── services/           # Business logic
    ├── widgets/            # Reusable widgets
    └── providers/          # State providers
```

### Key Architectural Patterns

#### 1. **Dependency Injection**
- Uses GetIt for service locator pattern
- Injectable for automatic dependency injection
- Easy service replacement for real API integration

#### 2. **State Management**
- Riverpod for reactive state management
- AsyncValue for loading/error states
- StateNotifier for complex state logic

#### 3. **Service Layer**
- Abstract service interfaces
- Mock implementations for development
- Easy swapping with real Shopify APIs

#### 4. **Data Models**
- JSON serializable models
- Matches Shopify API structure
- Type-safe data handling

## 🛠️ Technology Stack

### Core Dependencies
- **Flutter**: 3.2.3+
- **Dart**: 3.0.0+
- **Riverpod**: State management
- **GoRouter**: Navigation
- **Dio**: HTTP client
- **Hive**: Local database
- **SharedPreferences**: Key-value storage

### UI Dependencies
- **Cached Network Image**: Image caching
- **Shimmer**: Loading animations
- **Carousel Slider**: Image carousels
- **Pull to Refresh**: Refresh functionality

### Development Dependencies
- **Build Runner**: Code generation
- **Injectable**: Dependency injection
- **JSON Serializable**: Model serialization
- **Retrofit**: API client generation

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.2.3 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/voyageeyewear/Go-eye-app-duplicate-2025.git
   cd go_eye_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Mock Credentials
For testing the authentication system:
- **Email**: `john.doe@example.com` or `jane.smith@example.com`
- **Password**: `password123`

## 📱 App Features

### Authentication
- Login/Signup with email and password
- JWT token-based authentication
- Password reset functionality
- Email verification
- Profile management

### Product Catalog
- Product listing with images
- Product details with variants
- Search and filtering
- Collections and categories
- Sale and new arrival sections

### Shopping Cart
- Add/remove items
- Quantity management
- Price calculations
- Cart persistence
- Checkout process

### User Profile
- Personal information management
- Address management
- Order history
- Account settings

## 🎨 Design System

### Colors
- **Primary**: `#1A1A1A` (Dark Gray)
- **Secondary**: `#F5F5F5` (Light Gray)
- **Accent**: `#007AFF` (Blue)
- **Error**: `#FF3B30` (Red)
- **Success**: `#34C759` (Green)

### Typography
- **Font Family**: Inter
- **Headlines**: 32px, 28px, 24px, 20px
- **Body**: 16px, 14px
- **Caption**: 12px

### Spacing
- **XS**: 4px
- **S**: 8px
- **M**: 16px
- **L**: 24px
- **XL**: 32px
- **XXL**: 48px

## 🔧 Configuration

### App Configuration
The app can be configured through `lib/core/config/app_config.dart`:

```dart
class AppConfig {
  static const bool _useMockData = true; // Set to false for real APIs
  static const String _baseUrl = 'https://api.shopify.com';
  static const String _storefrontApiVersion = '2024-01';
}
```

### Environment Variables
Create a `.env` file for environment-specific configuration:
```env
SHOPIFY_STORE_URL=your-store.myshopify.com
SHOPIFY_STOREFRONT_TOKEN=your-storefront-token
SHOPIFY_ADMIN_TOKEN=your-admin-token
```

## 🔄 Shopify Integration

### Current State
The app currently uses mock data that matches Shopify's API structure. To integrate with real Shopify APIs:

1. **Update Configuration**
   - Set `_useMockData = false` in `AppConfig`
   - Add your Shopify store credentials

2. **Replace Services**
   - Update `AuthService` to use Shopify Customer API
   - Update `ProductService` to use Shopify Storefront API
   - Update `CartService` to use Shopify Cart API

3. **API Endpoints**
   - Storefront API: `/storefront/2024-01`
   - Admin API: `/admin/2024-01`
   - Customer API: `/customers`

### Shopify API Structure
The app is designed to work with:
- **Storefront API**: Product catalog, cart, checkout
- **Admin API**: Order management, inventory
- **Customer API**: Authentication, profiles

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📦 Building

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation

## 🔮 Roadmap

### Phase 1: Core Features ✅
- [x] Authentication system
- [x] Product catalog
- [x] Shopping cart
- [x] User profiles

### Phase 2: Enhanced Features 🚧
- [ ] Real Shopify API integration
- [ ] Payment processing
- [ ] Push notifications
- [ ] Analytics integration

### Phase 3: Advanced Features 📋
- [ ] Wishlist functionality
- [ ] Product reviews
- [ ] Social sharing
- [ ] Advanced search

### Phase 4: Optimization 🎯
- [ ] Performance optimization
- [ ] Offline support
- [ ] Multi-language support
- [ ] Accessibility improvements

---

**Built with ❤️ for the GoEye brand**
