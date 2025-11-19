/**
 * IoT Bay Application Core
 * Main initialization and configuration
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

/**
 * Application configuration interface
 */
interface AppConfig {
    readonly apiBaseUrl: string;
    readonly contextPath: string;
    readonly debounceDelay: number;
    readonly throttleDelay: number;
}

/**
 * Main Application class following Java-style conventions
 * 
 * @class App
 */
class App {
    private static readonly DEFAULT_DEBOUNCE_DELAY: number = 300;
    private static readonly DEFAULT_THROTTLE_DELAY: number = 100;
    
    private readonly config: AppConfig;
    private initialized: boolean = false;

    /**
     * Constructor
     */
    constructor() {
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
    public init(): void {
        if (this.initialized) {
            return;
        }

        // Wait for DOM to be ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', this.onDOMReady.bind(this));
        } else {
            this.onDOMReady();
        }

        this.initialized = true;
    }

    /**
     * DOM Ready handler
     * 
     * @private
     */
    private onDOMReady(): void {
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
    private initializeModules(): void {
        // Core modules
        if (typeof (window as any).Header !== 'undefined') {
            (window as any).Header.init();
        }
        if (typeof (window as any).Theme !== 'undefined') {
            (window as any).Theme.init();
        }
        if (typeof (window as any).Animations !== 'undefined') {
            (window as any).Animations.init();
        }
        
        // Page-specific initialization
        const pageName: string = this.getPageName();
        if (typeof (window as any).Pages !== 'undefined' && (window as any).Pages[pageName]) {
            (window as any).Pages[pageName].init();
        }
    }

    /**
     * Get current page name
     * 
     * @returns {string} The current page name
     * @private
     */
    private getPageName(): string {
        const path: string = window.location.pathname;
        const page: string = path.split('/').pop()?.replace('.jsp', '') || 'index';
        return page.charAt(0).toUpperCase() + page.slice(1);
    }

    /**
     * Measure and log performance metrics
     * 
     * @private
     */
    private measurePerformance(): void {
        window.addEventListener('load', (): void => {
            if (window.performance && window.performance.timing) {
                const loadTime: number = window.performance.timing.loadEventEnd - 
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
    private extractContextPath(): string {
        const pathParts: string[] = window.location.pathname.split('/');
        return pathParts[1] || '';
    }

    /**
     * Get application configuration
     * 
     * @returns {AppConfig} The application configuration
     * @public
     */
    public getConfig(): AppConfig {
        return this.config;
    }
}

// Initialize and expose globally
const appInstance: App = new App();
(window as any).App = appInstance;

// Auto-initialize
appInstance.init();

