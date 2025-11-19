/**
 * Optimistic UI Utility
 * 
 * Provides optimistic updates for better perceived performance.
 * Updates UI immediately before server confirmation.
 * 
 * @author Nexus - Chief Experience Architect
 * @version 1.0.0
 */

const OptimisticUI = {
  /**
   * Optimistically add item to cart
   * Updates UI immediately, reverts on error
   */
  addToCart: function(productId, productData) {
    const cart = this.getCart();
    const existingItem = cart.items.find(item => item.id === productId);
    
    if (existingItem) {
      existingItem.quantity += 1;
    } else {
      cart.items.push({
        id: productId,
        ...productData,
        quantity: 1
      });
    }
    
    cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
    this.saveCart(cart);
    this.updateCartUI(cart);
    
    // Show optimistic feedback
    this.showFeedback('Item added to cart', 'success');
    
    return cart;
  },

  /**
   * Optimistically remove item from cart
   */
  removeFromCart: function(productId) {
    const cart = this.getCart();
    const item = cart.items.find(item => item.id === productId);
    
    if (item) {
      cart.items = cart.items.filter(item => item.id !== productId);
      cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
      this.saveCart(cart);
      this.updateCartUI(cart);
      this.showFeedback('Item removed from cart', 'info');
    }
    
    return cart;
  },

  /**
   * Optimistically update cart quantity
   */
  updateCartQuantity: function(productId, quantity) {
    const cart = this.getCart();
    const item = cart.items.find(item => item.id === productId);
    
    if (item) {
      if (quantity <= 0) {
        return this.removeFromCart(productId);
      }
      
      item.quantity = quantity;
      cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
      this.saveCart(cart);
      this.updateCartUI(cart);
    }
    
    return cart;
  },

  /**
   * Optimistically toggle wishlist
   */
  toggleWishlist: function(productId, productData) {
    const wishlist = this.getWishlist();
    const index = wishlist.findIndex(item => item.id === productId);
    
    if (index > -1) {
      wishlist.splice(index, 1);
      this.showFeedback('Removed from wishlist', 'info');
    } else {
      wishlist.push({ id: productId, ...productData });
      this.showFeedback('Added to wishlist', 'success');
    }
    
    this.saveWishlist(wishlist);
    this.updateWishlistUI(wishlist);
    
    return wishlist;
  },

  /**
   * Get cart from localStorage
   */
  getCart: function() {
    try {
      const cart = localStorage.getItem('iotbay_cart');
      return cart ? JSON.parse(cart) : { items: [], totalItems: 0 };
    } catch (e) {
      console.error('Error reading cart:', e);
      return { items: [], totalItems: 0 };
    }
  },

  /**
   * Save cart to localStorage
   */
  saveCart: function(cart) {
    try {
      localStorage.setItem('iotbay_cart', JSON.stringify(cart));
    } catch (e) {
      console.error('Error saving cart:', e);
    }
  },

  /**
   * Get wishlist from localStorage
   */
  getWishlist: function() {
    try {
      const wishlist = localStorage.getItem('iotbay_wishlist');
      return wishlist ? JSON.parse(wishlist) : [];
    } catch (e) {
      console.error('Error reading wishlist:', e);
      return [];
    }
  },

  /**
   * Save wishlist to localStorage
   */
  saveWishlist: function(wishlist) {
    try {
      localStorage.setItem('iotbay_wishlist', JSON.stringify(wishlist));
    } catch (e) {
      console.error('Error saving wishlist:', e);
    }
  },

  /**
   * Update cart UI elements
   */
  updateCartUI: function(cart) {
    // Update cart count badge
    const cartCountElements = document.querySelectorAll('[data-cart-count]');
    cartCountElements.forEach(el => {
      el.textContent = cart.totalItems;
      el.setAttribute('aria-label', `${cart.totalItems} items in cart`);
    });
    
    // Update cart icon
    const cartIcons = document.querySelectorAll('.header__cart-count');
    cartIcons.forEach(el => {
      el.textContent = cart.totalItems;
      el.style.display = cart.totalItems > 0 ? 'block' : 'none';
    });
    
    // Dispatch custom event
    document.dispatchEvent(new CustomEvent('cart:updated', { 
      detail: { cart } 
    }));
  },

  /**
   * Update wishlist UI elements
   */
  updateWishlistUI: function(wishlist) {
    const wishlistButtons = document.querySelectorAll('[data-wishlist-id]');
    wishlistButtons.forEach(button => {
      const productId = button.getAttribute('data-wishlist-id');
      const isInWishlist = wishlist.some(item => item.id === productId);
      
      button.setAttribute('aria-pressed', isInWishlist);
      button.classList.toggle('wishlist--active', isInWishlist);
    });
    
    document.dispatchEvent(new CustomEvent('wishlist:updated', { 
      detail: { wishlist } 
    }));
  },

  /**
   * Show optimistic feedback message
   */
  showFeedback: function(message, type = 'success') {
    // Use toast notification system if available
    if (window.Toast && typeof window.Toast.show === 'function') {
      window.Toast.show(message, type);
    } else {
      // Fallback: simple notification
      const notification = document.createElement('div');
      notification.className = `optimistic-feedback optimistic-feedback--${type}`;
      notification.setAttribute('role', 'status');
      notification.setAttribute('aria-live', 'polite');
      notification.textContent = message;
      
      document.body.appendChild(notification);
      
      // Animate in
      requestAnimationFrame(() => {
        notification.classList.add('optimistic-feedback--visible');
      });
      
      // Remove after delay
      setTimeout(() => {
        notification.classList.remove('optimistic-feedback--visible');
        setTimeout(() => notification.remove(), 300);
      }, 3000);
    }
  },

  /**
   * Revert optimistic update on error
   */
  revert: function(previousState, stateType = 'cart') {
    if (stateType === 'cart') {
      this.saveCart(previousState);
      this.updateCartUI(previousState);
      this.showFeedback('Update failed. Please try again.', 'error');
    } else if (stateType === 'wishlist') {
      this.saveWishlist(previousState);
      this.updateWishlistUI(previousState);
      this.showFeedback('Update failed. Please try again.', 'error');
    }
  },

  /**
   * Sync with server (after optimistic update)
   */
  syncWithServer: async function(endpoint, data, previousState, stateType = 'cart') {
    try {
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
      });
      
      if (!response.ok) {
        throw new Error('Server sync failed');
      }
      
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Sync error:', error);
      this.revert(previousState, stateType);
      throw error;
    }
  }
};

// Initialize on DOM ready
document.addEventListener('DOMContentLoaded', function() {
  // Restore cart UI on page load
  const cart = OptimisticUI.getCart();
  OptimisticUI.updateCartUI(cart);
  
  // Restore wishlist UI on page load
  const wishlist = OptimisticUI.getWishlist();
  OptimisticUI.updateWishlistUI(wishlist);
});

// Export for use in other modules
window.OptimisticUI = OptimisticUI;

