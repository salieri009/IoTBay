<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.User" %>

<% 
    User user = (User) session.getAttribute("user");
    boolean isStaff = user != null && "staff".equalsIgnoreCase(user.getRole());
%>

<header class="nav">
    <div class="container">
        <!-- Brand -->
        <a href="<c:url value='/' />" class="nav__brand">
            <img src="<c:url value='/images/logo.png' />" alt="IoT Bay Logo" class="nav__brand-image" />
            <span class="nav__brand-text">IoT Bay</span>
        </a>
        
        <!-- Primary Navigation (Essential Only) -->
        <nav class="nav__menu">
            <a href="<c:url value='/' />" class="nav__link">Home</a>
            <a href="<c:url value='/browse.jsp' />" class="nav__link">Products</a>
            <a href="<c:url value='/about.jsp' />" class="nav__link">About</a>
        </nav>
        
        <!-- User Actions (Minimal) -->
        <div class="nav__actions">
            <% if (user != null) { %>
                <!-- Logged in user - Simple dropdown -->
                <div class="nav__user-menu">
                    <button class="nav__user-trigger" onclick="toggleUserMenu()">
                        <div class="nav__user-avatar">
                            ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
                        </div>
                        <span class="nav__user-name hidden sm:inline">${user.firstName}</span>
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    
                    <div class="nav__user-dropdown" id="userMenuDropdown">
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
                            <a href="<c:url value='/Profiles.jsp' />" class="nav__dropdown-item">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                                </svg>
                                My Profile
                            </a>
                            <a href="<c:url value='/orderList.jsp' />" class="nav__dropdown-item">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                </svg>
                                My Orders
                            </a>
                            
                            <!-- Staff Quick Access (Minimal) -->
                            <% if (isStaff) { %>
                                <div class="nav__dropdown-divider"></div>
                                <a href="<c:url value='/reports-dashboard.jsp' />" class="nav__dropdown-item">
                                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"></path>
                                    </svg>
                                    Staff Dashboard
                                </a>
                            <% } %>
                        </div>
                        
                        <div class="nav__dropdown-divider"></div>
                        
                        <!-- Logout -->
                        <div class="nav__dropdown-section">
                            <a href="<c:url value='/logout.jsp' />" class="nav__dropdown-item nav__dropdown-item--danger">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
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
            
            <!-- Theme Toggle (Minimal) -->
            <button class="nav__theme-toggle" onclick="toggleTheme()" aria-label="Toggle dark mode">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
                </svg>
            </button>
        </div>
        
        <!-- Mobile Menu Button -->
        <button class="nav__mobile-toggle md:hidden" onclick="toggleMobileMenu()" aria-label="Toggle mobile menu">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
    
    <!-- Mobile Menu (Simplified) -->
    <div class="nav__mobile-menu" id="mobileMenu">
        <div class="nav__mobile-content">
            <!-- Mobile Navigation -->
            <nav class="nav__mobile-nav">
                <a href="<c:url value='/' />" class="nav__mobile-link">Home</a>
                <a href="<c:url value='/browse.jsp' />" class="nav__mobile-link">Products</a>
                <a href="<c:url value='/about.jsp' />" class="nav__mobile-link">About</a>
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
// User menu toggle
function toggleUserMenu() {
    const menu = document.getElementById('userMenuDropdown');
    menu.classList.toggle('show');
}

// Mobile menu toggle
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    menu.classList.toggle('show');
}

// Close menus when clicking outside
document.addEventListener('click', function(event) {
    const userMenu = document.getElementById('userMenuDropdown');
    const mobileMenu = document.getElementById('mobileMenu');
    
    if (userMenu && !event.target.closest('.nav__user-menu')) {
        userMenu.classList.remove('show');
    }
    
    if (mobileMenu && !event.target.closest('.nav__mobile-toggle')) {
        mobileMenu.classList.remove('show');
    }
});

// Theme toggle
function toggleTheme() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
}
</script>