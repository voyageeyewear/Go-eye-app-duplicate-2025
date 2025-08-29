#!/bin/bash

# Setup Development Environment
# Configures PATH and environment for Flutter development

echo "🔧 Setting up Flutter development environment..."
echo "=============================================="

# Add Android SDK to PATH
export ANDROID_HOME="/Users/dhruv/Desktop/android-sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# Add Flutter to PATH (if not already there)
export PATH="/opt/homebrew/share/flutter/bin:$PATH"

echo "✅ Environment variables set:"
echo "   ANDROID_HOME: $ANDROID_HOME"
echo "   Flutter: $(which flutter)"
echo "   ADB: $(which adb)"

# Test ADB connection
echo ""
echo "📱 Testing ADB connection..."
adb devices

echo ""
echo "🔍 Checking Flutter devices..."
flutter devices

echo ""
echo "✅ Environment setup complete!"
echo "🚀 You can now run:"
echo "   ./scripts/start_dev.sh"
echo "   ./scripts/quick_dev.sh"
echo "   ./scripts/connect_wifi.sh"
