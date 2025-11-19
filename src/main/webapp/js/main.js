// Modern IoT Bay JavaScript
document.addEventListener('DOMContentLoaded', function() {
    initializeHeader();
    initializeTheme();
    initializeAnimations();
});

// Header functionality
function initializeHeader() {
    // Close dropdowns when clicking outside
    document.addEventListener('click', function(event) {
        const userMenu = document.getElementById('userMenuDropdown');
        const searchOverlay = document.getElementById('searchOverlay');
        
        if (userMenu && !event.target.closest('.user-menu')) {
            userMenu.classList.remove('show');
        }
        
        if (searchOverlay && !event.target.closest('.search-overlay') && !event.target.closest('.header__search-btn')) {
            searchOverlay.classList.remove('active');
        }
    });
}

// User menu toggle
function toggleUserMenu() {
    const dropdown = document.getElementById('userMenuDropdown');
    if (dropdown) {
        // Close other dropdowns first
        closeAllDropdowns();
        // Toggle current dropdown
        dropdown.classList.toggle('show');
    }
}

// Close all dropdowns
function closeAllDropdowns() {
    const dropdowns = document.querySelectorAll('.nav__user-dropdown, .nav__dropdown-menu');
    dropdowns.forEach(dropdown => {
        dropdown.classList.remove('show');
    });
}

// Close dropdowns when clicking outside
document.addEventListener('click', function(event) {
    const userMenu = document.querySelector('.nav__user-menu');
    const dropdown = document.getElementById('userMenuDropdown');
    
    if (userMenu && dropdown && !userMenu.contains(event.target)) {
        dropdown.classList.remove('show');
    }
});

// Search overlay toggle
function toggleSearch() {
    const overlay = document.getElementById('searchOverlay');
    if (overlay) {
        overlay.classList.toggle('active');
        if (overlay.classList.contains('active')) {
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                setTimeout(() => searchInput.focus(), 300);
            }
        }
    }
}

// Mobile menu toggle
function toggleMobileMenu() {
    const header = document.querySelector('.header');
    if (header) {
        header.classList.toggle('mobile-menu-open');
    }
}

// Theme functionality
function initializeTheme() {
    // Check for saved theme preference or default to light
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    
    // Update theme toggle button if it exists
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', toggleTheme);
        updateThemeToggleIcon(savedTheme);
    }
}

function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeToggleIcon(newTheme);
}

function updateThemeToggleIcon(theme) {
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        const icon = themeToggle.querySelector('svg');
        if (icon) {
            icon.innerHTML = theme === 'dark' 
                ? '<path d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>'
                : '<path d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>';
        }
    }
}

// Animation and scroll effects
function initializeAnimations() {
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);
    
    // Observe elements with animation classes
    document.querySelectorAll('.fade-in, .slide-in, .scale-in').forEach(el => {
        observer.observe(el);
    });
}

// Form enhancements
function initializeForms() {
    // Add floating label effect
    document.querySelectorAll('.form__input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });
        
        input.addEventListener('blur', function() {
            if (this.value === '') {
                this.parentElement.classList.remove('focused');
            }
        });
        
        // Check if input has value on load
        if (input.value !== '') {
            input.parentElement.classList.add('focused');
        }
    });
}

// Utility functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    }
}

// Search suggestions (placeholder for future implementation)
function showSuggestions(query) {
    const suggestions = document.getElementById('suggestions');
    if (!suggestions || query.length < 2) {
        if (suggestions) suggestions.style.display = 'none';
        return;
    }
    
    // This would typically make an AJAX call to get suggestions
    // For now, just show/hide the suggestions container
    suggestions.style.display = 'block';
    suggestions.innerHTML = '<div class="search__suggestion">Search for "' + query + '"</div>';
}

// Cart functionality
function updateCartCount(count) {
    const cartCount = document.querySelector('.header__cart-count');
    if (cartCount) {
        cartCount.textContent = count;
        cartCount.style.display = count > 0 ? 'flex' : 'none';
    }
}

// Toast notifications
function showToast(message, type = 'info') {
    const toast = document.createElement('div');
    toast.className = `toast toast--${type}`;
    toast.textContent = message;
    
    document.body.appendChild(toast);
    
    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 100);
    
    // Remove toast after 3 seconds
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => document.body.removeChild(toast), 300);
    }, 3000);
}

// Loading states
function showLoading(element) {
    if (element) {
        element.classList.add('loading');
        element.disabled = true;
    }
}

function hideLoading(element) {
    if (element) {
        element.classList.remove('loading');
        element.disabled = false;
    }
}

// ============================================
// Enhanced Features Based on improvement.md
// ============================================

// Compatibility Engine (Section 4.1)
const CompatibilityEngine = {
    /**
     * Check compatibility of products in cart
     * Based on improvement.md Section 4.1: Proactive Compatibility Checking
     */
    checkCartCompatibility: async function() {
        try {
            const response = await fetch(`${window.location.origin}${window.location.pathname.split('/').slice(0, -1).join('/')}/api/cart/items`);
            if (!response.ok) return [];
            
            const data = await response.json();
            const warnings = data.compatibilityWarnings || [];
            
            return warnings;
        } catch (error) {
            console.error('Error checking compatibility:', error);
            return [];
        }
    },
    
    /**
     * Display compatibility warnings
     */
    displayWarnings: function(warnings, container) {
        if (!warnings || warnings.length === 0) return;
        
        const warningContainer = document.createElement('div');
        warningContainer.className = 'compatibility-warnings';
        warningContainer.setAttribute('role', 'alert');
        warningContainer.setAttribute('aria-live', 'polite');
        
        warnings.forEach(warning => {
            const warningItem = document.createElement('div');
            warningItem.className = `alert alert--${warning.severity === 'error' ? 'error' : 'warning'}`;
            warningItem.innerHTML = `
                <div class="alert__icon">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <div class="alert__content">
                    <strong>Compatibility Notice:</strong> ${warning.message}
                </div>
            `;
            warningContainer.appendChild(warningItem);
        });
        
        if (container) {
            container.insertBefore(warningContainer, container.firstChild);
        }
    }
};

// Optimistic UI Updates (Section 3.1)
const OptimisticUI = {
    /**
     * Add to cart with optimistic UI update
     * Based on improvement.md Section 3.1: Optimistic UI Updates
     */
    addToCart: async function(productId, quantity = 1) {
        const button = event?.target?.closest('button') || document.querySelector(`[data-product-id="${productId}"]`);
        const originalText = button?.innerHTML;
        const originalDisabled = button?.disabled;
        
        // 1. Immediate UI update (optimistic)
        if (button) {
            button.disabled = true;
            button.innerHTML = '<span class="loading-spinner"></span> Adding...';
            button.classList.add('btn--loading');
        }
        
        if (typeof showToast === 'function') {
            showToast('Adding to cart...', 'info');
        }
        
        // Update cart count optimistically
        const cartCount = document.querySelector('.header__cart-count');
        if (cartCount) {
            const currentCount = parseInt(cartCount.textContent) || 0;
            cartCount.textContent = currentCount + quantity;
            cartCount.style.display = 'flex';
        }
        
        try {
            // 2. Server request (background)
            const response = await fetch(`${window.location.origin}${window.location.pathname.split('/').slice(0, -1).join('/')}/api/cart/add`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `productId=${productId}&quantity=${quantity}`
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
                // 3. Success feedback
                if (button) {
                    button.innerHTML = '✓ Added!';
                    button.classList.remove('btn--loading', 'btn--primary');
                    button.classList.add('btn--success');
                    
                    setTimeout(() => {
                        button.innerHTML = originalText;
                        button.classList.remove('btn--success');
                        button.classList.add('btn--primary');
                        button.disabled = originalDisabled;
                    }, 2000);
                }
                
                if (typeof showToast === 'function') {
                    showToast(data.message || 'Added to cart!', 'success');
                }
                
                // Display compatibility warnings if any
                if (data.compatibilityWarnings && data.compatibilityWarnings.length > 0) {
                    CompatibilityEngine.displayWarnings(data.compatibilityWarnings, document.querySelector('.cart-page') || document.body);
                }
                
                // Update cart count from server
                if (data.itemCount !== undefined && cartCount) {
                    cartCount.textContent = data.itemCount;
                }
            } else {
                // 4. Rollback on error
                throw new Error(data.errorMessage || 'Failed to add item');
            }
        } catch (error) {
            // 5. Rollback on error
            console.error('Error adding to cart:', error);
            
            if (button) {
                button.innerHTML = 'Error - Try Again';
                button.classList.remove('btn--loading', 'btn--primary');
                button.classList.add('btn--error');
                
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.classList.remove('btn--error');
                    button.classList.add('btn--primary');
                    button.disabled = originalDisabled;
                }, 3000);
            }
            
            // Rollback cart count
            if (cartCount) {
                const currentCount = parseInt(cartCount.textContent) || 0;
                cartCount.textContent = Math.max(0, currentCount - quantity);
            }
            
            if (typeof showToast === 'function') {
                showToast(error.message || 'Failed to add item. Please try again.', 'error');
            }
        }
    }
};

// Enhanced Toast System (Section 3.1)
function showToast(message, type = 'info', duration = 3000) {
    const container = document.getElementById('toast-container') || createToastContainer();
    
    const toast = document.createElement('div');
    toast.className = `toast toast--${type}`;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', type === 'error' ? 'assertive' : 'polite');
    
    const icons = {
        success: '<path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>',
        error: '<path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>',
        warning: '<path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>',
        info: '<path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>'
    };
    
    toast.innerHTML = `
        <div class="toast__content flex items-start p-4">
            <div class="toast__icon flex-shrink-0 mr-3">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    ${icons[type] || icons.info}
                </svg>
            </div>
            <div class="toast__message flex-1 text-sm">${message}</div>
            <button class="toast__close flex-shrink-0 ml-3" onclick="this.closest('.toast').remove()" aria-label="Close">
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                </svg>
            </button>
        </div>
    `;
    
    container.appendChild(toast);
    
    // Trigger animation
    setTimeout(() => toast.classList.add('toast--show'), 100);
    
    // Auto-remove after duration
    setTimeout(() => {
        toast.classList.remove('toast--show');
        setTimeout(() => toast.remove(), 300);
    }, duration);
}

function createToastContainer() {
    const container = document.createElement('div');
    container.id = 'toast-container';
    container.className = 'fixed top-4 right-4 z-50 space-y-2';
    container.setAttribute('role', 'region');
    container.setAttribute('aria-label', 'Notifications');
    document.body.appendChild(container);
    return container;
}

// Enhanced Loading States (Section 3.2)
function showLoading(element, message = 'Loading...') {
    if (!element) return;
    
    element.classList.add('loading');
    element.disabled = true;
    
    // Add loading overlay if it's a container
    if (element.classList.contains('container') || element.classList.contains('card')) {
        const overlay = document.createElement('div');
        overlay.className = 'loading-overlay';
        overlay.innerHTML = `
            <div class="loading-spinner">
                <div class="spinner"></div>
                <p class="loading-message">${message}</p>
            </div>
        `;
        element.style.position = 'relative';
        element.appendChild(overlay);
    }
}

function hideLoading(element) {
    if (!element) return;
    
    element.classList.remove('loading');
    element.disabled = false;
    
    const overlay = element.querySelector('.loading-overlay');
    if (overlay) {
        overlay.remove();
    }
}

// Skeleton Loading (Section 3.2)
function showSkeleton(container, count = 4) {
    if (!container) return;
    
    container.innerHTML = '';
    for (let i = 0; i < count; i++) {
        const skeleton = document.createElement('div');
        skeleton.className = 'skeleton-card';
        skeleton.innerHTML = `
            <div class="skeleton skeleton-image"></div>
            <div class="skeleton skeleton-text skeleton-text--title"></div>
            <div class="skeleton skeleton-text"></div>
            <div class="skeleton skeleton-text skeleton-text--short"></div>
        `;
        container.appendChild(skeleton);
    }
}

// Enhanced Form Validation (Section 4.2)
const FormValidator = {
    validateEmail: function(email) {
        const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
        return emailRegex.test(email);
    },
    
    validateBusinessEmail: function(email) {
        if (!this.validateEmail(email)) {
            return { valid: false, message: 'Please enter a valid email address.' };
        }
        
        const personalDomains = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com'];
        const domain = email.substring(email.indexOf('@') + 1).toLowerCase();
        
        if (personalDomains.includes(domain)) {
            return { 
                valid: true, 
                warning: true, 
                message: 'Business email is recommended for order confirmations and technical updates.' 
            };
        }
        
        return { valid: true };
    },
    
    showFieldError: function(field, message) {
        field.classList.add('form-input--error');
        let errorDiv = field.parentElement.querySelector('.form-error');
        
        if (!errorDiv) {
            errorDiv = document.createElement('div');
            errorDiv.className = 'form-error';
            errorDiv.setAttribute('role', 'alert');
            field.parentElement.appendChild(errorDiv);
        }
        
        errorDiv.textContent = message;
        errorDiv.hidden = false;
    },
    
    hideFieldError: function(field) {
        field.classList.remove('form-input--error');
        const errorDiv = field.parentElement.querySelector('.form-error');
        if (errorDiv) {
            errorDiv.hidden = true;
        }
    }
};

// Keyboard Navigation (Section 8.1)
function setupKeyboardNavigation() {
    document.addEventListener('keydown', function(e) {
        // Escape to close modals/dropdowns
        if (e.key === 'Escape') {
            const activeModal = document.querySelector('.modal--active');
            if (activeModal) {
                activeModal.classList.remove('modal--active');
            }
            closeAllDropdowns();
        }
        
        // Arrow keys for product grid navigation
        if (e.key && typeof e.key === 'string' && e.key.startsWith('Arrow') && e.target.closest('.product-grid')) {
            navigateProductGrid(e.key);
        }
    });
}

function navigateProductGrid(direction) {
    const products = Array.from(document.querySelectorAll('.product-card'));
    const currentIndex = products.findIndex(card => card === document.activeElement || card.contains(document.activeElement));
    
    if (currentIndex === -1) return;
    
    let nextIndex;
    switch (direction) {
        case 'ArrowRight':
            nextIndex = (currentIndex + 1) % products.length;
            break;
        case 'ArrowLeft':
            nextIndex = (currentIndex - 1 + products.length) % products.length;
            break;
        case 'ArrowDown':
            // Calculate grid columns
            const grid = document.querySelector('.product-grid');
            const columns = window.getComputedStyle(grid).gridTemplateColumns.split(' ').length;
            nextIndex = Math.min(currentIndex + columns, products.length - 1);
            break;
        case 'ArrowUp':
            const gridUp = document.querySelector('.product-grid');
            const columnsUp = window.getComputedStyle(gridUp).gridTemplateColumns.split(' ').length;
            nextIndex = Math.max(currentIndex - columnsUp, 0);
            break;
        default:
            return;
    }
    
    const nextProduct = products[nextIndex];
    const focusable = nextProduct.querySelector('a, button, [tabindex="0"]');
    if (focusable) {
        focusable.focus();
    }
}

// Initialize enhanced features
document.addEventListener('DOMContentLoaded', function() {
    setupKeyboardNavigation();
    
    // Initialize compatibility checking for cart page
    if (document.querySelector('.cart-page')) {
        CompatibilityEngine.checkCartCompatibility().then(warnings => {
            if (warnings.length > 0) {
                const container = document.querySelector('.cart-items-section') || document.querySelector('.cart-page');
                CompatibilityEngine.displayWarnings(warnings, container);
            }
        });
    }
});

// Export functions for global use
window.toggleUserMenu = toggleUserMenu;
window.toggleSearch = toggleSearch;
window.toggleMobileMenu = toggleMobileMenu;
window.toggleTheme = toggleTheme;
window.showSuggestions = showSuggestions;
window.updateCartCount = updateCartCount;
window.showToast = showToast;
window.showLoading = showLoading;
window.hideLoading = hideLoading;
window.showSkeleton = showSkeleton;
window.CompatibilityEngine = CompatibilityEngine;
window.OptimisticUI = OptimisticUI;
window.FormValidator = FormValidator;
window.addToCart = OptimisticUI.addToCart;
