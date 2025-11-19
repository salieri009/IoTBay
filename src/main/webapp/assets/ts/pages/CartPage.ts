/**
 * Cart Page Controller
 * Handles cart interactions with Optimistic UI and LocalStorage
 * Following Java-style conventions
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

import { HelperUtil } from '../utils/HelperUtil';

/**
 * Cart item interface
 */
interface CartItem {
    readonly productId: string;
    readonly price: number;
    readonly quantity: number;
}

/**
 * Cart interface
 */
interface Cart {
    readonly items: ReadonlyArray<CartItem>;
}

/**
 * Optimistic UI interface
 */
interface OptimisticUI {
    getCart(): Cart;
    updateCartQuantity(productId: string, quantity: number): void;
    removeFromCart(productId: string): void;
    syncWithServer(
        endpoint: string,
        currentState: Cart,
        previousState: Cart,
        type: string
    ): Promise<void>;
}

/**
 * Cart Page class
 * 
 * @class CartPage
 */
class CartPage {
    private static readonly FREE_SHIPPING_THRESHOLD: number = 50;
    private static readonly SHIPPING_COST: number = 15;
    private static readonly TAX_RATE: number = 0.1;
    private static readonly REMOVAL_ANIMATION_DURATION: number = 300;

    /**
     * Initialize cart page
     * 
     * @public
     * @static
     */
    public static init(): void {
        CartPage.setupOptimisticCart();
        CartPage.setupQuantityUpdates();
        CartPage.setupRemoveItems();
        CartPage.syncWithServer();
    }

    /**
     * Setup optimistic cart updates
     * 
     * @private
     * @static
     */
    private static setupOptimisticCart(): void {
        const optimisticUI: OptimisticUI | undefined = (window as any).OptimisticUI;
        if (!optimisticUI) {
            return;
        }

        const localCart: Cart = optimisticUI.getCart();
        if (localCart.items.length > 0) {
            // Merge with server cart if needed
            CartPage.mergeCarts(localCart);
        }
    }

    /**
     * Setup quantity update handlers
     * 
     * @private
     * @static
     */
    private static setupQuantityUpdates(): void {
        document.addEventListener('change', (e: Event): void => {
            const target: HTMLElement | null = (e.target as HTMLElement).closest('[data-cart-quantity]');
            if (!target) {
                return;
            }

            const quantityInput: HTMLInputElement = target as HTMLInputElement;
            const productId: string | null = quantityInput.getAttribute('data-cart-quantity');
            if (!productId) {
                return;
            }

            const newQuantity: number = parseInt(quantityInput.value, 10) || 1;

            const optimisticUI: OptimisticUI | undefined = (window as any).OptimisticUI;
            if (optimisticUI) {
                optimisticUI.updateCartQuantity(productId, newQuantity);
                CartPage.updateCartTotals();
            }
        });
    }

    /**
     * Setup remove item handlers
     * 
     * @private
     * @static
     */
    private static setupRemoveItems(): void {
        document.addEventListener('click', (e: Event): void => {
            const target: HTMLElement | null = (e.target as HTMLElement).closest('[data-cart-remove]');
            if (!target) {
                return;
            }

            e.preventDefault();
            const removeBtn: HTMLElement = target;
            const productId: string | null = removeBtn.getAttribute('data-cart-remove');
            if (!productId) {
                return;
            }

            const optimisticUI: OptimisticUI | undefined = (window as any).OptimisticUI;
            if (optimisticUI) {
                optimisticUI.removeFromCart(productId);
                CartPage.removeCartItem(productId);
                CartPage.updateCartTotals();
            }
        });
    }

    /**
     * Remove cart item from DOM
     * 
     * @param {string} productId - Product ID
     * @private
     * @static
     */
    private static removeCartItem(productId: string): void {
        const itemElement: HTMLElement | null = document.querySelector(`[data-cart-item="${productId}"]`);
        if (!itemElement) {
            return;
        }

        // Smooth removal animation
        itemElement.style.opacity = '0';
        itemElement.style.transform = 'translateX(-20px)';

        setTimeout((): void => {
            itemElement.remove();
            CartPage.checkEmptyCart();
        }, CartPage.REMOVAL_ANIMATION_DURATION);
    }

    /**
     * Update cart totals
     * 
     * @private
     * @static
     */
    private static updateCartTotals(): void {
        const optimisticUI: OptimisticUI | undefined = (window as any).OptimisticUI;
        if (!optimisticUI) {
            return;
        }

        const cart: Cart = optimisticUI.getCart();
        let subtotal: number = 0;

        cart.items.forEach((item: CartItem): void => {
            subtotal += (item.price || 0) * (item.quantity || 1);
        });

        const tax: number = subtotal * CartPage.TAX_RATE;
        const shipping: number = subtotal >= CartPage.FREE_SHIPPING_THRESHOLD ? 0 : CartPage.SHIPPING_COST;
        const total: number = subtotal + tax + shipping;

        // Update DOM
        const subtotalEl: HTMLElement | null = document.querySelector('[data-cart-subtotal]');
        const taxEl: HTMLElement | null = document.querySelector('[data-cart-tax]');
        const shippingEl: HTMLElement | null = document.querySelector('[data-cart-shipping]');
        const totalEl: HTMLElement | null = document.querySelector('[data-cart-total]');

        if (subtotalEl) {
            subtotalEl.textContent = CartPage.formatCurrency(subtotal);
        }
        if (taxEl) {
            taxEl.textContent = CartPage.formatCurrency(tax);
        }
        if (shippingEl) {
            shippingEl.textContent = shipping === 0 ? 'Free' : CartPage.formatCurrency(shipping);
        }
        if (totalEl) {
            totalEl.textContent = CartPage.formatCurrency(total);
        }

        // Update free shipping message
        CartPage.updateFreeShippingMessage(subtotal);
    }

    /**
     * Update free shipping message
     * 
     * @param {number} subtotal - Cart subtotal
     * @private
     * @static
     */
    private static updateFreeShippingMessage(subtotal: number): void {
        const freeShippingEl: HTMLElement | null = document.querySelector('[data-free-shipping]');
        if (!freeShippingEl) {
            return;
        }

        if (subtotal >= CartPage.FREE_SHIPPING_THRESHOLD) {
            freeShippingEl.innerHTML = '<span class="text-success">✓ You qualify for free shipping!</span>';
        } else {
            const remaining: number = CartPage.FREE_SHIPPING_THRESHOLD - subtotal;
            freeShippingEl.innerHTML = `<span>Add $${CartPage.formatCurrency(remaining)} more for free shipping</span>`;
        }
    }

    /**
     * Check if cart is empty
     * 
     * @private
     * @static
     */
    private static checkEmptyCart(): void {
        const cartItems: NodeListOf<Element> = document.querySelectorAll('[data-cart-item]');
        const emptyState: HTMLElement | null = document.querySelector('[data-cart-empty]');
        const cartContent: HTMLElement | null = document.querySelector('[data-cart-content]');

        if (cartItems.length === 0) {
            if (emptyState) {
                emptyState.style.display = 'block';
            }
            if (cartContent) {
                cartContent.style.display = 'none';
            }
        }
    }

    /**
     * Merge local and server carts
     * 
     * @param {Cart} localCart - Local cart
     * @private
     * @static
     */
    private static mergeCarts(localCart: Cart): void {
        // This would typically make an API call to merge carts
        // For now, we'll just use the local cart
        console.log('Merging carts:', localCart);
    }

    /**
     * Sync cart with server
     * 
     * @private
     * @static
     */
    private static syncWithServer(): void {
        const optimisticUI: OptimisticUI | undefined = (window as any).OptimisticUI;
        if (!optimisticUI) {
            return;
        }

        const cart: Cart = optimisticUI.getCart();
        if (cart.items.length === 0) {
            return;
        }

        // Sync with server (replace with actual endpoint)
        const endpoint: string = '/api/cart/sync';
        const previousState: Cart = HelperUtil.clone(cart);

        optimisticUI.syncWithServer(endpoint, cart, previousState, 'cart')
            .catch((error: Error): void => {
                console.error('Cart sync failed:', error);
            });
    }

    /**
     * Format currency
     * 
     * @param {number} amount - Amount to format
     * @returns {string} Formatted currency string
     * @private
     * @static
     */
    private static formatCurrency(amount: number): string {
        return HelperUtil.formatCurrency(amount, 'USD');
    }
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', (): void => CartPage.init());
} else {
    CartPage.init();
}

// Export
(window as any).CartPage = CartPage;

