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

<t:base title="Warehouse Management Solutions - IoT Bay" description="Optimize your warehouse operations with IoT solutions for inventory, automation, logistics.">
    
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
                    <a href="${pageContext.request.contextPath}/category-industrial.jsp" class="nav__link">Industrial</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-warehouse.jsp" class="nav__link nav__link--active">Warehouse</a>
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
    <section class="hero bg-gradient-to-r from-blue-50 to-indigo-100">
        <div class="container">
            <div class="hero__content">
                <h1 class="hero__title">Smart Warehouse Solutions</h1>
                <p class="hero__subtitle">
                    Revolutionize your warehouse operations with intelligent automation, real-time inventory tracking, 
                    and data-driven logistics optimization for maximum efficiency and cost savings.
                </p>
                <div class="hero__actions">
                    <a href="#products" class="btn btn--primary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                        </svg>
                        Explore Solutions
                    </a>
                    <a href="#capabilities" class="btn btn--outline btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                        View Capabilities
                    </a>
                </div>
            </div>
            <div class="hero__image">
                <img src="${pageContext.request.contextPath}/images/warehouse-hero.jpg" 
                     alt="Smart Warehouse Management" 
                     class="hero__image"
                     onerror="this.src='${pageContext.request.contextPath}/images/sample2.png'">
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
                <li class="text-neutral-900 font-medium">Warehouse Management</li>
            </ol>
        </nav>

        <!-- Key Benefits Section -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Transform Your Warehouse Operations</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Achieve operational excellence with our comprehensive warehouse IoT solutions designed to optimize every aspect of your logistics operations.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="text-center">
                    <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">95% Accuracy</h3>
                    <p class="text-neutral-600 text-sm">Real-time inventory tracking with RFID and barcode scanning</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">40% Faster</h3>
                    <p class="text-neutral-600 text-sm">Automated workflows and optimized picking routes</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">99.8% Uptime</h3>
                    <p class="text-neutral-600 text-sm">Predictive maintenance and system reliability</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">30% Cost Savings</h3>
                    <p class="text-neutral-600 text-sm">Reduced labor costs and optimized space utilization</p>
                </div>
            </div>
        </section>

        <!-- Capabilities Section -->
        <section id="capabilities" class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Comprehensive Warehouse Capabilities</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    From inventory management to automated fulfillment, our solutions cover every aspect of modern warehouse operations.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Inventory Management -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Real-Time Inventory</h3>
                        <p class="text-neutral-600 mb-4">
                            Track every item with precision using RFID tags, barcode scanners, and automated counting systems.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                RFID & Barcode Integration
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Automated Stock Counting
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Low Stock Alerts
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Automated Picking -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Picking Systems</h3>
                        <p class="text-neutral-600 mb-4">
                            Optimize order fulfillment with AI-powered route optimization and automated picking guidance.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Route Optimization
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Voice-Directed Picking
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Batch Processing
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Environmental Monitoring -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Environmental Control</h3>
                        <p class="text-neutral-600 mb-4">
                            Maintain optimal storage conditions with intelligent climate control and monitoring systems.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Temperature Monitoring
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Humidity Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Automated Adjustments
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter and Search Section -->
        <section id="products" class="mb-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6 mb-8">
                <div>
                    <h2 class="text-2xl font-bold text-neutral-900 mb-2">Warehouse Management Products</h2>
                    <p class="text-neutral-600">Discover our complete range of warehouse automation solutions</p>
                </div>
                
                <!-- Search and Filter Controls -->
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="relative">
                        <form action="${pageContext.request.contextPath}/category-warehouse.jsp" method="get" class="flex">
                            <input type="text" 
                                   name="search" 
                                   value="${param.search != null ? param.search : ''}"
                                   placeholder="Search warehouse products..." 
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
                        <option value="tracking">Tracking Systems</option>
                        <option value="automation">Automation</option>
                        <option value="picking">Picking Solutions</option>
                        <option value="monitoring">Monitoring</option>
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
                    <h2 class="text-3xl font-bold text-neutral-900 mb-4">Warehouse Management Products</h2>
                    <p class="text-lg text-neutral-600 max-w-2xl mx-auto">Discover our complete range of warehouse automation solutions designed for efficiency and accuracy</p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                    <!-- Product 1 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="tracking" data-price="399">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" alt="RFID Inventory Tracking System" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">RFID Inventory Tracking System</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Complete RFID solution for real-time inventory tracking with cloud-based analytics dashboard.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$399.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=7" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(7)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 2 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="automation" data-price="1599">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="Automated Picking Robot" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Automated Picking Robot</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">AI-powered robotic picking system for high-speed order fulfillment and reduced labor costs.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$1,599.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=8" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(8)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 3 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="monitoring" data-price="249">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="Warehouse Environmental Sensor" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Environmental Monitoring Hub</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Multi-sensor hub for monitoring temperature, humidity, and air quality in storage areas.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$249.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=9" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(9)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 4 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="picking" data-price="699">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" alt="Smart Picking Guidance System" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Smart Picking Guidance System</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Voice-directed picking system with LED lights and barcode verification for error-free fulfillment.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$699.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=10" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(10)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 5 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="tracking" data-price="129">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="Barcode Scanner Pro" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Wireless Barcode Scanner Pro</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">High-performance wireless scanner with long-range capabilities and rugged design.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$129.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=11" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(11)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 6 -->
                    <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 border border-neutral-200 overflow-hidden" data-category="automation" data-price="2999">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="Conveyor Control System" class="w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="bg-green-600 text-white px-2 py-1 rounded-full text-xs font-medium">Warehouse</span>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2 line-clamp-2">Smart Conveyor Control System</h3>
                            <p class="text-neutral-600 text-sm mb-4 line-clamp-3">Intelligent conveyor management with dynamic routing and real-time package tracking.</p>
                            <div class="flex items-center justify-between mb-4">
                                <div class="text-2xl font-bold text-neutral-900">$2,999.99</div>
                                <div class="text-sm text-neutral-500">USD</div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/productDetails.jsp?id=12" class="flex-1 bg-green-600 text-white text-center py-2 px-4 rounded-md hover:bg-green-700 transition-colors duration-200 text-sm font-medium">View Details</a>
                                <button onclick="addToCart(12)" class="flex-1 border border-neutral-300 text-neutral-700 py-2 px-4 rounded-md hover:bg-neutral-50 transition-colors duration-200 text-sm font-medium">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Success Stories Section -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Success Stories</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    See how leading companies have transformed their warehouse operations with our IoT solutions.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-brand-primary mb-2">75%</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Faster Processing</div>
                        <p class="text-sm text-neutral-600">Global Electronics reduced order processing time with automated picking systems</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-brand-primary mb-2">99.9%</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Inventory Accuracy</div>
                        <p class="text-sm text-neutral-600">Fashion Forward achieved near-perfect inventory tracking with RFID implementation</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-brand-primary mb-2">$2M</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Annual Savings</div>
                        <p class="text-sm text-neutral-600">MegaDistributor saved millions through optimized operations and reduced errors</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="card bg-gradient-to-r from-indigo-600 to-purple-600 text-white">
            <div class="card__body text-center py-16">
                <h2 class="text-3xl font-bold mb-4">Ready to Optimize Your Warehouse?</h2>
                <p class="text-xl mb-8 opacity-90">
                    Get a free consultation and see how our warehouse IoT solutions can transform your operations.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn--secondary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Schedule Consultation
                    </a>
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--outline btn--lg border-white text-white hover:bg-white hover:text-indigo-600">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                        </svg>
                        View All Solutions
                    </a>
                </div>
            </div>
        </section>
    </main>


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

        // Counter animation on scroll
        function animateCounters() {
            const counters = document.querySelectorAll('.text-3xl');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const counter = entry.target;
                        const text = counter.textContent;
                        if (text.includes('%') || text.includes('$') || text.includes('.')) {
                            // Animate counter
                            const finalValue = text;
                            counter.style.opacity = '0';
                            setTimeout(() => {
                                counter.textContent = finalValue;
                                counter.style.opacity = '1';
                                counter.style.transition = 'opacity 0.5s ease';
                            }, 200);
                        }
                    }
                }
            });
            
            counters.forEach(counter => observer.observe(counter));
        }

        // Initialize animations when page loads
        document.addEventListener('DOMContentLoaded', animateCounters);
    </script>
</t:base>
