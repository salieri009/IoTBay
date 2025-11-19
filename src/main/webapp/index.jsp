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
    
    <!-- 1. Hero Section (Standalone) -->
    <section class="py-8 bg-white">
        <div class="l-container">
            <jsp:include page="/components/organisms/hero-banner/hero-banner.jsp">
                <jsp:param name="badgeText" value="New Arrivals" />
                <jsp:param name="title" value="Build Your <br/> Connected World" />
                <jsp:param name="description" value="From Arduino and Raspberry Pi to industrial sensors.<br/> Everything you need to turn your projects into reality is here." />
                <jsp:param name="primaryCtaText" value="Start Building" />
                <jsp:param name="primaryCtaHref" value="${pageContext.request.contextPath}/browse.jsp" />
                <jsp:param name="secondaryCtaText" value="Watch Demo" />
                <jsp:param name="secondaryCtaHref" value="${pageContext.request.contextPath}/about.jsp" />
                <jsp:param name="imageUrl" value="${pageContext.request.contextPath}/images/iot-device-hero-3d.png" />
                <jsp:param name="imageAlt" value="3D rendering of a connected IoT device ecosystem" />
            </jsp:include>
        </div>
    </section>

    <!-- 2. Shop by Category -->
    <jsp:include page="/components/organisms/category-grid/category-grid.jsp" />

    <!-- 3. Featured Products -->
    <section class="section-container section-container--white">
        <div class="l-container">
            <div class="section-container__header">
                <h2 class="section-container__title">Featured IoT Products</h2>
                <p class="section-container__description">
                    Handpicked devices for professionals
                </p>
            </div>
            
            <!-- Loading State with ARIA -->
            <div id="featured-products-skeleton" 
                 class="l-grid l-grid--gap-medium hidden" 
                 data-product-grid
                 role="status" 
                 aria-live="polite" 
                 aria-label="Loading featured products">
                <c:forEach begin="1" end="4" varStatus="loop">
                    <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                        <jsp:include page="/components/atoms/skeleton/skeleton.jsp">
                            <jsp:param name="type" value="card" />
                        </jsp:include>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Product Grid with Status Announcement -->
            <div class="l-grid l-grid--gap-medium" 
                 id="featured-products-grid" 
                 data-product-grid
                 role="region"
                 aria-label="Featured products"
                 aria-live="polite">
                <c:choose>
                    <c:when test="${featuredProducts != null && !empty featuredProducts}">
                        <c:forEach var="p" items="${featuredProducts}" end="3">
                            <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3" 
                                 data-product-id="${p.id}" 
                                 data-product-name="${p.name}"
                                 data-product-price="${p.price}"
                                 data-product-image="${p.imageUrl}">
                                <c:set var="product" value="${p}" scope="request" />
                                <div class="c-product-card">
                                    <jsp:include page="/components/molecules/product-card/product-card.jsp">
                                        <jsp:param name="showQuickView" value="true" />
                                        <jsp:param name="size" value="medium" />
                                    </jsp:include>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback Featured Products -->
                        <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                            <div class="c-product-card">
                                <jsp:useBean id="fallbackProduct" class="model.Product" />
                                <jsp:setProperty name="fallbackProduct" property="id" value="1" />
                                <jsp:setProperty name="fallbackProduct" property="name" value="Smart Industrial Sensor" />
                                <jsp:setProperty name="fallbackProduct" property="price" value="459.00" />
                                <jsp:setProperty name="fallbackProduct" property="imageUrl" value="${pageContext.request.contextPath}/images/sample1.png" />
                                <c:set var="product" value="${fallbackProduct}" scope="request" />
                                <jsp:include page="/components/molecules/product-card/product-card.jsp">
                                    <jsp:param name="showQuickView" value="true" />
                                    <jsp:param name="size" value="medium" />
                                </jsp:include>
                            </div>
                        </div>
                        
                        <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                            <div class="c-product-card">
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
                                            <span class="text-success text-sm">??In Stock (8 available)</span>
                                        </div>
                                    </div>
                                    <div class="product-card__actions">
                                        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=2" class="btn btn--outline btn--sm">View Details</a>
                                        <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(2, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                            <div class="c-product-card">
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
                                            <span class="text-success text-sm">??In Stock (12 available)</span>
                                        </div>
                                    </div>
                                    <div class="product-card__actions">
                                        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=3" class="btn btn--outline btn--sm">View Details</a>
                                        <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(3, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        
                        <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                            <div class="c-product-card">
                                <div class="product-card__image-container">
                                    <img src="${pageContext.request.contextPath}/images/sample1.png" 
                                         alt="Industrial Gateway" 
                                         class="product-card__image"
                                         loading="lazy"
                                         width="300"
                                         height="300"
                                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                </div>
                                <div class="product-card__body">
                                    <div class="product-card__header">
                                        <h3 class="product-card__title">Industrial Gateway</h3>
                                        <span class="product-card__spec-badge">LoRaWAN</span>
                                    </div>
                                    <p class="product-card__description">
                                        Robust gateway for connecting thousands of sensors over long distances.
                                    </p>
                                    <div class="product-card__footer">
                                        <div class="product-card__price-info">
                                            <div class="product-card__price">$599.00</div>
                                        </div>
                                        <div class="product-card__actions">
                                            <a href="${pageContext.request.contextPath}/productDetails.jsp?id=4" class="btn btn--outline btn--sm">View Details</a>
                                            <button type="button" onclick="if(typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') { OptimisticUI.addToCart(4, 1); }" class="btn btn--primary btn--sm">Add to Cart</button>
                                        </div>
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

    <!-- 4. Trust Indicators -->
    <jsp:include page="/components/organisms/trust-indicators/trust-indicators.jsp" />

    <!-- 5. Newsletter Signup -->
    <jsp:include page="/components/organisms/newsletter-section/newsletter-section.jsp">
        <jsp:param name="title" value="Stay Updated with Latest IoT Solutions" />
        <jsp:param name="description" value="Get the latest product updates, technical guides, and exclusive offers delivered to your inbox." />
        <jsp:param name="placeholder" value="Enter your email address" />
        <jsp:param name="buttonText" value="Subscribe" />
    </jsp:include>
    
    <script>
        // Nielsen Heuristics Improvements for index.jsp
        document.addEventListener('DOMContentLoaded', function() {
            // 1. Visibility of System Status - Show loading state
            const skeleton = document.getElementById('featured-products-skeleton');
            const grid = document.getElementById('featured-products-grid');
            
            // Show skeleton initially if products are loading
            if (skeleton && grid && grid.children.length === 0) {
                skeleton.classList.remove('hidden');
                // Announce loading to screen readers
                const liveRegion = document.getElementById('aria-live-announcements');
                if (liveRegion) {
                    liveRegion.textContent = 'Loading featured products...';
                }
            }
            
            // Hide skeleton when products load
            if (grid && grid.children.length > 0 && skeleton) {
                skeleton.classList.add('hidden');
                const liveRegion = document.getElementById('aria-live-announcements');
                if (liveRegion) {
                    liveRegion.textContent = `Loaded ${grid.children.length} featured products`;
                }
            }
            
            // 7. Flexibility and Efficiency - Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Don't trigger if user is typing in an input
                if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {
                    return;
                }
                
                // '/' key focuses search
                if (e.key === '/' && !e.ctrlKey && !e.metaKey) {
                    e.preventDefault();
                    const searchInput = document.querySelector('input[type="search"], input[name="search"], #search');
                    if (searchInput) {
                        searchInput.focus();
                    }
                }
                
                // 'b' key goes to browse
                if (e.key === 'b' || e.key === 'B') {
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/browse.jsp';
                }
            });
            
            // 6. Recognition Rather Than Recall - Add to cart feedback
            document.addEventListener('click', function(e) {
                const addToCartBtn = e.target.closest('button[onclick*="addToCart"], .btn[onclick*="addToCart"]');
                if (addToCartBtn) {
                    const productName = addToCartBtn.closest('[data-product-name]')?.getAttribute('data-product-name') || 'product';
                    
                    // Show optimistic feedback
                    const toast = document.getElementById('toast-container');
                    if (toast) {
                        const toastEl = document.createElement('div');
                        toastEl.className = 'bg-success text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
                        toastEl.innerHTML = `
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span>Added "${productName}" to cart</span>
                        `;
                        toastEl.setAttribute('role', 'status');
                        toastEl.setAttribute('aria-live', 'polite');
                        toast.appendChild(toastEl);
                        
                        // Announce to screen readers
                        const liveRegion = document.getElementById('aria-live-announcements');
                        if (liveRegion) {
                            liveRegion.textContent = `Added ${productName} to cart`;
                        }
                        
                        // Remove after 3 seconds
                        setTimeout(() => {
                            toastEl.remove();
                        }, 3000);
                    }
                }
            });
            
            // 3. User Control and Freedom - Add skip to main content
            const skipLink = document.querySelector('.skip-link[href="#main-content"]');
            if (skipLink) {
                skipLink.addEventListener('click', function(e) {
                    e.preventDefault();
                    const mainContent = document.getElementById('main-content');
                    if (mainContent) {
                        mainContent.focus();
                        mainContent.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                });
            }
        });
    </script>
</t:base>
