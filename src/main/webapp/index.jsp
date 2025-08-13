<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoT Bay - Smart Solutions for the Connected World</title>
    <meta name="description" content="Leading provider of IoT solutions for industrial automation, smart agriculture, warehouse management, and connected homes.">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <!-- Include Navigation -->
    <nav class="nav__container">
        <div class="container">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-industrial.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                        </svg>
                        Industrial IoT
                    </a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-warehouse.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                        </svg>
                        Warehouse Management
                    </a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-agriculture.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                        </svg>
                        Smart Agriculture
                    </a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-smarthome.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                        </svg>
                        Smart Home
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero__content">
                <h1 class="hero__title">Transform Your World with Smart IoT Solutions</h1>
                <p class="hero__subtitle">
                    Discover cutting-edge IoT technologies that power the future of industry, agriculture, 
                    logistics, and smart living. Connect, monitor, and optimize with confidence.
                </p>
                <div class="hero__actions">
                    <a href="<%=request.getContextPath()%>/browse" class="btn btn--primary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        Explore Products
                    </a>
                    <a href="<%=request.getContextPath()%>/about.jsp" class="btn btn--outline btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Learn More
                    </a>
                </div>
            </div>
            <div class="hero__image">
                <img src="<%=request.getContextPath()%>/images/hero.png" 
                     alt="IoT Bay - Connected Devices and Smart Solutions"
                     onerror="this.src='<%=request.getContextPath()%>/images/welcome.png'"/>
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-16">
        <div class="container">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Featured IoT Solutions</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Discover our most popular IoT solutions trusted by industry leaders worldwide. 
                    From sensors to complete automation systems, we have everything you need.
                </p>
            </div>
            
            <div class="product-grid">
                <!-- Smart Industrial Sensor -->
                <div class="product-card">
                    <img src="<%=request.getContextPath()%>/images/sample1.png" 
                         alt="Smart Industrial Sensor" 
                         class="product-card__image"
                         onerror="this.src='<%=request.getContextPath()%>/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--primary mb-3">Industrial IoT</div>
                        <h3 class="product-card__title">Smart Industrial Sensor</h3>
                        <p class="product-card__description">
                            Advanced multi-parameter sensor for real-time monitoring of temperature, 
                            humidity, and pressure in industrial environments.
                        </p>
                        <div class="product-card__price">$459.00</div>
                        <div class="product-card__actions">
                            <a href="<%=request.getContextPath()%>/productDetails.jsp?id=1" class="btn btn--outline btn--sm">
                                View Details
                            </a>
                            <button onclick="addToCart(1)" class="btn btn--primary btn--sm">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- IoT Connectivity Kit -->
                <div class="product-card">
                    <img src="<%=request.getContextPath()%>/images/sample2.png" 
                         alt="IoT Connectivity Kit" 
                         class="product-card__image"
                         onerror="this.src='<%=request.getContextPath()%>/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--secondary mb-3">Connectivity</div>
                        <h3 class="product-card__title">IoT Connectivity Kit</h3>
                        <p class="product-card__description">
                            Complete connectivity solution with high-quality cables, adapters, 
                            and wireless modules for seamless IoT device integration.
                        </p>
                        <div class="product-card__price">$89.00</div>
                        <div class="product-card__actions">
                            <a href="<%=request.getContextPath()%>/productDetails.jsp?id=2" class="btn btn--outline btn--sm">
                                View Details
                            </a>
                            <button onclick="addToCart(2)" class="btn btn--primary btn--sm">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Smart Power Management -->
                <div class="product-card">
                    <img src="<%=request.getContextPath()%>/images/sample3.png" 
                         alt="Smart Power Management System" 
                         class="product-card__image"
                         onerror="this.src='<%=request.getContextPath()%>/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--success mb-3">Energy</div>
                        <h3 class="product-card__title">Smart Power Management</h3>
                        <p class="product-card__description">
                            Intelligent power management system with monitoring, 
                            backup capabilities, and energy optimization for IoT devices.
                        </p>
                        <div class="product-card__price">$299.00</div>
                        <div class="product-card__actions">
                            <a href="<%=request.getContextPath()%>/productDetails.jsp?id=3" class="btn btn--outline btn--sm">
                                View Details
                            </a>
                            <button onclick="addToCart(3)" class="btn btn--primary btn--sm">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Call to Action -->
            <div class="text-center mt-16">
                <a href="<%=request.getContextPath()%>/browse" class="btn btn--primary btn--lg">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    Browse All Products
                </a>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-16 bg-neutral-50">
        <div class="container">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">IoT Solutions by Industry</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Explore specialized IoT solutions designed for different industries and applications
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Industrial IoT -->
                <a href="<%=request.getContextPath()%>/category-industrial.jsp" class="card card--interactive group">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-blue-100 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:bg-blue-200 transition-colors">
                            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Industrial IoT</h3>
                        <p class="text-neutral-600 text-sm">
                            Manufacturing automation, predictive maintenance, and process optimization solutions.
                        </p>
                    </div>
                </a>

                <!-- Warehouse Management -->
                <a href="<%=request.getContextPath()%>/category-warehouse.jsp" class="card card--interactive group">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-green-100 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:bg-green-200 transition-colors">
                            <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Warehouse</h3>
                        <p class="text-neutral-600 text-sm">
                            Inventory tracking, automated picking, and logistics optimization systems.
                        </p>
                    </div>
                </a>

                <!-- Smart Agriculture -->
                <a href="<%=request.getContextPath()%>/category-agriculture.jsp" class="card card--interactive group">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-emerald-100 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:bg-emerald-200 transition-colors">
                            <svg class="w-8 h-8 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Agriculture</h3>
                        <p class="text-neutral-600 text-sm">
                            Precision farming, soil monitoring, irrigation control, and livestock tracking.
                        </p>
                    </div>
                </a>

                <!-- Smart Home -->
                <a href="<%=request.getContextPath()%>/category-smarthome.jsp" class="card card--interactive group">
                    <div class="card__body text-center">
                        <div class="w-16 h-16 bg-purple-100 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:bg-purple-200 transition-colors">
                            <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Home</h3>
                        <p class="text-neutral-600 text-sm">
                            Home automation, security systems, energy management, and entertainment.
                        </p>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- Trust & Statistics Section -->
    <section class="py-16">
        <div class="container">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Trusted by Industry Leaders</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Join thousands of companies worldwide who rely on IoT Bay for their smart technology solutions
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-8 text-center">
                <div>
                    <div class="text-4xl font-bold text-brand-primary mb-2">10,000+</div>
                    <div class="text-lg font-semibold text-neutral-900 mb-1">Happy Customers</div>
                    <p class="text-sm text-neutral-600">Across 50+ countries</p>
                </div>
                
                <div>
                    <div class="text-4xl font-bold text-brand-primary mb-2">500+</div>
                    <div class="text-lg font-semibold text-neutral-900 mb-1">IoT Products</div>
                    <p class="text-sm text-neutral-600">Premium quality devices</p>
                </div>
                
                <div>
                    <div class="text-4xl font-bold text-brand-primary mb-2">99.9%</div>
                    <div class="text-lg font-semibold text-neutral-900 mb-1">Uptime</div>
                    <p class="text-sm text-neutral-600">Reliable connectivity</p>
                </div>
                
                <div>
                    <div class="text-4xl font-bold text-brand-primary mb-2">24/7</div>
                    <div class="text-lg font-semibold text-neutral-900 mb-1">Support</div>
                    <p class="text-sm text-neutral-600">Expert assistance</p>
                </div>
            </div>
        </div>
    </section>
        <jsp:include page="components/footer.jsp" />
        <script src="js/main.js"></script>
    </body>
</html>
