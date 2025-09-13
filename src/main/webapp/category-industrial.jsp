<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String searchKeyword = (String) request.getParameter("search");
    if (products == null) {
        products = new ArrayList<>();
    }
%>

<t:base title="Industrial IoT Solutions - IoT Bay" description="Discover cutting-edge Industrial IoT solutions for manufacturing, automation, and smart factory applications.">
    
    <!-- Include Navigation -->
    <nav class="nav__container">
        <div class="container">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="nav__link">Home</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/browse" class="nav__link">Browse</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-industrial.jsp" class="nav__link nav__link--active">Industrial</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-warehouse.jsp" class="nav__link">Warehouse</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-agriculture.jsp" class="nav__link">Agriculture</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-smarthome.jsp" class="nav__link">Smart Home</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero__content">
                <h1 class="hero__title">Industrial IoT Solutions</h1>
                <p class="hero__subtitle">
                    Transform your manufacturing operations with cutting-edge Industrial IoT technology. 
                    Monitor, control, and optimize your production processes with real-time data and automation.
                </p>
                <div class="hero__actions">
                    <a href="#products" class="btn btn--primary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        Explore Products
                    </a>
                    <a href="#solutions" class="btn btn--outline btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Learn More
                    </a>
                </div>
            </div>
            <div class="hero__image">
                <img src="${pageContext.request.contextPath}/images/industrial-hero.jpg" 
                     alt="Industrial IoT Manufacturing" 
                     class="hero__image"
                     onerror="this.src='${pageContext.request.contextPath}/images/sample1.png'">
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="container py-16">
        <!-- Breadcrumb -->
        <nav class="mb-8">
            <ol class="flex items-center gap-2 text-sm text-neutral-600">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="hover:text-primary">Home</a></li>
                <li>/</li>
                <li><a href="${pageContext.request.contextPath}/browse" class="hover:text-primary">Categories</a></li>
                <li>/</li>
                <li class="text-neutral-900 font-medium">Industrial IoT</li>
            </ol>
        </nav>

        <!-- Solutions Overview Section -->
        <section id="solutions" class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Industrial IoT Solutions</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Revolutionize your industrial operations with our comprehensive IoT ecosystem designed for manufacturing excellence.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Smart Manufacturing -->
                <div class="card card--interactive">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-brand-primary rounded-2xl flex items-center justify-center mx-auto mb-6">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Manufacturing</h3>
                        <p class="text-neutral-600 mb-6">
                            Real-time production monitoring, predictive maintenance, and automated quality control systems.
                        </p>
                        <div class="space-y-2">
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Production Line Monitoring
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Machine Learning Analytics
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Automated Reporting
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Asset Tracking -->
                <div class="card card--interactive">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-brand-secondary rounded-2xl flex items-center justify-center mx-auto mb-6">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Asset Tracking</h3>
                        <p class="text-neutral-600 mb-6">
                            Track and manage your industrial assets with GPS, RFID, and beacon technology for complete visibility.
                        </p>
                        <div class="space-y-2">
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Real-time Location Tracking
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Inventory Management
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Maintenance Scheduling
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Environmental Monitoring -->
                <div class="card card--interactive">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-brand-accent rounded-2xl flex items-center justify-center mx-auto mb-6">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Environmental Monitoring</h3>
                        <p class="text-neutral-600 mb-6">
                            Monitor air quality, temperature, humidity, and other environmental factors critical to your operations.
                        </p>
                        <div class="space-y-2">
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Air Quality Sensors
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Climate Control Integration
                            </div>
                            <div class="flex items-center gap-2 text-sm text-neutral-700">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Compliance Reporting
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter and Search Section -->
        <section id="products" class="mb-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6 mb-8">
                <div>
                    <h2 class="text-2xl font-bold text-neutral-900 mb-2">Industrial IoT Products</h2>
                    <p class="text-neutral-600">Discover our complete range of industrial IoT solutions</p>
                </div>
                
                <!-- Search and Filter Controls -->
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="relative">
                        <form action="${pageContext.request.contextPath}/category-industrial.jsp" method="get" class="flex">
                            <input type="text" 
                                   name="search" 
                                   value="${param.search != null ? param.search : ''}"
                                   placeholder="Search industrial products..." 
                                   class="form-input rounded-r-none w-64">
                            <button type="submit" class="btn btn--primary rounded-l-none">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>
                            </button>
                        </form>
                    </div>
                    
                    <select class="form-select" onchange="filterProducts(this.value)">
                        <option value="">All Categories</option>
                        <option value="sensors">Sensors</option>
                        <option value="controllers">Controllers</option>
                        <option value="gateways">Gateways</option>
                        <option value="analytics">Analytics</option>
                    </select>
                    
                    <select class="form-select" onchange="sortProducts(this.value)">
                        <option value="">Sort by</option>
                        <option value="name">Name A-Z</option>
                        <option value="price-low">Price: Low to High</option>
                        <option value="price-high">Price: High to Low</option>
                        <option value="newest">Newest First</option>
                    </select>
                </div>
            </div>
        </section>

        <!-- Products Grid -->
        <section class="py-16" id="productsGrid">
            <div class="container">
                <div class="text-center mb-12">
                    <h2 class="text-3xl font-bold text-neutral-900 mb-4">Industrial IoT Products</h2>
                    <p class="text-lg text-neutral-600 max-w-2xl mx-auto">Discover our comprehensive range of Industrial IoT solutions designed for manufacturing excellence</p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                    <!-- Product 1 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="sensors" data-price="299">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" alt="Industrial Temperature Sensor" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Industrial Temperature Sensor</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">High-precision temperature monitoring for industrial environments with wireless connectivity.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$299.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=1" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(1)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 2 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="controllers" data-price="899">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="IoT Process Controller" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">IoT Process Controller</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Advanced process control unit with machine learning capabilities and cloud integration.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$899.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=2" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(2)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 3 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="gateways" data-price="1299">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="Industrial IoT Gateway" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Industrial IoT Gateway</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Rugged gateway for connecting legacy equipment to modern IoT platforms.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$1,299.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=3" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(3)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 4 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="sensors" data-price="199">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" alt="Vibration Monitoring Sensor" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Vibration Monitoring Sensor</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Predictive maintenance sensor for early detection of mechanical issues.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$199.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=4" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(4)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 5 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="analytics" data-price="599">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="Manufacturing Analytics Platform" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Manufacturing Analytics Platform</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Comprehensive analytics solution for production optimization and quality control.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$599.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=5" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(5)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 6 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="controllers" data-price="449">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="Smart Valve Controller" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-medium">Industrial</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Smart Valve Controller</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Intelligent valve control system with remote monitoring and automation capabilities.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$449.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=6" class="flex-1 bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(6)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="card bg-gradient-to-r from-brand-primary to-brand-secondary text-white">
            <div class="card__body text-center py-16">
                <h2 class="text-3xl font-bold mb-4">Ready to Transform Your Industrial Operations?</h2>
                <p class="text-xl mb-8 opacity-90">
                    Get expert consultation on implementing IoT solutions tailored to your specific manufacturing needs.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn--secondary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Get Consultation
                    </a>
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--outline btn--lg border-white text-white hover:bg-white hover:text-brand-primary">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                        </svg>
                        View All Products
                    </a>
                </div>
            </div>
        </section>
    </main>

    <!-- Include Footer -->

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Product filtering and sorting functionality
        function filterProducts(category) {
            const products = document.querySelectorAll('.product-card');
            products.forEach(product => {
                if (!category || product.dataset.category === category) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }

        function sortProducts(sortBy) {
            const grid = document.getElementById('productsGrid');
            const products = Array.from(grid.querySelectorAll('.product-card'));
            
            products.sort((a, b) => {
                switch(sortBy) {
                    case 'name':
                        return a.querySelector('.product-card__title').textContent.localeCompare(
                            b.querySelector('.product-card__title').textContent
                        );
                    case 'price-low':
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    case 'price-high':
                        return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                    default:
                        return 0;
                }
            });
            
            products.forEach(product => grid.appendChild(product));
        }

        function addToCart(productId) {
            // Add loading state
            const button = event.target;
            const originalText = button.textContent;
            button.innerHTML = '<div class="loading mr-2"></div> Adding...';
            button.disabled = true;
            
            // Simulate API call
            setTimeout(() => {
                button.textContent = originalText;
                button.disabled = false;
                showToast('Product added to cart successfully!', 'success');
            }, 1000);
        }

        // Smooth scrolling for anchor links
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
    </script>
</t:base>
