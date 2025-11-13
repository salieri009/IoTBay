<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, model.*" %>

<%
    // Get featured products (can be loaded from controller or hardcoded for now)
    List<Product> featuredProducts = (List<Product>) request.getAttribute("featuredProducts");
    if (featuredProducts == null) {
        featuredProducts = new ArrayList<>();
    }
    request.setAttribute("featuredProducts", featuredProducts);
%>

<t:base title="Home" description="Your Premier IoT Device Store - Technical sophistication meets user-friendly design">
    
    <!-- Hero Section - Full Width (Section 4.1) -->
    <section class="hero bg-gradient-to-r from-brand-primary via-brand-primary-600 to-brand-secondary relative overflow-hidden">
        <div class="absolute inset-0 opacity-10">
            <img src="${pageContext.request.contextPath}/images/hero.png" 
                 alt="" 
                 class="w-full h-full object-cover"
                 aria-hidden="true">
        </div>
        <div class="container relative z-10 text-center py-16 md:py-24">
            <div class="max-w-4xl mx-auto">
                <h1 class="text-display-xl font-extrabold text-white mb-6 animate-fade-in-up drop-shadow-2xl">
                    Your Premier IoT Device Store
                </h1>
                <p class="text-xl md:text-2xl text-white/90 max-w-3xl mx-auto mb-8 animate-fade-in-up animation-delay-200">
                    Technical sophistication meets user-friendly design
                </p>
                <div class="flex flex-wrap justify-center gap-4 animate-fade-in-up animation-delay-400">
                    <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary btn--lg">
                        Browse Products
                    </a>
                    <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn--secondary btn--lg">
                        Learn More
                    </a>
                </div>
                <div class="mt-8 animate-fade-in-up animation-delay-600">
                    <p class="text-white/80 text-sm font-medium">
                        ✓ Trusted by 10,000+ Engineers Worldwide
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Category Quick Links - Grid Layout (Section 4.1) -->
    <section class="py-12 bg-white">
        <div class="container">
            <div class="text-center mb-12">
                <h2 class="text-display-m font-bold text-neutral-900 mb-4">Shop by Category</h2>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                    Explore our comprehensive range of IoT solutions across industries
                </p>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Industrial Category Card -->
                <a href="${pageContext.request.contextPath}/category-industrial.jsp" 
                   class="category-card group bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 p-6 border border-neutral-200 hover:border-brand-primary">
                    <div class="category-card__icon mb-4">
                        <div class="w-16 h-16 bg-brand-primary-100 rounded-lg flex items-center justify-center group-hover:bg-brand-primary group-hover:scale-110 transition-all duration-300">
                            <svg class="w-8 h-8 text-brand-primary group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Industrial</h3>
                    <ul class="text-sm text-neutral-600 space-y-1 mb-4">
                        <li>• Sensors</li>
                        <li>• Controllers</li>
                        <li>• Connectivity</li>
                    </ul>
                    <span class="text-brand-primary font-medium group-hover:underline inline-flex items-center">
                        Explore →
                    </span>
                </a>

                <!-- Warehouse Category Card -->
                <a href="${pageContext.request.contextPath}/category-warehouse.jsp" 
                   class="category-card group bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 p-6 border border-neutral-200 hover:border-brand-primary">
                    <div class="category-card__icon mb-4">
                        <div class="w-16 h-16 bg-brand-secondary-100 rounded-lg flex items-center justify-center group-hover:bg-brand-secondary group-hover:scale-110 transition-all duration-300">
                            <svg class="w-8 h-8 text-brand-secondary group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Warehouse</h3>
                    <ul class="text-sm text-neutral-600 space-y-1 mb-4">
                        <li>• RFID Systems</li>
                        <li>• Automation</li>
                        <li>• Monitoring</li>
                    </ul>
                    <span class="text-brand-primary font-medium group-hover:underline inline-flex items-center">
                        Explore →
                    </span>
                </a>

                <!-- Agriculture Category Card -->
                <a href="${pageContext.request.contextPath}/category-agriculture.jsp" 
                   class="category-card group bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 p-6 border border-neutral-200 hover:border-brand-primary">
                    <div class="category-card__icon mb-4">
                        <div class="w-16 h-16 bg-success-100 rounded-lg flex items-center justify-center group-hover:bg-success group-hover:scale-110 transition-all duration-300">
                            <svg class="w-8 h-8 text-success group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Agriculture</h3>
                    <ul class="text-sm text-neutral-600 space-y-1 mb-4">
                        <li>• Environmental Sensors</li>
                        <li>• Irrigation</li>
                        <li>• Livestock Monitoring</li>
                    </ul>
                    <span class="text-brand-primary font-medium group-hover:underline inline-flex items-center">
                        Explore →
                    </span>
                </a>

                <!-- Smart Home Category Card -->
                <a href="${pageContext.request.contextPath}/category-smarthome.jsp" 
                   class="category-card group bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 p-6 border border-neutral-200 hover:border-brand-primary">
                    <div class="category-card__icon mb-4">
                        <div class="w-16 h-16 bg-accent-100 rounded-lg flex items-center justify-center group-hover:bg-accent group-hover:scale-110 transition-all duration-300">
                            <svg class="w-8 h-8 text-accent group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Smart Home</h3>
                    <ul class="text-sm text-neutral-600 space-y-1 mb-4">
                        <li>• Security Systems</li>
                        <li>• Energy Management</li>
                        <li>• Home Automation</li>
                    </ul>
                    <span class="text-brand-primary font-medium group-hover:underline inline-flex items-center">
                        Explore →
                    </span>
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Products - Product Grid (Section 4.1) -->
    <section class="py-12 bg-neutral-50">
        <div class="container">
            <div class="text-center mb-12">
                <h2 class="text-display-m font-bold text-neutral-900 mb-4">Featured IoT Products</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Handpicked devices for professionals
                </p>
            </div>
            
            <!-- Skeleton Loading State (Section 3.2) -->
            <div id="featured-products-skeleton" class="product-grid hidden">
                <c:forEach begin="1" end="4" varStatus="loop">
                    <div class="skeleton-card">
                        <div class="skeleton skeleton-image"></div>
                        <div class="skeleton skeleton-text skeleton-text--title"></div>
                        <div class="skeleton skeleton-text"></div>
                        <div class="skeleton skeleton-text skeleton-text--short"></div>
                    </div>
                </c:forEach>
            </div>
            
            <div class="product-grid" id="featured-products-grid">
                <c:choose>
                    <c:when test="${featuredProducts != null && !empty featuredProducts}">
                        <c:forEach var="p" items="${featuredProducts}" end="3">
                            <div class="product-card" 
                                 data-product-id="${p.id}" 
                                 data-price="${p.price}" 
                                 data-name="${fn:toLowerCase(p.name)}"
                                 tabindex="0"
                                 role="article"
                                 aria-label="Product: ${p.name}">
                                <div class="product-card__image-container">
                                    <img class="product-card__image" 
                                         src="${p.imageUrl != null && !empty p.imageUrl ? p.imageUrl : 'images/default-product.png'}" 
                                         alt="${p.name}" 
                                         loading="lazy"
                                         width="300"
                                         height="300"
                                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                    <!-- Stock Badge (Visibility of System Status - Nielsen's Heuristic 1) -->
                                    <c:if test="${p.stockQuantity > 0 && p.stockQuantity < 5}">
                                        <span class="product-card__badge product-card__badge--warning" aria-label="Low stock: ${p.stockQuantity} remaining">
                                            Low Stock
                                        </span>
                                    </c:if>
                                    <c:if test="${p.stockQuantity == 0}">
                                        <span class="product-card__badge product-card__badge--error" aria-label="Out of stock">
                                            Out of Stock
                                        </span>
                                    </c:if>
                                </div>
                                <div class="product-card__body">
                                    <div class="product-card__header">
                                        <h3 class="product-card__title">${p.name}</h3>
                                        <!-- Key Spec Badge (Section 1.1 - Recognition rather than recall) -->
                                        <span class="product-card__spec-badge" title="Communication Protocol">LoRaWAN</span>
                                    </div>
                                    <p class="product-card__description">
                                        <c:choose>
                                            <c:when test="${fn:length(p.description) > 100}">
                                                ${fn:substring(p.description, 0, 100)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${p.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="product-card__footer">
                                        <div class="product-card__price-info">
                                            <div class="product-card__price">$<fmt:formatNumber value="${p.price}" pattern="#.00" /></div>
                                            <div class="product-card__stock-status">
                                                <c:choose>
                                                    <c:when test="${p.stockQuantity > 0}">
                                                        <span class="text-success text-sm">✓ In Stock</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-error text-sm">✗ Out of Stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="product-card__actions">
                                            <a href="${pageContext.request.contextPath}/product?productId=${p.id}" 
                                               class="btn btn--outline btn--sm"
                                               aria-label="View details for ${p.name}">
                                                View Details
                                            </a>
                                            <button type="button"
                                                    onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(${p.id}, 1); } else { window.location.href='${pageContext.request.contextPath}/productDetails.jsp?id=${p.id}'; }"
                                                    class="btn btn--primary btn--sm"
                                                    aria-label="Add ${p.name} to cart"
                                                    <c:if test="${p.stockQuantity == 0}">disabled</c:if>>
                                                <c:choose>
                                                    <c:when test="${p.stockQuantity > 0}">Add to Cart</c:when>
                                                    <c:otherwise>Out of Stock</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback Featured Products (if no data from controller) -->
                        <div class="product-card">
                            <div class="product-card__image-container">
                                <img src="${pageContext.request.contextPath}/images/sample1.png" 
                                     alt="Smart Industrial Sensor" 
                                     class="product-card__image"
                                     loading="lazy"
                                     width="300"
                                     height="300"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                <span class="product-card__badge product-card__badge--success" aria-label="In stock">In Stock</span>
                            </div>
                            <div class="product-card__body">
                                <div class="product-card__header">
                                    <h3 class="product-card__title">Smart Industrial Sensor</h3>
                                    <span class="product-card__spec-badge">LoRaWAN</span>
                                </div>
                                <p class="product-card__description">
                                    Advanced multi-parameter sensor for real-time monitoring of temperature, humidity, and pressure.
                                </p>
                                <div class="product-card__footer">
                                    <div class="product-card__price-info">
                                        <div class="product-card__price">$459.00</div>
                                        <div class="product-card__stock-status">
                                            <span class="text-success text-sm">✓ In Stock (15 available)</span>
                                        </div>
                                    </div>
                                    <div class="product-card__actions">
                                        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=1" class="btn btn--outline btn--sm">View Details</a>
                                        <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(1, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="product-card">
                            <div class="product-card__image-container">
                                <img src="${pageContext.request.contextPath}/images/sample2.png" 
                                     alt="IoT Connectivity Kit" 
                                     class="product-card__image"
                                     loading="lazy"
                                     width="300"
                                     height="300"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                <span class="product-card__badge product-card__badge--success" aria-label="In stock">In Stock</span>
                            </div>
                            <div class="product-card__body">
                                <div class="product-card__header">
                                    <h3 class="product-card__title">IoT Connectivity Kit</h3>
                                    <span class="product-card__spec-badge">WiFi</span>
                                </div>
                                <p class="product-card__description">
                                    Complete connectivity solution with high-quality cables, adapters, and wireless modules.
                                </p>
                                <div class="product-card__footer">
                                    <div class="product-card__price-info">
                                        <div class="product-card__price">$89.00</div>
                                        <div class="product-card__stock-status">
                                            <span class="text-success text-sm">✓ In Stock (8 available)</span>
                                        </div>
                                    </div>
                                    <div class="product-card__actions">
                                        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=2" class="btn btn--outline btn--sm">View Details</a>
                                        <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(2, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="product-card">
                            <div class="product-card__image-container">
                                <img src="${pageContext.request.contextPath}/images/sample3.png" 
                                     alt="Smart Power Management" 
                                     class="product-card__image"
                                     loading="lazy"
                                     width="300"
                                     height="300"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                <span class="product-card__badge product-card__badge--success" aria-label="In stock">In Stock</span>
                            </div>
                            <div class="product-card__body">
                                <div class="product-card__header">
                                    <h3 class="product-card__title">Smart Power Management</h3>
                                    <span class="product-card__spec-badge">12V DC</span>
                                </div>
                                <p class="product-card__description">
                                    Intelligent power management system with monitoring, backup capabilities, and energy optimization.
                                </p>
                                <div class="product-card__footer">
                                    <div class="product-card__price-info">
                                        <div class="product-card__price">$299.00</div>
                                        <div class="product-card__stock-status">
                                            <span class="text-success text-sm">✓ In Stock (12 available)</span>
                                        </div>
                                    </div>
                                    <div class="product-card__actions">
                                        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=3" class="btn btn--outline btn--sm">View Details</a>
                                        <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(3, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Call to Action -->
            <div class="text-center mt-12">
                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--secondary btn--lg">
                    View All Products
                    <svg class="w-4 h-4 inline ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </a>
            </div>
        </div>
    </section>

    <!-- Trust Indicators - Horizontal Strip (Section 4.1) -->
    <section class="py-12 bg-white border-t border-neutral-200">
        <div class="container">
            <div class="text-center mb-8">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-2">Why Choose IoTBay?</h2>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="trust-indicator text-center p-6 bg-neutral-50 rounded-lg">
                    <div class="w-16 h-16 bg-brand-primary-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-brand-primary" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-neutral-900 mb-2">Certified Products</h3>
                    <p class="text-sm text-neutral-600">CE/FCC Approved</p>
                </div>
                
                <div class="trust-indicator text-center p-6 bg-neutral-50 rounded-lg">
                    <div class="w-16 h-16 bg-brand-secondary-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-brand-secondary" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path d="M2 5a2 2 0 012-2h7a2 2 0 012 2v4a2 2 0 01-2 2H9l-3 3v-3H4a2 2 0 01-2-2V5z"></path>
                            <path d="M15 7v2a4 4 0 01-4 4H9.828l-1.766 1.767c.28.149.599.233.938.233h2l3 3v-3h2a2 2 0 002-2V9a2 2 0 00-2-2h-1z"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-neutral-900 mb-2">24/7 Support</h3>
                    <p class="text-sm text-neutral-600">Live Chat Available</p>
                </div>
                
                <div class="trust-indicator text-center p-6 bg-neutral-50 rounded-lg">
                    <div class="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-success" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-neutral-900 mb-2">2-Year Warranty</h3>
                    <p class="text-sm text-neutral-600">All Items Covered</p>
                </div>
                
                <div class="trust-indicator text-center p-6 bg-neutral-50 rounded-lg">
                    <div class="w-16 h-16 bg-accent-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-accent" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                            <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-neutral-900 mb-2">Free Shipping</h3>
                    <p class="text-sm text-neutral-600">On Orders $50+</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Signup - Optional (Section 4.1) -->
    <section class="py-12 bg-gradient-to-r from-brand-primary-50 to-brand-secondary-50">
        <div class="container">
            <div class="max-w-2xl mx-auto text-center">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Stay Updated with Latest IoT Solutions</h2>
                <p class="text-lg text-neutral-600 mb-6">
                    Get the latest product updates, technical guides, and exclusive offers delivered to your inbox.
                </p>
                <form class="newsletter-form flex flex-col sm:flex-row gap-3 max-w-md mx-auto" 
                      id="newsletterForm"
                      onsubmit="handleNewsletterSubmit(event)">
                    <input 
                        type="email" 
                        id="newsletterEmail"
                        name="email"
                        placeholder="Enter your email address"
                        class="form-input flex-1"
                        required
                        aria-label="Email address for newsletter"
                        aria-describedby="newsletter-help">
                    <button type="submit" class="btn btn--primary">
                        Subscribe
                    </button>
                </form>
                <p id="newsletter-help" class="text-sm text-neutral-500 mt-3">
                    We respect your privacy. Unsubscribe at any time.
                </p>
            </div>
        </div>
    </section>

    <script>
        // Newsletter form handler
        function handleNewsletterSubmit(event) {
            event.preventDefault();
            const email = document.getElementById('newsletterEmail').value;
            
            if (typeof showToast === 'function') {
                showToast('Thank you for subscribing!', 'success');
            }
            
            // Reset form
            event.target.reset();
        }
    </script>
</t:base>
