<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<t:base title="Home" description="Leading provider of IoT solutions for industry and smart living">

    <!-- Masthead (global hero under header) -->
    <jsp:include page="components/masthead.jsp">
        <jsp:param name="title" value="Transform Your World with Smart IoT Solutions" />
        <jsp:param name="subtitle" value="Discover cutting-edge IoT technologies for industry, agriculture, logistics, and smart living." />
        <jsp:param name="image" value="${pageContext.request.contextPath}/images/hero.png" />
        <jsp:param name="size" value="lg" />
        <jsp:param name="align" value="left" />
    </jsp:include>

    <!-- Homepage CTAs under masthead -->
    <section class="py-6">
        <div class="container">
            <div class="flex flex-wrap gap-3">
                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary btn--md">
                    Explore Products
                </a>
                <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn--outline btn--md">
                    Learn More
                </a>
            </div>
        </div>
    </section>

    <!-- Include Navigation -->
    <nav class="nav__container">
        <div class="container">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-industrial.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                        </svg>
                        Industrial IoT
                    </a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-warehouse.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                        </svg>
                        Warehouse Management
                    </a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-agriculture.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                        </svg>
                        Smart Agriculture
                    </a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/category-smarthome.jsp" class="nav__link">
                        <svg class="nav__icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                        </svg>
                        Smart Home
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    

    <!-- Featured Products -->
    <section class="py-12">
        <div class="container">
            <div class="text-center mb-8">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Featured IoT Solutions</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Discover our most popular IoT solutions trusted by industry leaders worldwide. 
                    From sensors to complete automation systems, we have everything you need.
                </p>
            </div>
            
            <div class="product-grid">
                <!-- Smart Industrial Sensor -->
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/images/sample1.png" 
                         alt="Smart Industrial Sensor" 
                         class="product-card__image"
                         onerror="this.src='${pageContext.request.contextPath}/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--primary mb-3">Industrial IoT</div>
                        <h3 class="product-card__title">Smart Industrial Sensor</h3>
                        <p class="product-card__description">
                            Advanced multi-parameter sensor for real-time monitoring of temperature, 
                            humidity, and pressure in industrial environments.
                        </p>
                        <div class="product-card__price">$459.00</div>
                        <div class="product-card__actions">
                            <a href="${pageContext.request.contextPath}/productDetails.jsp?id=1" class="btn btn--outline btn--sm">
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
                    <img src="${pageContext.request.contextPath}/images/sample2.png" 
                         alt="IoT Connectivity Kit" 
                         class="product-card__image"
                         onerror="this.src='${pageContext.request.contextPath}/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--secondary mb-3">Connectivity</div>
                        <h3 class="product-card__title">IoT Connectivity Kit</h3>
                        <p class="product-card__description">
                            Complete connectivity solution with high-quality cables, adapters, 
                            and wireless modules for seamless IoT device integration.
                        </p>
                        <div class="product-card__price">$89.00</div>
                        <div class="product-card__actions">
                            <a href="${pageContext.request.contextPath}/productDetails.jsp?id=2" class="btn btn--outline btn--sm">
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
                    <img src="${pageContext.request.contextPath}/images/sample3.png" 
                         alt="Smart Power Management System" 
                         class="product-card__image"
                         onerror="this.src='${pageContext.request.contextPath}/images/welcome.png'">
                    <div class="product-card__body">
                        <div class="badge badge--success mb-3">Energy</div>
                        <h3 class="product-card__title">Smart Power Management</h3>
                        <p class="product-card__description">
                            Intelligent power management system with monitoring, 
                            backup capabilities, and energy optimization for IoT devices.
                        </p>
                        <div class="product-card__price">$299.00</div>
                        <div class="product-card__actions">
                            <a href="${pageContext.request.contextPath}/productDetails.jsp?id=3" class="btn btn--outline btn--sm">
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
            <div class="text-center mt-12">
                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary btn--lg">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    Browse All Products
                </a>
            </div>
        </div>
    </section>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
</t:base>
