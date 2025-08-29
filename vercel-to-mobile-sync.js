// Vercel to Mobile Sync Script
// Add this to your Vercel app to sync changes to your mobile APK

class VercelToMobileSync {
    constructor() {
        this.localServerUrl = 'http://192.168.0.121:8082';
        this.syncInterval = 5000; // 5 seconds
        this.isSyncing = false;
        this.lastSyncTime = null;
    }

    // Initialize the sync
    init() {
        console.log('🚀 Initializing Vercel to Mobile sync...');
        this.startPeriodicSync();
        this.setupCustomizationListeners();
    }

    // Start periodic sync with local server
    startPeriodicSync() {
        setInterval(() => {
            this.syncToLocalServer();
        }, this.syncInterval);
    }

    // Setup listeners for customization changes
    setupCustomizationListeners() {
        // Listen for changes in the customization panel
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (mutation.type === 'attributes' || mutation.type === 'childList') {
                    this.handleCustomizationChange();
                }
            });
        });

        // Observe the customization panel
        const customizationPanel = document.querySelector('[data-customization-panel]') || 
                                  document.querySelector('.customization-panel') ||
                                  document.body;
        
        observer.observe(customizationPanel, {
            attributes: true,
            childList: true,
            subtree: true
        });

        // Also listen for form changes
        document.addEventListener('change', (e) => {
            if (e.target.matches('input, select, textarea')) {
                this.handleCustomizationChange();
            }
        });

        console.log('✅ Customization listeners setup complete');
    }

    // Handle customization changes
    handleCustomizationChange() {
        console.log('🔄 Customization change detected');
        this.syncToLocalServer();
    }

    // Sync current customization data to local server
    async syncToLocalServer() {
        if (this.isSyncing) return;
        
        try {
            this.isSyncing = true;
            console.log('📡 Syncing to local server...');

            // Get current customization data from the page
            const customizationData = this.extractCustomizationData();
            
            // Send to local server
            const response = await fetch(`${this.localServerUrl}/api/customizations`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(customizationData)
            });

            if (response.ok) {
                this.lastSyncTime = new Date();
                console.log('✅ Successfully synced to local server');
                this.showSyncStatus('✅ Synced to mobile app', 'success');
            } else {
                throw new Error(`Server responded with ${response.status}`);
            }

        } catch (error) {
            console.error('❌ Sync failed:', error);
            this.showSyncStatus('❌ Sync failed - check local server', 'error');
        } finally {
            this.isSyncing = false;
        }
    }

    // Extract customization data from the current page
    extractCustomizationData() {
        // This function should extract the current customization data from your Vercel app
        // You'll need to customize this based on your actual app structure
        
        const data = {
            showPromotionalBanner: this.getBannerVisibility(),
            promotionalBannerText: this.getBannerText(),
            promotionalBannerBackgroundColor: this.getBannerBackgroundColor(),
            promotionalBannerTextColor: this.getBannerTextColor(),
            headerBackgroundColor: this.getHeaderBackgroundColor(),
            headerTextColor: this.getHeaderTextColor(),
            headerIconColor: this.getHeaderIconColor(),
            showHeaderLogo: this.getHeaderLogoVisibility(),
            showHeaderIcons: this.getHeaderIconsVisibility(),
            collectionsSectionTitle: this.getCollectionsTitle(),
            collections: this.getCollections(),
            productCategoriesSectionTitle: this.getCategoriesTitle(),
            productCategories: this.getProductCategories(),
            showProductCategoryCards: this.getCategoryCardsVisibility(),
            productCategoryCardsTitle: this.getCategoryCardsTitle(),
            eyeglassesCategoryCards: this.getEyeglassesCards(),
            sunglassesCategoryCards: this.getSunglassesCards(),
            lastUpdated: new Date().toISOString()
        };

        return data;
    }

    // Helper methods to extract data from the page
    getBannerVisibility() {
        const bannerToggle = document.querySelector('[data-banner-toggle]') || 
                            document.querySelector('input[type="checkbox"][name*="banner"]');
        return bannerToggle ? bannerToggle.checked : true;
    }

    getBannerText() {
        const bannerInput = document.querySelector('[data-banner-text]') || 
                           document.querySelector('input[name*="banner-text"]');
        return bannerInput ? bannerInput.value : '🎉 Special Offer: 50% Off on Premium Frames!';
    }

    getBannerBackgroundColor() {
        const colorInput = document.querySelector('[data-banner-bg-color]') || 
                          document.querySelector('input[type="color"][name*="banner-bg"]');
        return colorInput ? this.hexToInt(colorInput.value) : 4294198070;
    }

    getBannerTextColor() {
        const colorInput = document.querySelector('[data-banner-text-color]') || 
                          document.querySelector('input[type="color"][name*="banner-text"]');
        return colorInput ? this.hexToInt(colorInput.value) : 4294967295;
    }

    getHeaderBackgroundColor() {
        const colorInput = document.querySelector('[data-header-bg-color]') || 
                          document.querySelector('input[type="color"][name*="header-bg"]');
        return colorInput ? this.hexToInt(colorInput.value) : 4294967295;
    }

    getHeaderTextColor() {
        const colorInput = document.querySelector('[data-header-text-color]') || 
                          document.querySelector('input[type="color"][name*="header-text"]');
        return colorInput ? this.hexToInt(colorInput.value) : 4278190080;
    }

    getHeaderIconColor() {
        const colorInput = document.querySelector('[data-header-icon-color]') || 
                          document.querySelector('input[type="color"][name*="header-icon"]');
        return colorInput ? this.hexToInt(colorInput.value) : 4278190080;
    }

    getHeaderLogoVisibility() {
        const logoToggle = document.querySelector('[data-header-logo-toggle]') || 
                          document.querySelector('input[type="checkbox"][name*="header-logo"]');
        return logoToggle ? logoToggle.checked : true;
    }

    getHeaderIconsVisibility() {
        const iconsToggle = document.querySelector('[data-header-icons-toggle]') || 
                           document.querySelector('input[type="checkbox"][name*="header-icons"]');
        return iconsToggle ? iconsToggle.checked : true;
    }

    getCollectionsTitle() {
        const titleInput = document.querySelector('[data-collections-title]') || 
                          document.querySelector('input[name*="collections-title"]');
        return titleInput ? titleInput.value : 'Hot Collections';
    }

    getCollections() {
        // Extract collections from the page
        const collectionElements = document.querySelectorAll('[data-collection]') || 
                                  document.querySelectorAll('.collection-item');
        
        return Array.from(collectionElements).map((element, index) => ({
            id: (index + 1).toString(),
            title: element.querySelector('[data-collection-title]')?.value || `Collection ${index + 1}`,
            subtitle: element.querySelector('[data-collection-subtitle]')?.value || 'Collection description',
            imagePath: element.querySelector('[data-collection-image]')?.value || 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=200&fit=crop',
            isVisible: true
        }));
    }

    getCategoriesTitle() {
        const titleInput = document.querySelector('[data-categories-title]') || 
                          document.querySelector('input[name*="categories-title"]');
        return titleInput ? titleInput.value : 'Categories';
    }

    getProductCategories() {
        return [
            { id: "1", label: "Men", icon: 128104, isVisible: true },
            { id: "2", label: "Women", icon: 128105, isVisible: true },
            { id: "3", label: "Kids", icon: 128512, isVisible: true },
            { id: "4", label: "Essentials", icon: 128717, isVisible: true }
        ];
    }

    getCategoryCardsVisibility() {
        const toggle = document.querySelector('[data-category-cards-toggle]') || 
                      document.querySelector('input[type="checkbox"][name*="category-cards"]');
        return toggle ? toggle.checked : true;
    }

    getCategoryCardsTitle() {
        const titleInput = document.querySelector('[data-category-cards-title]') || 
                          document.querySelector('input[name*="category-cards-title"]');
        return titleInput ? titleInput.value : 'Eyeglasses';
    }

    getEyeglassesCards() {
        return [
            { id: "1", title: "Round Frames", imagePath: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=150&h=100&fit=crop", isVisible: true },
            { id: "2", title: "Square Frames", imagePath: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=100&fit=crop", isVisible: true },
            { id: "3", title: "Cat Eye", imagePath: "https://images.unsplash.com/photo-1556306535-38febf6782e7?w=150&h=100&fit=crop", isVisible: true }
        ];
    }

    getSunglassesCards() {
        return [
            { id: "1", title: "Aviator", imagePath: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=150&h=100&fit=crop", isVisible: true },
            { id: "2", title: "Wayfarer", imagePath: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=100&fit=crop", isVisible: true },
            { id: "3", title: "Round", imagePath: "https://images.unsplash.com/photo-1556306535-38febf6782e7?w=150&h=100&fit=crop", isVisible: true }
        ];
    }

    // Convert hex color to integer
    hexToInt(hex) {
        return parseInt(hex.replace('#', ''), 16);
    }

    // Show sync status to user
    showSyncStatus(message, type = 'info') {
        // Create or update status element
        let statusElement = document.getElementById('sync-status');
        if (!statusElement) {
            statusElement = document.createElement('div');
            statusElement.id = 'sync-status';
            statusElement.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 12px 20px;
                border-radius: 8px;
                color: white;
                font-weight: bold;
                z-index: 10000;
                transition: opacity 0.3s;
            `;
            document.body.appendChild(statusElement);
        }

        // Set colors based on type
        const colors = {
            success: '#28a745',
            error: '#dc3545',
            info: '#17a2b8'
        };

        statusElement.style.backgroundColor = colors[type] || colors.info;
        statusElement.textContent = message;

        // Auto-hide after 3 seconds
        setTimeout(() => {
            statusElement.style.opacity = '0';
            setTimeout(() => {
                if (statusElement.parentNode) {
                    statusElement.parentNode.removeChild(statusElement);
                }
            }, 300);
        }, 3000);
    }

    // Manual sync trigger
    manualSync() {
        console.log('🔄 Manual sync triggered');
        this.syncToLocalServer();
    }
}

// Initialize sync when page loads
window.addEventListener('load', () => {
    const sync = new VercelToMobileSync();
    sync.init();
    
    // Make sync available globally for manual triggering
    window.vercelToMobileSync = sync;
    
    console.log('✅ Vercel to Mobile sync initialized');
});

// Add manual sync button to the page
function addManualSyncButton() {
    const button = document.createElement('button');
    button.textContent = '🔄 Sync to Mobile';
    button.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 12px 20px;
        background: linear-gradient(135deg, #ff6b6b, #ee5a24);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: bold;
        cursor: pointer;
        z-index: 10000;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    `;
    
    button.addEventListener('click', () => {
        if (window.vercelToMobileSync) {
            window.vercelToMobileSync.manualSync();
        }
    });
    
    document.body.appendChild(button);
}

// Add the manual sync button
setTimeout(addManualSyncButton, 1000);

