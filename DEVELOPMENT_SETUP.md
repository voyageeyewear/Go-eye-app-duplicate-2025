# Flutter Development Setup - Hot Reload & Auto Deployment

## 🚀 Complete Setup for Automatic Code Sync

This guide will set up your Flutter project for seamless development where code changes in Cursor are immediately reflected on your Android device without rebuilding APKs.

## 📱 Prerequisites

1. **Android Device Setup**:
   - Enable Developer Options on your Android device
   - Enable USB Debugging
   - Enable Wireless Debugging (for WiFi connection)
   - Connect device via USB or WiFi

2. **Flutter Environment**:
   - Flutter SDK installed and configured
   - Android SDK installed
   - ADB (Android Debug Bridge) working

## 🔧 Step-by-Step Setup

### 1. Connect Your Android Device

**Via USB:**
```bash
# Connect your device via USB cable
# Enable USB debugging in Developer Options
flutter devices  # Should show your device
```

**Via WiFi (Recommended for development):**
```bash
# 1. Connect via USB first
adb tcpip 5555

# 2. Get your device IP (shown in WiFi settings)
adb connect YOUR_DEVICE_IP:5555

# 3. Disconnect USB cable
# 4. Verify connection
flutter devices
```

### 2. Development Commands

**Initial Setup (Run Once):**
```bash
# Install app in debug mode with hot reload
flutter run -d android --debug --hot
```

**Daily Development Workflow:**
```bash
# Start development server (run this once per session)
./scripts/start_dev.sh

# Or manually:
flutter run -d android --debug --hot --verbose
```

### 3. Hot Reload Commands

When the app is running, use these commands:
- `r` - Hot reload (preserves state)
- `R` - Hot restart (resets state)
- `q` - Quit the app
- `h` - Show all commands

## 🛠️ Scripts and Automation

### Quick Start Script
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Start development
./scripts/start_dev.sh
```

### VS Code/Cursor Integration
Add these to your `.vscode/settings.json`:
```json
{
  "flutter.hotReloadOnSave": true,
  "flutter.hotRestartOnSave": false,
  "dart.flutterSdkPath": "/opt/homebrew/share/flutter"
}
```

## 📋 Troubleshooting

### Device Not Detected
```bash
# Check ADB connection
adb devices

# Restart ADB server
adb kill-server
adb start-server

# Check Flutter devices
flutter devices
```

### Hot Reload Not Working
```bash
# Restart Flutter daemon
flutter daemon --shutdown
flutter doctor

# Clear Flutter cache
flutter clean
flutter pub get
```

### Performance Issues
```bash
# Run in profile mode for better performance
flutter run -d android --profile

# Enable Skia rendering
flutter run -d android --enable-software-rendering
```

## 🔄 Workflow Summary

1. **Connect Device**: USB or WiFi
2. **Start Development**: `flutter run -d android --debug --hot`
3. **Make Changes**: Edit code in Cursor
4. **Auto Sync**: Changes reflect immediately on device
5. **Hot Reload**: Press `r` for instant updates
6. **Hot Restart**: Press `R` if needed

## 📱 Device Requirements

- Android 5.0 (API level 21) or higher
- USB Debugging enabled
- Developer Options enabled
- Sufficient storage space

## 🎯 Benefits

✅ **No APK rebuilding required**  
✅ **Instant code changes**  
✅ **Preserved app state**  
✅ **Debug tools available**  
✅ **Performance monitoring**  
✅ **Real-time error reporting**

## 🚨 Important Notes

- Keep your device connected during development
- Use WiFi connection for better mobility
- Monitor device battery and storage
- Use Flutter DevTools for debugging
- Save files frequently for auto-reload

## 📞 Support

If you encounter issues:
1. Check `flutter doctor` output
2. Verify device connection with `adb devices`
3. Restart Flutter daemon
4. Clear Flutter cache if needed
