/**
 * Cart Page Controller
 * 
 * Handles cart interactions with Optimistic UI and LocalStorage.
 * 
 * @author Nexus - Chief Experience Architect
 */

const CartPage = {
  /**
   * Initialize cart page
   */
  init: function() {
    this.setupOptimisticCart();
    this.setupQuantityUpdates();
    this.setupRemoveItems();
    this.syncWithServer();
  },
  
  /**
   * Setup optimistic cart updates
   */
  setupOptimisticCart: function() {
    // Load cart from localStorage if available
    if (window.OptimisticUI) {
      const localCart = OptimisticUI.getCart();
      if (localCart.items.length > 0) {
        // Merge with server cart if needed
        this.mergeCarts(localCart);
      }
    }
  },
  
  /**
   * Setup quantity update handlers
   */
  setupQuantityUpdates: function() {
    document.addEventListener('change', (e) => {
      const quantityInput = e.target.closest('[data-cart-quantity]');
      if (quantityInput) {
        const productId = quantityInput.getAttribute('data-cart-quantity');
        const newQuantity = parseInt(quantityInput.value) || 1;
        
        if (window.OptimisticUI) {
          OptimisticUI.updateCartQuantity(productId, newQuantity);
          this.updateCartTotals();
        }
      }
    });
  },
  
  /**
   * Setup remove item handlers
   */
  setupRemoveItems: function() {
    document.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('[data-cart-remove]');
      if (removeBtn) {
        e.preventDefault();
        const productId = removeBtn.getAttribute('data-cart-remove');
        
        if (window.OptimisticUI) {
          OptimisticUI.removeFromCart(productId);
          this.removeCartItem(productId);
          this.updateCartTotals();
        }
      }
    });
  },
  
  /**
   * Remove cart item from DOM
   */
  removeCartItem: function(productId) {
    const itemElement = document.querySelector(`[data-cart-item="${productId}"]`);
    if (itemElement) {
      // Smooth removal animation
      itemElement.style.opacity = '0';
      itemElement.style.transform = 'translateX(-20px)';
      
      setTimeout(() => {
        itemElement.remove();
        this.checkEmptyCart();
      }, 300);
    }
  },
  
  /**
   * Update cart totals
   */
  updateCartTotals: function() {
    if (!window.OptimisticUI) return;
    
    const cart = OptimisticUI.getCart();
    let subtotal = 0;
    
    cart.items.forEach(item => {
      subtotal += (item.price || 0) * (item.quantity || 1);
    });
    
    const tax = subtotal * 0.1;
    const shipping = subtotal >= 50 ? 0 : 15;
    const total = subtotal + tax + shipping;
    
    // Update DOM
    const subtotalEl = document.querySelector('[data-cart-subtotal]');
    const taxEl = document.querySelector('[data-cart-tax]');
    const shippingEl = document.querySelector('[data-cart-shipping]');
    const totalEl = document.querySelector('[data-cart-total]');
    
    if (subtotalEl) subtotalEl.textContent = this.formatCurrency(subtotal);
    if (taxEl) taxEl.textContent = this.formatCurrency(tax);
    if (shippingEl) shippingEl.textContent = shipping === 0 ? 'Free' : this.formatCurrency(shipping);
    if (totalEl) totalEl.textContent = this.formatCurrency(total);
    
    // Update free shipping message
    this.updateFreeShippingMessage(subtotal);
  },
  
  /**
   * Update free shipping message
   */
  updateFreeShippingMessage: function(subtotal) {
    const freeShippingEl = document.querySelector('[data-free-shipping]');
    if (!freeShippingEl) return;
    
    if (subtotal >= 50) {
      freeShippingEl.innerHTML = '<span class="text-success">✓ You qualify for free shipping!</span>';
    } else {
      const remaining = 50 - subtotal;
      freeShippingEl.innerHTML = `<span>Add $${this.formatCurrency(remaining)} more for free shipping</span>`;
    }
  },
  
  /**
   * Check if cart is empty
   */
  checkEmptyCart: function() {
    const cartItems = document.querySelectorAll('[data-cart-item]');
    const emptyState = document.querySelector('[data-cart-empty]');
    const cartContent = document.querySelector('[data-cart-content]');
    
    if (cartItems.length === 0) {
      if (emptyState) emptyState.style.display = 'block';
      if (cartContent) cartContent.style.display = 'none';
    }
  },
  
  /**
   * Merge local and server carts
   */
  mergeCarts: function(localCart) {
    // This would typically make an API call to merge carts
    // For now, we'll just use the local cart
    console.log('Merging carts:', localCart);
  },
  
  /**
   * Sync cart with server
   */
  syncWithServer: function() {
    if (!window.OptimisticUI) return;
    
    const cart = OptimisticUI.getCart();
    if (cart.items.length === 0) return;
    
    // Sync with server (replace with actual endpoint)
    const endpoint = '/api/cart/sync';
    const previousState = JSON.parse(JSON.stringify(cart));
    
    OptimisticUI.syncWithServer(endpoint, cart, previousState, 'cart')
      .catch(error => {
        console.error('Cart sync failed:', error);
      });
  },
  
  /**
   * Format currency
   */
  formatCurrency: function(amount) {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  }
};

// Initialize on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => CartPage.init());
} else {
  CartPage.init();
}

// Export
window.CartPage = CartPage;

