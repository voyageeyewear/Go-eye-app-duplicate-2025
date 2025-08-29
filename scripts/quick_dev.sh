#!/bin/bash

# Quick Development Script
# Fast startup for daily development with hot reload

echo "⚡ Quick Development Mode"
echo "========================="

# Check for Android device
ANDROID_DEVICE=$(flutter devices | grep "android" | head -1 | awk '{print $1}')

if [ -z "$ANDROID_DEVICE" ]; then
    echo "❌ No Android device found!"
    echo "📱 Please connect your device and run: flutter devices"
    exit 1
fi

echo "📱 Using device: $ANDROID_DEVICE"

# Quick dependency check
echo "📦 Checking dependencies..."
flutter pub get

# Start development with optimizations
echo "🔥 Starting optimized development mode..."
echo "💡 Hot reload: 'r' | Hot restart: 'R' | Quit: 'q'"
echo "================================================"

flutter run -d "$ANDROID_DEVICE" \
    --debug \
    --hot \
    --fast-start \
    --enable-software-rendering
