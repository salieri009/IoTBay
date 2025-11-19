<%@ page import="model.Product, model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%
    Product product = (Product) request.getAttribute("product");
    User currentUser = (User) session.getAttribute("user");
    
    // 기본값 설정
    String productName = "Sample IoT Device";
    String productDescription = "A high-quality IoT device for smart automation and monitoring. Features advanced connectivity, robust build quality, and seamless integration with popular IoT platforms.";
    double productPrice = 199.99;
    int productStock = 10;
    int productId = 0;
    String productImage = "images/sample1.png";
    
    // product 객체가 있으면 실제 값을 사용
    if (product != null) {
        try {
            productName = product.getName() != null ? product.getName() : productName;
            productDescription = product.getDescription() != null ? product.getDescription() : productDescription;
            productPrice = product.getPrice();
            productStock = product.getStockQuantity();
            productId = product.getId();
            productImage = product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? product.getImageUrl() : productImage;
        } catch (Exception e) {
            // 메소드 호출 실패 시 기본값 사용
        }
    }

    boolean inStock = productStock > 0;
    String stockLabel = inStock ? "In stock (" + productStock + " available)" : "Out of stock";
    String stockBadgeTone = inStock ? "success" : "error";
    String formattedPrice = String.format("%1$,.2f", productPrice);

    // Expose for EL
    pageContext.setAttribute("pd_name", productName);
    pageContext.setAttribute("pd_desc", productDescription);
    pageContext.setAttribute("pd_price", productPrice);
    pageContext.setAttribute("pd_priceFormatted", formattedPrice);
    pageContext.setAttribute("pd_stock", productStock);
    pageContext.setAttribute("pd_inStock", inStock);
    pageContext.setAttribute("pd_stockLabel", stockLabel);
    pageContext.setAttribute("pd_stockBadgeTone", stockBadgeTone);
    pageContext.setAttribute("pd_id", productId);
    pageContext.setAttribute("pd_image", productImage);
%>
<t:base title="${pd_name} - IoT Bay" description="Product details">
    <main class="py-12 bg-neutral-50">
        <div class="container mx-auto px-4">
            <!-- Breadcrumb Navigation -->
            <nav aria-label="Breadcrumb" class="mb-8">
                <ol class="flex flex-wrap items-center gap-2 text-sm text-neutral-600">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary transition-colors">Home</a></li>
                    <li aria-hidden="true" class="text-neutral-400">/</li>
                    <li><a href="${pageContext.request.contextPath}/browse.jsp" class="hover:text-brand-primary transition-colors">Products</a></li>
                    <li aria-hidden="true" class="text-neutral-400">/</li>
                    <li class="text-neutral-900 font-medium" aria-current="page">${pd_name}</li>
                </ol>
            </nav>

            <!-- Product Details: 12-column Grid 7:5 Ratio (Image:Info) -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-12">
                <!-- Left Panel: Product Images (7 columns, sticky) -->
                <article class="lg:col-span-7 space-y-12">
                    <!-- Product Imagery -->
                    <jsp:include page="/components/organisms/product-gallery/product-gallery.jsp">
                        <jsp:param name="mainImageUrl" value="${pageContext.request.contextPath}/${pd_image}" />
                        <jsp:param name="productName" value="${pd_name}" />
                    </jsp:include>

                    <!-- Product Overview -->
                    <section class="space-y-6">
                        <div class="flex items-center gap-3">
                            <span class="inline-flex items-center gap-2 rounded-full bg-brand-primary/10 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-brand-primary">
                                <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                                Product overview
                            </span>
                        </div>
                        <h1 class="text-4xl font-bold text-neutral-900 tracking-tight">
                            ${pd_name}
                        </h1>
                        <p class="text-lg text-neutral-600 leading-relaxed max-w-3xl">
                            ${pd_desc}
                        </p>
                    </section>

                    <!-- Product Highlights -->
                    <section>
                        <dl class="grid grid-cols-1 md:grid-cols-3 gap-6" aria-label="Product highlights">
                            <div class="bg-white rounded-xl border border-neutral-200 p-6 shadow-sm">
                                <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500 mb-2">Price</dt>
                                <dd class="text-3xl font-bold text-neutral-900">&#36;${pd_priceFormatted}</dd>
                                <dd class="mt-1 text-xs text-neutral-500">All prices include GST.</dd>
                            </div>
                            <div class="bg-white rounded-xl border border-neutral-200 p-6 shadow-sm">
                                <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500 mb-2">Availability</dt>
                                <c:choose>
                                    <c:when test="${pd_inStock}">
                                            <dd class="mt-2 text-sm font-semibold text-success" aria-live="polite">${pd_stockLabel}</dd>
                                        </c:when>
                                        <c:otherwise>
                                            <dd class="mt-2 text-sm font-semibold text-error" aria-live="polite">${pd_stockLabel}</dd>
                                        </c:otherwise>
                                    </c:choose>
                                    <dd class="mt-1 text-xs text-neutral-500">Ships within 2-3 business days.</dd>
                                </div>
                            </div>
                            <div class="l-grid__col-12 l-grid__col-md-4">
                                <div class="c-card c-card--padded-small" role="group" aria-label="Support">
                                    <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500">Support</dt>
                                    <dd class="mt-2 text-sm font-semibold text-neutral-900">24/7 specialist assistance</dd>
                                    <dd class="mt-1 text-xs text-neutral-500">Includes onboarding & integration guidance.</dd>
                                </div>
                            </div>
                        </dl>
                    </section>

                    <!-- Key Features -->
                    <section class="l-spacing-md">
                        <h2 class="text-lg font-semibold text-neutral-900 l-spacing-sm">Key features</h2>
                        <ul class="space-y-2">
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Wireless connectivity (Wi-Fi & Bluetooth)</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Real-time monitoring and alerts</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Easy setup and configuration</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Energy efficient design</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Mobile app integration</span>
                            </li>
                        </ul>
                    </section>
                </article>

                <!-- Right Panel: Product Info & Buy Box (5 columns, sticky) -->
                <aside class="l-product-details__info c-buy-box l-sticky">
                    <div class="space-y-4">
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-neutral-700">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                            Product overview
                        </span>
                        <h1 class="text-display-l font-bold text-neutral-900 leading-tight">
                            ${pd_name}
                        </h1>
                        <p class="text-neutral-600 leading-relaxed">
                            ${pd_desc}
                        </p>
                    </div>

                    <dl class="grid gap-4 sm:grid-cols-3" aria-label="Product highlights">
                        <div class="rounded-2xl border border-neutral-200 bg-white p-4 shadow-sm" role="group" aria-label="Price">
                            <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500">Price</dt>
                            <dd class="mt-2 text-2xl font-bold text-neutral-900">&#36;${pd_priceFormatted}</dd>
                            <dd class="mt-1 text-xs text-neutral-500">All prices include GST.</dd>
                        </div>
                        <div class="rounded-2xl border border-neutral-200 bg-white p-4 shadow-sm" role="group" aria-label="Availability">
                            <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500">Availability</dt>
                            <c:choose>
                                <c:when test="${pd_inStock}">
                                    <dd class="mt-2 text-sm font-semibold text-success" aria-live="polite">${pd_stockLabel}</dd>
                                </c:when>
                                <c:otherwise>
                                    <dd class="mt-2 text-sm font-semibold text-error" aria-live="polite">${pd_stockLabel}</dd>
                                </c:otherwise>
                            </c:choose>
                            <dd class="mt-1 text-xs text-neutral-500">Ships within 2-3 business days.</dd>
                        </div>
                        <div class="rounded-2xl border border-neutral-200 bg-white p-4 shadow-sm" role="group" aria-label="Support">
                            <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500">Support</dt>
                            <dd class="mt-2 text-sm font-semibold text-neutral-900">24/7 specialist assistance</dd>
                            <dd class="mt-1 text-xs text-neutral-500">Includes onboarding & integration guidance.</dd>
                        </div>
                    </dl>

                    <!-- Price -->
                    <div class="c-buy-box__price">
                        &#36;${pd_priceFormatted}
                    </div>
                    <p class="text-sm text-neutral-500 l-spacing-sm">All prices include GST.</p>

                    <!-- Stock Status -->
                    <div class="l-spacing-md">
                        <jsp:include page="/components/atoms/badge/badge.jsp">
                            <jsp:param name="text" value="${pd_stockLabel}" />
                            <jsp:param name="type" value="${pd_inStock ? 'success' : 'error'}" />
                            <jsp:param name="size" value="medium" />
                        </jsp:include>
                        <p class="text-xs text-neutral-500 mt-1">Ships within 2-3 business days.</p>
                    </div>

                    <!-- Quantity Selector -->
                    <div class="l-spacing-md">
                        <label for="quantity" class="block text-sm font-medium text-neutral-700 l-spacing-xs">Quantity</label>
                        <div class="flex items-center gap-2">
                            <button type="button" onclick="decreaseQuantity()" class="btn btn--ghost btn--sm" aria-label="Decrease quantity">
                                <span aria-hidden="true">&minus;</span>
                            </button>
                            <input type="number" id="quantity" value="1" min="1" max="${pd_stock}" 
                                   class="form-input w-24 text-center" aria-live="polite">
                            <button type="button" onclick="increaseQuantity()" class="btn btn--ghost btn--sm" aria-label="Increase quantity">
                                <span aria-hidden="true">+</span>
                            </button>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="c-buy-box__actions">
                        <c:choose>
                            <c:when test="${pd_inStock}">
                                <jsp:include page="/components/atoms/button/button.jsp">
                                    <jsp:param name="text" value="Add to Cart" />
                                    <jsp:param name="type" value="primary" />
                                    <jsp:param name="size" value="large" />
                                    <jsp:param name="fullWidth" value="true" />
                                    <jsp:param name="icon" value="cart" />
                                    <jsp:param name="ariaLabel" value="Add ${pd_name} to cart" />
                                    <jsp:param name="extraClass" value="add-to-cart-button" />
                                    <jsp:param name="attributes" value="data-product-id='${pd_id}' data-action='add-to-cart'" />
                                </jsp:include>
                                
                                <jsp:include page="/components/atoms/button/button.jsp">
                                    <jsp:param name="text" value="Add to Wishlist" />
                                    <jsp:param name="type" value="outline" />
                                    <jsp:param name="size" value="large" />
                                    <jsp:param name="fullWidth" value="true" />
                                    <jsp:param name="icon" value="heart" />
                                </jsp:include>
                            </c:when>
                            <c:otherwise>
                                <jsp:include page="/components/atoms/button/button.jsp">
                                    <jsp:param name="text" value="Currently unavailable" />
                                    <jsp:param name="type" value="outline" />
                                    <jsp:param name="size" value="large" />
                                    <jsp:param name="fullWidth" value="true" />
                                    <jsp:param name="disabled" value="true" />
                                </jsp:include>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Trust Info -->
                    <div class="c-buy-box__info">
                        <div class="c-buy-box__info-item">
                            <svg class="w-5 h-5 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"></path>
                            </svg>
                            <span>Free shipping on orders over &#36;100.</span>
                        </div>
                        <div class="c-buy-box__info-item">
                            <svg class="w-5 h-5 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <span>2-year warranty included.</span>
                        </div>
                        <div class="c-buy-box__info-item">
                            <svg class="w-5 h-5 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                            </svg>
                            <span>30-day return policy.</span>
                        </div>
                    </div>
                </aside>
            </div>

            <!-- Trust Badges Section -->
            <section class="l-spacing-md">
                <div class="flex flex-wrap gap-3">
                    <div class="trust-badge" title="CE Certified - European Conformity">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>CE Certified</span>
                    </div>
                    <div class="trust-badge" title="FCC Approved - Federal Communications Commission">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>FCC Approved</span>
                    </div>
                    <div class="trust-badge" title="Works with Home Assistant">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"/>
                        </svg>
                        <span>Home Assistant</span>
                    </div>
                    <div class="trust-badge" title="2-Year Warranty Included">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>2-Year Warranty</span>
                    </div>
                </div>
            </div>

            <!-- Product Tabs (Section 4.3) -->
            <div class="mt-16">
                <div class="border-b border-neutral-200">
                    <nav class="flex flex-wrap space-x-8" role="tablist" aria-label="Product information tabs">
                        <button 
                            class="tab-button active py-4 px-1 border-b-2 border-brand-primary text-brand-primary font-medium transition-colors" 
                            onclick="showTab('specifications')" 
                            role="tab" 
                            id="specifications-tab"
                            aria-selected="true"
                            aria-controls="specifications-panel">
                            Specifications
                        </button>
                        <button 
                            class="tab-button py-4 px-1 border-b-2 border-transparent text-neutral-500 hover:text-neutral-700 hover:border-neutral-300 transition-colors" 
                            onclick="showTab('compatibility')" 
                            role="tab" 
                            id="compatibility-tab"
                            aria-selected="false"
                            aria-controls="compatibility-panel">
                            Compatibility
                        </button>
                        <button 
                            class="tab-button py-4 px-1 border-b-2 border-transparent text-neutral-500 hover:text-neutral-700 hover:border-neutral-300 transition-colors" 
                            onclick="showTab('documentation')" 
                            role="tab" 
                            id="documentation-tab"
                            aria-selected="false"
                            aria-controls="documentation-panel">
                            Documentation
                        </button>
                        <button 
                            class="tab-button py-4 px-1 border-b-2 border-transparent text-neutral-500 hover:text-neutral-700 hover:border-neutral-300 transition-colors" 
                            onclick="showTab('reviews')" 
                            role="tab" 
                            id="reviews-tab"
                            aria-selected="false"
                            aria-controls="reviews-panel">
                            Reviews (12)
                        </button>
                    </nav>
                </div>

                <div class="tab-content l-spacing-md">
                    <!-- Specifications Tab with Progressive Disclosure (Section 5.1) -->
                    <div id="specifications" class="tab-panel active" role="tabpanel" aria-labelledby="specifications-tab">
                        <div class="c-card">
                            <div class="c-card__header">
                                <h3 class="c-card__title">Technical Specifications</h3>
                            </div>
                            <div class="c-card__body">
                            
                            <%-- Essential Specs Accordion --%>
                            <jsp:include page="/components/molecules/accordion/accordion.jsp">
                                <jsp:param name="id" value="essential-specs" />
                                <jsp:param name="title" value="Essential Specifications" />
                                <jsp:param name="open" value="true" />
                            </jsp:include>
                            <div class="mb-6">
                                <h4 class="font-semibold text-neutral-900 mb-4">Essential Specifications</h4>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <h5 class="font-medium text-neutral-700 mb-3 flex items-center gap-2">
                                            Communication Protocol
                                            <button class="help-tooltip" 
                                                    aria-label="What is communication protocol?"
                                                    data-tooltip="The communication protocol determines how this device connects and communicates with other devices and systems. Common protocols include LoRaWAN, Zigbee, WiFi, and Bluetooth.">
                                                <svg class="w-4 h-4 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
                                                </svg>
                                            </button>
                                        </h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Protocol:</dt>
                                                <dd class="text-neutral-900 font-medium">WiFi 802.11 b/g/n/ac</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Bluetooth:</dt>
                                                <dd class="text-neutral-900">5.0 LE</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Range:</dt>
                                                <dd class="text-neutral-900">Up to 100m indoor</dd>
                                            </div>
                                        </dl>
                                    </div>
                                    <div>
                                        <h5 class="font-medium text-neutral-700 mb-3 flex items-center gap-2">
                                            Power Requirements
                                            <button class="help-tooltip" 
                                                    aria-label="What are power requirements?"
                                                    data-tooltip="Power requirements specify the voltage and current needed to operate this device. Ensure your power supply matches these specifications for safe operation.">
                                                <svg class="w-4 h-4 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
                                                </svg>
                                            </button>
                                        </h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Input:</dt>
                                                <dd class="text-neutral-900 font-medium">DC 5V/2A</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Consumption:</dt>
                                                <dd class="text-neutral-900">2.5W max</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Battery Life:</dt>
                                                <dd class="text-neutral-900">6+ months</dd>
                                            </div>
                                        </dl>
                                    </div>
                                    <div>
                                        <h5 class="font-medium text-neutral-700 mb-3">Operating Range</h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Temperature:</dt>
                                                <dd class="text-neutral-900">-40°C to 85°C</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Humidity:</dt>
                                                <dd class="text-neutral-900">0% to 95% RH</dd>
                                            </div>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            
                            </jsp:include>
                            
                            <%-- Detailed Specifications Accordion --%>
                            <jsp:include page="/components/molecules/accordion/accordion.jsp">
                                <jsp:param name="id" value="detailed-specs" />
                                <jsp:param name="title" value="Detailed Specifications" />
                                <jsp:param name="open" value="false" />
                            </jsp:include>
                            <details class="spec-details" style="display: none;">
                                <summary class="spec-summary cursor-pointer font-medium text-neutral-700 py-3 border-t border-neutral-200">
                                    <span>Detailed Specifications</span>
                                    <svg class="w-5 h-5 inline-block ml-2 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                    </svg>
                                </summary>
                                <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <h5 class="font-medium text-neutral-900 mb-3">Environmental Ratings</h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">IP Rating:</dt>
                                                <dd class="text-neutral-900">IP65</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Shock Resistance:</dt>
                                                <dd class="text-neutral-900">50G</dd>
                                            </div>
                                        </dl>
                                    </div>
                                    <div>
                                        <h5 class="font-medium text-neutral-900 mb-3">Certifications</h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">CE:</dt>
                                                <dd class="text-neutral-900">✓ Certified</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">FCC:</dt>
                                                <dd class="text-neutral-900">✓ Approved</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">RoHS:</dt>
                                                <dd class="text-neutral-900">✓ Compliant</dd>
                                            </div>
                                        </dl>
                                    </div>
                                    <div>
                                        <h5 class="font-medium text-neutral-900 mb-3">Mechanical Dimensions</h5>
                                        <dl class="space-y-2 text-sm">
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Size:</dt>
                                                <dd class="text-neutral-900">85 x 55 x 25 mm</dd>
                                            </div>
                                            <div class="flex justify-between">
                                                <dt class="text-neutral-600">Weight:</dt>
                                                <dd class="text-neutral-900">120g</dd>
                                            </div>
                                        </dl>
                                    </div>
                                </div>
                            </details>
                            
                            </jsp:include>
                            
                            <%-- Advanced Configuration Accordion --%>
                            <jsp:include page="/components/molecules/accordion/accordion.jsp">
                                <jsp:param name="id" value="advanced-config" />
                                <jsp:param name="title" value="Advanced Configuration" />
                                <jsp:param name="open" value="false" />
                            </jsp:include>
                            <details class="spec-details" style="display: none;">
                                <summary class="spec-summary cursor-pointer font-medium text-neutral-700 py-3 border-t border-neutral-200">
                                    <span>Advanced Configuration</span>
                                    <svg class="w-5 h-5 inline-block ml-2 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                    </svg>
                                </summary>
                                <div class="mt-4">
                                    <h5 class="font-medium text-neutral-900 mb-3">API & Integration</h5>
                                    <dl class="space-y-2 text-sm">
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">API Endpoints:</dt>
                                            <dd class="text-neutral-900">RESTful API v2.1</dd>
                                        </div>
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Firmware Version:</dt>
                                            <dd class="text-neutral-900">v3.2.1</dd>
                                        </div>
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Compatible Platforms:</dt>
                                            <dd class="text-neutral-900">Home Assistant, AWS IoT, Google Cloud IoT</dd>
                                        </div>
                                    </dl>
                                </div>
                            </details>
                            
                            <!-- Expand/Collapse Controls -->
                            <div class="mt-6 flex gap-3 pt-6 border-t border-neutral-200">
                                <button 
                                    type="button" 
                                    onclick="expandAllSpecs()" 
                                    class="btn btn--ghost btn--sm"
                                    aria-label="Expand all specifications">
                                    Expand All
                                </button>
                                <button 
                                    type="button" 
                                    onclick="collapseAllSpecs()" 
                                    class="btn btn--ghost btn--sm"
                                    aria-label="Collapse all specifications">
                                    Collapse All
                                </button>
                                <button 
                                    type="button" 
                                    onclick="printSpecs()" 
                                    class="btn btn--ghost btn--sm"
                                    aria-label="Print specifications">
                                    Print Specs
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Compatibility Tab (Section 4.3) -->
                    <div id="compatibility" class="tab-panel hidden" role="tabpanel" aria-labelledby="compatibility-tab">
                        <div class="bg-white rounded-lg shadow p-6">
                            <h3 class="text-xl font-semibold text-neutral-900 mb-6">Compatibility Matrix</h3>
                            
                            <!-- Compatible Gateways -->
                            <div class="mb-8">
                                <h4 class="font-semibold text-neutral-900 mb-4">Compatible Gateways</h4>
                                <div class="space-y-3">
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">Gateway X (LoRaWAN)</span>
                                            <p class="text-sm text-neutral-600">Fully compatible with all features</p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">Gateway Y (Multi-protocol)</span>
                                            <p class="text-sm text-neutral-600">Compatible with LoRaWAN mode</p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-error-50 rounded-lg border border-error-200">
                                        <svg class="w-5 h-5 text-error flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">Gateway Z (Zigbee only)</span>
                                            <p class="text-sm text-neutral-600">Not compatible - different protocol</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Compatible Platforms -->
                            <div class="mb-8">
                                <h4 class="font-semibold text-neutral-900 mb-4">Compatible Platforms</h4>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span class="font-medium text-neutral-900">Home Assistant</span>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span class="font-medium text-neutral-900">AWS IoT Core</span>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span class="font-medium text-neutral-900">Azure IoT Hub</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Power Supply Compatibility -->
                            <div class="mb-8">
                                <h4 class="font-semibold text-neutral-900 mb-4">Power Supply Compatibility</h4>
                                <div class="space-y-3">
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">12V DC Power Adapter (included)</span>
                                            <p class="text-sm text-neutral-600">Recommended power supply</p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-success-50 rounded-lg border border-success-200">
                                        <svg class="w-5 h-5 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">12V Battery Pack</span>
                                            <p class="text-sm text-neutral-600">Portable power option</p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 p-3 bg-warning-50 rounded-lg border border-warning-200">
                                        <svg class="w-5 h-5 text-warning flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                                        </svg>
                                        <div class="flex-1">
                                            <span class="font-medium text-neutral-900">24V DC</span>
                                            <p class="text-sm text-neutral-600">Requires voltage regulator (not included)</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <%-- Compatibility Checker Component --%>
                            <jsp:include page="/components/molecules/compatibility-checker/compatibility-checker.jsp">
                                <jsp:param name="productId" value="${pd_id}" />
                            </jsp:include>
                            
                            <!-- Legacy Compatibility Checker Tool (hidden) -->
                            <div class="mt-8 p-6 bg-neutral-50 rounded-lg border border-neutral-200">
                                <h4 class="font-semibold text-neutral-900 mb-4">Check Your Setup</h4>
                                <p class="text-sm text-neutral-600 mb-4">
                                    Verify compatibility with your existing IoT infrastructure
                                </p>
                                <button 
                                    type="button" 
                                    onclick="openCompatibilityChecker()" 
                                    class="btn btn--primary btn--sm"
                                    aria-label="Open compatibility checker tool">
                                    Check Your Setup
                                </button>
                            </div>
                            
                            <div class="mt-6">
                                <a href="#" class="text-brand-primary hover:underline text-sm font-medium">
                                    View Full Compatibility Matrix →
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Documentation Tab (Section 4.3) -->
                    <div id="documentation" class="tab-panel hidden" role="tabpanel" aria-labelledby="documentation-tab">
                        <div class="c-card">
                            <div class="c-card__header">
                                <h3 class="c-card__title">Product Documentation</h3>
                            </div>
                            <div class="c-card__body">
                            
                            <div class="space-y-6">
                                <!-- Quick Start Guide -->
                                <div class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <h4 class="font-semibold text-neutral-900 mb-2">Quick Start Guide</h4>
                                            <p class="text-sm text-neutral-600 mb-3">
                                                Get up and running in minutes with our step-by-step setup guide
                                            </p>
                                            <div class="flex flex-wrap gap-2">
                                                <a href="#" class="btn btn--outline btn--sm" aria-label="Download Quick Start Guide PDF">
                                                    <svg class="w-4 h-4 inline mr-1" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                        <path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                                    </svg>
                                                    Download PDF
                                                </a>
                                                <a href="#" class="btn btn--ghost btn--sm" aria-label="View Quick Start Guide online">
                                                    View Online
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Full Datasheet -->
                                <div class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <h4 class="font-semibold text-neutral-900 mb-2">Full Datasheet</h4>
                                            <p class="text-sm text-neutral-600 mb-3">
                                                Complete technical specifications and performance data
                                            </p>
                                            <div class="flex flex-wrap gap-2">
                                                <a href="#" class="btn btn--outline btn--sm" aria-label="Download Full Datasheet PDF">
                                                    <svg class="w-4 h-4 inline mr-1" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                        <path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                                    </svg>
                                                    Download PDF
                                                </a>
                                                <a href="#" class="btn btn--ghost btn--sm" aria-label="View Full Datasheet in embedded viewer">
                                                    Embedded Viewer
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Integration Guides -->
                                <div class="border border-neutral-200 rounded-lg p-4">
                                    <h4 class="font-semibold text-neutral-900 mb-4">Integration Guides</h4>
                                    <ul class="space-y-2">
                                        <li>
                                            <a href="#" class="text-brand-primary hover:underline flex items-center gap-2">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                    <path fill-rule="evenodd" d="M12.316 3.051a1 1 0 01.633 1.265l-4 12a1 1 0 11-1.898-.632l4-12a1 1 0 011.265-.633zM5.707 6.293a1 1 0 010 1.414L3.414 10l2.293 2.293a1 1 0 11-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0zm8.586 0a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 11-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                                </svg>
                                                Home Assistant Integration
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="text-brand-primary hover:underline flex items-center gap-2">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                    <path fill-rule="evenodd" d="M12.316 3.051a1 1 0 01.633 1.265l-4 12a1 1 0 11-1.898-.632l4-12a1 1 0 011.265-.633zM5.707 6.293a1 1 0 010 1.414L3.414 10l2.293 2.293a1 1 0 11-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0zm8.586 0a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 11-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                                </svg>
                                                AWS IoT Setup Guide
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="text-brand-primary hover:underline flex items-center gap-2">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                    <path fill-rule="evenodd" d="M12.316 3.051a1 1 0 01.633 1.265l-4 12a1 1 0 11-1.898-.632l4-12a1 1 0 011.265-.633zM5.707 6.293a1 1 0 010 1.414L3.414 10l2.293 2.293a1 1 0 11-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0zm8.586 0a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 11-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                                </svg>
                                                API Documentation
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                
                                <!-- Code Examples -->
                                <div class="border border-neutral-200 rounded-lg p-4">
                                    <h4 class="font-semibold text-neutral-900 mb-4">Code Examples</h4>
                                    <div class="flex flex-wrap gap-2 mb-4">
                                        <button type="button" onclick="showCodeExample('python')" class="btn btn--outline btn--sm">Python</button>
                                        <button type="button" onclick="showCodeExample('javascript')" class="btn btn--outline btn--sm">JavaScript</button>
                                        <button type="button" onclick="showCodeExample('arduino')" class="btn btn--outline btn--sm">Arduino</button>
                                    </div>
                                    <div id="code-example-container" class="bg-neutral-900 text-neutral-100 rounded p-4 font-mono text-sm">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="text-neutral-400">Select a language to view code example</span>
                                            <button 
                                                type="button" 
                                                onclick="copyCodeExample()" 
                                                class="btn btn--ghost btn--sm text-neutral-400 hover:text-white"
                                                aria-label="Copy code to clipboard">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                                </svg>
                                                Copy
                                            </button>
                                        </div>
                                        <pre id="code-example" class="text-neutral-300"></pre>
                                    </div>
                                </div>
                                
                                <!-- Firmware Updates -->
                                <div class="border border-neutral-200 rounded-lg p-4">
                                    <h4 class="font-semibold text-neutral-900 mb-2">Firmware Updates</h4>
                                    <p class="text-sm text-neutral-600 mb-4">
                                        Current Version: <span class="font-medium text-neutral-900">v2.1.3</span>
                                    </p>
                                    <div class="flex flex-wrap gap-2">
                                        <a href="#" class="btn btn--outline btn--sm">Download Latest</a>
                                        <a href="#" class="btn btn--ghost btn--sm">Update Instructions</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Reviews Tab - Enhanced (Section 4.3) -->
                    <div id="reviews" class="tab-panel hidden" role="tabpanel" aria-labelledby="reviews-tab">
                        <div class="c-card">
                            <div class="c-card__header">
                                <h3 class="c-card__title">Customer Reviews</h3>
                            </div>
                            <div class="c-card__body">
                            <div class="mb-6">
                                <div class="flex items-center gap-4 mb-4">
                                    <div>
                                        <div class="text-4xl font-bold text-neutral-900">4.5</div>
                                        <div class="text-sm text-neutral-600">out of 5.0</div>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center gap-2 mb-2">
                                            <div class="flex text-yellow-400">
                                                ★★★★★
                                            </div>
                                            <span class="text-sm text-neutral-600">(128 reviews)</span>
                                        </div>
                                        <div class="space-y-1 text-sm">
                                            <div class="flex items-center gap-2">
                                                <span class="w-20 text-right">5 stars</span>
                                                <div class="flex-1 bg-neutral-200 rounded-full h-2">
                                                    <div class="bg-yellow-400 h-2 rounded-full" style="width: 85%"></div>
                                                </div>
                                                <span class="w-12 text-neutral-600">85%</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <span class="w-20 text-right">4 stars</span>
                                                <div class="flex-1 bg-neutral-200 rounded-full h-2">
                                                    <div class="bg-yellow-400 h-2 rounded-full" style="width: 10%"></div>
                                                </div>
                                                <span class="w-12 text-neutral-600">10%</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <span class="w-20 text-right">3 stars</span>
                                                <div class="flex-1 bg-neutral-200 rounded-full h-2">
                                                    <div class="bg-yellow-400 h-2 rounded-full" style="width: 3%"></div>
                                                </div>
                                                <span class="w-12 text-neutral-600">3%</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <span class="w-20 text-right">2 stars</span>
                                                <div class="flex-1 bg-neutral-200 rounded-full h-2">
                                                    <div class="bg-yellow-400 h-2 rounded-full" style="width: 1%"></div>
                                                </div>
                                                <span class="w-12 text-neutral-600">1%</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <span class="w-20 text-right">1 star</span>
                                                <div class="flex-1 bg-neutral-200 rounded-full h-2">
                                                    <div class="bg-yellow-400 h-2 rounded-full" style="width: 1%"></div>
                                                </div>
                                                <span class="w-12 text-neutral-600">1%</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <button 
                                    type="button" 
                                    onclick="openReviewModal()" 
                                    class="btn btn--primary"
                                    aria-label="Write a review">
                                    Write a Review
                                </button>
                            </div>
                            
                            <div class="space-y-6">
                                <!-- Sample Review -->
                                <div class="border-b border-neutral-200 pb-6">
                                    <div class="flex items-start justify-between mb-3">
                                        <div class="flex items-center gap-3">
                                            <div class="flex text-yellow-400 text-sm">
                                                ★★★★★
                                            </div>
                                            <div>
                                                <span class="font-medium text-neutral-900">John D.</span>
                                                <span class="text-sm text-neutral-500 ml-2">Verified Purchase</span>
                                            </div>
                                        </div>
                                        <span class="text-sm text-neutral-500">2 weeks ago</span>
                                    </div>
                                    <p class="text-neutral-700 mb-3">
                                        "Excellent sensor, easy integration with Home Assistant. The documentation was clear and the device has been running reliably for 3 months now."
                                    </p>
                                    <div class="flex items-center gap-4 text-sm">
                                        <button 
                                            type="button" 
                                            onclick="markReviewHelpful(1)" 
                                            class="text-neutral-600 hover:text-brand-primary flex items-center gap-1"
                                            aria-label="Mark review as helpful">
                                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path d="M2 10.5a1.5 1.5 0 113 0v6a1.5 1.5 0 01-3 0v-6zM6 10.333v5.834a1 1 0 001.1 1h2.312a1 1 0 00.944-.724l1.562-4.874a1 1 0 00-.944-1.276H8.333a1 1 0 00-1 .667v-.834a1 1 0 00-1 1v1.834a1 1 0 001 1h1V11.5a1.5 1.5 0 011.5-1.5h5.379a2.25 2.25 0 011.852.97l.803 1.278A2.25 2.25 0 0118 13.818v1.682a1 1 0 01-1 1h-1.5a1.5 1.5 0 01-1.5-1.5v-6a1.5 1.5 0 011.5-1.5H17a1 1 0 001-1V9.667a1 1 0 00-1-1h-5.379a2.25 2.25 0 01-1.852-.97l-.803-1.278A2.25 2.25 0 009.379 6H6.5a1 1 0 00-1 1v3.333z"></path>
                                            </svg>
                                            Helpful (12)
                                        </button>
                                        <button 
                                            type="button" 
                                            onclick="replyToReview(1)" 
                                            class="text-neutral-600 hover:text-brand-primary"
                                            aria-label="Reply to review">
                                            Reply
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="text-center">
                                    <button 
                                        type="button" 
                                        onclick="loadMoreReviews()" 
                                        class="btn btn--outline"
                                        aria-label="Load more reviews">
                                        Load More Reviews
                                    </button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Related Products -->
            <section class="section-container l-spacing-lg">
                <div class="section-container__header">
                    <h2 class="section-container__title">You Might Also Like</h2>
                </div>
                <div class="l-grid l-grid--gap-medium">
                    <!-- Related product cards would go here -->
                    <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                        <div class="c-product-card">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="Smart Sensor Pro" class="c-product-card__image">
                            <div class="c-product-card__body">
                                <h3 class="c-product-card__title">Smart Sensor Pro</h3>
                                <p class="text-neutral-600 text-sm mb-2">Advanced environmental monitoring</p>
                                <div class="c-product-card__price">$149.99</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="l-grid__col-12 l-grid__col-md-6 l-grid__col-lg-3">
                        <div class="c-product-card">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="IoT Hub Gateway" class="c-product-card__image">
                            <div class="c-product-card__body">
                                <h3 class="c-product-card__title">IoT Hub Gateway</h3>
                                <p class="text-neutral-600 text-sm mb-2">Central control for all devices</p>
                                <div class="c-product-card__price">$299.99</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <script src="js/main.js"></script>
    <script>
        // Add to cart handler
        function handleAddToCart(button) {
            const productId = parseInt(button.getAttribute('data-product-id'));
            const quantity = parseInt(document.getElementById('quantity').value) || 1;
            if (typeof OptimisticUI !== 'undefined' && typeof OptimisticUI.addToCart === 'function') {
                OptimisticUI.addToCart(productId, quantity);
            } else {
                const form = button.closest('form');
                if (form) {
                    form.submit();
                }
            }
        }
        
        // Initialize add to cart buttons
        document.addEventListener('DOMContentLoaded', function() {
            const addToCartButtons = document.querySelectorAll('.add-to-cart-button');
            addToCartButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    handleAddToCart(this);
                });
            });
        });
        
        // Quantity control functions
        function increaseQuantity() {
            const quantityInput = document.getElementById('quantity');
            const hiddenQuantity = document.getElementById('hiddenQuantity');
            const currentValue = parseInt(quantityInput.value);
            const maxValue = parseInt(quantityInput.max);
            
            if (currentValue < maxValue) {
                const newValue = currentValue + 1;
                quantityInput.value = newValue;
                hiddenQuantity.value = newValue;
            }
        }
        
        function decreaseQuantity() {
            const quantityInput = document.getElementById('quantity');
            const hiddenQuantity = document.getElementById('hiddenQuantity');
            const currentValue = parseInt(quantityInput.value);
            const minValue = parseInt(quantityInput.min);
            
            if (currentValue > minValue) {
                const newValue = currentValue - 1;
                quantityInput.value = newValue;
                hiddenQuantity.value = newValue;
            }
        }
        
        // Update hidden quantity when input changes
        document.getElementById('quantity').addEventListener('change', function() {
            document.getElementById('hiddenQuantity').value = this.value;
        });
        
        // Add to cart form submission
        document.querySelector('.add-to-cart-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            const button = this.querySelector('.add-to-cart-btn');
            const originalText = button.innerHTML;
            
            button.innerHTML = '<span class="loading-spinner"></span> Adding...';
            button.disabled = true;
            
            fetch(this.action, {
                method: 'POST',
                body: new FormData(this)
            })
            .then(response => {
                if (response.ok) {
                    button.innerHTML = '✓ Added to Cart!';
                    button.classList.remove('btn--primary');
                    button.classList.add('btn--success');
                    
                    // Show success toast
                    if (window.showToast) {
                        window.showToast('Product added to cart successfully!', 'success');
                    }
                    
                    setTimeout(() => {
                        button.innerHTML = originalText;
                        button.classList.remove('btn--success');
                        button.classList.add('btn--primary');
                        button.disabled = false;
                    }, 3000);
                } else {
                    throw new Error('Failed to add to cart');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                button.innerHTML = 'Error - Try Again';
                button.classList.add('btn--error');
                
                if (window.showToast) {
                    window.showToast('Failed to add product to cart. Please try again.', 'error');
                }
                
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.classList.remove('btn--error');
                    button.disabled = false;
                }, 3000);
            });
        });
        
        // Wishlist form submission
        document.querySelector('.wishlist-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            const button = this.querySelector('.wishlist-btn');
            const originalText = button.innerHTML;
            
            button.innerHTML = '<span class="loading-spinner"></span> Adding...';
            button.disabled = true;
            
            fetch(this.action, {
                method: 'POST',
                body: new FormData(this)
            })
            .then(response => {
                if (response.ok) {
                    button.innerHTML = '✓ Added to Wishlist!';
                    button.classList.remove('btn--outline');
                    button.classList.add('btn--success');
                    
                    if (window.showToast) {
                        window.showToast('Product added to wishlist!', 'success');
                    }
                } else {
                    throw new Error('Failed to add to wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                button.innerHTML = 'Error - Try Again';
                button.classList.add('btn--error');
                
                if (window.showToast) {
                    window.showToast('Failed to add to wishlist. Please try again.', 'error');
                }
                
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.classList.remove('btn--error');
                    button.disabled = false;
                }, 3000);
            });
        });
    </script>
</t:base>
