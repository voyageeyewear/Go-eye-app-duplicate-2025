# 🔧 GoEye Sync Debugging Guide

## 🎯 **Issue**: Mobile APK not showing customized content

### ✅ **What's Fixed**:
1. **Storage Key Mismatch**: Fixed sync service saving to wrong key
2. **Data Reload**: Added callback to reload data after sync
3. **Debug Logging**: Added detailed console logs
4. **Manual Sync Button**: Added green sync button in header

### 📱 **New APK Features**:
- **Green Sync Button**: In header (next to shopping cart)
- **Detailed Logs**: Console shows sync progress
- **Auto Reload**: Data refreshes after successful sync

---

## 🧪 **Testing Steps**:

### 1. **Install the New APK**
```bash
# APK Location:
/Users/dhruv/Desktop/GoEye-app-dup-2025/build/app/outputs/flutter-apk/app-release.apk
```

### 2. **Check Server Status**
```bash
# Test server connectivity
python3 test_mobile_connection.py

# Expected output:
✅ Server health check: PASSED
✅ API endpoint: PASSED (15 items)
✅ Port 8082 is open and accessible
```

### 3. **Test Manual Sync**
1. Open the GoEye app on your phone
2. Look for the **green sync button** in the header
3. Tap the sync button
4. Check console logs for:
   ```
   🔄 Manual sync triggered
   🔄 Attempting to sync from: http://192.168.0.104:8082/api/customizations
   📡 Response status: 200
   📊 Received 15 customization items
   ✅ Customizations synced from web backend
   ✅ Local storage updated with web backend data
   ✅ Loaded customization data from local storage
   ```

### 4. **Expected Changes After Sync**
- **Collections**: Should show custom images instead of grey placeholders
- **Eyeglasses Categories**: Should show custom images/URLs
- **Sunglasses Categories**: Should show custom images/URLs
- **Promotional Banner**: Should show custom text and colors
- **Section Titles**: Should show custom fonts and sizes

---

## 🔍 **Debugging Checklist**:

### ✅ **Network Issues**
- [ ] Phone and computer on same WiFi network
- [ ] Server running on `192.168.0.104:8082`
- [ ] No firewall blocking port 8082
- [ ] Can access `http://192.168.0.104:8082` from mobile browser

### ✅ **App Issues**
- [ ] App has internet permissions
- [ ] Green sync button visible in header
- [ ] Console logs show sync attempts
- [ ] No error messages in logs

### ✅ **Data Issues**
- [ ] Server has customization data (15 items)
- [ ] Local storage key matches (`header_customization_data`)
- [ ] Data format is correct (JSON)
- [ ] Provider reloads after sync

---

## 🚨 **Common Issues & Solutions**:

### **Issue 1: Still showing placeholder content**
**Solution**: 
1. Tap the green sync button
2. Check console logs for sync success
3. Wait 5 seconds for auto-sync
4. Restart the app if needed

### **Issue 2: Sync button not visible**
**Solution**: 
1. Make sure you installed the latest APK
2. Check if the app has proper permissions
3. Restart the app

### **Issue 3: Console shows sync errors**
**Solution**:
1. Check network connectivity
2. Verify server is running
3. Check IP address hasn't changed
4. Run `python3 test_mobile_connection.py`

### **Issue 4: Data syncs but UI doesn't update**
**Solution**:
1. Check if provider reloads data
2. Verify data format is correct
3. Check for UI state management issues

---

## 📊 **Monitoring Tools**:

### **Server Logs**
```bash
# Watch server logs
python3 web_server.py

# Expected logs:
🌐 API GET /api/customizations - 192.168.0.104
✅ Customization data updated: 15 items
```

### **Mobile App Logs**
Look for these messages in console:
- `🔄 Manual sync triggered`
- `📡 Response status: 200`
- `📊 Received 15 customization items`
- `✅ Customizations synced from web backend`
- `✅ Loaded customization data from local storage`

### **Connection Test**
```bash
python3 test_mobile_connection.py
```

---

## 🎯 **Next Steps**:

1. **Install the new APK**
2. **Test the green sync button**
3. **Check console logs for sync success**
4. **Verify content updates**
5. **Report any remaining issues**

---

## 📞 **Support**:

If sync still doesn't work:
1. Share console logs from mobile app
2. Share server logs
3. Share network test results
4. Describe exactly what you see vs. what you expect

**The sync should now work properly with the new APK!** 🎉
