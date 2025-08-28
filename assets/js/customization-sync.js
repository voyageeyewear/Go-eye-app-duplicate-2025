// Customization sync for web app
class WebCustomizationSync {
  constructor() {
    this.baseUrl = 'https://go-eye-app-duplicate-2025.vercel.app';
    this.syncInterval = 5000; // 5 seconds
    this.isInitialized = false;
  }

  async init() {
    if (this.isInitialized) return;
    
    console.log('🌐 Initializing web customization sync...');
    
    // Load initial data
    await this.loadCustomizationData();
    
    // Set up periodic sync
    setInterval(() => {
      this.loadCustomizationData();
    }, this.syncInterval);
    
    this.isInitialized = true;
    console.log('✅ Web customization sync initialized');
  }

  async loadCustomizationData() {
    try {
      const response = await fetch(`${this.baseUrl}/api/customizations`);
      if (response.ok) {
        const data = await response.json();
        console.log('📥 Loaded customization data:', Object.keys(data).length, 'items');
        
        // Store in localStorage for the Flutter app to access
        localStorage.setItem('header_customization_data', JSON.stringify(data));
        
        // Trigger a custom event that Flutter can listen to
        window.dispatchEvent(new CustomEvent('customizationDataUpdated', { 
          detail: data 
        }));
        
        return data;
      } else {
        console.log('⚠️ Failed to load customization data:', response.status);
      }
    } catch (error) {
      console.log('❌ Error loading customization data:', error.message);
    }
    return null;
  }

  async saveCustomizationData(data) {
    try {
      const response = await fetch(`${this.baseUrl}/api/customizations`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
      });
      
      if (response.ok) {
        console.log('✅ Customization data saved successfully');
        return true;
      } else {
        console.log('⚠️ Failed to save customization data:', response.status);
        return false;
      }
    } catch (error) {
      console.log('❌ Error saving customization data:', error.message);
      return false;
    }
  }
}

// Initialize sync when page loads
window.addEventListener('load', () => {
  window.customizationSync = new WebCustomizationSync();
  window.customizationSync.init();
});

// Export for use in other scripts
window.WebCustomizationSync = WebCustomizationSync;
