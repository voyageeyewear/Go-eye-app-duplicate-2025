#!/usr/bin/env python3
"""
Test script to verify Vercel sync connection
"""

import requests
import json
import time

def test_vercel_connection():
    """Test connection to Vercel deployment"""
    
    # Vercel deployment URL
    base_url = "https://go-eye-app-duplicate-2025-nz2jzupv5-voyageeyewears-projects.vercel.app"
    sync_endpoint = "/api/customizations"
    
    print("🔍 Testing Vercel Sync Connection...")
    print(f"📍 URL: {base_url}{sync_endpoint}")
    
    try:
        # Test basic connection
        print("\n1️⃣ Testing basic connection...")
        response = requests.get(f"{base_url}/", timeout=10)
        print(f"   Status: {response.status_code}")
        print(f"   Response: {response.text[:200]}...")
        
        # Test sync endpoint
        print("\n2️⃣ Testing sync endpoint...")
        response = requests.get(f"{base_url}{sync_endpoint}", timeout=10)
        print(f"   Status: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"   Data received: {json.dumps(data, indent=2)}")
            print("   ✅ Sync endpoint is working!")
        else:
            print(f"   ❌ Sync endpoint failed: {response.text}")
            
        # Test health endpoint
        print("\n3️⃣ Testing health endpoint...")
        response = requests.get(f"{base_url}/health", timeout=5)
        print(f"   Status: {response.status_code}")
        if response.status_code == 200:
            print("   ✅ Health endpoint is working!")
        else:
            print("   ⚠️ Health endpoint not available")
            
    except requests.exceptions.RequestException as e:
        print(f"   ❌ Connection failed: {e}")
    except Exception as e:
        print(f"   ❌ Error: {e}")

def test_customization_data():
    """Test sending customization data to Vercel"""
    
    base_url = "https://go-eye-app-duplicate-2025-nz2jzupv5-voyageeyewears-projects.vercel.app"
    sync_endpoint = "/api/customizations"
    
    # Sample customization data
    test_data = {
        "header": {
            "backgroundColor": "#FF6B6B",
            "textColor": "#FFFFFF",
            "logo": "https://example.com/logo.png"
        },
        "searchBar": {
            "backgroundColor": "#FFFFFF",
            "borderColor": "#FF6B6B",
            "placeholderText": "Search for frames, lenses, ..."
        },
        "timestamp": int(time.time())
    }
    
    print("\n📤 Testing data upload...")
    
    try:
        response = requests.post(
            f"{base_url}{sync_endpoint}",
            json=test_data,
            headers={'Content-Type': 'application/json'},
            timeout=10
        )
        
        print(f"   Status: {response.status_code}")
        if response.status_code in [200, 201]:
            print("   ✅ Data upload successful!")
            print(f"   Response: {response.text}")
        else:
            print(f"   ❌ Data upload failed: {response.text}")
            
    except Exception as e:
        print(f"   ❌ Upload error: {e}")

if __name__ == "__main__":
    print("🚀 Vercel Sync Test Script")
    print("=" * 50)
    
    test_vercel_connection()
    test_customization_data()
    
    print("\n" + "=" * 50)
    print("✅ Test completed!")
