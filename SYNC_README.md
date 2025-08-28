# 🔄 GoEye App - Web Backend Sync

## Overview
The GoEye app now supports real-time synchronization between the web backend (localhost) and the mobile APK app. Any customizations made on the web backend will automatically reflect on your mobile app within 5 seconds.

## 🚀 How to Use

### 1. Start the Web Server
```bash
# Make sure you're in the project directory
cd /Users/dhruv/Desktop/GoEye-app-dup-2025

# Start the sync server
python3 web_server.py
```

You should see:
```
🚀 Starting GoEye customization sync server on port 8082
📱 Mobile app will sync every 5 seconds
🌐 Web app available at: http://localhost:8082
🔗 API endpoint: http://localhost:8082/api/customizations
💚 Health check: http://localhost:8082/health
```

### 2. Test the Sync (Optional)
```bash
# Run the test script to upload sample data
python3 test_sync.py

# Test mobile connectivity
python3 test_mobile_connection.py
```

### 3. Install the Mobile App
- Download the APK: `build/app/outputs/flutter-apk/app-release.apk`
- Install it on your Android device
- Make sure your phone and computer are on the same network

### 4. Customize on Web Backend
1. Open your browser and go to: `http://localhost:8082`
2. Navigate to the "Customize" tab
3. Make any changes you want (colors, text, images, etc.)
4. Changes are automatically saved and synced

### 5. See Changes on Mobile App
- Open the GoEye app on your phone
- **Look for the green sync button** in the header (next to the shopping cart)
- **Tap the sync button** to manually trigger a sync
- The changes you made on the web backend will appear within 5 seconds
- No need to restart the app or refresh

## 🔧 How It Works

### Sync Process
1. **Web Backend**: Customizations are saved to the server
2. **Mobile App**: Checks for updates every 5 seconds
3. **Automatic Update**: New data is downloaded and applied
4. **Local Storage**: Changes are also saved locally for offline use

### API Endpoints
- `GET /health` - Check if server is running
- `GET /api/customizations` - Get current customization data
- `POST /api/customizations` - Save customization data

### Network Requirements
- Both devices must be on the same WiFi network
- Server runs on `localhost:8082`
- Mobile app connects to your computer's IP address

## 📱 Mobile App Features

### Sync Status
- App automatically detects if web backend is available
- Shows sync status in console logs
- Falls back to local storage if server is unavailable

### What Syncs
✅ Header customizations  
✅ Promotional banner settings  
✅ Collection items and images  
✅ Product categories  
✅ Eyeglasses/Sunglasses category cards  
✅ Video carousel settings  
✅ Today's mood section  
✅ Most loved products  
✅ Instagram showcase  
✅ Video categories  
✅ All font sizes and families  
✅ Colors and styling  

## 🛠️ Troubleshooting

### Server Not Starting
```bash
# Check if port is in use
lsof -i :8082

# Kill existing process
lsof -ti:8082 | xargs kill -9

# Start server again
python3 web_server.py
```

### Mobile App Not Syncing
1. Check if server is running: `curl http://localhost:8082/health`
2. Ensure both devices are on same network
3. Check console logs in mobile app for sync status
4. Restart the mobile app

### Network Issues
- Make sure your computer's firewall allows connections on port 8082
- Try using your computer's IP address instead of localhost
- Check that both devices are on the same WiFi network

## 📊 Monitoring

### Server Logs
The web server shows:
- API requests and responses
- Customization data updates
- File serving statistics

### Mobile App Logs
Look for these messages:
- `✅ Web backend is available - sync enabled`
- `✅ Customizations synced from web backend`
- `⚠️ Web backend not available - using local storage only`

## 🔄 Manual Sync

If you need to force a sync:
1. Make changes on web backend
2. Wait 5 seconds for automatic sync
3. Or restart the mobile app to trigger immediate sync

## 📁 Files

- `web_server.py` - Custom web server with sync API
- `lib/shared/services/sync_service.dart` - Mobile sync service
- `customization_data.json` - Persistent storage for customizations
- `SYNC_README.md` - This documentation

## 🎯 Benefits

1. **Real-time Updates**: Changes appear instantly on mobile
2. **No Manual Refresh**: App automatically syncs every 5 seconds
3. **Offline Support**: App works even when server is down
4. **Persistent Storage**: Changes are saved permanently
5. **Easy Testing**: Test changes on web, see results on mobile

---

**Note**: This sync system is designed for development and testing. For production, you would want to use a proper backend server with authentication and security measures.
