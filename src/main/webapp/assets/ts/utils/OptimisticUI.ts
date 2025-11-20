/**
 * Optimistic UI Utility
 * 
 * Provides optimistic updates for better perceived performance.
 * Updates UI immediately before server confirmation.
 * 
 * @author Nexus - Chief Experience Architect
 * @version 1.0.0
 */

interface CartItem {
    id: string;
    name?: string;
    price?: number;
    image?: string;
    quantity: number;
}

interface Cart {
    items: CartItem[];
    totalItems: number;
}

interface WishlistItem {
    id: string;
    name?: string;
    price?: number;
    image?: string;
}

type FeedbackType = 'success' | 'error' | 'info';

export class OptimisticUI {
    /**
     * Optimistically add item to cart
     * Updates UI immediately, reverts on error
     */
    public static addToCart(productId: string, productData: Partial<CartItem>): Cart {
        const cart = OptimisticUI.getCart();
        const existingItem = cart.items.find(item => item.id === productId);
        
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.items.push({
                id: productId,
                ...productData,
                quantity: 1
            } as CartItem);
        }
        
        cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
        OptimisticUI.saveCart(cart);
        OptimisticUI.updateCartUI(cart);
        
        // Show optimistic feedback
        OptimisticUI.showFeedback('Item added to cart', 'success');
        
        return cart;
    }

    /**
     * Optimistically remove item from cart
     */
    public static removeFromCart(productId: string): Cart {
        const cart = OptimisticUI.getCart();
        const item = cart.items.find(item => item.id === productId);
        
        if (item) {
            cart.items = cart.items.filter(item => item.id !== productId);
            cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
            OptimisticUI.saveCart(cart);
            OptimisticUI.updateCartUI(cart);
            OptimisticUI.showFeedback('Item removed from cart', 'info');
        }
        
        return cart;
    }

    /**
     * Optimistically update cart quantity
     */
    public static updateCartQuantity(productId: string, quantity: number): Cart {
        const cart = OptimisticUI.getCart();
        const item = cart.items.find(item => item.id === productId);
        
        if (item) {
            if (quantity <= 0) {
                return OptimisticUI.removeFromCart(productId);
            }
            
            item.quantity = quantity;
            cart.totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
            OptimisticUI.saveCart(cart);
            OptimisticUI.updateCartUI(cart);
        }
        
        return cart;
    }

    /**
     * Optimistically toggle wishlist
     */
    public static toggleWishlist(productId: string, productData: Partial<WishlistItem>): WishlistItem[] {
        const wishlist = OptimisticUI.getWishlist();
        const index = wishlist.findIndex(item => item.id === productId);
        
        if (index > -1) {
            wishlist.splice(index, 1);
            OptimisticUI.showFeedback('Removed from wishlist', 'info');
        } else {
            wishlist.push({ id: productId, ...productData } as WishlistItem);
            OptimisticUI.showFeedback('Added to wishlist', 'success');
        }
        
        OptimisticUI.saveWishlist(wishlist);
        OptimisticUI.updateWishlistUI(wishlist);
        
        return wishlist;
    }

    /**
     * Get cart from localStorage
     */
    public static getCart(): Cart {
        try {
            const cart = localStorage.getItem('iotbay_cart');
            return cart ? JSON.parse(cart) : { items: [], totalItems: 0 };
        } catch (e) {
            console.error('Error reading cart:', e);
            return { items: [], totalItems: 0 };
        }
    }

    /**
     * Save cart to localStorage
     */
    public static saveCart(cart: Cart): void {
        try {
            localStorage.setItem('iotbay_cart', JSON.stringify(cart));
        } catch (e) {
            console.error('Error saving cart:', e);
        }
    }

    /**
     * Get wishlist from localStorage
     */
    public static getWishlist(): WishlistItem[] {
        try {
            const wishlist = localStorage.getItem('iotbay_wishlist');
            return wishlist ? JSON.parse(wishlist) : [];
        } catch (e) {
            console.error('Error reading wishlist:', e);
            return [];
        }
    }

    /**
     * Save wishlist to localStorage
     */
    public static saveWishlist(wishlist: WishlistItem[]): void {
        try {
            localStorage.setItem('iotbay_wishlist', JSON.stringify(wishlist));
        } catch (e) {
            console.error('Error saving wishlist:', e);
        }
    }

    /**
     * Update cart UI elements
     */
    public static updateCartUI(cart: Cart): void {
        // Update cart count badge
        const cartCountElements = document.querySelectorAll<HTMLElement>('[data-cart-count]');
        cartCountElements.forEach((el: HTMLElement) => {
            el.textContent = cart.totalItems.toString();
            el.setAttribute('aria-label', `${cart.totalItems} items in cart`);
        });
        
        // Update cart icon
        const cartIcons = document.querySelectorAll<HTMLElement>('.header__cart-count');
        cartIcons.forEach((el: HTMLElement) => {
            el.textContent = cart.totalItems.toString();
            el.style.display = cart.totalItems > 0 ? 'block' : 'none';
        });
        
        // Dispatch custom event
        document.dispatchEvent(new CustomEvent('cart:updated', { 
            detail: { cart } 
        }));
    }

    /**
     * Update wishlist UI elements
     */
    public static updateWishlistUI(wishlist: WishlistItem[]): void {
        const wishlistButtons = document.querySelectorAll<HTMLElement>('[data-wishlist-id]');
        wishlistButtons.forEach((button: HTMLElement) => {
            const productId = button.getAttribute('data-wishlist-id');
            const isInWishlist = wishlist.some(item => item.id === productId);
            
            button.setAttribute('aria-pressed', isInWishlist.toString());
            button.classList.toggle('wishlist--active', isInWishlist);
        });
        
        document.dispatchEvent(new CustomEvent('wishlist:updated', { 
            detail: { wishlist } 
        }));
    }

    /**
     * Show optimistic feedback message
     */
    public static showFeedback(message: string, type: FeedbackType = 'success'): void {
        // Use toast notification system if available
        const toast = (window as any).Toast;
        if (toast && typeof toast.show === 'function') {
            toast.show(message, type);
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
    }

    /**
     * Revert optimistic update on error
     */
    public static revert(previousState: Cart | WishlistItem[], stateType: 'cart' | 'wishlist' = 'cart'): void {
        if (stateType === 'cart') {
            const cart = previousState as Cart;
            OptimisticUI.saveCart(cart);
            OptimisticUI.updateCartUI(cart);
            OptimisticUI.showFeedback('Update failed. Please try again.', 'error');
        } else if (stateType === 'wishlist') {
            const wishlist = previousState as WishlistItem[];
            OptimisticUI.saveWishlist(wishlist);
            OptimisticUI.updateWishlistUI(wishlist);
            OptimisticUI.showFeedback('Update failed. Please try again.', 'error');
        }
    }

    /**
     * Sync with server (after optimistic update)
     */
    public static async syncWithServer(
        endpoint: string, 
        data: any, 
        previousState: Cart | WishlistItem[], 
        stateType: 'cart' | 'wishlist' = 'cart'
    ): Promise<any> {
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
            OptimisticUI.revert(previousState, stateType);
            throw error;
        }
    }
}

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
(window as any).OptimisticUI = OptimisticUI;

