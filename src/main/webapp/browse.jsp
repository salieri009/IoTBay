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
    // Expose to EL
    request.setAttribute("category", category);
%>

<t:base title="Browse Products" description="Browse IoT products across categories and keywords">
    <!-- Page Header -->
    <section class="page-header bg-white border-b border-neutral-200 py-8">
        <div class="container">
            <!-- Breadcrumb -->
            <nav class="breadcrumb mb-4" aria-label="Breadcrumb">
                <ol class="flex items-center gap-2 text-sm text-neutral-600">
                    <li>
                        <a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary">Home</a>
                    </li>
                    <li>/</li>
                    <c:choose>
                        <c:when test="${category != null && !empty category}">
                            <li>
                                <a href="${pageContext.request.contextPath}/categories.jsp" class="hover:text-brand-primary">Categories</a>
                            </li>
                            <li>/</li>
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
            
            <!-- Page Title -->
            <div class="mb-6">
                <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                    <h1 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-2">
                        Search Results for "<span class="text-brand-primary"><%= keyword %></span>"
                    </h1>
                    <p class="text-lg text-neutral-600">
                        Found <%= totalResults %> product<%= totalResults != 1 ? "s" : "" %> matching your search
                    </p>
                <% } else if (category != null) { %>
                    <h1 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-2"><%= category %> Products</h1>
                    <p class="text-lg text-neutral-600">
                        Discover <%= totalResults %> innovative <%= category.toLowerCase() %> solution<%= totalResults != 1 ? "s" : "" %>
                    </p>
                <% } else { %>
                    <h1 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-2">Browse All Products</h1>
                    <p class="text-lg text-neutral-600">
                        Explore our complete collection of <%= totalResults %> IoT products and solutions
                    </p>
                <% } %>
            </div>
            
            <!-- Filters and Sort Options -->
            <div class="flex flex-wrap items-center gap-4 mb-8">
                <div class="flex-1 min-w-[200px]">
                    <label for="categoryFilter" class="sr-only">Filter by Category</label>
                    <select class="form-input w-full" id="categoryFilter" onchange="filterByCategory()" aria-label="Filter by category">
                        <option value="">All Categories</option>
                        <option value="1" <%= categoryId != null && categoryId == 1 ? "selected" : "" %>>Sensors</option>
                        <option value="2" <%= categoryId != null && categoryId == 2 ? "selected" : "" %>>Controllers</option>
                        <option value="3" <%= categoryId != null && categoryId == 3 ? "selected" : "" %>>Connectivity</option>
                        <option value="4" <%= categoryId != null && categoryId == 4 ? "selected" : "" %>>Power & Batteries</option>
                    </select>
                </div>
                
                <div class="flex-1 min-w-[200px]">
                    <label for="sortBy" class="sr-only">Sort Products</label>
                    <select class="form-input w-full" id="sortBy" onchange="sortProducts()" aria-label="Sort products">
                        <option value="name">Sort by Name</option>
                        <option value="price-low">Price: Low to High</option>
                        <option value="price-high">Price: High to Low</option>
                    </select>
                </div>
            </div>
        </div>
    </section>

    <!-- Products Grid -->
    <section class="py-8">
        <div class="container">
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
            <% } else { %>
                <div class="empty-state text-center py-16">
                    <div class="empty-state__icon mb-6">
                        <svg class="w-24 h-24 mx-auto text-neutral-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-bold text-neutral-900 mb-4">No products found</h3>
                    <p class="text-lg text-neutral-600 mb-8 max-w-md mx-auto">
                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                            We couldn't find any products matching "<%= keyword %>". Try adjusting your search terms.
                        <% } else { %>
                            There are no products available in this category.
                        <% } %>
                    </p>
                    <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary btn--lg">Browse All Products</a>
                </div>
            <% } %>
        </div>
    </section>
    <script>
        function filterByCategory() {
            const categorySelect = document.getElementById('categoryFilter');
            const categoryId = categorySelect.value;
            const currentKeyword = '<%= keyword != null ? keyword : "" %>';
            
            let url = '${pageContext.request.contextPath}/browse';
            const params = new URLSearchParams();
            
            if (categoryId) {
                params.append('categoryId', categoryId);
            }
            if (currentKeyword) {
                params.append('keyword', currentKeyword);
            }
            
            if (params.toString()) {
                url += '?' + params.toString();
            }
            
            window.location.href = url;
        }
        
        function sortProducts() {
            const sortSelect = document.getElementById('sortBy');
            const sortBy = sortSelect.value;
            const productContainer = document.querySelector('.product-grid');
            if (!productContainer) return;
            const products = Array.from(productContainer.children);
            
            products.sort((a, b) => {
                switch(sortBy) {
                    case 'price-low':
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    case 'price-high':
                        return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                    case 'name':
                    default:
                        return a.dataset.name.localeCompare(b.dataset.name);
                }
            });
            
            products.forEach(product => productContainer.appendChild(product));
        }
        
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