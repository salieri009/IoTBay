/**
 * Index Page Controller
 * 
 * Handles homepage-specific interactions and optimizations.
 * 
 * @author Nexus - Chief Experience Architect
 */

const IndexPage = {
  /**
   * Initialize homepage
   */
  init: function() {
    this.setupProductCards();
    this.setupCategoryCards();
    this.setupHeroAnimation();
    this.setupOptimisticInteractions();
  },
  
  /**
   * Setup product card interactions
   */
  setupProductCards: function() {
    // Add to cart with optimistic UI
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
      name: card.querySelector('[data-product-name]')?.textContent || '',
      price: parseFloat(card.querySelector('[data-product-price]')?.textContent?.replace(/[^0-9.]/g, '') || 0),
      image: card.querySelector('[data-product-image]')?.getAttribute('src') || ''
    };
  },
  
  /**
   * Setup category card animations
   */
  setupCategoryCards: function() {
    const categoryCards = document.querySelectorAll('.category-card');
    
    categoryCards.forEach(card => {
      card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-4px)';
      });
      
      card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
      });
    });
  },
  
  /**
   * Setup hero section animation
   */
  setupHeroAnimation: function() {
    const hero = document.querySelector('.hero-section');
    if (!hero) return;
    
    // Fade in on load
    hero.style.opacity = '0';
    setTimeout(() => {
      hero.style.transition = 'opacity 0.6s ease-in';
      hero.style.opacity = '1';
    }, 100);
  },
  
  /**
   * Setup optimistic interactions
   */
  setupOptimisticInteractions: function() {
    // Preload critical images
    const heroImage = document.querySelector('.hero-section img');
    if (heroImage && 'loading' in HTMLImageElement.prototype) {
      heroImage.loading = 'eager';
    }
    
    // Prefetch category pages on hover
    const categoryLinks = document.querySelectorAll('.category-card[href]');
    categoryLinks.forEach(link => {
      link.addEventListener('mouseenter', function() {
        const href = this.getAttribute('href');
        if (href) {
          const linkEl = document.createElement('link');
          linkEl.rel = 'prefetch';
          linkEl.href = href;
          document.head.appendChild(linkEl);
        }
      }, { once: true });
    });
  }
};

// Initialize on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => IndexPage.init());
} else {
  IndexPage.init();
}

// Export
window.IndexPage = IndexPage;

