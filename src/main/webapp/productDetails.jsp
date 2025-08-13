<%@ page import="model.Product, model.User" %>
<%
    Product product = (Product) request.getAttribute("product");
    User currentUser = (User) session.getAttribute("user");
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> - IoT Bay</title>
    <link rel="stylesheet" href="css/modern-theme.css"/>
</head>
<body>
    <jsp:include page="components/header.jsp" />

    <main class="product-detail-page">
        <div class="container">
            <!-- Breadcrumb Navigation -->
            <nav class="breadcrumb">
                <a href="index.jsp" class="breadcrumb__link">Home</a>
                <span class="breadcrumb__separator">/</span>
                <a href="search" class="breadcrumb__link">Products</a>
                <span class="breadcrumb__separator">/</span>
                <span class="breadcrumb__current"><%= product.getName() %></span>
            </nav>

            <div class="product-detail">
                <!-- Product Images Section -->
                <div class="product-detail__gallery">
                    <div class="product-gallery">
                        <div class="product-gallery__main">
                            <img src="<%= product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? product.getImageUrl() : "images/default-product.png" %>" 
                                 alt="<%= product.getName() %>" 
                                 class="product-gallery__image"
                                 id="mainProductImage"
                                 onerror="this.onerror=null;this.src='images/default-product.png';"/>
                        </div>
                        <!-- Additional product images could go here -->
                    </div>
                </div>

                <!-- Product Information Section -->
                <div class="product-detail__info">
                    <div class="product-info">
                        <h1 class="product-info__title"><%= product.getName() %></h1>
                        <div class="product-info__price">
                            <span class="price-current">$<%= String.format("%.2f", product.getPrice()) %></span>
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

