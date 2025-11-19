/**
 * DOM Utility Class
 * Common DOM manipulation utilities following Java-style conventions
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

/**
 * DOM Utility class
 * 
 * @class DomUtil
 */
class DomUtil {
    /**
     * Query selector with optional context
     * 
     * @param {string} selector - CSS selector
     * @param {Document | Element} context - Context element (default: document)
     * @returns {Element | null} Selected element
     * @public
     * @static
     */
    public static querySelector<T extends Element = Element>(
        selector: string,
        context: Document | Element = document
    ): T | null {
        return context.querySelector<T>(selector);
    }

    /**
     * Query selector all with optional context
     * 
     * @param {string} selector - CSS selector
     * @param {Document | Element} context - Context element (default: document)
     * @returns {ReadonlyArray<T>} Selected elements
     * @public
     * @static
     */
    public static querySelectorAll<T extends Element = Element>(
        selector: string,
        context: Document | Element = document
    ): ReadonlyArray<T> {
        return Array.from(context.querySelectorAll<T>(selector));
    }

    /**
     * Check if element exists
     * 
     * @param {string} selector - CSS selector
     * @returns {boolean} True if element exists
     * @public
     * @static
     */
    public static exists(selector: string): boolean {
        return DomUtil.querySelector(selector) !== null;
    }

    /**
     * Add event listener with delegation support
     * 
     * @param {Element} element - Element to attach listener
     * @param {string} event - Event type
     * @param {string | Function} selectorOrHandler - Selector for delegation or handler
     * @param {Function} handler - Event handler (if selector provided)
     * @public
     * @static
     */
    public static on(
        element: Element,
        event: string,
        selectorOrHandler: string | ((e: Event) => void),
        handler?: (e: Event) => void
    ): void {
        if (typeof selectorOrHandler === 'function') {
            handler = selectorOrHandler;
            element.addEventListener(event, handler);
        } else if (handler) {
            // Event delegation
            element.addEventListener(event, (e: Event): void => {
                const target: Element | null = (e.target as Element).closest(selectorOrHandler);
                if (target) {
                    handler!.call(target, e);
                }
            });
        }
    }

    /**
     * Remove event listener
     * 
     * @param {Element} element - Element to remove listener from
     * @param {string} event - Event type
     * @param {Function} handler - Event handler
     * @public
     * @static
     */
    public static off(element: Element, event: string, handler: (e: Event) => void): void {
        element.removeEventListener(event, handler);
    }

    /**
     * Toggle class
     * 
     * @param {Element | null} element - Element
     * @param {string} className - Class name
     * @public
     * @static
     */
    public static toggleClass(element: Element | null, className: string): void {
        if (element) {
            element.classList.toggle(className);
        }
    }

    /**
     * Add class
     * 
     * @param {Element | null} element - Element
     * @param {string} className - Class name
     * @public
     * @static
     */
    public static addClass(element: Element | null, className: string): void {
        if (element) {
            element.classList.add(className);
        }
    }

    /**
     * Remove class
     * 
     * @param {Element | null} element - Element
     * @param {string} className - Class name
     * @public
     * @static
     */
    public static removeClass(element: Element | null, className: string): void {
        if (element) {
            element.classList.remove(className);
        }
    }

    /**
     * Check if element has class
     * 
     * @param {Element | null} element - Element
     * @param {string} className - Class name
     * @returns {boolean} True if element has class
     * @public
     * @static
     */
    public static hasClass(element: Element | null, className: string): boolean {
        return element !== null && element.classList.contains(className);
    }

    /**
     * Get/set attribute
     * 
     * @param {Element} element - Element
     * @param {string} name - Attribute name
     * @param {string | undefined} value - Attribute value (optional)
     * @returns {string | Element} Attribute value or element
     * @public
     * @static
     */
    public static attr(element: Element, name: string, value?: string): string | Element {
        if (value !== undefined) {
            element.setAttribute(name, value);
            return element;
        }
        return element.getAttribute(name) || '';
    }

    /**
     * Smooth scroll to element
     * 
     * @param {string | Element} element - Element selector or element
     * @param {ScrollIntoViewOptions} options - Scroll options
     * @public
     * @static
     */
    public static scrollTo(
        element: string | Element,
        options?: ScrollIntoViewOptions
    ): void {
        const scrollOptions: ScrollIntoViewOptions = options || { 
            behavior: 'smooth', 
            block: 'start' 
        };
        
        const targetElement: Element | null = typeof element === 'string' 
            ? DomUtil.querySelector(element) 
            : element;
            
        if (targetElement) {
            targetElement.scrollIntoView(scrollOptions);
        }
    }
}

// Export
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DomUtil;
} else {
    (window as any).DOM = DomUtil;
}

