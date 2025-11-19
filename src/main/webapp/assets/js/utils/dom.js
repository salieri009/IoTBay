/**
 * DOM Utility Functions
 * Common DOM manipulation utilities
 */

const DOM = {
    /**
     * Query selector with optional context
     */
    $: function(selector, context) {
        context = context || document;
        return context.querySelector(selector);
    },

    /**
     * Query selector all with optional context
     */
    $$: function(selector, context) {
        context = context || document;
        return Array.from(context.querySelectorAll(selector));
    },

    /**
     * Check if element exists
     */
    exists: function(selector) {
        return !!this.$(selector);
    },

    /**
     * Add event listener with delegation support
     */
    on: function(element, event, selector, handler) {
        if (typeof selector === 'function') {
            handler = selector;
            selector = null;
        }

        if (selector) {
            // Event delegation
            element.addEventListener(event, function(e) {
                const target = e.target.closest(selector);
                if (target) {
                    handler.call(target, e);
                }
            });
        } else {
            element.addEventListener(event, handler);
        }
    },

    /**
     * Remove event listener
     */
    off: function(element, event, handler) {
        element.removeEventListener(event, handler);
    },

    /**
     * Toggle class
     */
    toggleClass: function(element, className) {
        if (element) {
            element.classList.toggle(className);
        }
    },

    /**
     * Add class
     */
    addClass: function(element, className) {
        if (element) {
            element.classList.add(className);
        }
    },

    /**
     * Remove class
     */
    removeClass: function(element, className) {
        if (element) {
            element.classList.remove(className);
        }
    },

    /**
     * Check if element has class
     */
    hasClass: function(element, className) {
        return element && element.classList.contains(className);
    },

    /**
     * Get/set attribute
     */
    attr: function(element, name, value) {
        if (value !== undefined) {
            element.setAttribute(name, value);
            return element;
        }
        return element.getAttribute(name);
    },

    /**
     * Smooth scroll to element
     */
    scrollTo: function(element, options) {
        options = options || { behavior: 'smooth', block: 'start' };
        if (typeof element === 'string') {
            element = this.$(element);
        }
        if (element) {
            element.scrollIntoView(options);
        }
    }
};

// Export
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DOM;
} else {
    window.DOM = DOM;
}




