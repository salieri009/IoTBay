<%@ page import="model.Product, model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%
    Product product = (Product) request.getAttribute("product");
    User currentUser = (User) session.getAttribute("user");
    
    // 기본�??�정
    String productName = "Sample IoT Device";
    String productDescription = "A high-quality IoT device for smart automation and monitoring. Features advanced connectivity, robust build quality, and seamless integration with popular IoT platforms.";
    double productPrice = 199.99;
    int productStock = 10;
    int productId = 0;
    String productImage = "images/sample1.png";
    
    // product 객체가 ?�으�??�제 값을 ?�용
    if (product != null) {
        try {
            productName = product.getName() != null ? product.getName() : productName;
            productDescription = product.getDescription() != null ? product.getDescription() : productDescription;
            productPrice = product.getPrice();
            productStock = product.getStockQuantity();
            productId = product.getId();
            productImage = product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? product.getImageUrl() : productImage;
        } catch (Exception e) {
            // 메소???�출 ?�패 ??기본�??�용
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
                            <div class="bg-white rounded-xl border border-neutral-200 p-6 shadow-sm">
                                <dt class="text-xs font-semibold uppercase tracking-wide text-neutral-500 mb-2">Support</dt>
                                <dd class="text-sm font-semibold text-neutral-900">24/7 specialist assistance</dd>
                                <dd class="mt-1 text-xs text-neutral-500">Includes onboarding & integration guidance.</dd>
                            </div>
                        </dl>
                    </section>

                    <!-- Technical Specifications (Collapsible) -->
                    <section class="border-t border-neutral-200 pt-8">
                        <h2 class="text-2xl font-bold text-neutral-900 mb-6">Technical Specifications</h2>
                        <div class="space-y-4">
                            <!-- Connectivity -->
                            <details class="group bg-white rounded-lg border border-neutral-200 open:ring-2 open:ring-brand-primary/50 transition-all duration-200">
                                <summary class="flex items-center justify-between p-4 cursor-pointer list-none">
                                    <span class="font-semibold text-neutral-900">Connectivity & Protocol</span>
                                    <span class="transition-transform group-open:rotate-180">
                                        <svg class="w-5 h-5 text-neutral-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </span>
                                </summary>
                                <div class="px-4 pb-4 text-neutral-600 space-y-2">
                                    <div class="grid grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <dt class="font-medium text-neutral-900">Wireless Protocol</dt>
                                            <dd>Wi-Fi 802.11 b/g/n, Bluetooth 5.0</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Frequency</dt>
                                            <dd>2.4 GHz / 5 GHz</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Range</dt>
                                            <dd>Up to 100m (outdoor), 30m (indoor)</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Encryption</dt>
                                            <dd>WPA2/WPA3 Personal</dd>
                                        </div>
                                    </div>
                                </div>
                            </details>

                            <!-- Power -->
                            <details class="group bg-white rounded-lg border border-neutral-200 open:ring-2 open:ring-brand-primary/50 transition-all duration-200">
                                <summary class="flex items-center justify-between p-4 cursor-pointer list-none">
                                    <span class="font-semibold text-neutral-900">Power Requirements</span>
                                    <span class="transition-transform group-open:rotate-180">
                                        <svg class="w-5 h-5 text-neutral-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </span>
                                </summary>
                                <div class="px-4 pb-4 text-neutral-600 space-y-2">
                                    <div class="grid grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <dt class="font-medium text-neutral-900">Input Voltage</dt>
                                            <dd>5V DC (USB-C) or 12V DC (Terminal)</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Power Consumption</dt>
                                            <dd>Max 2.5W (Active), 0.1W (Sleep)</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Battery Support</dt>
                                            <dd>Li-Po 3.7V Connector</dd>
                                        </div>
                                    </div>
                                </div>
                            </details>

                            <!-- Physical -->
                            <details class="group bg-white rounded-lg border border-neutral-200 open:ring-2 open:ring-brand-primary/50 transition-all duration-200">
                                <summary class="flex items-center justify-between p-4 cursor-pointer list-none">
                                    <span class="font-semibold text-neutral-900">Physical Dimensions</span>
                                    <span class="transition-transform group-open:rotate-180">
                                        <svg class="w-5 h-5 text-neutral-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </span>
                                </summary>
                                <div class="px-4 pb-4 text-neutral-600 space-y-2">
                                    <div class="grid grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <dt class="font-medium text-neutral-900">Dimensions</dt>
                                            <dd>68mm x 42mm x 15mm</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Weight</dt>
                                            <dd>45g</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-neutral-900">Operating Temp</dt>
                                            <dd>-20°C to +70°C</dd>
                                        </div>
                                    </div>
                                </div>
                            </details>
                        </div>
                    </section>

                    <!-- Use Cases -->
                    <section class="border-t border-neutral-200 pt-8">
                        <h2 class="text-2xl font-bold text-neutral-900 mb-6">Common Applications</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="flex gap-4 p-4 rounded-lg bg-white border border-neutral-200">
                                <div class="flex-shrink-0 w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-600">
                                    <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                                    </svg>
                                </div>
                                <div>
                                    <h3 class="font-semibold text-neutral-900">Smart Home Automation</h3>
                                    <p class="text-sm text-neutral-600 mt-1">Control lights, temperature, and security systems remotely.</p>
                                </div>
                            </div>
                            <div class="flex gap-4 p-4 rounded-lg bg-white border border-neutral-200">
                                <div class="flex-shrink-0 w-10 h-10 rounded-full bg-green-50 flex items-center justify-center text-green-600">
                                    <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <div>
                                    <h3 class="font-semibold text-neutral-900">Industrial Monitoring</h3>
                                    <p class="text-sm text-neutral-600 mt-1">Track equipment health and environmental conditions.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                </article>

                <!-- Right Panel: Product Info & Buy Box (5 columns, sticky) -->
                <aside class="lg:col-span-5">
                    <div class="sticky top-6 space-y-6">
                        <!-- Add to Cart Card -->
                        <div class="bg-white rounded-xl border border-neutral-200 p-6 shadow-sm space-y-6">
                            <h2 class="text-lg font-semibold text-neutral-900">Purchase</h2>
                            
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="space-y-4">
                                <input type="hidden" name="productId" value="${pd_id}">
                                
                                <div>
                                    <label for="quantity" class="block text-sm font-medium text-neutral-700 mb-1">Quantity</label>
                                    <div class="flex items-center rounded-lg border border-neutral-300 overflow-hidden">
                                        <button type="button" onclick="decrementQuantity()" class="px-4 py-2 text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors border-r border-neutral-300">
                                            <span class="sr-only">Decrease quantity</span>
                                            -
                                        </button>
                                        <input type="number" name="quantity" id="quantity" value="1" min="1" max="99" 
                                            class="w-full border-0 p-2 text-center text-neutral-900 focus:ring-0 sm:text-sm">
                                        <button type="button" onclick="incrementQuantity()" class="px-4 py-2 text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors border-l border-neutral-300">
                                            <span class="sr-only">Increase quantity</span>
                                            +
                                        </button>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 gap-3">
                                    <button type="submit" class="w-full flex justify-center items-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg shadow-sm text-white bg-brand-primary hover:bg-brand-primary-dark focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary disabled:opacity-50 disabled:cursor-not-allowed transition-colors" ${!pd_inStock ? 'disabled' : ''}>
                                        Add to Cart
                                    </button>
                                    <button type="button" class="w-full flex justify-center items-center px-4 py-3 border border-neutral-300 text-sm font-medium rounded-lg shadow-sm text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary transition-colors">
                                        Add to Wishlist
                                    </button>
                                </div>
                            </form>

                            <div class="border-t border-neutral-200 pt-4">
                                <ul class="space-y-3 text-sm text-neutral-600">
                                    <li class="flex items-center gap-3">
                                        <div class="flex-shrink-0 w-8 h-8 rounded-full bg-neutral-100 flex items-center justify-center">
                                            <svg class="h-4 w-4 text-neutral-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                            </svg>
                                        </div>
                                        <span>Secure payment processing</span>
                                    </li>
                                    <li class="flex items-center gap-3">
                                        <div class="flex-shrink-0 w-8 h-8 rounded-full bg-neutral-100 flex items-center justify-center">
                                            <svg class="h-4 w-4 text-neutral-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                            </svg>
                                        </div>
                                        <span>Fast & reliable shipping</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Specifications -->
                        <div class="bg-white rounded-xl border border-neutral-200 p-6 shadow-sm space-y-4">
                            <h3 class="text-sm font-semibold text-neutral-900 uppercase tracking-wide">Specifications</h3>
                            <dl class="divide-y divide-neutral-200 text-sm">
                                <div class="flex justify-between py-3">
                                    <dt class="text-neutral-500">Type</dt>
                                    <dd class="font-medium text-neutral-900">${pd_type}</dd>
                                </div>
                                <div class="flex justify-between py-3">
                                    <dt class="text-neutral-500">Warranty</dt>
                                    <dd class="font-medium text-neutral-900">1 Year</dd>
                                </div>
                                <div class="flex justify-between py-3">
                                    <dt class="text-neutral-500">Manufacturer</dt>
                                    <dd class="font-medium text-neutral-900">IoT Bay Inc.</dd>
                                </div>
                            </dl>
                        </div>
                    </div>
                </aside>
            </div>

            <!-- Trust Badges Section -->
            <section class="py-8">
                <div class="flex flex-wrap gap-4">
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-neutral-200 rounded-full text-sm font-medium text-neutral-700 shadow-sm" title="CE Certified - European Conformity">
                        <svg class="w-5 h-5 text-brand-primary" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>CE Certified</span>
                    </div>
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-neutral-200 rounded-full text-sm font-medium text-neutral-700 shadow-sm" title="FCC Approved - Federal Communications Commission">
                        <svg class="w-5 h-5 text-brand-primary" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>FCC Approved</span>
                    </div>
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-neutral-200 rounded-full text-sm font-medium text-neutral-700 shadow-sm" title="Works with Home Assistant">
                        <svg class="w-5 h-5 text-brand-primary" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"/>
                        </svg>
                        <span>Home Assistant</span>
                    </div>
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-neutral-200 rounded-full text-sm font-medium text-neutral-700 shadow-sm" title="2-Year Warranty Included">
                        <svg class="w-5 h-5 text-brand-primary" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span>2-Year Warranty</span>
                    </div>
                </div>
            </section>

            <!-- Product Tabs -->
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
                    </nav>
                </div>

                <div class="py-8">
                    <!-- Specifications Tab -->
                    <div id="specifications" class="tab-panel space-y-8" role="tabpanel" aria-labelledby="specifications-tab">
                        <div class="bg-white rounded-xl border border-neutral-200 shadow-sm overflow-hidden">
                            <details class="group border-b border-neutral-200 last:border-0" open>
                                <summary class="flex items-center justify-between p-6 cursor-pointer bg-neutral-50 hover:bg-neutral-100 transition-colors">
                                    <h3 class="text-lg font-semibold text-neutral-900">Essential Specifications</h3>
                                    <span class="ml-6 flex-shrink-0">
                                        <svg class="w-5 h-5 text-neutral-500 transform group-open:rotate-180 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </span>
                                </summary>
                                <div class="p-6 bg-white">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                        <div>
                                            <h4 class="font-medium text-neutral-900 mb-4">Communication</h4>
                                            <dl class="space-y-3 text-sm">
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Protocol</dt>
                                                    <dd class="font-medium text-neutral-900">WiFi 802.11 b/g/n/ac</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Bluetooth</dt>
                                                    <dd class="font-medium text-neutral-900">5.0 LE</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Range</dt>
                                                    <dd class="font-medium text-neutral-900">Up to 100m indoor</dd>
                                                </div>
                                            </dl>
                                        </div>
                                        <div>
                                            <h4 class="font-medium text-neutral-900 mb-4">Power</h4>
                                            <dl class="space-y-3 text-sm">
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Input</dt>
                                                    <dd class="font-medium text-neutral-900">DC 5V/2A</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Consumption</dt>
                                                    <dd class="font-medium text-neutral-900">2.5W max</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Battery Life</dt>
                                                    <dd class="font-medium text-neutral-900">6+ months</dd>
                                                </div>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </details>
                            
                            <details class="group border-b border-neutral-200 last:border-0">
                                <summary class="flex items-center justify-between p-6 cursor-pointer bg-neutral-50 hover:bg-neutral-100 transition-colors">
                                    <h3 class="text-lg font-semibold text-neutral-900">Detailed Specifications</h3>
                                    <span class="ml-6 flex-shrink-0">
                                        <svg class="w-5 h-5 text-neutral-500 transform group-open:rotate-180 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </span>
                                </summary>
                                <div class="p-6 bg-white">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                        <div>
                                            <h4 class="font-medium text-neutral-900 mb-4">Environmental</h4>
                                            <dl class="space-y-3 text-sm">
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">IP Rating</dt>
                                                    <dd class="font-medium text-neutral-900">IP65</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Operating Temp</dt>
                                                    <dd class="font-medium text-neutral-900">-40°C to 85°C</dd>
                                                </div>
                                            </dl>
                                        </div>
                                        <div>
                                            <h4 class="font-medium text-neutral-900 mb-4">Physical</h4>
                                            <dl class="space-y-3 text-sm">
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Dimensions</dt>
                                                    <dd class="font-medium text-neutral-900">85 x 55 x 25 mm</dd>
                                                </div>
                                                <div class="flex justify-between border-b border-neutral-100 pb-2">
                                                    <dt class="text-neutral-500">Weight</dt>
                                                    <dd class="font-medium text-neutral-900">120g</dd>
                                                </div>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </details>
                        </div>
                    </div>

                    <!-- Compatibility Tab -->
                    <div id="compatibility" class="tab-panel hidden space-y-8" role="tabpanel" aria-labelledby="compatibility-tab">
                        <div class="bg-white rounded-xl border border-neutral-200 shadow-sm p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-6">Compatibility Matrix</h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <div class="p-4 bg-green-50 rounded-lg border border-green-100">
                                    <div class="flex items-center gap-3 mb-2">
                                        <svg class="w-5 h-5 text-green-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                        <span class="font-medium text-neutral-900">Home Assistant</span>
                                    </div>
                                    <p class="text-sm text-neutral-600">Fully supported via MQTT or native integration.</p>
                                </div>
                                <div class="p-4 bg-green-50 rounded-lg border border-green-100">
                                    <div class="flex items-center gap-3 mb-2">
                                        <svg class="w-5 h-5 text-green-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                        <span class="font-medium text-neutral-900">AWS IoT Core</span>
                                    </div>
                                    <p class="text-sm text-neutral-600">Certified device, ready for provisioning.</p>
                                </div>
                                <div class="p-4 bg-yellow-50 rounded-lg border border-yellow-100">
                                    <div class="flex items-center gap-3 mb-2">
                                        <svg class="w-5 h-5 text-yellow-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>
                                        <span class="font-medium text-neutral-900">Zigbee</span>
                                    </div>
                                    <p class="text-sm text-neutral-600">Requires separate bridge (not included).</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Documentation Tab -->
                    <div id="documentation" class="tab-panel hidden space-y-8" role="tabpanel" aria-labelledby="documentation-tab">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <a href="#" class="block p-6 bg-white rounded-xl border border-neutral-200 shadow-sm hover:border-brand-primary hover:shadow-md transition-all group">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="p-3 bg-brand-primary/10 rounded-lg text-brand-primary group-hover:bg-brand-primary group-hover:text-white transition-colors">
                                        <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <span class="text-xs font-semibold uppercase tracking-wide text-neutral-500">PDF</span>
                                </div>
                                <h3 class="text-lg font-semibold text-neutral-900 mb-2">Quick Start Guide</h3>
                                <p class="text-sm text-neutral-600">Step-by-step instructions to get your device up and running in minutes.</p>
                            </a>
                            <a href="#" class="block p-6 bg-white rounded-xl border border-neutral-200 shadow-sm hover:border-brand-primary hover:shadow-md transition-all group">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="p-3 bg-brand-primary/10 rounded-lg text-brand-primary group-hover:bg-brand-primary group-hover:text-white transition-colors">
                                        <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                                        </svg>
                                    </div>
                                    <span class="text-xs font-semibold uppercase tracking-wide text-neutral-500">API</span>
                                </div>
                                <h3 class="text-lg font-semibold text-neutral-900 mb-2">Developer API Docs</h3>
                                <p class="text-sm text-neutral-600">Complete API reference for integrating with custom applications.</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        function showTab(tabId) {
            // Hide all panels
            document.querySelectorAll('.tab-panel').forEach(panel => {
                panel.classList.add('hidden');
            });
            
            // Deactivate all tabs
            document.querySelectorAll('.tab-button').forEach(tab => {
                tab.classList.remove('active', 'border-brand-primary', 'text-brand-primary');
                tab.classList.add('border-transparent', 'text-neutral-500');
                tab.setAttribute('aria-selected', 'false');
            });
            
            // Show selected panel
            document.getElementById(tabId).classList.remove('hidden');
            
            // Activate selected tab
            const activeTab = document.getElementById(tabId + '-tab');
            activeTab.classList.remove('border-transparent', 'text-neutral-500');
            activeTab.classList.add('active', 'border-brand-primary', 'text-brand-primary');
            activeTab.setAttribute('aria-selected', 'true');
        }

        function incrementQuantity() {
            const input = document.getElementById('quantity');
            const max = parseInt(input.getAttribute('max') || 99);
            const val = parseInt(input.value || 1);
            if (val < max) input.value = val + 1;
        }

        function decrementQuantity() {
            const input = document.getElementById('quantity');
            const val = parseInt(input.value || 1);
            if (val > 1) input.value = val - 1;
        }
    </script>
</t:base>
