/**
 * Facet Search Component
 * 
 * Handles faceted search with immediate feedback.
 * Updates results as user interacts with filters.
 * 
 * @author Nexus - Chief Experience Architect
 */

import { HelperUtil } from '../utils/HelperUtil';

interface FilterValues {
    categories: string[];
    priceMin: number | null;
    priceMax: number | null;
    stock: string;
}

export class FacetSearch {
    /**
     * Initialize facet search
     */
    public static init(containerId: string): void {
        const container: HTMLElement | null = document.getElementById(containerId);
        if (!container) return;
        
        // Debounce filter changes for performance
        const debouncedFilter = HelperUtil.debounce((filters: FilterValues) => {
            FacetSearch.applyFilters(filters);
        }, 300);
        
        // Listen to filter changes
        container.addEventListener('change', (e: Event) => {
            const target = e.target as HTMLElement;
            if (target.matches('.facet-search__checkbox, .facet-search__radio, .facet-search__price-input')) {
                const filters = FacetSearch.getFilters(container);
                debouncedFilter(filters);
            }
        });
        
        // Initial filter application
        const initialFilters = FacetSearch.getFilters(container);
        if (Object.keys(initialFilters).length > 0) {
            FacetSearch.applyFilters(initialFilters);
        }
    }
    
    /**
     * Get current filter values
     */
    public static getFilters(container: HTMLElement): FilterValues {
        const filters: FilterValues = {
            categories: [],
            priceMin: null,
            priceMax: null,
            stock: 'all'
        };
        
        // Get selected categories
        container.querySelectorAll<HTMLInputElement>('.facet-search__checkbox:checked').forEach((cb: HTMLInputElement) => {
            filters.categories.push(cb.value);
        });
        
        // Get price range
        const priceMin = container.querySelector<HTMLInputElement>('[name="priceMin"]');
        const priceMax = container.querySelector<HTMLInputElement>('[name="priceMax"]');
        if (priceMin && priceMin.value) {
            filters.priceMin = parseFloat(priceMin.value);
        }
        if (priceMax && priceMax.value) {
            filters.priceMax = parseFloat(priceMax.value);
        }
        
        // Get stock status
        const stockRadio = container.querySelector<HTMLInputElement>('.facet-search__radio:checked');
        if (stockRadio) {
            filters.stock = stockRadio.value;
        }
        
        return filters;
    }
    
    /**
     * Apply filters and update results
     */
    public static applyFilters(filters: FilterValues): void {
        // Show loading state
        FacetSearch.showLoading();
        
        // Build query string
        const params = new URLSearchParams();
        if (filters.categories.length > 0) {
            params.append('categories', filters.categories.join(','));
        }
        if (filters.priceMin !== null) {
            params.append('priceMin', filters.priceMin.toString());
        }
        if (filters.priceMax !== null) {
            params.append('priceMax', filters.priceMax.toString());
        }
        if (filters.stock !== 'all') {
            params.append('stock', filters.stock);
        }
        
        // Update URL without page reload
        const newUrl = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
        window.history.pushState({ filters }, '', newUrl);
        
        // Fetch filtered results
        FacetSearch.fetchResults(params);
    }
    
    /**
     * Fetch filtered results
     */
    private static async fetchResults(params: URLSearchParams): Promise<void> {
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
            const productGrid = document.querySelector<HTMLElement>('[data-product-grid]');
            const newGrid = doc.querySelector<HTMLElement>('[data-product-grid]');
            
            if (productGrid && newGrid) {
                // Smooth transition
                productGrid.style.opacity = '0.5';
                
                setTimeout(() => {
                    productGrid.innerHTML = newGrid.innerHTML;
                    productGrid.style.opacity = '1';
                    
                    // Update result count
                    const resultCount = doc.querySelector<HTMLElement>('[data-result-count]');
                    if (resultCount) {
                        const currentCount = document.querySelector<HTMLElement>('[data-result-count]');
                        if (currentCount) {
                            currentCount.textContent = resultCount.textContent;
                        }
                    }
                    
                    // Announce to screen readers
                    FacetSearch.announceResults();
                }, 150);
            }
        } catch (error) {
            console.error('Filter error:', error);
            FacetSearch.showError('Failed to apply filters. Please try again.');
        } finally {
            FacetSearch.hideLoading();
        }
    }
    
    /**
     * Show loading state
     */
    private static showLoading(): void {
        const productGrid = document.querySelector<HTMLElement>('[data-product-grid]');
        if (productGrid) {
            productGrid.classList.add('product-grid--loading');
        }
    }
    
    /**
     * Hide loading state
     */
    private static hideLoading(): void {
        const productGrid = document.querySelector<HTMLElement>('[data-product-grid]');
        if (productGrid) {
            productGrid.classList.remove('product-grid--loading');
        }
    }
    
    /**
     * Show error message
     */
    private static showError(message: string): void {
        const optimisticUI = (window as any).OptimisticUI;
        if (optimisticUI && optimisticUI.showFeedback) {
            optimisticUI.showFeedback(message, 'error');
        }
    }
    
    /**
     * Announce results to screen readers
     */
    private static announceResults(): void {
        const liveRegion = document.getElementById('aria-live-announcements');
        if (liveRegion) {
            const count = document.querySelector<HTMLElement>('[data-result-count]')?.textContent || 'results';
            liveRegion.textContent = `Filtered results: ${count}`;
            setTimeout(() => {
                liveRegion.textContent = '';
            }, 1000);
        }
    }
}

// Export for global access
(window as any).FacetSearch = FacetSearch;

