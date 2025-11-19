/**
 * Facet Search Component
 * 
 * Handles faceted search with immediate feedback.
 * Updates results as user interacts with filters.
 * 
 * @author Nexus - Chief Experience Architect
 */

const FacetSearch = {
  /**
   * Initialize facet search
   */
  init: function(containerId) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    // Debounce filter changes for performance
    const debouncedFilter = Helpers.debounce((filters) => {
      this.applyFilters(filters);
    }, 300);
    
    // Listen to filter changes
    container.addEventListener('change', (e) => {
      if (e.target.matches('.facet-search__checkbox, .facet-search__radio, .facet-search__price-input')) {
        const filters = this.getFilters(container);
        debouncedFilter(filters);
      }
    });
    
    // Initial filter application
    const initialFilters = this.getFilters(container);
    if (Object.keys(initialFilters).length > 0) {
      this.applyFilters(initialFilters);
    }
  },
  
  /**
   * Get current filter values
   */
  getFilters: function(container) {
    const filters = {
      categories: [],
      priceMin: null,
      priceMax: null,
      stock: 'all'
    };
    
    // Get selected categories
    container.querySelectorAll('.facet-search__checkbox:checked').forEach(cb => {
      filters.categories.push(cb.value);
    });
    
    // Get price range
    const priceMin = container.querySelector('[name="priceMin"]');
    const priceMax = container.querySelector('[name="priceMax"]');
    if (priceMin && priceMin.value) {
      filters.priceMin = parseFloat(priceMin.value);
    }
    if (priceMax && priceMax.value) {
      filters.priceMax = parseFloat(priceMax.value);
    }
    
    // Get stock status
    const stockRadio = container.querySelector('.facet-search__radio:checked');
    if (stockRadio) {
      filters.stock = stockRadio.value;
    }
    
    return filters;
  },
  
  /**
   * Apply filters and update results
   */
  applyFilters: function(filters) {
    // Show loading state
    this.showLoading();
    
    // Build query string
    const params = new URLSearchParams();
    if (filters.categories.length > 0) {
      params.append('categories', filters.categories.join(','));
    }
    if (filters.priceMin) {
      params.append('priceMin', filters.priceMin);
    }
    if (filters.priceMax) {
      params.append('priceMax', filters.priceMax);
    }
    if (filters.stock !== 'all') {
      params.append('stock', filters.stock);
    }
    
    // Update URL without page reload
    const newUrl = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
    window.history.pushState({ filters }, '', newUrl);
    
    // Fetch filtered results
    this.fetchResults(params);
  },
  
  /**
   * Fetch filtered results
   */
  fetchResults: async function(params) {
    try {
      const response = await fetch(window.location.pathname + '?' + params.toString(), {
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      });
      
      if (!response.ok) throw new Error('Filter request failed');
      
      const html = await response.text();
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');
      
      // Update product grid
      const productGrid = document.querySelector('[data-product-grid]');
      const newGrid = doc.querySelector('[data-product-grid]');
      
      if (productGrid && newGrid) {
        // Smooth transition
        productGrid.style.opacity = '0.5';
        
        setTimeout(() => {
          productGrid.innerHTML = newGrid.innerHTML;
          productGrid.style.opacity = '1';
          
          // Update result count
          const resultCount = doc.querySelector('[data-result-count]');
          if (resultCount) {
            const currentCount = document.querySelector('[data-result-count]');
            if (currentCount) {
              currentCount.textContent = resultCount.textContent;
            }
          }
          
          // Announce to screen readers
          this.announceResults();
        }, 150);
      }
    } catch (error) {
      console.error('Filter error:', error);
      this.showError('Failed to apply filters. Please try again.');
    } finally {
      this.hideLoading();
    }
  },
  
  /**
   * Show loading state
   */
  showLoading: function() {
    const productGrid = document.querySelector('[data-product-grid]');
    if (productGrid) {
      productGrid.classList.add('product-grid--loading');
    }
  },
  
  /**
   * Hide loading state
   */
  hideLoading: function() {
    const productGrid = document.querySelector('[data-product-grid]');
    if (productGrid) {
      productGrid.classList.remove('product-grid--loading');
    }
  },
  
  /**
   * Show error message
   */
  showError: function(message) {
    if (window.OptimisticUI) {
      OptimisticUI.showFeedback(message, 'error');
    }
  },
  
  /**
   * Announce results to screen readers
   */
  announceResults: function() {
    const liveRegion = document.getElementById('aria-live-announcements');
    if (liveRegion) {
      const count = document.querySelector('[data-result-count]')?.textContent || 'results';
      liveRegion.textContent = `Filtered results: ${count}`;
      setTimeout(() => {
        liveRegion.textContent = '';
      }, 1000);
    }
  }
};

// Export
window.FacetSearch = FacetSearch;

