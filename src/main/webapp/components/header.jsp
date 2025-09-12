<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<% 
    User user = (User) session.getAttribute("user");
    boolean isStaff = user != null && "staff".equalsIgnoreCase(user.getRole());
%>

<header class="nav">
    <div class="container">
        <a href="index.jsp" class="nav__brand">
            <img src="images/logo.png" alt="IoT Bay Logo" class="nav__brand-image" />
            <span class="nav__brand-text">IoT Bay</span>
        </a>
        
        <nav class="nav__menu">
            <a href="index.jsp" class="nav__link">Home</a>
            <a href="browse.jsp" class="nav__link">Products</a>
            <a href="about.jsp" class="nav__link">About</a>
            <a href="contact.jsp" class="nav__link">Contact</a>
            <% if (user == null) { %>
                <!-- Sign Up prominently displayed in main navigation for guests -->
                <a href="register.jsp" class="nav__link nav__link--highlight">Sign Up</a>
            <% } %>
        </nav>
        
        <div class="nav__actions">
            <% if (user != null) { %>
                <!-- Logged in user actions -->
                <div class="dropdown">
                    <button class="dropdown__trigger" onclick="toggleUserMenu()">
                        <span class="text-sm">Hello, <%= user.getFirstName() %></span>
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    <div class="dropdown__menu" id="userMenuDropdown">
                        <a href="Profiles.jsp" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                            </svg>
                            Profile
                        </a>
                        <a href="orders.jsp" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                            </svg>
                            Orders
                        </a>
                        <a href="cart" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                            </svg>
                            Cart
                        </a>
                        <% if (isStaff) { %>
                        <a href="<%=request.getContextPath()%>/reports" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"></path>
                            </svg>
                            Reports & Analytics
                        </a>
                        <a href="<%=request.getContextPath()%>/manage/users" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                            Manage Users
                        </a>
                        <a href="<%=request.getContextPath()%>/manage/products" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                            </svg>
                            Manage Products
                        </a>
                        <a href="<%=request.getContextPath()%>/manage/suppliers" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                            </svg>
                            Manage Suppliers
                        </a>
                        <a href="<%=request.getContextPath()%>/manage/data" class="dropdown__item">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
                            </svg>
                            Data Management
                        </a>
                        <% } %>
                        <div class="dropdown__divider"></div>
                        <a href="logout.jsp" class="dropdown__item dropdown__item--danger">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z" clip-rule="evenodd"></path>
                            </svg>
                            Logout
                        </a>
                    </div>
                </div>
            <% } else { %>
                <!-- Guest user actions -->
                <div class="flex gap-2">
                    <a href="login.jsp" class="btn btn--primary btn--sm">Sign In</a>
                </div>
            <% } %>
            
            <!-- Cart and Theme -->
            <div class="flex items-center gap-3 ml-4">
                <!-- Theme Toggle -->
                <button class="theme-toggle btn btn--ghost btn--icon" onclick="toggleTheme()" aria-label="Toggle dark mode">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
                    </svg>
                </button>
                
                <a href="cart" class="btn btn--ghost btn--icon relative" aria-label="Shopping cart">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                    </svg>
                    <span class="header__cart-count badge badge--primary absolute -top-2 -right-2 hidden">0</span>
                </a>
            </div>
        </div>
        
        <!-- Mobile menu button -->
        <button class="nav__toggle md:hidden" onclick="toggleMobileMenu()">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
</header>
