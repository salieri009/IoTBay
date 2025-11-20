/**
 * Browse Page Controller
 * 
 * Handles product browsing, filtering, and search interactions.
 * Implements Facet Search with immediate feedback.
 * 
 * @author Nexus - Chief Experience Architect
 */

import { FacetSearch } from '../components/FacetSearch';

interface ProductData {
    name: string;
    price: number;
    image: string;
}

export class BrowsePage {
    /**
     * Initialize browse page
     */
    public static init(): void {
        BrowsePage.setupFacetSearch();
        BrowsePage.setupProductGrid();
        BrowsePage.setupSkeletonLoading();
        BrowsePage.setupOptimisticInteractions();
        BrowsePage.setupSorting();
    }
    
    /**
     * Setup facet search
     */
    private static setupFacetSearch(): void {
        // Initialize desktop facet search
        const desktopFacet = document.getElementById('facet-search-desktop');
        if (desktopFacet && (window as any).FacetSearch) {
            FacetSearch.init('facet-search-desktop');
        }
        
        // Initialize mobile facet search
        const mobileFacet = document.getElementById('facet-search-mobile');
        if (mobileFacet && (window as any).FacetSearch) {
            FacetSearch.init('facet-search-mobile');
        }
    }
    
    /**
     * Setup product grid with skeleton loading
     */
    private static setupProductGrid(): void {
        const productGrid = document.querySelector<HTMLElement>('[data-product-grid]');
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
    }
    
    /**
     * Setup skeleton loading for dynamic content
     */
    private static setupSkeletonLoading(): void {
        // Show skeleton when filters change
        document.addEventListener('filter:changing', () => {
            const grid = document.querySelector<HTMLElement>('[data-product-grid]');
            if (grid) {
                grid.classList.add('product-grid--loading');
            }
        });
        
        document.addEventListener('filter:changed', () => {
            const grid = document.querySelector<HTMLElement>('[data-product-grid]');
            if (grid) {
                grid.classList.remove('product-grid--loading');
            }
        });
    }
    
    /**
     * Setup optimistic interactions
     */
    private static setupOptimisticInteractions(): void {
        // Add to cart from product cards
        document.addEventListener('click', (e: Event) => {
            const target = e.target as HTMLElement;
            const addToCartBtn = target.closest<HTMLElement>('[data-add-to-cart]');
            if (addToCartBtn) {
                e.preventDefault();
                const productId = addToCartBtn.getAttribute('data-add-to-cart');
                if (productId) {
                    const productData = BrowsePage.getProductData(addToCartBtn);
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
                    const productData = BrowsePage.getProductData(wishlistBtn);
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
            name: nameEl?.textContent || card.getAttribute('data-product-name') || '',
            price: parseFloat(priceEl?.textContent?.replace(/[^0-9.]/g, '') || 
                             card.getAttribute('data-product-price') || '0'),
            image: imageEl?.getAttribute('src') || card.getAttribute('data-product-image') || ''
        };
    }
    
    /**
     * Setup sorting functionality
     */
    private static setupSorting(): void {
        const sortSelect = document.getElementById('sortBy') as HTMLSelectElement;
        if (!sortSelect) return;
        
        sortSelect.addEventListener('change', (e: Event) => {
            const target = e.target as HTMLSelectElement;
            const sortValue = target.value;
            BrowsePage.applySorting(sortValue);
        });
    }
    
    /**
     * Apply sorting to product grid
     */
    private static applySorting(sortValue: string): void {
        const productGrid = document.querySelector<HTMLElement>('[data-product-grid]');
        if (!productGrid) return;
        
        const products = Array.from(productGrid.children) as HTMLElement[];
        
        products.sort((a: HTMLElement, b: HTMLElement) => {
            switch(sortValue) {
                case 'price-low': {
                    const priceA = parseFloat(a.getAttribute('data-price') || '0');
                    const priceB = parseFloat(b.getAttribute('data-price') || '0');
                    return priceA - priceB;
                }
                    
                case 'price-high': {
                    const priceA2 = parseFloat(a.getAttribute('data-price') || '0');
                    const priceB2 = parseFloat(b.getAttribute('data-price') || '0');
                    return priceB2 - priceA2;
                }
                    
                case 'name-asc': {
                    const nameA = (a.getAttribute('data-name') || '').toLowerCase();
                    const nameB = (b.getAttribute('data-name') || '').toLowerCase();
                    return nameA.localeCompare(nameB);
                }
                    
                case 'name-desc': {
                    const nameA2 = (a.getAttribute('data-name') || '').toLowerCase();
                    const nameB2 = (b.getAttribute('data-name') || '').toLowerCase();
                    return nameB2.localeCompare(nameA2);
                }
                    
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
            BrowsePage.announceSortChange(sortValue);
        }, 150);
    }
    
    /**
     * Announce sort change to screen readers
     */
    private static announceSortChange(sortValue: string): void {
        const liveRegion = document.getElementById('aria-live-announcements');
        if (liveRegion) {
            const sortLabels: { [key: string]: string } = {
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
}

// Global filter change handler
(window as any).handleFilterChange = function(filterType: string): void {
    const facetSearch = (window as any).FacetSearch;
    if (facetSearch) {
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
(window as any).BrowsePage = BrowsePage;

