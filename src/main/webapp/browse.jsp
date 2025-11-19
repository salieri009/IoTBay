<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    request.setAttribute("pageHeading", pageHeading);
    request.setAttribute("pageDescription", pageDescription);
    request.setAttribute("badgeLabel", badgeLabel);
    request.setAttribute("totalResults", totalResults);
    request.setAttribute("resultsNoun", resultsNoun);
    request.setAttribute("resultsSummaryText", resultsSummaryText);
    request.setAttribute("products", products);
    request.setAttribute("keyword", keyword);
    
    // Category check states
    request.setAttribute("isIndustrial", category != null && category.equalsIgnoreCase("industrial"));
    request.setAttribute("isWarehouse", category != null && category.equalsIgnoreCase("warehouse"));
    request.setAttribute("isAgriculture", category != null && category.equalsIgnoreCase("agriculture"));
    request.setAttribute("isSmarthome", category != null && category.equalsIgnoreCase("smarthome"));
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

            <!-- Optimized layout for 1920x1080: 280px sidebar, flexible main content -->
            <div class="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,280px)] xl:grid-cols-[minmax(0,1fr)_minmax(0,320px)]">
                <div class="space-y-4">
                    <h1 class="text-display-m md:text-display-l font-bold text-neutral-900 leading-tight">
                        ${pageHeading}
                    </h1>
                    <p class="text-lg text-neutral-600 max-w-3xl">
                        ${pageDescription}
                    </p>
                    <div class="flex flex-wrap items-center gap-3 text-sm text-neutral-600">
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                            ${totalResults} ${resultsNoun}
                        </span>
                        <c:if test="${badgeLabel != null && !empty badgeLabel}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                                <span class="inline-flex h-2 w-2 rounded-full bg-brand-secondary"></span>
                                ${badgeLabel}
                            </span>
                        </c:if>
                    </div>
                </div>
                <aside class="rounded-2xl bg-neutral-50 border border-neutral-200 p-6 space-y-4" aria-label="Search guidance">
                    <div>
                        <h2 class="text-sm font-semibold text-neutral-700 uppercase tracking-wide">At a glance</h2>
                        <p class="mt-2 text-2xl font-bold text-neutral-900">${totalResults} <span class="text-sm font-medium text-neutral-600">results</span></p>
                    </div>
                    <ul class="space-y-3 text-sm text-neutral-600">
                        <li>Use filters to focus by category, protocol, voltage, or stock availability.</li>
                        <li>Switch between grid and list views to compare product metadata efficiently.</li>
                        <li>Sorting updates the catalogue instantly?�screen readers announce each change.</li>
                    </ul>
                    <p class="text-xs text-neutral-500">Need help selecting hardware? <a href="${pageContext.request.contextPath}/contact.jsp" class="text-brand-primary hover:underline">Contact a specialist</a>.</p>
                </aside>
            </div>

            <!-- Search, Sort & View Controls -->
            <div class="flex flex-col gap-4 xl:flex-row xl:items-end">
                <form action="${pageContext.request.contextPath}/browse.jsp" method="get" class="flex w-full flex-col gap-2 sm:flex-row">
                    <label for="productSearch" class="sr-only">Search products</label>
                    <input 
                        type="search" 
                        id="productSearch"
                        name="keyword" 
                        value="${keyword != null ? keyword : ''}"
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
                    ${resultsSummaryText}
                </p>
            </div>
        </div>
    </section>

    <!-- Main Content Area - Two Column Layout (Section 4.2) -->
    <section class="py-12 bg-neutral-50">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                <!-- Filters Sidebar (Desktop) / Bottom Sheet (Mobile) -->
                <div class="lg:col-span-1">
                <%-- Desktop: Sidebar --%>
                <aside class="hidden lg:block" id="filters-sidebar-desktop" role="complementary" aria-label="Filter products">
                    <div class="sticky top-24">
                        <jsp:include page="/components/molecules/facet-search/facet-search.jsp">
                            <jsp:param name="id" value="facet-search-desktop" />
                            <jsp:param name="onFilterChange" value="handleFilterChange" />
                        </jsp:include>
                    </div>
                </aside>
                
                <%-- Mobile: Bottom Sheet Trigger --%>
                <div class="lg:hidden fixed bottom-0 left-0 right-0 z-40 bg-white border-t border-neutral-200 shadow-lg">
                    <button id="filter-trigger-mobile" 
                            class="w-full py-4 px-6 flex items-center justify-between"
                            aria-label="Open filters"
                            aria-expanded="false">
                        <span class="font-semibold text-neutral-900">Filters</span>
                        <jsp:include page="/components/atoms/icon/icon.jsp">
                            <jsp:param name="name" value="filter" />
                            <jsp:param name="size" value="medium" />
                        </jsp:include>
                    </button>
                </div>
                
                <%-- Mobile: Bottom Sheet with Facet Search --%>
                <jsp:include page="/components/organisms/bottom-sheet/bottom-sheet.jsp">
                    <jsp:param name="id" value="filter-sheet-mobile" />
                    <jsp:param name="title" value="Filter Products" />
                    <jsp:param name="trigger" value="#filter-trigger-mobile" />
                </jsp:include>
                <%-- Include facet-search in temp container, then move to bottom-sheet body --%>
                <div id="facet-search-mobile-temp" style="display: none;">
                    <jsp:include page="/components/molecules/facet-search/facet-search.jsp">
                        <jsp:param name="id" value="facet-search-mobile" />
                        <jsp:param name="onFilterChange" value="handleFilterChange" />
                    </jsp:include>
                </div>
                <script>
                // Move facet-search into bottom-sheet body after page load
                document.addEventListener('DOMContentLoaded', function() {
                    const sheetBody = document.getElementById('filter-sheet-mobile-content-body');
                    const tempContent = document.getElementById('facet-search-mobile-temp');
                    if (sheetBody && tempContent) {
                        while (tempContent.firstChild) {
                            sheetBody.appendChild(tempContent.firstChild);
                        }
                        tempContent.remove();
                    }
                });
                </script>
                
                <!-- Product Grid Area (Section 4.2) -->
                <div class="lg:col-span-3">
                    <!-- Skeleton Loading State (Section 3.2) -->
                    <div id="products-skeleton" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 hidden">
                        <c:forEach begin="1" end="8" varStatus="loop">
                            <div class="animate-pulse bg-white rounded-xl border border-neutral-200 p-4 h-full">
                                <div class="bg-neutral-200 h-48 rounded-lg mb-4"></div>
                                <div class="h-4 bg-neutral-200 rounded w-3/4 mb-2"></div>
                                <div class="h-4 bg-neutral-200 rounded w-1/2 mb-4"></div>
                                <div class="h-8 bg-neutral-200 rounded w-full"></div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <c:if test="${products != null && !empty products}">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="products-grid">
                            <c:forEach var="p" items="${products}">
                                <c:set var="productId" value="${p.id}" />
                                <c:set var="productName" value="${p.name}" />
                                <c:set var="productPrice" value="${p.price}" />
                                
                                <div class="col-span-1 h-full" 
                                     data-product-id="${productId}" 
                                     data-price="${productPrice}" 
                                     data-name="${fn:toLowerCase(productName)}"
                                     tabindex="0"
                                     role="article"
                                     aria-label="Product: ${productName}">
                                    
                                    <%-- Use Atomic Design Molecule --%>
                                    <c:set var="product" value="${p}" scope="request" />
                                    <jsp:include page="/components/molecules/product-card/product-card.jsp">
                                        <jsp:param name="showQuickView" value="true" />
                                        <jsp:param name="showWishlist" value="false" />
                                    </jsp:include>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination (Section 4.2) -->
                        <jsp:include page="/components/molecules/pagination/pagination.jsp">
                            <jsp:param name="currentPage" value="${currentPage != null ? currentPage : 1}" />
                            <jsp:param name="totalPages" value="${totalPages != null ? totalPages : 1}" />
                            <jsp:param name="onPageChange" value="goToPage" />
                        </jsp:include>

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
                    </c:if>
                    <c:if test="${products == null || empty products}">
                        <!-- Empty State -->
                        <div class="empty-state text-center py-16">
                            <div class="empty-state__icon mb-6">
                                <svg class="w-24 h-24 mx-auto text-neutral-400" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-4">No products found</h3>
                            <p class="text-lg text-neutral-600 mb-8 max-w-md mx-auto">
                                <c:choose>
                                    <c:when test="${keyword != null && !empty keyword}">
                                        We couldn't find any products matching "${keyword}". Try adjusting your search terms or filters.
                                    </c:when>
                                    <c:otherwise>
                                        There are no products available matching your current filters. Try adjusting your filter criteria.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="flex flex-wrap justify-center gap-4">
                                <button onclick="clearFilters()" class="btn btn--outline">Clear all filters</button>
                                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary">Browse all products</a>
                            </div>
                        </div>
                    </c:if>
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
            const keyword = '${keyword != null ? keyword : ""}';
            if (keyword) {
                params.append('keyword', keyword);
            }
            
            // Update URL and reload
            const url = '${pageContext.request.contextPath}/browse.jsp' + (params.toString() ? '?' + params.toString() : '');
            window.location.href = url;
        }
        
        function clearFilters() {
            const form = document.getElementById('filtersForm');
            form.reset();
            const keyword = '${keyword != null ? keyword : ""}';
            const url = '${pageContext.request.contextPath}/browse.jsp' + (keyword ? '?keyword=' + encodeURIComponent(keyword) : '');
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
