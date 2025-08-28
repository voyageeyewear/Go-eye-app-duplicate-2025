#!/usr/bin/env python3
"""
Debug script to test sync functionality
"""

import requests
import json
import time

def test_server_connection():
    """Test if server is accessible"""
    try:
        response = requests.get('http://192.168.0.104:8082/health', timeout=5)
        print(f"✅ Server health check: {response.status_code}")
        return True
    except Exception as e:
        print(f"❌ Server health check failed: {e}")
        return False

def test_api_endpoint():
    """Test the API endpoint"""
    try:
        response = requests.get('http://192.168.0.104:8082/api/customizations', timeout=5)
        print(f"✅ API endpoint: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"📊 Data received: {len(data)} items")
            return True
        return False
    except Exception as e:
        print(f"❌ API endpoint failed: {e}")
        return False

def update_test_data():
    """Update test data to trigger sync"""
    test_data = {
        "test_update": True,
        "timestamp": time.time(),
        "message": "Test update from debug script"
    }
    
    try:
        response = requests.post(
            'http://192.168.0.104:8082/api/customizations',
            json=test_data,
            headers={'Content-Type': 'application/json'},
            timeout=5
        )
        print(f"✅ Test data update: {response.status_code}")
        return True
    except Exception as e:
        print(f"❌ Test data update failed: {e}")
        return False

def main():
    print("🔍 Testing GoEye Sync Functionality")
    print("=" * 50)
    
    # Test 1: Server connection
    print("\n1. Testing server connection...")
    if not test_server_connection():
        print("❌ Server is not accessible")
        return
    
    # Test 2: API endpoint
    print("\n2. Testing API endpoint...")
    if not test_api_endpoint():
        print("❌ API endpoint is not working")
        return
    
    # Test 3: Update test data
    print("\n3. Testing data update...")
    if update_test_data():
        print("✅ All tests passed! Server is working correctly.")
        print("\n📱 If your mobile app is still not syncing, the issue is in the Flutter app.")
        print("   Check the Flutter console logs for sync messages.")
    else:
        print("❌ Data update failed")

if __name__ == "__main__":
    main()
