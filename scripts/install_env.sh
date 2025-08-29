#!/bin/bash

# Install Environment Variables Permanently
# Adds Android SDK and Flutter to your shell profile

echo "🔧 Installing Flutter development environment permanently..."
echo "=========================================================="

# Determine shell profile
if [ -f "$HOME/.zshrc" ]; then
    PROFILE_FILE="$HOME/.zshrc"
    echo "📝 Using .zshrc profile"
elif [ -f "$HOME/.bash_profile" ]; then
    PROFILE_FILE="$HOME/.bash_profile"
    echo "📝 Using .bash_profile"
elif [ -f "$HOME/.bashrc" ]; then
    PROFILE_FILE="$HOME/.bashrc"
    echo "📝 Using .bashrc"
else
    PROFILE_FILE="$HOME/.zshrc"
    echo "📝 Creating .zshrc profile"
fi

# Check if already configured
if grep -q "ANDROID_HOME" "$PROFILE_FILE" 2>/dev/null; then
    echo "✅ Environment already configured in $PROFILE_FILE"
    echo "🔄 To reload environment, run: source $PROFILE_FILE"
else
    # Add environment variables
    echo "" >> "$PROFILE_FILE"
    echo "# Flutter Development Environment" >> "$PROFILE_FILE"
    echo "export ANDROID_HOME=\"/Users/dhruv/Desktop/android-sdk\"" >> "$PROFILE_FILE"
    echo "export PATH=\"\$ANDROID_HOME/platform-tools:\$PATH\"" >> "$PROFILE_FILE"
    echo "export PATH=\"\$ANDROID_HOME/tools:\$PATH\"" >> "$PROFILE_FILE"
    echo "export PATH=\"\$ANDROID_HOME/tools/bin:\$PATH\"" >> "$PROFILE_FILE"
    echo "export PATH=\"/opt/homebrew/share/flutter/bin:\$PATH\"" >> "$PROFILE_FILE"
    
    echo "✅ Environment variables added to $PROFILE_FILE"
    echo "🔄 To activate, run: source $PROFILE_FILE"
fi

echo ""
echo "🎉 Installation complete!"
echo "📱 You can now use ADB and Flutter commands directly"
echo "🚀 Run './scripts/quick_dev.sh' to start development"
