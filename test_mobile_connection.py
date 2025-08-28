#!/usr/bin/env python3
"""
Test script to verify mobile device connectivity to the sync server
"""
import requests
import socket
import subprocess
import sys

# Server configuration
SERVER_IP = "192.168.0.104"
SERVER_PORT = 8082
BASE_URL = f"http://{SERVER_IP}:{SERVER_PORT}"

def get_local_ip():
    """Get the local IP address"""
    try:
        # Connect to a remote address to determine local IP
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "Unknown"

def test_server_connectivity():
    """Test if the server is accessible"""
    print("🔍 Testing server connectivity...")
    print(f"📍 Server IP: {SERVER_IP}")
    print(f"📍 Server Port: {SERVER_PORT}")
    print(f"📍 Local IP: {get_local_ip()}")
    print("-" * 50)
    
    # Test health endpoint
    try:
        response = requests.get(f"{BASE_URL}/health", timeout=5)
        if response.status_code == 200:
            print("✅ Server health check: PASSED")
            return True
        else:
            print(f"❌ Server health check: FAILED (Status: {response.status_code})")
            return False
    except requests.exceptions.ConnectionError:
        print("❌ Server health check: FAILED (Connection refused)")
        return False
    except requests.exceptions.Timeout:
        print("❌ Server health check: FAILED (Timeout)")
        return False
    except Exception as e:
        print(f"❌ Server health check: FAILED ({e})")
        return False

def test_api_endpoint():
    """Test the API endpoint"""
    print("\n🔍 Testing API endpoint...")
    try:
        response = requests.get(f"{BASE_URL}/api/customizations", timeout=5)
        if response.status_code == 200:
            data = response.json()
            print(f"✅ API endpoint: PASSED ({len(data)} items)")
            return True
        else:
            print(f"❌ API endpoint: FAILED (Status: {response.status_code})")
            return False
    except Exception as e:
        print(f"❌ API endpoint: FAILED ({e})")
        return False

def check_network_connectivity():
    """Check network connectivity"""
    print("\n🔍 Checking network connectivity...")
    
    # Test if port is open
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(5)
        result = sock.connect_ex((SERVER_IP, SERVER_PORT))
        sock.close()
        
        if result == 0:
            print("✅ Port 8082 is open and accessible")
            return True
        else:
            print("❌ Port 8082 is not accessible")
            return False
    except Exception as e:
        print(f"❌ Network test failed: {e}")
        return False

def provide_troubleshooting_tips():
    """Provide troubleshooting tips"""
    print("\n🔧 Troubleshooting Tips:")
    print("=" * 50)
    print("1. Make sure your mobile device and computer are on the same WiFi network")
    print("2. Check if your computer's firewall is blocking port 8082")
    print("3. Try accessing the server from your mobile browser:")
    print(f"   http://{SERVER_IP}:8082")
    print("4. If using Android, make sure the app has internet permissions")
    print("5. Check the mobile app logs for connection errors")
    print("6. Try restarting the web server: python3 web_server.py")
    print("7. Verify the IP address hasn't changed: ifconfig | grep 'inet '")

def main():
    print("📱 Mobile Connection Test for GoEye Sync")
    print("=" * 50)
    
    # Run all tests
    health_ok = test_server_connectivity()
    api_ok = test_api_endpoint() if health_ok else False
    network_ok = check_network_connectivity()
    
    print("\n📊 Test Results:")
    print("=" * 50)
    print(f"Server Health: {'✅ PASS' if health_ok else '❌ FAIL'}")
    print(f"API Endpoint: {'✅ PASS' if api_ok else '❌ FAIL'}")
    print(f"Network: {'✅ PASS' if network_ok else '❌ FAIL'}")
    
    if health_ok and api_ok and network_ok:
        print("\n🎉 All tests passed! Your mobile app should be able to connect.")
        print("📱 Install the APK and test the sync functionality.")
    else:
        print("\n⚠️ Some tests failed. Check the troubleshooting tips below.")
        provide_troubleshooting_tips()

if __name__ == "__main__":
    main()
