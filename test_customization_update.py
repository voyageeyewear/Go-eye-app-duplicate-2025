#!/usr/bin/env python3
"""
Test script to update customization data and verify sync
"""
import json
import requests

def update_customization_data():
    # Load current data
    with open('customization_data.json', 'r') as f:
        data = json.load(f)
    
    # Make a visible change
    data['promotionalBannerText'] = "🔥 HOT DEAL: 70% Off on All Frames! Limited Time!"
    data['collectionsSectionTitle'] = "🔥 HOT Collections"
    
    # Update the first collection
    if data['collections']:
        data['collections'][0]['title'] = "🔥 Summer Collection UPDATED"
        data['collections'][0]['subtitle'] = "🔥 Trendy frames for sunny days - UPDATED!"
    
    # Save back to file
    with open('customization_data.json', 'w') as f:
        json.dump(data, f, indent=2)
    
    # Also send to server
    try:
        response = requests.post(
            'http://192.168.0.104:8082/api/customizations',
            json=data,
            headers={'Content-Type': 'application/json'}
        )
        print(f"✅ Server update response: {response.status_code}")
    except Exception as e:
        print(f"❌ Server update failed: {e}")
    
    print("✅ Customization data updated with 🔥 emojis!")
    print("📱 Now test the green sync button on your mobile app!")

if __name__ == "__main__":
    update_customization_data()
