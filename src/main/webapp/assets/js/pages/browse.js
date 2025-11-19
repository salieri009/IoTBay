/**
 * Browse Page Controller
 * 
 * Handles product browsing, filtering, and search interactions.
 * Implements Facet Search with immediate feedback.
 * 
 * @author Nexus - Chief Experience Architect
 */

const BrowsePage = {
  /**
   * Initialize browse page
   */
  init: function() {
    this.setupFacetSearch();
    this.setupProductGrid();
    this.setupSkeletonLoading();
    this.setupOptimisticInteractions();
    this.setupSorting();
  },
  
  /**
   * Setup facet search
   */
  setupFacetSearch: function() {
    // Initialize desktop facet search
    const desktopFacet = document.getElementById('facet-search-desktop');
    if (desktopFacet && window.FacetSearch) {
      FacetSearch.init('facet-search-desktop');
    }
    
    // Initialize mobile facet search
    const mobileFacet = document.getElementById('facet-search-mobile');
    if (mobileFacet && window.FacetSearch) {
      FacetSearch.init('facet-search-mobile');
    }
  },
  
  /**
   * Setup product grid with skeleton loading
   */
  setupProductGrid: function() {
    const productGrid = document.querySelector('[data-product-grid]');
    if (!productGrid) return;
    
    // Show skeleton while loading
    const skeleton = document.getElementById('featured-products-skeleton');
    if (skeleton) {
      skeleton.classList.remove('hidden');
      productGrid.style.opacity = '0.5';
      
      // Hide skeleton when products load
      setTimeout(() => {
        skeleton.classList.add('hidden');
        productGrid.style.opacity = '1';
      }, 500);
    }
  },
  
  /**
   * Setup skeleton loading for dynamic content
   */
  setupSkeletonLoading: function() {
    // Show skeleton when filters change
    document.addEventListener('filter:changing', () => {
      const grid = document.querySelector('[data-product-grid]');
      if (grid) {
        grid.classList.add('product-grid--loading');
      }
    });
    
    document.addEventListener('filter:changed', () => {
      const grid = document.querySelector('[data-product-grid]');
      if (grid) {
        grid.classList.remove('product-grid--loading');
      }
    });
  },
  
  /**
   * Setup optimistic interactions
   */
  setupOptimisticInteractions: function() {
    // Add to cart from product cards
    document.addEventListener('click', (e) => {
      const addToCartBtn = e.target.closest('[data-add-to-cart]');
      if (addToCartBtn) {
        e.preventDefault();
        const productId = addToCartBtn.getAttribute('data-add-to-cart');
        const productData = this.getProductData(addToCartBtn);
        
        if (window.OptimisticUI) {
          OptimisticUI.addToCart(productId, productData);
        }
      }
    });
    
    // Wishlist toggle
    document.addEventListener('click', (e) => {
      const wishlistBtn = e.target.closest('[data-wishlist-id]');
      if (wishlistBtn) {
        e.preventDefault();
        const productId = wishlistBtn.getAttribute('data-wishlist-id');
        const productData = this.getProductData(wishlistBtn);
        
        if (window.OptimisticUI) {
          OptimisticUI.toggleWishlist(productId, productData);
        }
      }
    });
  },
  
  /**
   * Get product data from element
   */
  getProductData: function(element) {
    const card = element.closest('.product-card, [data-product-card]');
    if (!card) return {};
    
    return {
      name: card.querySelector('[data-product-name]')?.textContent || 
            card.getAttribute('data-product-name') || '',
      price: parseFloat(card.querySelector('[data-product-price]')?.textContent?.replace(/[^0-9.]/g, '') || 
                       card.getAttribute('data-product-price') || 0),
      image: card.querySelector('[data-product-image]')?.getAttribute('src') || 
             card.getAttribute('data-product-image') || ''
    };
  },
  
  /**
   * Setup sorting functionality
   */
  setupSorting: function() {
    const sortSelect = document.getElementById('sortBy');
    if (!sortSelect) return;
    
    sortSelect.addEventListener('change', (e) => {
      const sortValue = e.target.value;
      this.applySorting(sortValue);
    });
  },
  
  /**
   * Apply sorting to product grid
   */
  applySorting: function(sortValue) {
    const productGrid = document.querySelector('[data-product-grid]');
    if (!productGrid) return;
    
    const products = Array.from(productGrid.children);
    
    products.sort((a, b) => {
      switch(sortValue) {
        case 'price-low':
          const priceA = parseFloat(a.getAttribute('data-price') || 0);
          const priceB = parseFloat(b.getAttribute('data-price') || 0);
          return priceA - priceB;
          
        case 'price-high':
          const priceA2 = parseFloat(a.getAttribute('data-price') || 0);
          const priceB2 = parseFloat(b.getAttribute('data-price') || 0);
          return priceB2 - priceA2;
          
        case 'name-asc':
          const nameA = (a.getAttribute('data-name') || '').toLowerCase();
          const nameB = (b.getAttribute('data-name') || '').toLowerCase();
          return nameA.localeCompare(nameB);
          
        case 'name-desc':
          const nameA2 = (a.getAttribute('data-name') || '').toLowerCase();
          const nameB2 = (b.getAttribute('data-name') || '').toLowerCase();
          return nameB2.localeCompare(nameA2);
          
        default:
          return 0;
      }
    });
    
    // Animate reordering
    productGrid.style.opacity = '0.5';
    
    setTimeout(() => {
      products.forEach(product => product.remove());
      products.forEach(product => productGrid.appendChild(product));
      productGrid.style.opacity = '1';
      
      // Announce to screen readers
      this.announceSortChange(sortValue);
    }, 150);
  },
  
  /**
   * Announce sort change to screen readers
   */
  announceSortChange: function(sortValue) {
    const liveRegion = document.getElementById('aria-live-announcements');
    if (liveRegion) {
      const sortLabels = {
        'price-low': 'Price: Low to High',
        'price-high': 'Price: High to Low',
        'name-asc': 'Name: A to Z',
        'name-desc': 'Name: Z to A'
      };
      
      liveRegion.textContent = `Products sorted by ${sortLabels[sortValue] || sortValue}`;
      setTimeout(() => {
        liveRegion.textContent = '';
      }, 1000);
    }
  }
};

// Global filter change handler
window.handleFilterChange = function(filterType) {
  if (window.FacetSearch) {
    const facetId = window.innerWidth >= 1024 ? 'facet-search-desktop' : 'facet-search-mobile';
    const facet = document.getElementById(facetId);
    if (facet) {
      const filters = FacetSearch.getFilters(facet);
      FacetSearch.applyFilters(filters);
    }
  }
};

// Initialize on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => BrowsePage.init());
} else {
  BrowsePage.init();
}

// Export
window.BrowsePage = BrowsePage;

