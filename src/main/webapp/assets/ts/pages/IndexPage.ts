/**
 * Index Page Controller
 * 
 * Handles homepage-specific interactions and optimizations.
 * 
 * @author Nexus - Chief Experience Architect
 */

interface ProductData {
    name: string;
    price: number;
    image: string;
}

export class IndexPage {
    /**
     * Initialize homepage
     */
    public static init(): void {
        IndexPage.setupProductCards();
        IndexPage.setupCategoryCards();
        IndexPage.setupHeroAnimation();
        IndexPage.setupOptimisticInteractions();
    }
    
    /**
     * Setup product card interactions
     */
    private static setupProductCards(): void {
        // Add to cart with optimistic UI
        document.addEventListener('click', (e: Event) => {
            const target = e.target as HTMLElement;
            const addToCartBtn = target.closest<HTMLElement>('[data-add-to-cart]');
            if (addToCartBtn) {
                e.preventDefault();
                const productId = addToCartBtn.getAttribute('data-add-to-cart');
                if (productId) {
                    const productData = IndexPage.getProductData(addToCartBtn);
                    const optimisticUI = (window as any).OptimisticUI;
                    if (optimisticUI && optimisticUI.addToCart) {
                        optimisticUI.addToCart(productId, productData);
                    }
                }
            }
        });
        
        // Wishlist toggle
        document.addEventListener('click', (e: Event) => {
            const target = e.target as HTMLElement;
            const wishlistBtn = target.closest<HTMLElement>('[data-wishlist-id]');
            if (wishlistBtn) {
                e.preventDefault();
                const productId = wishlistBtn.getAttribute('data-wishlist-id');
                if (productId) {
                    const productData = IndexPage.getProductData(wishlistBtn);
                    const optimisticUI = (window as any).OptimisticUI;
                    if (optimisticUI && optimisticUI.toggleWishlist) {
                        optimisticUI.toggleWishlist(productId, productData);
                    }
                }
            }
        });
    }
    
    /**
     * Get product data from element
     */
    private static getProductData(element: HTMLElement): ProductData {
        const card = element.closest<HTMLElement>('.product-card, [data-product-card]');
        if (!card) return { name: '', price: 0, image: '' };
        
        const nameEl = card.querySelector<HTMLElement>('[data-product-name]');
        const priceEl = card.querySelector<HTMLElement>('[data-product-price]');
        const imageEl = card.querySelector<HTMLImageElement>('[data-product-image]');
        
        return {
            name: nameEl?.textContent || '',
            price: parseFloat(priceEl?.textContent?.replace(/[^0-9.]/g, '') || '0'),
            image: imageEl?.getAttribute('src') || ''
        };
    }
    
    /**
     * Setup category card animations
     */
    private static setupCategoryCards(): void {
        const categoryCards = document.querySelectorAll<HTMLElement>('.category-card');
        
        categoryCards.forEach((card: HTMLElement) => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-4px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    }
    
    /**
     * Setup hero section animation
     */
    private static setupHeroAnimation(): void {
        const hero = document.querySelector<HTMLElement>('.hero-section');
        if (!hero) return;
        
        // Fade in on load
        hero.style.opacity = '0';
        setTimeout(() => {
            hero.style.transition = 'opacity 0.6s ease-in';
            hero.style.opacity = '1';
        }, 100);
    }
    
    /**
     * Setup optimistic interactions
     */
    private static setupOptimisticInteractions(): void {
        // Preload critical images
        const heroImage = document.querySelector<HTMLImageElement>('.hero-section img');
        if (heroImage && 'loading' in HTMLImageElement.prototype) {
            heroImage.loading = 'eager';
        }
        
        // Prefetch category pages on hover
        const categoryLinks = document.querySelectorAll<HTMLElement>('.category-card[href]');
        categoryLinks.forEach((link: HTMLElement) => {
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
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => IndexPage.init());
} else {
    IndexPage.init();
}

// Export
(window as any).IndexPage = IndexPage;

