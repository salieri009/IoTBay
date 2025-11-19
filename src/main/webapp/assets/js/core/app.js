/**
 * IoT Bay Application Core
 * Main initialization and configuration
 */

(function() {
    'use strict';

    const App = {
        config: {
            apiBaseUrl: '/api',
            contextPath: window.location.pathname.split('/')[1] || '',
            debounceDelay: 300,
            throttleDelay: 100
        },

        /**
         * Initialize the application
         */
        init: function() {
            // Wait for DOM to be ready
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', this.onDOMReady.bind(this));
            } else {
                this.onDOMReady();
            }
        },

        /**
         * DOM Ready handler
         */
        onDOMReady: function() {
            // Initialize core modules
            this.initializeModules();
            
            // Performance monitoring
            this.measurePerformance();
        },

        /**
         * Initialize all modules
         */
        initializeModules: function() {
            // Core modules
            if (typeof Header !== 'undefined') Header.init();
            if (typeof Theme !== 'undefined') Theme.init();
            if (typeof Animations !== 'undefined') Animations.init();
            
            // Page-specific initialization
            const pageName = this.getPageName();
            if (typeof Pages !== 'undefined' && Pages[pageName]) {
                Pages[pageName].init();
            }
        },

        /**
         * Get current page name
         */
        getPageName: function() {
            const path = window.location.pathname;
            const page = path.split('/').pop().replace('.jsp', '') || 'index';
            return page.charAt(0).toUpperCase() + page.slice(1);
        },

        /**
         * Measure and log performance metrics
         */
        measurePerformance: function() {
            window.addEventListener('load', function() {
                if (window.performance && window.performance.timing) {
                    const loadTime = window.performance.timing.loadEventEnd - 
                                   window.performance.timing.navigationStart;
                    console.log('[App] Page loaded in:', Math.round(loadTime), 'ms');
                }
            });
        }
    };

    // Expose App globally
    window.App = App;

    // Auto-initialize
    App.init();
})();




