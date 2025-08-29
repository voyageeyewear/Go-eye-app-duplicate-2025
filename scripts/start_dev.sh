#!/bin/bash

# Flutter Development Startup Script
# Automatically detects Android devices and starts development mode

echo "🚀 Starting Flutter Development Mode..."
echo "======================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Check Flutter doctor
echo "🔍 Checking Flutter environment..."
flutter doctor --android-licenses

# Get available devices
echo "📱 Checking for connected devices..."
DEVICES=$(flutter devices)

# Check if Android device is connected
if echo "$DEVICES" | grep -q "android"; then
    echo "✅ Android device detected!"
    
    # Get the Android device ID
    ANDROID_DEVICE=$(echo "$DEVICES" | grep "android" | head -1 | awk '{print $1}')
    echo "📱 Using device: $ANDROID_DEVICE"
    
    # Clean and get dependencies
    echo "🧹 Cleaning project..."
    flutter clean
    flutter pub get
    
    # Start development mode
    echo "🔥 Starting development mode with hot reload..."
    echo "💡 Use 'r' for hot reload, 'R' for hot restart, 'q' to quit"
    echo "======================================"
    
    flutter run -d "$ANDROID_DEVICE" --debug --hot --verbose
    
else
    echo "❌ No Android device detected!"
    echo "📋 Available devices:"
    echo "$DEVICES"
    echo ""
    echo "🔧 To connect your Android device:"
    echo "1. Enable Developer Options on your device"
    echo "2. Enable USB Debugging"
    echo "3. Connect via USB cable"
    echo "4. Run: adb devices"
    echo "5. Run this script again"
    echo ""
    echo "🌐 For WiFi connection:"
    echo "1. Connect via USB first"
    echo "2. Run: adb tcpip 5555"
    echo "3. Run: adb connect YOUR_DEVICE_IP:5555"
    echo "4. Disconnect USB"
    echo "5. Run this script again"
    exit 1
fi
