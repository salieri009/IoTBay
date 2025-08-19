<%@ page import="model.Product, model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            productStock = product.getStock();
            productId = product.getProductID();
            productImage = product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? product.getImageUrl() : productImage;
        } catch (Exception e) {
            // 메소드 호출 실패 시 기본값 사용
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= productName %> - IoT Bay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="bg-neutral-50 min-h-screen flex flex-col">
    <jsp:include page="components/header.jsp" />

    <main class="flex-1 py-8">
        <div class="container">
            <!-- Breadcrumb Navigation -->
            <nav class="mb-8">
                <ol class="flex items-center gap-2 text-sm text-neutral-600">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary">Home</a></li>
                    <li>/</li>
                    <li><a href="${pageContext.request.contextPath}/browse" class="hover:text-brand-primary">Products</a></li>
                    <li>/</li>
                    <li class="text-neutral-900 font-medium"><%= productName %></li>
                </ol>
            </nav>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                <!-- Product Images Section -->
                <div class="product-gallery">
                    <div class="aspect-square bg-white rounded-lg shadow-lg overflow-hidden mb-4">
                        <img src="${pageContext.request.contextPath}/<%= productImage %>" 
                             alt="<%= productName %>" 
                             class="w-full h-full object-cover"
                             id="mainProductImage"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/sample1.png';"/>
                    </div>
                    
                    <!-- Thumbnail Gallery -->
                    <div class="grid grid-cols-4 gap-2">
                        <div class="aspect-square bg-white rounded border-2 border-brand-primary overflow-hidden cursor-pointer">
                            <img src="${pageContext.request.contextPath}/<%= productImage %>" 
                                 alt="<%= productName %>" 
                                 class="w-full h-full object-cover">
                        </div>
                        <div class="aspect-square bg-neutral-100 rounded border overflow-hidden cursor-pointer">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" 
                                 alt="<%= productName %> view 2" 
                                 class="w-full h-full object-cover">
                        </div>
                        <div class="aspect-square bg-neutral-100 rounded border overflow-hidden cursor-pointer">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" 
                                 alt="<%= productName %> view 3" 
                                 class="w-full h-full object-cover">
                        </div>
                        <div class="aspect-square bg-neutral-100 rounded border overflow-hidden cursor-pointer flex items-center justify-center">
                            <span class="text-neutral-500 text-xs">+2 more</span>
                        </div>
                    </div>
                </div>

                <!-- Product Information Section -->
                <div class="product-info">
                    <div class="mb-4">
                        <span class="inline-block px-3 py-1 bg-brand-primary text-white text-sm rounded-full mb-4">
                            IoT Device
                        </span>
                        <h1 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-4"><%= productName %></h1>
                        <div class="flex items-center gap-4 mb-6">
                            <div class="text-3xl font-bold text-brand-primary">
                                $<%= String.format("%.2f", productPrice) %>
                            </div>
                            <div class="text-sm text-neutral-600">
                                <% if (productStock > 0) { %>
                                    <span class="text-green-600 font-medium">✓ In Stock (<%= productStock %> available)</span>
                                <% } else { %>
                                    <span class="text-red-600 font-medium">✗ Out of Stock</span>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <!-- Product Description -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-3">Description</h3>
                        <p class="text-neutral-600 leading-relaxed">
                            <%= productDescription %>
                        </p>
                    </div>

                    <!-- Key Features -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Key Features</h3>
                        <ul class="space-y-2">
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Wireless connectivity (Wi-Fi & Bluetooth)</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Real-time monitoring and alerts</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Easy setup and configuration</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Energy efficient design</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-neutral-700">Mobile app integration</span>
                            </li>
                        </ul>
                    </div>

                    <!-- Purchase Section -->
                    <div class="bg-white rounded-lg shadow-lg p-6">
                        <div class="mb-6">
                            <label class="block text-sm font-medium text-neutral-700 mb-2">Quantity</label>
                            <div class="flex items-center gap-3">
                                <button type="button" onclick="decreaseQuantity()" class="w-10 h-10 bg-neutral-100 rounded border flex items-center justify-center hover:bg-neutral-200">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                    </svg>
                                </button>
                                <input type="number" id="quantity" value="1" min="1" max="<%= productStock %>" 
                                       class="w-20 h-10 text-center border rounded focus:outline-none focus:ring-2 focus:ring-brand-primary">
                                <button type="button" onclick="increaseQuantity()" class="w-10 h-10 bg-neutral-100 rounded border flex items-center justify-center hover:bg-neutral-200">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div class="space-y-3">
                            <% if (productStock > 0) { %>
                                <button onclick="addToCart(<%= productId %>)" 
                                        class="w-full btn btn--primary btn--lg">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-2.5 5M7 13l2.5 5m0 0H17"></path>
                                    </svg>
                                    Add to Cart
                                </button>
                                <button class="w-full btn btn--outline btn--lg">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                                    </svg>
                                    Add to Wishlist
                                </button>
                            <% } else { %>
                                <button disabled class="w-full btn btn--disabled btn--lg">
                                    Out of Stock
                                </button>
                            <% } %>
                        </div>

                        <!-- Shipping Info -->
                        <div class="mt-6 pt-6 border-t border-neutral-200">
                            <div class="space-y-3 text-sm text-neutral-600">
                                <div class="flex items-center gap-3">
                                    <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"></path>
                                    </svg>
                                    <span>Free shipping on orders over $100</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <span>2-year warranty included</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                                    </svg>
                                    <span>30-day return policy</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Tabs -->
            <div class="mt-16">
                <div class="border-b border-neutral-200">
                    <nav class="flex space-x-8">
                        <button class="tab-button active py-4 px-1 border-b-2 border-brand-primary text-brand-primary font-medium" onclick="showTab('specifications')">
                            Specifications
                        </button>
                        <button class="tab-button py-4 px-1 border-b-2 border-transparent text-neutral-500 hover:text-neutral-700" onclick="showTab('reviews')">
                            Reviews (12)
                        </button>
                        <button class="tab-button py-4 px-1 border-b-2 border-transparent text-neutral-500 hover:text-neutral-700" onclick="showTab('support')">
                            Support
                        </button>
                    </nav>
                </div>

                <div class="tab-content mt-8">
                    <!-- Specifications Tab -->
                    <div id="specifications" class="tab-panel active">
                        <div class="bg-white rounded-lg shadow p-6">
                            <h3 class="text-xl font-semibold text-neutral-900 mb-6">Technical Specifications</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <h4 class="font-medium text-neutral-900 mb-3">Connectivity</h4>
                                    <dl class="space-y-2 text-sm">
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Wi-Fi:</dt>
                                            <dd class="text-neutral-900">802.11 b/g/n/ac</dd>
                                        </div>
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Bluetooth:</dt>
                                            <dd class="text-neutral-900">5.0 LE</dd>
                                        </div>
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Range:</dt>
                                            <dd class="text-neutral-900">Up to 100m</dd>
                                        </div>
                                    </dl>
                                </div>
                                <div>
                                    <h4 class="font-medium text-neutral-900 mb-3">Power</h4>
                                    <dl class="space-y-2 text-sm">
                                        <div class="flex justify-between">
                                            <dt class="text-neutral-600">Input:</dt>
                                            <dd class="text-neutral-900">DC 5V/2A</dd>
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
                            </div>
                        </div>
                    </div>

                    <!-- Reviews Tab -->
                    <div id="reviews" class="tab-panel hidden">
                        <div class="bg-white rounded-lg shadow p-6">
                            <h3 class="text-xl font-semibold text-neutral-900 mb-6">Customer Reviews</h3>
                            <div class="space-y-6">
                                <!-- Sample Review -->
                                <div class="border-b border-neutral-200 pb-6">
                                    <div class="flex items-center gap-2 mb-2">
                                        <div class="flex text-yellow-400">
                                            ★★★★★
                                        </div>
                                        <span class="font-medium">John D.</span>
                                        <span class="text-neutral-500 text-sm">Verified Purchase</span>
                                    </div>
                                    <p class="text-neutral-700 mb-2">
                                        "Excellent product! Easy to set up and works perfectly with my smart home system. The app interface is intuitive and the device is very reliable."
                                    </p>
                                    <span class="text-neutral-500 text-sm">2 weeks ago</span>
                                </div>
                                
                                <div class="text-center">
                                    <button class="btn btn--outline">Load More Reviews</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Support Tab -->
                    <div id="support" class="tab-panel hidden">
                        <div class="bg-white rounded-lg shadow p-6">
                            <h3 class="text-xl font-semibold text-neutral-900 mb-6">Product Support</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <h4 class="font-medium text-neutral-900 mb-3">Documentation</h4>
                                    <ul class="space-y-2">
                                        <li><a href="#" class="text-brand-primary hover:underline">Quick Start Guide</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">User Manual (PDF)</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">API Documentation</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">Troubleshooting</a></li>
                                    </ul>
                                </div>
                                <div>
                                    <h4 class="font-medium text-neutral-900 mb-3">Support Options</h4>
                                    <ul class="space-y-2">
                                        <li><a href="#" class="text-brand-primary hover:underline">Contact Technical Support</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">Community Forum</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">Video Tutorials</a></li>
                                        <li><a href="#" class="text-brand-primary hover:underline">Warranty Information</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Related Products -->
            <section class="mt-16">
                <h2 class="text-2xl font-bold text-neutral-900 mb-8">You Might Also Like</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Related product cards would go here -->
                    <div class="bg-white rounded-lg shadow hover:shadow-lg transition-shadow">
                        <div class="aspect-square bg-neutral-100 rounded-t-lg overflow-hidden">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" alt="Related Product" class="w-full h-full object-cover">
                        </div>
                        <div class="p-4">
                            <h3 class="font-medium text-neutral-900 mb-2">Smart Sensor Pro</h3>
                            <p class="text-neutral-600 text-sm mb-2">Advanced environmental monitoring</p>
                            <div class="text-brand-primary font-bold">$149.99</div>
                        </div>
                    </div>
                    
                    <div class="bg-white rounded-lg shadow hover:shadow-lg transition-shadow">
                        <div class="aspect-square bg-neutral-100 rounded-t-lg overflow-hidden">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" alt="Related Product" class="w-full h-full object-cover">
                        </div>
                        <div class="p-4">
                            <h3 class="font-medium text-neutral-900 mb-2">IoT Hub Gateway</h3>
                            <p class="text-neutral-600 text-sm mb-2">Central control for all devices</p>
                            <div class="text-brand-primary font-bold">$299.99</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

                        <!-- Product Description -->
                        <div class="product-info__description">
                            <h3 class="section-title">Description</h3>
                            <p class="description-text">
                                <%= product.getDescription() != null ? product.getDescription() : "No description available for this product." %>
                            </p>
                        </div>

                        <!-- Product Specifications -->
                        <div class="product-info__specs">
                            <h3 class="section-title">Specifications</h3>
                            <div class="specs-list">
                                <div class="spec-item">
                                    <span class="spec-label">Product ID:</span>
                                    <span class="spec-value">#<%= product.getId() %></span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label">Category:</span>
                                    <span class="spec-value">IoT Device</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label">Availability:</span>
                                    <span class="spec-value status-available">In Stock</span>
                                </div>
                            </div>
                        </div>

                        <!-- Add to Cart Section -->
                        <div class="product-actions">
                            <div class="quantity-selector">
                                <label for="quantity" class="quantity-label">Quantity:</label>
                                <div class="quantity-input">
                                    <button type="button" class="quantity-btn quantity-btn--minus" onclick="decreaseQuantity()">-</button>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="10" class="quantity-field">
                                    <button type="button" class="quantity-btn quantity-btn--plus" onclick="increaseQuantity()">+</button>
                                </div>
                            </div>

                            <div class="action-buttons">
                                <% if (currentUser != null) { %>
                                    <form class="add-to-cart-form" action="cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <input type="hidden" name="productPrice" value="<%= product.getPrice() %>">
                                        <input type="hidden" id="hiddenQuantity" name="quantity" value="1">
                                        <button type="submit" class="btn btn--primary btn--lg add-to-cart-btn">
                                            <svg class="btn-icon" fill="currentColor" viewBox="0 0 20 20">
                                                <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                                            </svg>
                                            Add to Cart
                                        </button>
                                    </form>

                                    <form class="wishlist-form" action="wishlist" method="post">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <button type="submit" class="btn btn--outline btn--lg wishlist-btn">
                                            <svg class="btn-icon" fill="currentColor" viewBox="0 0 20 20">
                                                <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"></path>
                                            </svg>
                                            Add to Wishlist
                                        </button>
                                    </form>
                                <% } else { %>
                                    <a href="login.jsp" class="btn btn--primary btn--lg">
                                        Sign in to Purchase
                                    </a>
                                <% } %>
                            </div>
                        </div>

                        <!-- Trust Badges -->
                        <div class="trust-badges">
                            <div class="trust-badge">
                                <svg class="trust-badge__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span>Secure Payment</span>
                            </div>
                            <div class="trust-badge">
                                <svg class="trust-badge__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                                    <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1V8a1 1 0 00-1-1h-3z"></path>
                                </svg>
                                <span>Free Shipping</span>
                            </div>
                            <div class="trust-badge">
                                <svg class="trust-badge__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"></path>
                                </svg>
                                <span>30-Day Returns</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Related Products Section -->
            <div class="related-products">
                <h2 class="section-title">Related Products</h2>
                <div class="related-products__grid">
                    <!-- This would be populated by a servlet call to get related products -->
                    <p class="text-muted">Loading related products...</p>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="components/footer.jsp" />
    <script src="js/main.js"></script>
    <script>
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
</body>
</html>

