#!/usr/bin/env python3
"""
Test script for GoEye sync functionality
"""
import requests
import json
import time

# Server configuration
BASE_URL = "http://192.168.0.104:8082"
API_ENDPOINT = f"{BASE_URL}/api/customizations"
HEALTH_ENDPOINT = f"{BASE_URL}/health"

def test_server_health():
    """Test if the server is running"""
    try:
        response = requests.get(HEALTH_ENDPOINT, timeout=5)
        if response.status_code == 200:
            print("✅ Server is running and healthy")
            return True
        else:
            print(f"❌ Server health check failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Cannot connect to server: {e}")
        return False

def get_current_customizations():
    """Get current customization data"""
    try:
        response = requests.get(API_ENDPOINT, timeout=5)
        if response.status_code == 200:
            data = response.json()
            print(f"📊 Current customizations: {len(data)} items")
            return data
        else:
            print(f"❌ Failed to get customizations: {response.status_code}")
            return {}
    except Exception as e:
        print(f"❌ Error getting customizations: {e}")
        return {}

def upload_sample_customizations():
    """Upload sample customization data for testing"""
    sample_data = {
        "showPromotionalBanner": True,
        "promotionalBannerText": "🎉 FREE LENS with every frame!",
        "promotionalBannerBackgroundColor": 4294198070,  # Red color
        "promotionalBannerTextColor": 4294967295,  # White color
        "headerBackgroundColor": 4278190080,  # Dark blue
        "collectionsSectionTitle": "🔥 HOT COLLECTIONS",
                            "collections": [
                        {
                            "id": "collection1",
                            "title": "Ms fierceness...",
                            "subtitle": "Fierce and bold eyewear for the confident woman",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400",
                            "isVisible": True
                        },
                        {
                            "id": "collection2", 
                            "title": "Visionary",
                            "subtitle": "Mastering the art of luxury eyewear",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400",
                            "isVisible": True
                        }
                    ],
                    "mensStyleCards": [
                        {
                            "id": "mens_style1",
                            "title": "CEO Look",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        },
                        {
                            "id": "mens_style2",
                            "title": "Casual Wear",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        }
                    ],
                    "womensStyleCards": [
                        {
                            "id": "womens_style1",
                            "title": "Boss Lady",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        },
                        {
                            "id": "womens_style2",
                            "title": "Glam Queen",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        }
                    ],
                    "mostLovedProducts": [
                        {
                            "id": "product1",
                            "title": "RICKER",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        },
                        {
                            "id": "product2",
                            "title": "COMMANDER",
                            "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                            "isVisible": True
                        }
                    ],
        "eyeglassesCategoryCards": [
            {
                "id": "men_eyeglasses",
                "title": "Men",
                "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                "isVisible": True
            },
            {
                "id": "women_eyeglasses", 
                "title": "Women",
                "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                "isVisible": True
            }
        ],
        "sunglassesCategoryCards": [
            {
                "id": "sunglasses",
                "title": "Sunglasses",
                "imagePath": "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200",
                "isVisible": True
            }
        ],
        "videoCarouselTitle": "🎬 Watch Our Story",
        "showVideoCarousel": True,
        "todaysMoodTitle": "💫 Today's Mood",
        "showTodaysMoodSection": True,
        "mostLovedTitle": "❤️ Most Loved",
        "showMostLovedSection": True
    }
    
    try:
        response = requests.post(
            API_ENDPOINT,
            json=sample_data,
            headers={'Content-Type': 'application/json'},
            timeout=10
        )
        
        if response.status_code == 200:
            print("✅ Sample customizations uploaded successfully!")
            print("📱 Your mobile app should now sync these changes within 5 seconds")
            return True
        else:
            print(f"❌ Failed to upload customizations: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Error uploading customizations: {e}")
        return False

def main():
    print("🧪 GoEye Sync Test Script")
    print("=" * 40)
    
    # Test server health
    if not test_server_health():
        print("\n❌ Server is not running. Please start the server first:")
        print("   python3 web_server.py")
        return
    
    print("\n📊 Current server status:")
    current_data = get_current_customizations()
    
    if not current_data:
        print("\n📤 Uploading sample customizations...")
        if upload_sample_customizations():
            print("\n⏳ Waiting 5 seconds for mobile app to sync...")
            time.sleep(5)
            
            print("\n📊 Updated server data:")
            get_current_customizations()
        else:
            print("\n❌ Failed to upload sample data")
    else:
        print("\n✅ Server already has customization data")
        print("📱 Your mobile app should be syncing this data")

if __name__ == "__main__":
    main()
