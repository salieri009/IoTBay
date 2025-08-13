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
        dropdown.classList.toggle('show');
    }
}

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
