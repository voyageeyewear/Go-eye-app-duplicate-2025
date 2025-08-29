#!/usr/bin/env python3
"""
Final test script to update customization data and verify sync
"""
import json
import requests
import time

def update_customization_data():
    print("🔥 FINAL SYNC TEST - Updating customization data...")
    
    # Load current data
    with open('customization_data.json', 'r') as f:
        data = json.load(f)
    
    # Make very visible changes
    data['promotionalBannerText'] = "🔥 FINAL TEST: 90% Off Everything! 🔥"
    data['collectionsSectionTitle'] = "🔥 FINAL Collections"
    
    # Update the first collection
    if data['collections']:
        data['collections'][0]['title'] = "🔥 FINAL Collection"
        data['collections'][0]['subtitle'] = "🔥 This is a FINAL test!"
    
    # Save back to file
    with open('customization_data.json', 'w') as f:
        json.dump(data, f, indent=2)
    
    # Send to server
    try:
        response = requests.post(
            'http://192.168.0.121:8082/api/customizations',
            json=data,
            headers={'Content-Type': 'application/json'}
        )
        print(f"✅ Server update response: {response.status_code}")
        
        if response.status_code == 200:
            print("🎉 FINAL TEST DATA UPDATED SUCCESSFULLY!")
            print("📱 Now test your mobile app:")
            print("   1. Open your mobile APK")
            print("   2. Tap the green sync button")
            print("   3. You should see '🔥 FINAL TEST: 90% Off Everything! 🔥'")
            print("   4. And '🔥 FINAL Collections' title")
        else:
            print(f"❌ Server update failed: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Server update failed: {e}")
    
    print("\n" + "="*50)
    print("🔥 FINAL TEST COMPLETE!")
    print("="*50)

if __name__ == "__main__":
    update_customization_data()

