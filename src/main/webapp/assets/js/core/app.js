"use strict";
/**
 * IoT Bay Application Core
 * Main initialization and configuration
 *
 * @author IoT Bay Development Team
 * @version 1.0.0
 */
/**
 * Main Application class following Java-style conventions
 *
 * @class App
 */
class App {
    /**
     * Constructor
     */
    constructor() {
        this.initialized = false;
        this.config = {
            apiBaseUrl: '/api',
            contextPath: this.extractContextPath(),
            debounceDelay: App.DEFAULT_DEBOUNCE_DELAY,
            throttleDelay: App.DEFAULT_THROTTLE_DELAY
        };
    }
    /**
     * Initialize the application
     *
     * @public
     */
    init() {
        if (this.initialized) {
            return;
        }
        // Wait for DOM to be ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', this.onDOMReady.bind(this));
        }
        else {
            this.onDOMReady();
        }
        this.initialized = true;
    }
    /**
     * DOM Ready handler
     *
     * @private
     */
    onDOMReady() {
        // Initialize core modules
        this.initializeModules();
        // Performance monitoring
        this.measurePerformance();
    }
    /**
     * Initialize all modules
     *
     * @private
     */
    initializeModules() {
        // Core modules
        if (typeof window.Header !== 'undefined') {
            window.Header.init();
        }
        if (typeof window.Theme !== 'undefined') {
            window.Theme.init();
        }
        if (typeof window.Animations !== 'undefined') {
            window.Animations.init();
        }
        // Page-specific initialization
        const pageName = this.getPageName();
        if (typeof window.Pages !== 'undefined' && window.Pages[pageName]) {
            window.Pages[pageName].init();
        }
    }
    /**
     * Get current page name
     *
     * @returns {string} The current page name
     * @private
     */
    getPageName() {
        var _a;
        const path = window.location.pathname;
        const page = ((_a = path.split('/').pop()) === null || _a === void 0 ? void 0 : _a.replace('.jsp', '')) || 'index';
        return page.charAt(0).toUpperCase() + page.slice(1);
    }
    /**
     * Measure and log performance metrics
     *
     * @private
     */
    measurePerformance() {
        window.addEventListener('load', () => {
            if (window.performance && window.performance.timing) {
                const loadTime = window.performance.timing.loadEventEnd -
                    window.performance.timing.navigationStart;
                console.log('[App] Page loaded in:', Math.round(loadTime), 'ms');
            }
        });
    }
    /**
     * Extract context path from URL
     *
     * @returns {string} The context path
     * @private
     */
    extractContextPath() {
        const pathParts = window.location.pathname.split('/');
        return pathParts[1] || '';
    }
    /**
     * Get application configuration
     *
     * @returns {AppConfig} The application configuration
     * @public
     */
    getConfig() {
        return this.config;
    }
}
App.DEFAULT_DEBOUNCE_DELAY = 300;
App.DEFAULT_THROTTLE_DELAY = 100;
// Initialize and expose globally
const appInstance = new App();
window.App = appInstance;
// Auto-initialize
appInstance.init();
//# sourceMappingURL=App.js.map