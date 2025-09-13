<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<%
    List<model.Product> products = (List<model.Product>) request.getAttribute("results");
    String keyword = (String) request.getAttribute("keyword");
    Integer categoryId = (Integer) request.getAttribute("categoryId");
    String category = (String) request.getAttribute("category");
    int totalResults = products != null ? products.size() : 0;
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Products - IoT Bay</title>
    <meta name="description" content="Browse IoT products across categories and keywords">
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
</head>
<body>
    <!-- Page Header -->
    <section class="page-header bg-white border-b border-neutral-200 py-8">
        <div class="container">
            <!-- Breadcrumb -->
            <nav class="breadcrumb mb-4" aria-label="Breadcrumb">
                <ol class="breadcrumb__list">
                    <li class="breadcrumb__item">
                        <a href="<%= contextPath %>/" class="breadcrumb__link">Home</a>
                    </li>
                    <% if (category != null) { %>
                        <li class="breadcrumb__item">
                            <a href="<%= contextPath %>/categories" class="breadcrumb__link">Categories</a>
                        </li>
                        <li class="breadcrumb__item breadcrumb__item--current" aria-current="page">
                            <%= category %>
                        </li>
                    <% } else { %>
                        <li class="breadcrumb__item breadcrumb__item--current" aria-current="page">
                            Browse Products
                        </li>
                    <% } %>
                </ol>
            </nav>
            
            <!-- Page Title -->
            <div class="page-header__content">
                <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                    <h1 class="page-header__title">
                        Search Results for "<span class="text-primary"><%= keyword %></span>"
                    </h1>
                    <p class="page-header__subtitle">
                        Found <%= totalResults %> product<%= totalResults != 1 ? "s" : "" %> matching your search
                    </p>
                <% } else if (category != null) { %>
                    <h1 class="page-header__title"><%= category %> Products</h1>
                    <p class="page-header__subtitle">
                        Discover <%= totalResults %> innovative <%= category.toLowerCase() %> solution<%= totalResults != 1 ? "s" : "" %>
                    </p>
                <% } else { %>
                    <h1 class="page-header__title">Browse All Products</h1>
                    <p class="page-header__subtitle">
                        Explore our complete collection of <%= totalResults %> IoT products and solutions
                    </p>
                <% } %>
                    
                <% if (products != null) { %>
                    <p class="search-results-count">
                        <%= products.size() %> product<%= products.size() != 1 ? "s" : "" %> found
                    </p>
                <% } %>
            </div>
            
            <!-- Filters and Sort Options -->
            <div class="browse-controls">
                <div class="filter-controls">
                    <select class="form-select" id="categoryFilter" onchange="filterByCategory()">
                        <option value="">All Categories</option>
                        <option value="1" <%= categoryId != null && categoryId == 1 ? "selected" : "" %>>Sensors</option>
                        <option value="2" <%= categoryId != null && categoryId == 2 ? "selected" : "" %>>Controllers</option>
                        <option value="3" <%= categoryId != null && categoryId == 3 ? "selected" : "" %>>Connectivity</option>
                        <option value="4" <%= categoryId != null && categoryId == 4 ? "selected" : "" %>>Power & Batteries</option>
                    </select>
                </div>
                
                <div class="sort-controls">
                    <select class="form-select" id="sortBy" onchange="sortProducts()">
                        <option value="name">Sort by Name</option>
                        <option value="price-low">Price: Low to High</option>
                        <option value="price-high">Price: High to Low</option>
                    </select>
                </div>
            </div>
        </div>
    </section>

    <!-- Products Grid -->
    <div class="products-section">
        <% if (products != null && !products.isEmpty()) { %>
            <div class="product__container">
                <% for (Product p : products) { %>
                    <div class="product-card" data-product-id="<%= p.getId() %>" data-price="<%= p.getPrice() %>" data-name="<%= p.getName().toLowerCase() %>">
                        <div class="product-card__image-container">
                            <img class="product-card__image" 
                                 src="<%= p.getImageUrl() != null && !p.getImageUrl().isEmpty() ? p.getImageUrl() : "images/default-product.png" %>" 
                                 alt="<%= p.getName() %>" 
                                 onerror="this.onerror=null;this.src='images/default-product.png';" />
                        </div>
                        <div class="product-card__body">
                            <h3 class="product-card__title"><%= p.getName() %></h3>
                            <p class="product-card__description">
                                <%= p.getDescription() != null && p.getDescription().length() > 100 
                                    ? p.getDescription().substring(0, 100) + "..." 
                                    : p.getDescription() %>
                            </p>
                            <div class="product-card__footer">
                                <div class="product-card__price">$<%= String.format("%.2f", p.getPrice()) %></div>
                                <div class="product-card__actions">
                                    <a href="product?productId=<%= p.getId() %>" class="btn btn--outline btn--sm">
                                        View Details
                                    </a>
                                    <form class="add-to-cart-form inline-block" action="cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn--primary btn--sm">
                                            Add to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <div class="empty-state__icon">
                    <svg fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <h3 class="empty-state__title">No products found</h3>
                <p class="empty-state__description">
                    <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                        We couldn't find any products matching "<%= keyword %>". Try adjusting your search terms.
                    <% } else { %>
                        There are no products available in this category.
                    <% } %>
                </p>
                <a href="index.jsp" class="btn btn--primary">Browse All Products</a>
            </div>
        <% } %>
    </div>

    <script src="<%= contextPath %>/js/main.js"></script>
    <script>
        function filterByCategory() {
            const categorySelect = document.getElementById('categoryFilter');
            const categoryId = categorySelect.value;
            const currentKeyword = '<%= keyword != null ? keyword : "" %>';
            
            let url = 'search';
            const params = new URLSearchParams();
            
            if (categoryId) {
                params.append('categoryId', categoryId);
            }
            if (currentKeyword) {
                params.append('query', currentKeyword);
            }
            
            if (params.toString()) {
                url += '?' + params.toString();
            }
            
            window.location.href = url;
        }
        
        function sortProducts() {
            const sortSelect = document.getElementById('sortBy');
            const sortBy = sortSelect.value;
            const productContainer = document.querySelector('.product__container');
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
                
                fetch(this.action, {
                    method: 'POST',
                    body: new FormData(this)
                })
                .then(response => {
                    if (response.ok) {
                        button.textContent = 'Added!';
                        button.classList.remove('btn--primary');
                        button.classList.add('btn--success');
                        
                        // Update cart count if function exists
                        if (window.updateCartCount) {
                            // This would need to be implemented to get actual cart count
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
                    button.textContent = 'Error';
                    button.classList.add('btn--error');
                    
                    setTimeout(() => {
                        button.textContent = originalText;
                        button.classList.remove('btn--error');
                        button.disabled = false;
                    }, 2000);
                });
            });
        });
    </script>
</body>
</html>