#!/bin/bash

# WiFi Connection Script for Android Development
# Connects your Android device via WiFi for wireless development

echo "🌐 Setting up WiFi connection for Android development..."
echo "======================================================"

# Check if device is connected via USB
echo "📱 Checking USB connection..."
USB_DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$")

if [ -z "$USB_DEVICES" ]; then
    echo "❌ No Android device connected via USB!"
    echo "🔧 Please connect your device via USB cable first"
    exit 1
fi

echo "✅ USB device detected: $USB_DEVICES"

# Enable TCP/IP mode
echo "🔌 Enabling TCP/IP mode..."
adb tcpip 5555

echo "⏳ Waiting for device to restart ADB..."
sleep 3

# Get device IP address
echo "🔍 Getting device IP address..."
echo "📱 Please check your device's WiFi settings for the IP address"
echo "💡 Usually it's something like 192.168.1.xxx"

read -p "Enter your device's IP address: " DEVICE_IP

if [ -z "$DEVICE_IP" ]; then
    echo "❌ No IP address provided"
    exit 1
fi

# Connect to device via WiFi
echo "🔗 Connecting to $DEVICE_IP:5555..."
adb connect "$DEVICE_IP:5555"

# Verify connection
echo "✅ Verifying connection..."
sleep 2

WIFI_DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$")
if echo "$WIFI_DEVICES" | grep -q "$DEVICE_IP"; then
    echo "🎉 Successfully connected via WiFi!"
    echo "📱 You can now disconnect the USB cable"
    echo "🚀 Run './scripts/start_dev.sh' to start development"
else
    echo "❌ Failed to connect via WiFi"
    echo "🔧 Please check:"
    echo "   - Device and computer are on same WiFi network"
    echo "   - IP address is correct"
    echo "   - Firewall isn't blocking the connection"
fi
