#!/bin/bash

# APK Building Script
# Builds APK files for testing on Android devices

echo "📱 Building APK for Android device testing..."
echo "=============================================="

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build debug APK
echo "🔨 Building debug APK..."
flutter build apk --debug

if [ $? -eq 0 ]; then
    echo "✅ Debug APK built successfully!"
    echo "📁 Location: build/app/outputs/flutter-apk/app-debug.apk"
    echo "📏 Size: $(ls -lh build/app/outputs/flutter-apk/app-debug.apk | awk '{print $5}')"
    
    # Show APK info
    echo ""
    echo "📋 APK Information:"
    echo "   File: app-debug.apk"
    echo "   Path: $(pwd)/build/app/outputs/flutter-apk/app-debug.apk"
    echo "   Type: Debug (for testing)"
    
    # Ask if user wants to build release APK too
    echo ""
    read -p "🤔 Do you also want to build a release APK? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🔨 Building release APK..."
        flutter build apk --release
        
        if [ $? -eq 0 ]; then
            echo "✅ Release APK built successfully!"
            echo "📁 Location: build/app/outputs/flutter-apk/app-release.apk"
            echo "📏 Size: $(ls -lh build/app/outputs/flutter-apk/app-release.apk | awk '{print $5}')"
        else
            echo "❌ Failed to build release APK"
        fi
    fi
    
    echo ""
    echo "🎉 APK building complete!"
    echo "📱 To install on your device:"
    echo "   1. Transfer the APK to your Android device"
    echo "   2. Enable 'Install from unknown sources' in settings"
    echo "   3. Tap the APK file to install"
    echo ""
    echo "💡 For development with hot reload, use: ./scripts/quick_dev.sh"
    
else
    echo "❌ Failed to build debug APK"
    exit 1
fi
