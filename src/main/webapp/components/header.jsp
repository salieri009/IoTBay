<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.User" %>

<% 
    User user = (User) session.getAttribute("user");
    boolean isStaff = user != null && "staff".equalsIgnoreCase(user.getRole());
%>

<header class="nav" role="banner">
    <div class="container">
        <!-- Brand -->
        <a href="<c:url value='/' />" class="nav__brand" aria-label="IoT Bay - Home">
            <img src="<c:url value='/images/logo.png' />" alt="IoT Bay Logo" class="nav__brand-image" />
            <span class="nav__brand-text">IoT Bay</span>
        </a>
        
        <!-- Primary Navigation (Essential Only) - Enhanced Accessibility -->
        <nav id="site-navigation" class="nav__menu" role="navigation" aria-label="Main navigation">
            <ul class="nav__menu-list" role="menubar">
                <li role="none">
                    <a href="<c:url value='/' />" class="nav__link" role="menuitem">Home</a>
                </li>
                <li role="none">
                    <a href="<c:url value='/browse.jsp' />" class="nav__link" role="menuitem">Products</a>
                </li>
                <li role="none">
                    <a href="<c:url value='/about.jsp' />" class="nav__link" role="menuitem">About</a>
                </li>
            </ul>
        </nav>
        
        <!-- Search Bar (Section 4.1 - Homepage Layout) -->
        <div class="nav__search" role="search" aria-label="Search products">
            <form action="<c:url value='/browse.jsp' />" method="get" class="nav__search-form">
                <label for="searchInput" class="sr-only">Search products</label>
                <input 
                    type="search" 
                    id="searchInput" 
                    name="q" 
                    class="nav__search-input" 
                    placeholder="Search products..." 
                    autocomplete="off"
                    aria-label="Search products"
                    aria-describedby="searchHelp"
                >
                <button 
                    type="submit" 
                    class="nav__search-button"
                    aria-label="Submit search"
                >
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                    <span class="sr-only">Search</span>
                </button>
                <div id="searchHelp" class="sr-only">Press Enter to search or use arrow keys to navigate suggestions</div>
            </form>
            <!-- Search Suggestions (Hidden by default) -->
            <div id="searchSuggestions" class="nav__search-suggestions" role="listbox" aria-label="Search suggestions" aria-hidden="true"></div>
        </div>
        
        <!-- User Actions (Minimal) - Enhanced Accessibility -->
        <div class="nav__actions" role="toolbar" aria-label="User actions">
            <!-- Shopping Cart Icon (Section 4.1) -->
            <a 
                href="<c:url value='/cart.jsp' />" 
                class="nav__cart-link"
                aria-label="Shopping cart"
                aria-describedby="cartCount"
            >
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
                </svg>
                <span id="cartCount" class="nav__cart-count" aria-live="polite" aria-atomic="true">0</span>
                <span class="sr-only">items in cart</span>
            </a>
            <% if (user != null) { %>
                <!-- Logged in user - Simple dropdown -->
                <div class="nav__user-menu">
                    <button 
                        class="nav__user-trigger" 
                        onclick="toggleUserMenu()"
                        aria-expanded="false"
                        aria-haspopup="true"
                        aria-controls="userMenuDropdown"
                        aria-label="User menu for ${user.firstName} ${user.lastName}"
                        id="userMenuButton"
                    >
                        <div class="nav__user-avatar" aria-hidden="true">
                            ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
                        </div>
                        <span class="nav__user-name hidden sm:inline">${user.firstName}</span>
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    
                    <div 
                        class="nav__user-dropdown" 
                        id="userMenuDropdown"
                        role="menu"
                        aria-labelledby="userMenuButton"
                        aria-orientation="vertical"
                    >
                        <!-- User Info -->
                        <div class="nav__user-info">
                            <div class="nav__user-avatar nav__user-avatar--large">
                                ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
                            </div>
                            <div>
                                <p class="nav__user-fullname">${user.firstName} ${user.lastName}</p>
                                <p class="nav__user-email">${user.email}</p>
                                <% if (isStaff) { %>
                                    <span class="nav__user-role">Staff Member</span>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="nav__dropdown-divider"></div>
                        
                        <!-- Essential Actions Only -->
                        <div class="nav__dropdown-section">
                            <a href="<c:url value='/Profiles.jsp' />" class="nav__dropdown-item" role="menuitem">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                                </svg>
                                My Profile
                            </a>
                            <a href="<c:url value='/orderList.jsp' />" class="nav__dropdown-item" role="menuitem">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                </svg>
                                My Orders
                            </a>
                            
                            <!-- Staff Quick Access (Minimal) -->
                            <% if (isStaff) { %>
                                <div class="nav__dropdown-divider" role="separator" aria-orientation="horizontal"></div>
                                <a href="<c:url value='/reports-dashboard.jsp' />" class="nav__dropdown-item" role="menuitem">
                                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                        <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"></path>
                                    </svg>
                                    Staff Dashboard
                                </a>
                            <% } %>
                        </div>
                        
                        <div class="nav__dropdown-divider" role="separator" aria-orientation="horizontal"></div>
                        
                        <!-- Logout -->
                        <div class="nav__dropdown-section">
                            <a href="<c:url value='/logout.jsp' />" class="nav__dropdown-item nav__dropdown-item--danger" role="menuitem">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z" clip-rule="evenodd"></path>
                                </svg>
                                Sign Out
                            </a>
                        </div>
                    </div>
                </div>
            <% } else { %>
                <!-- Guest user - Simple buttons -->
                <div class="nav__guest-actions">
                    <a href="<c:url value='/login.jsp' />" class="btn btn--ghost">Sign In</a>
                    <a href="<c:url value='/register.jsp' />" class="btn btn--primary">Sign Up</a>
                </div>
            <% } %>
            
            <!-- Theme Toggle (Minimal) - Enhanced Accessibility -->
            <button 
                class="nav__theme-toggle" 
                onclick="toggleTheme()" 
                aria-label="Toggle dark mode"
                aria-pressed="false"
                id="themeToggleButton"
                type="button"
            >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
                </svg>
                <span class="sr-only">Toggle dark mode</span>
            </button>
        </div>
        
        <!-- Mobile Menu Button - Enhanced Accessibility -->
        <button 
            class="nav__mobile-toggle md:hidden" 
            onclick="toggleMobileMenu()" 
            aria-label="Toggle mobile menu"
            aria-expanded="false"
            aria-controls="mobileMenu"
            aria-haspopup="true"
            id="mobileMenuButton"
            type="button"
        >
            <span class="sr-only">Menu</span>
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
        </button>
    </div>
    
    <!-- Mobile Menu (Simplified) - Enhanced Accessibility -->
    <div 
        class="nav__mobile-menu" 
        id="mobileMenu"
        role="menu"
        aria-labelledby="mobileMenuButton"
        aria-orientation="vertical"
    >
        <div class="nav__mobile-content">
            <!-- Mobile Navigation -->
            <nav class="nav__mobile-nav" role="navigation" aria-label="Mobile navigation">
                <ul role="menubar">
                    <li role="none">
                        <a href="<c:url value='/' />" class="nav__mobile-link" role="menuitem">Home</a>
                    </li>
                    <li role="none">
                        <a href="<c:url value='/browse.jsp' />" class="nav__mobile-link" role="menuitem">Products</a>
                    </li>
                    <li role="none">
                        <a href="<c:url value='/about.jsp' />" class="nav__mobile-link" role="menuitem">About</a>
                    </li>
                </ul>
            </nav>
            
            <!-- Mobile User Actions -->
            <% if (user != null) { %>
                <div class="nav__mobile-user">
                    <div class="nav__mobile-user-info">
                        <div class="nav__user-avatar nav__user-avatar--large">
                            ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
                        </div>
                        <div>
                            <p class="nav__user-fullname">${user.firstName} ${user.lastName}</p>
                            <p class="nav__user-email">${user.email}</p>
                        </div>
                    </div>
                    
                    <div class="nav__mobile-user-actions">
                        <a href="<c:url value='/Profiles.jsp' />" class="nav__mobile-action">My Profile</a>
                        <a href="<c:url value='/orderList.jsp' />" class="nav__mobile-action">My Orders</a>
                        
                        <% if (isStaff) { %>
                            <div class="nav__mobile-divider"></div>
                            <a href="<c:url value='/reports-dashboard.jsp' />" class="nav__mobile-action">Staff Dashboard</a>
                        <% } %>
                        
                        <div class="nav__mobile-divider"></div>
                        <a href="<c:url value='/logout.jsp' />" class="nav__mobile-action nav__mobile-action--danger">Sign Out</a>
                    </div>
                </div>
            <% } else { %>
                <div class="nav__mobile-guest">
                    <a href="<c:url value='/login.jsp' />" class="btn btn--ghost w-full mb-3">Sign In</a>
                    <a href="<c:url value='/register.jsp' />" class="btn btn--primary w-full">Sign Up</a>
                </div>
            <% } %>
        </div>
    </div>
</header>

<script>
// Enhanced User menu toggle with ARIA updates (Section 8.1 - Enhanced Keyboard Navigation)
function toggleUserMenu() {
    const menu = document.getElementById('userMenuDropdown');
    const button = document.getElementById('userMenuButton');
    const isExpanded = menu.classList.toggle('show');
    
    // Update ARIA attributes
    if (button) {
        button.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
    }
    
    // Announce to screen readers (Section 8.2)
    if (isExpanded) {
        announceToScreenReader('User menu opened');
    }
}

// Enhanced Mobile menu toggle with ARIA updates
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    const button = document.getElementById('mobileMenuButton');
    const isExpanded = menu.classList.toggle('show');
    
    // Update ARIA attributes
    if (button) {
        button.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
    }
    
    // Announce to screen readers
    if (isExpanded) {
        announceToScreenReader('Mobile menu opened');
    }
}

// Enhanced Keyboard Navigation (Section 8.1)
document.addEventListener('keydown', function(e) {
    // Escape key closes modals/dropdowns
    if (e.key === 'Escape') {
        const userMenu = document.getElementById('userMenuDropdown');
        const mobileMenu = document.getElementById('mobileMenu');
        
        if (userMenu && userMenu.classList.contains('show')) {
            toggleUserMenu();
            const button = document.getElementById('userMenuButton');
            if (button) button.focus();
        }
        
        if (mobileMenu && mobileMenu.classList.contains('show')) {
            toggleMobileMenu();
            const button = document.getElementById('mobileMenuButton');
            if (button) button.focus();
        }
    }
});

// Close menus when clicking outside
document.addEventListener('click', function(event) {
    const userMenu = document.getElementById('userMenuDropdown');
    const mobileMenu = document.getElementById('mobileMenu');
    const userButton = document.getElementById('userMenuButton');
    const mobileButton = document.getElementById('mobileMenuButton');
    
    if (userMenu && !event.target.closest('.nav__user-menu')) {
        userMenu.classList.remove('show');
        if (userButton) userButton.setAttribute('aria-expanded', 'false');
    }
    
    if (mobileMenu && !event.target.closest('.nav__mobile-toggle') && !event.target.closest('#mobileMenu')) {
        mobileMenu.classList.remove('show');
        if (mobileButton) mobileButton.setAttribute('aria-expanded', 'false');
    }
});

// Enhanced Theme toggle with ARIA updates
function toggleTheme() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    const button = document.getElementById('themeToggleButton');
    
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    
    // Update ARIA pressed state
    if (button) {
        button.setAttribute('aria-pressed', newTheme === 'dark' ? 'true' : 'false');
        button.setAttribute('aria-label', `Toggle ${newTheme === 'dark' ? 'light' : 'dark'} mode`);
    }
    
    // Announce to screen readers
    announceToScreenReader(`Switched to ${newTheme} mode`);
}

// Screen Reader Announcement Helper (Section 8.2 - Screen Reader Optimization)
function announceToScreenReader(message, priority = 'polite') {
    const liveRegion = priority === 'assertive' 
        ? document.getElementById('aria-live-errors')
        : document.getElementById('aria-live-announcements');
    
    if (liveRegion) {
        liveRegion.textContent = message;
        // Clear after announcement to allow re-announcement
        setTimeout(() => {
            liveRegion.textContent = '';
        }, 1000);
    }
}

// Initialize theme button state on load
document.addEventListener('DOMContentLoaded', function() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-theme');
    const button = document.getElementById('themeToggleButton');
    
    if (button) {
        button.setAttribute('aria-pressed', currentTheme === 'dark' ? 'true' : 'false');
    }
});
</script>