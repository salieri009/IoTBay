/**
 * Helper Utility Class
 * Common utility functions following Java-style conventions
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

/**
 * Helper Utility class
 * 
 * @class HelperUtil
 */
class HelperUtil {
    /**
     * Debounce function
     * 
     * @param {Function} func - Function to debounce
     * @param {number} wait - Wait time in milliseconds
     * @param {boolean} immediate - Execute immediately
     * @returns {Function} Debounced function
     * @public
     * @static
     */
    public static debounce<T extends (...args: any[]) => any>(
        func: T,
        wait: number,
        immediate: boolean = false
    ): (...args: Parameters<T>) => void {
        let timeout: NodeJS.Timeout | null = null;
        
        return function executedFunction(...args: Parameters<T>): void {
            const later: () => void = (): void => {
                timeout = null;
                if (!immediate) {
                    func(...args);
                }
            };
            
            const callNow: boolean = immediate && timeout === null;
            
            if (timeout !== null) {
                clearTimeout(timeout);
            }
            
            timeout = setTimeout(later, wait);
            
            if (callNow) {
                func(...args);
            }
        };
    }

    /**
     * Throttle function
     * 
     * @param {Function} func - Function to throttle
     * @param {number} limit - Time limit in milliseconds
     * @returns {Function} Throttled function
     * @public
     * @static
     */
    public static throttle<T extends (...args: any[]) => any>(
        func: T,
        limit: number
    ): (...args: Parameters<T>) => void {
        let inThrottle: boolean = false;
        
        return function(...args: Parameters<T>): void {
            if (!inThrottle) {
                func.apply(this, args);
                inThrottle = true;
                setTimeout((): void => {
                    inThrottle = false;
                }, limit);
            }
        };
    }

    /**
     * Format currency
     * 
     * @param {number} amount - Amount to format
     * @param {string} currency - Currency code (default: 'USD')
     * @returns {string} Formatted currency string
     * @public
     * @static
     */
    public static formatCurrency(amount: number, currency: string = 'USD'): string {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(amount);
    }

    /**
     * Format date
     * 
     * @param {Date | string | number} date - Date to format
     * @param {string} format - Format type ('short', 'long', 'time')
     * @returns {string} Formatted date string
     * @public
     * @static
     */
    public static formatDate(
        date: Date | string | number,
        format: 'short' | 'long' | 'time' = 'short'
    ): string {
        const d: Date = new Date(date);
        const options: Record<string, Intl.DateTimeFormatOptions> = {
            short: { year: 'numeric', month: 'short', day: 'numeric' },
            long: { year: 'numeric', month: 'long', day: 'numeric' },
            time: { hour: '2-digit', minute: '2-digit' }
        };
        
        return d.toLocaleDateString('en-US', options[format] || options.short);
    }

    /**
     * Generate unique ID
     * 
     * @param {string} prefix - ID prefix (default: 'id')
     * @returns {string} Unique ID
     * @public
     * @static
     */
    public static generateId(prefix: string = 'id'): string {
        return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    }

    /**
     * Deep clone object
     * 
     * @param {T} obj - Object to clone
     * @returns {T} Cloned object
     * @public
     * @static
     */
    public static clone<T>(obj: T): T {
        return JSON.parse(JSON.stringify(obj));
    }

    /**
     * Check if value is empty
     * 
     * @param {any} value - Value to check
     * @returns {boolean} True if value is empty
     * @public
     * @static
     */
    public static isEmpty(value: any): boolean {
        if (value === null || value === undefined) {
            return true;
        }
        if (typeof value === 'string') {
            return value.trim().length === 0;
        }
        if (Array.isArray(value)) {
            return value.length === 0;
        }
        if (typeof value === 'object') {
            return Object.keys(value).length === 0;
        }
        return false;
    }

    /**
     * Escape HTML
     * 
     * @param {string} text - Text to escape
     * @returns {string} Escaped HTML string
     * @public
     * @static
     */
    public static escapeHtml(text: string): string {
        const map: Record<string, string> = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.replace(/[&<>"']/g, (m: string): string => map[m]);
    }
}

// Export
if (typeof module !== 'undefined' && module.exports) {
    module.exports = HelperUtil;
} else {
    (window as any).Helpers = HelperUtil;
}

