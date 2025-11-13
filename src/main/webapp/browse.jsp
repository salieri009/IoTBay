<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    List<model.Product> products = (List<model.Product>) request.getAttribute("results");
    String keyword = (String) request.getAttribute("keyword");
    Integer categoryId = (Integer) request.getAttribute("categoryId");
    String category = (String) request.getAttribute("category");
    int totalResults = products != null ? products.size() : 0;
    String contextPath = request.getContextPath();

    String pageHeading;
    String pageDescription;
    String badgeLabel = null;
    if (keyword != null && !keyword.trim().isEmpty()) {
        pageHeading = "Search results for \"" + keyword + "\"";
        pageDescription = "Found " + totalResults + " product" + (totalResults != 1 ? "s" : "") + " matching your search.";
        badgeLabel = "Keyword: " + keyword;
    } else if (category != null && !category.trim().isEmpty()) {
        pageHeading = category + " products";
        pageDescription = "Discover " + totalResults + " " + category.toLowerCase() + " solution" + (totalResults != 1 ? "s" : "") + ".";
        badgeLabel = "Category: " + category;
    } else {
        pageHeading = "Browse all products";
        pageDescription = "Explore our complete collection of " + totalResults + " IoT products and solutions.";
    }
    String resultsNoun = totalResults == 1 ? "product" : "products";
    int displayUpperBound = totalResults == 0 ? 0 : Math.min(totalResults, 12);
    String resultsSummaryText = totalResults == 0
        ? "No " + resultsNoun + " available for the current selection."
        : "Showing 1-" + displayUpperBound + " of " + totalResults + " " + resultsNoun;

    // Expose to EL
    request.setAttribute("category", category);
%>

<t:base title="Browse Products" description="Browse IoT products across categories and keywords">
    <!-- Page Header -->
    <section class="pt-12 pb-8 bg-white border-b border-neutral-200">
        <div class="container space-y-8">
            <!-- Breadcrumb -->
            <nav class="breadcrumb" aria-label="Breadcrumb">
                <ol class="flex flex-wrap items-center gap-2 text-sm text-neutral-600">
                    <li>
                        <a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary">Home</a>
                    </li>
                    <li aria-hidden="true">/</li>
                    <c:choose>
                        <c:when test="${category != null && !empty category}">
                            <li>
                                <a href="${pageContext.request.contextPath}/categories.jsp" class="hover:text-brand-primary">Categories</a>
                            </li>
                            <li aria-hidden="true">/</li>
                            <li class="text-neutral-900 font-medium" aria-current="page">
                                ${category}
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="text-neutral-900 font-medium" aria-current="page">
                                Browse Products
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ol>
            </nav>

            <div class="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,340px)]">
                <div class="space-y-4">
                    <h1 class="text-display-m md:text-display-l font-bold text-neutral-900 leading-tight">
                        <%= pageHeading %>
                    </h1>
                    <p class="text-lg text-neutral-600 max-w-3xl">
                        <%= pageDescription %>
                    </p>
                    <div class="flex flex-wrap items-center gap-3 text-sm text-neutral-600">
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                            <%= totalResults %> <%= resultsNoun %>
                        </span>
                        <% if (badgeLabel != null) { %>
                            <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                                <span class="inline-flex h-2 w-2 rounded-full bg-brand-secondary"></span>
                                <%= badgeLabel %>
                            </span>
                        <% } %>
                    </div>
                </div>
                <aside class="rounded-2xl bg-neutral-50 border border-neutral-200 p-6 space-y-4" aria-label="Search guidance">
                    <div>
                        <h2 class="text-sm font-semibold text-neutral-700 uppercase tracking-wide">At a glance</h2>
                        <p class="mt-2 text-2xl font-bold text-neutral-900"><%= totalResults %> <span class="text-sm font-medium text-neutral-600">results</span></p>
                    </div>
                    <ul class="space-y-3 text-sm text-neutral-600">
                        <li>Use filters to focus by category, protocol, voltage, or stock availability.</li>
                        <li>Switch between grid and list views to compare product metadata efficiently.</li>
                        <li>Sorting updates the catalogue instantly—screen readers announce each change.</li>
                    </ul>
                    <p class="text-xs text-neutral-500">Need help selecting hardware? <a href="${pageContext.request.contextPath}/contact.jsp" class="text-brand-primary hover:underline">Contact a specialist</a>.</p>
                </aside>
            </div>

            <!-- Search, Sort & View Controls -->
            <div class="flex flex-col gap-4 xl:flex-row xl:items-end">
                <form action="${pageContext.request.contextPath}/browse" method="get" class="flex w-full flex-col gap-2 sm:flex-row">
                    <label for="productSearch" class="sr-only">Search products</label>
                    <input 
                        type="search" 
                        id="productSearch"
                        name="keyword" 
                        value="<%= keyword != null ? keyword : "" %>"
                        placeholder="Search products by name, SKU, or capability" 
                        class="form-input flex-1"
                        aria-describedby="search-hint">
                    <button type="submit" class="btn btn--primary" aria-label="Submit product search">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                        </svg>
                    </button>
                </form>
                <div class="flex w-full flex-col gap-3 sm:flex-row sm:items-stretch xl:w-auto">
                    <div class="sm:w-56">
                        <label for="sortBy" class="sr-only">Sort products</label>
                        <select class="form-input w-full" id="sortBy" onchange="sortProducts()" aria-label="Sort products">
                            <option value="relevance">Sort by: Relevance</option>
                            <option value="price-low">Price: Low to High</option>
                            <option value="price-high">Price: High to Low</option>
                            <option value="name-asc">Name: A to Z</option>
                            <option value="name-desc">Name: Z to A</option>
                            <option value="newest">Newest First</option>
                            <option value="stock">Stock: High to Low</option>
                        </select>
                    </div>
                    <div class="flex items-center gap-2" role="group" aria-label="View options">
                        <button 
                            type="button" 
                            id="gridViewBtn"
                            class="btn btn--primary btn--sm"
                            onclick="toggleView('grid')"
                            aria-label="Grid view"
                            aria-pressed="true">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
                            </svg>
                            <span class="sr-only">Grid view</span>
                        </button>
                        <button 
                            type="button" 
                            id="listViewBtn"
                            class="btn btn--ghost btn--sm"
                            onclick="toggleView('list')"
                            aria-label="List view"
                            aria-pressed="false">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="sr-only">List view</span>
                        </button>
                    </div>
                </div>
            </div>

            <p id="search-hint" class="text-sm text-neutral-500">
                Tip: combine keyword search with filters for precise results. Results update instantly and are announced for assistive technologies.
            </p>

            <!-- Results Count -->
            <div>
                <p class="text-sm text-neutral-600" id="results-count" aria-live="polite">
                    <%= resultsSummaryText %>
                </p>
            </div>
        </div>
    </section>

    <!-- Main Content Area - Two Column Layout (Section 4.2) -->
    <section class="py-8">
        <div class="container">
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                <!-- Filters Sidebar (Section 4.2) -->
                <aside class="lg:col-span-1" id="filters-sidebar" role="complementary" aria-label="Filter products">
                    <div class="filters-panel bg-white rounded-lg shadow-sm border border-neutral-200 p-6 sticky top-8 space-y-6">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-semibold text-neutral-900">Filters</h2>
                            <button 
                                type="button" 
                                class="text-sm text-brand-primary hover:underline lg:hidden"
                                onclick="toggleFilters(event)"
                                aria-label="Toggle filter visibility"
                                aria-expanded="true">
                                Hide
                            </button>
                        </div>

                        <form id="filtersForm" class="space-y-6" aria-describedby="filters-help">
                            <p id="filters-help" class="text-sm text-neutral-500">
                                Select one or more filter options and choose “Apply filters” to refresh the catalogue.
                            </p>

                            <!-- Category Filter -->
                            <fieldset class="filter-group">
                                <legend class="text-sm font-semibold text-neutral-900 mb-3">Category</legend>
                                <div class="space-y-2">
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="category" value="industrial" class="form-checkbox" 
                                               <%= category != null && category.equalsIgnoreCase("industrial") ? "checked" : "" %>>
                                        <span class="text-sm text-neutral-700">Industrial</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="category" value="warehouse" class="form-checkbox"
                                               <%= category != null && category.equalsIgnoreCase("warehouse") ? "checked" : "" %>>
                                        <span class="text-sm text-neutral-700">Warehouse</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="category" value="agriculture" class="form-checkbox"
                                               <%= category != null && category.equalsIgnoreCase("agriculture") ? "checked" : "" %>>
                                        <span class="text-sm text-neutral-700">Agriculture</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="category" value="smarthome" class="form-checkbox"
                                               <%= category != null && category.equalsIgnoreCase("smarthome") ? "checked" : "" %>>
                                        <span class="text-sm text-neutral-700">Smart Home</span>
                                    </label>
                                </div>
                            </fieldset>
                            
                            <!-- Protocol Filter -->
                            <fieldset class="filter-group">
                                <legend class="text-sm font-semibold text-neutral-900 mb-3">Protocol</legend>
                                <div class="space-y-2">
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="protocol" value="lorawan" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">LoRaWAN</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="protocol" value="wifi" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">WiFi</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="protocol" value="zigbee" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">Zigbee</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="protocol" value="bluetooth" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">Bluetooth</span>
                                    </label>
                                </div>
                            </fieldset>
                            
                            <!-- Voltage Filter -->
                            <fieldset class="filter-group">
                                <legend class="text-sm font-semibold text-neutral-900 mb-3">Voltage</legend>
                                <div class="space-y-2">
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="voltage" value="5v" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">5V DC</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="voltage" value="12v" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">12V DC</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="voltage" value="24v" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">24V DC</span>
                                    </label>
                                </div>
                            </fieldset>
                            
                            <!-- Price Range -->
                            <fieldset class="filter-group">
                                <legend class="text-sm font-semibold text-neutral-900 mb-3">Price range</legend>
                                <div class="space-y-3">
                                    <div class="flex items-center gap-2">
                                        <label for="priceMin" class="sr-only">Minimum price</label>
                                        <input type="number" id="priceMin" name="priceMin" placeholder="Min" 
                                               class="form-input text-sm" min="0" step="10">
                                        <span class="text-neutral-500" aria-hidden="true">–</span>
                                        <label for="priceMax" class="sr-only">Maximum price</label>
                                        <input type="number" id="priceMax" name="priceMax" placeholder="Max" 
                                               class="form-input text-sm" min="0" step="10">
                                    </div>
                                    <div class="price-range-slider">
                                        <label for="priceRange" class="sr-only">Adjust price range slider</label>
                                        <input type="range" id="priceRange" min="0" max="1000" value="500" 
                                               class="w-full" aria-valuemin="0" aria-valuemax="1000" aria-label="Price range">
                                    </div>
                                </div>
                            </fieldset>
                            
                            <!-- Stock Status -->
                            <fieldset class="filter-group">
                                <legend class="text-sm font-semibold text-neutral-900 mb-3">Stock status</legend>
                                <div class="space-y-2">
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="stock" value="in-stock" class="form-checkbox" checked>
                                        <span class="text-sm text-neutral-700">In stock only</span>
                                    </label>
                                    <label class="flex items-center gap-2">
                                        <input type="checkbox" name="stock" value="include-out" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">Include out of stock</span>
                                    </label>
                                </div>
                            </fieldset>
                            
                            <!-- Filter Actions -->
                            <div class="flex flex-col gap-2 pt-4 border-t border-neutral-200">
                                <button type="button" onclick="applyFilters()" class="btn btn--primary w-full">
                                    Apply filters
                                </button>
                                <button type="button" onclick="clearFilters()" class="btn btn--outline w-full">
                                    Clear all
                                </button>
                            </div>
                        </form>
                    </div>
                </aside>
                
                <!-- Product Grid Area (Section 4.2) -->
                <div class="lg:col-span-3">
                    <!-- Skeleton Loading State (Section 3.2) -->
                    <div id="products-skeleton" class="product-grid hidden">
                        <% for (int i = 0; i < 8; i++) { %>
                            <div class="skeleton-card">
                                <div class="skeleton skeleton-image"></div>
                                <div class="skeleton skeleton-text skeleton-text--title"></div>
                                <div class="skeleton skeleton-text"></div>
                                <div class="skeleton skeleton-text skeleton-text--short"></div>
                            </div>
                        <% } %>
                    </div>
                    
                    <% if (products != null && !products.isEmpty()) { %>
                        <div class="product-grid" id="products-grid">
                <% for (Product p : products) { %>
                    <div class="product-card" 
                         data-product-id="<%= p.getId() %>" 
                         data-price="<%= p.getPrice() %>" 
                         data-name="<%= p.getName().toLowerCase() %>"
                         tabindex="0"
                         role="article"
                         aria-label="Product: <%= p.getName() %>">
                        <div class="product-card__image-container">
                            <img class="product-card__image" 
                                 src="<%= p.getImageUrl() != null && !p.getImageUrl().isEmpty() ? p.getImageUrl() : "images/default-product.png" %>" 
                                 alt="<%= p.getName() %>" 
                                 loading="lazy"
                                 width="300"
                                 height="300"
                                 onerror="this.onerror=null;this.src='images/default-product.png';" />
                            <!-- Stock Badge (Visibility of System Status - Nielsen's Heuristic 1) -->
                            <% if (p.getStockQuantity() > 0 && p.getStockQuantity() < 5) { %>
                                <span class="product-card__badge product-card__badge--warning" aria-label="Low stock: <%= p.getStockQuantity() %> remaining">
                                    Low Stock
                                </span>
                            <% } else if (p.getStockQuantity() == 0) { %>
                                <span class="product-card__badge product-card__badge--error" aria-label="Out of stock">
                                    Out of Stock
                                </span>
                            <% } %>
                        </div>
                        <div class="product-card__body">
                            <div class="product-card__header">
                                <h3 class="product-card__title"><%= p.getName() %></h3>
                                <!-- Key Spec Badge (Section 1.1 - Recognition rather than recall) -->
                                <span class="product-card__spec-badge" title="Communication Protocol">WiFi</span>
                            </div>
                            <p class="product-card__description">
                                <%= p.getDescription() != null && p.getDescription().length() > 100 
                                    ? p.getDescription().substring(0, 100) + "..." 
                                    : (p.getDescription() != null ? p.getDescription() : "") %>
                            </p>
                            <div class="product-card__footer">
                                <div class="product-card__price-info">
                                    <div class="product-card__price">$<%= String.format("%.2f", p.getPrice()) %></div>
                                    <div class="product-card__stock-status">
                                        <% if (p.getStockQuantity() > 0) { %>
                                            <span class="text-success text-sm">✓ In Stock</span>
                                        <% } else { %>
                                            <span class="text-error text-sm">✗ Out of Stock</span>
                                        <% } %>
                                    </div>
                                </div>
                                <div class="product-card__actions">
                                    <a href="product?productId=<%= p.getId() %>" 
                                       class="btn btn--outline btn--sm"
                                       aria-label="View details for <%= p.getName() %>">
                                        View Details
                                    </a>
                                    <button type="button"
                                            onclick="if(typeof addToCart === 'function') { addToCart(<%= p.getId() %>, 1); } else { document.querySelector('[data-product-id=\'<%= p.getId() %>\'] .add-to-cart-form')?.submit(); }"
                                            class="btn btn--primary btn--sm"
                                            aria-label="Add <%= p.getName() %> to cart"
                                            <%= p.getStockQuantity() == 0 ? "disabled" : "" %>>
                                        <%= p.getStockQuantity() > 0 ? "Add to Cart" : "Out of Stock" %>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                        <% } %>
                        </div>
                        
                        <!-- Pagination (Section 4.2) -->
                        <nav class="pagination mt-12" aria-label="Product pagination">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <button 
                                        type="button" 
                                        class="btn btn--ghost btn--sm"
                                        onclick="goToPage(1)"
                                        aria-label="First page"
                                        disabled>
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M15.707 15.707a1 1 0 01-1.414 0l-5-5a1 1 0 010-1.414l5-5a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 010 1.414zm-6 0a1 1 0 01-1.414 0l-5-5a1 1 0 010-1.414l5-5a1 1 0 011.414 1.414L5.414 10l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd"></path>
                                        </svg>
                                    </button>
                                    <button 
                                        type="button" 
                                        class="btn btn--ghost btn--sm"
                                        onclick="goToPage(currentPage - 1)"
                                        aria-label="Previous page"
                                        disabled>
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                        </svg>
                                        Previous
                                    </button>
                                </div>
                                
                                <div class="flex items-center gap-2">
                                    <span class="text-sm text-neutral-600">Page</span>
                                    <input 
                                        type="number" 
                                        id="pageInput"
                                        class="form-input w-16 text-center" 
                                        min="1" 
                                        value="1"
                                        aria-label="Current page">
                                    <span class="text-sm text-neutral-600">of <span id="totalPages">1</span></span>
                                </div>
                                
                                <div class="flex items-center gap-2">
                                    <button 
                                        type="button" 
                                        class="btn btn--ghost btn--sm"
                                        onclick="goToPage(currentPage + 1)"
                                        aria-label="Next page">
                                        Next
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                                        </svg>
                                    </button>
                                    <button 
                                        type="button" 
                                        class="btn btn--ghost btn--sm"
                                        onclick="goToPage(totalPages)"
                                        aria-label="Last page">
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10.293 15.707a1 1 0 010-1.414L14.586 11H10a1 1 0 110-2h4.586l-4.293-4.293a1 1 0 111.414-1.414l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Results per page selector -->
                            <div class="flex items-center justify-center gap-2 mt-4">
                                <label for="resultsPerPage" class="text-sm text-neutral-600">Show:</label>
                                <select id="resultsPerPage" class="form-input text-sm" onchange="changeResultsPerPage()" aria-label="Results per page">
                                    <option value="12" selected>12</option>
                                    <option value="24">24</option>
                                    <option value="48">48</option>
                                    <option value="96">96</option>
                                </select>
                                <span class="text-sm text-neutral-600">per page</span>
                            </div>
                        </nav>
                    <% } else { %>
                        <!-- Empty State (Section 4.2) -->
                        <div class="empty-state text-center py-16">
                            <div class="empty-state__icon mb-6">
                                <svg class="w-24 h-24 mx-auto text-neutral-400" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-4">No products found</h3>
                            <p class="text-lg text-neutral-600 mb-8 max-w-md mx-auto">
                                <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                                    We couldn't find any products matching "<%= keyword %>". Try adjusting your search terms or filters.
                                <% } else { %>
                                    There are no products available matching your current filters. Try adjusting your filter criteria.
                                <% } %>
                            </p>
                            <div class="flex flex-wrap justify-center gap-4">
                                <button onclick="clearFilters()" class="btn btn--outline">Clear all filters</button>
                                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary">Browse all products</a>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
    <script>
        // Pagination state
        let currentPage = 1;
        let totalPages = 1;
        let resultsPerPage = 12;
        
        // View state
        let currentView = 'grid';
        
        // Filter state management
        function applyFilters() {
            const form = document.getElementById('filtersForm');
            const formData = new FormData(form);
            const params = new URLSearchParams();
            
            // Collect filter values
            const categories = formData.getAll('category');
            const protocols = formData.getAll('protocol');
            const voltages = formData.getAll('voltage');
            const stockStatus = formData.getAll('stock');
            const priceMin = formData.get('priceMin');
            const priceMax = formData.get('priceMax');
            
            // Build URL parameters
            if (categories.length > 0) {
                params.append('category', categories.join(','));
            }
            if (protocols.length > 0) {
                params.append('protocol', protocols.join(','));
            }
            if (voltages.length > 0) {
                params.append('voltage', voltages.join(','));
            }
            if (stockStatus.length > 0) {
                params.append('stock', stockStatus.join(','));
            }
            if (priceMin) {
                params.append('priceMin', priceMin);
            }
            if (priceMax) {
                params.append('priceMax', priceMax);
            }
            
            // Preserve search keyword
            const keyword = '<%= keyword != null ? keyword : "" %>';
            if (keyword) {
                params.append('keyword', keyword);
            }
            
            // Update URL and reload
            const url = '${pageContext.request.contextPath}/browse' + (params.toString() ? '?' + params.toString() : '');
            window.location.href = url;
        }
        
        function clearFilters() {
            const form = document.getElementById('filtersForm');
            form.reset();
            const keyword = '<%= keyword != null ? keyword : "" %>';
            const url = '${pageContext.request.contextPath}/browse' + (keyword ? '?keyword=' + encodeURIComponent(keyword) : '');
            window.location.href = url;
        }
        
        function toggleFilters(event) {
            const sidebar = document.getElementById('filters-sidebar');
            if (!sidebar) return;
            const button = event.currentTarget || event.target;
            const isHiddenNow = sidebar.classList.toggle('hidden');
            button.setAttribute('aria-expanded', isHiddenNow ? 'false' : 'true');
            button.textContent = isHiddenNow ? 'Show' : 'Hide';
        }
        
        function sortProducts() {
            const sortSelect = document.getElementById('sortBy');
            const sortBy = sortSelect.value;
            const productContainer = document.getElementById('products-grid');
            if (!productContainer) return;
            
            const products = Array.from(productContainer.children);
            
            products.sort((a, b) => {
                switch(sortBy) {
                    case 'price-low':
                        return parseFloat(a.dataset.price || 0) - parseFloat(b.dataset.price || 0);
                    case 'price-high':
                        return parseFloat(b.dataset.price || 0) - parseFloat(a.dataset.price || 0);
                    case 'name-asc':
                        return (a.dataset.name || '').localeCompare(b.dataset.name || '');
                    case 'name-desc':
                        return (b.dataset.name || '').localeCompare(a.dataset.name || '');
                    case 'newest':
                        // Assuming newest products have higher IDs
                        return parseFloat(b.dataset.productId || 0) - parseFloat(a.dataset.productId || 0);
                    case 'stock':
                        // Sort by stock quantity (would need data attribute)
                        return 0; // Placeholder
                    case 'relevance':
                    default:
                        return 0; // Keep original order
                }
            });
            
            // Re-append sorted products
            products.forEach(product => productContainer.appendChild(product));
            
            // Announce to screen readers
            if (typeof announceToScreenReader === 'function') {
                announceToScreenReader(`Products sorted by ${sortSelect.options[sortSelect.selectedIndex].text}`);
            }
        }
        
        function toggleView(view) {
            currentView = view;
            const gridBtn = document.getElementById('gridViewBtn');
            const listBtn = document.getElementById('listViewBtn');
            const productGrid = document.getElementById('products-grid');
            
            if (!productGrid || !gridBtn || !listBtn) return;
            
            if (view === 'grid') {
                gridBtn.classList.add('btn--primary');
                gridBtn.classList.remove('btn--ghost');
                gridBtn.setAttribute('aria-pressed', 'true');
                listBtn.classList.remove('btn--primary');
                listBtn.classList.add('btn--ghost');
                listBtn.setAttribute('aria-pressed', 'false');
                productGrid.classList.remove('product-list');
                productGrid.classList.add('product-grid');
            } else {
                listBtn.classList.add('btn--primary');
                listBtn.classList.remove('btn--ghost');
                listBtn.setAttribute('aria-pressed', 'true');
                gridBtn.classList.remove('btn--primary');
                gridBtn.classList.add('btn--ghost');
                gridBtn.setAttribute('aria-pressed', 'false');
                productGrid.classList.remove('product-grid');
                productGrid.classList.add('product-list');
            }
            
            // Save preference
            localStorage.setItem('productView', view);
        }
        
        function goToPage(page) {
            if (page < 1 || page > totalPages) return;
            currentPage = page;
            // Implement pagination logic
            updatePagination();
        }
        
        function changeResultsPerPage() {
            const select = document.getElementById('resultsPerPage');
            resultsPerPage = parseInt(select.value);
            currentPage = 1;
            // Implement pagination logic
            updatePagination();
            localStorage.setItem('resultsPerPage', resultsPerPage);
        }
        
        function updatePagination() {
            const pageInput = document.getElementById('pageInput');
            const totalPagesSpan = document.getElementById('totalPages');
            
            if (pageInput) pageInput.value = currentPage;
            if (totalPagesSpan) totalPagesSpan.textContent = totalPages;
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Restore view preference
            const savedView = localStorage.getItem('productView') || 'grid';
            if (savedView !== currentView) {
                toggleView(savedView);
            }
            
            // Restore results per page
            const savedResultsPerPage = localStorage.getItem('resultsPerPage');
            if (savedResultsPerPage) {
                resultsPerPage = parseInt(savedResultsPerPage);
                const select = document.getElementById('resultsPerPage');
                if (select) select.value = resultsPerPage;
            }
            
            // Initialize price range slider
            const priceRange = document.getElementById('priceRange');
            const priceMin = document.getElementById('priceMin');
            const priceMax = document.getElementById('priceMax');
            
            if (priceRange && priceMin && priceMax) {
                priceRange.addEventListener('input', function() {
                    priceMax.value = this.value;
                });
            }
        });
        
        // Add to cart functionality
        document.querySelectorAll('.add-to-cart-form').forEach(form => {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                const button = this.querySelector('button');
                const originalText = button.textContent;
                
                button.textContent = 'Adding...';
                button.disabled = true;
                
                if (typeof showLoading === 'function') {
                    showLoading(button);
                }
                
                fetch(this.action, {
                    method: 'POST',
                    body: new FormData(this)
                })
                .then(response => {
                    if (response.ok) {
                        if (typeof showToast === 'function') {
                            showToast('Product added to cart!', 'success');
                        }
                        button.textContent = 'Added!';
                        button.classList.remove('btn--primary');
                        button.classList.add('btn--success');
                        
                        // Update cart count if function exists
                        if (window.updateCartCount) {
                            window.updateCartCount(parseInt(document.querySelector('.header__cart-count')?.textContent || '0') + 1);
                        }
                        
                        setTimeout(() => {
                            button.textContent = originalText;
                            button.classList.remove('btn--success');
                            button.classList.add('btn--primary');
                            button.disabled = false;
                        }, 2000);
                    } else {
                        throw new Error('Failed to add to cart');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    if (typeof showToast === 'function') {
                        showToast('Failed to add product to cart. Please try again.', 'error');
                    }
                    button.textContent = 'Error';
                    button.classList.add('btn--error');
                    
                    setTimeout(() => {
                        button.textContent = originalText;
                        button.classList.remove('btn--error');
                        button.disabled = false;
                    }, 2000);
                })
                .finally(() => {
                    if (typeof hideLoading === 'function') {
                        hideLoading(button);
                    }
                });
            });
        });
    </script>
</t:base>