# 🚀 Quick Start - Flutter Hot Reload Development

## ⚡ Get Started in 3 Steps

### Step 1: Connect Your Android Device

**Option A: USB Connection (Easiest)**
```bash
# 1. Connect your Android device via USB
# 2. Enable USB Debugging in Developer Options
# 3. Verify connection
flutter devices
```

**Option B: WiFi Connection (Recommended for development)**
```bash
# 1. Connect via USB first
# 2. Run the WiFi setup script
./scripts/connect_wifi.sh

# 3. Follow the prompts to enter your device's IP address
# 4. Disconnect USB cable when prompted
```

### Step 2: Start Development Mode

**Quick Start (Recommended):**
```bash
./scripts/quick_dev.sh
```

**Full Setup (First time only):**
```bash
./scripts/start_dev.sh
```

**Manual Start:**
```bash
flutter run -d android --debug --hot
```

### Step 3: Start Coding!

1. **Make changes** in Cursor
2. **Save the file** (Ctrl+S / Cmd+S)
3. **Watch the app update instantly** on your device
4. **Use hot reload commands** in terminal:
   - `r` - Hot reload (preserves state)
   - `R` - Hot restart (resets state)
   - `q` - Quit

## 🎯 What You Get

✅ **Instant code updates** - No APK rebuilding  
✅ **Preserved app state** - Hot reload keeps your data  
✅ **Real-time debugging** - See errors immediately  
✅ **Performance monitoring** - Built-in DevTools  
✅ **Wireless development** - No cables needed  

## 🔧 Troubleshooting

**Device not detected?**
```bash
# Check ADB connection
adb devices

# Restart ADB
adb kill-server && adb start-server

# Check Flutter
flutter devices
```

**Hot reload not working?**
```bash
# Restart Flutter daemon
flutter daemon --shutdown

# Clear cache
flutter clean && flutter pub get
```

**Performance issues?**
```bash
# Use profile mode
flutter run -d android --profile
```

## 📱 Device Requirements

- Android 5.0+ (API 21+)
- USB Debugging enabled
- Developer Options enabled
- Same WiFi network (for wireless)

## 🎉 You're Ready!

Your Flutter app will now automatically sync with your Android device. Any changes you make in Cursor will be reflected immediately on your device without rebuilding APKs!

**Next Steps:**
- Open your app in Cursor
- Make some changes
- Save the file
- Watch it update on your device instantly!
