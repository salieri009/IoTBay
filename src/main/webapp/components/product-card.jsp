<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 
    Product Card Component
    
    Parameters:
    - product: Product object
    - showQuickView: boolean (optional, default: true)
    - cardSize: string (sm, md, lg - optional, default: md)
    - showWishlist: boolean (optional, default: true)
--%>

<c:set var="product" value="${param.product != null ? param.product : requestScope.product}" />
<c:set var="showQuickView" value="${param.showQuickView != null ? param.showQuickView : true}" />
<c:set var="cardSize" value="${param.cardSize != null ? param.cardSize : 'md'}" />
<c:set var="showWishlist" value="${param.showWishlist != null ? param.showWishlist : true}" />

<article class="product-card product-card--${cardSize} group relative bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 overflow-hidden">
    <!-- Product Image -->
    <div class="product-card__image-container relative overflow-hidden">
        <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="block">
            <img 
                src="${pageContext.request.contextPath}/images/products/${product.image != null ? product.image : 'default-product.jpg'}" 
                alt="${product.name}"
                class="product-card__image w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300"
                loading="lazy"
            >
        </a>
        
        <!-- Product Badges -->
        <div class="product-card__badges absolute top-3 left-3 flex flex-col gap-2">
            <c:if test="${product.isNew}">
                <span class="badge badge--new">New</span>
            </c:if>
            <c:if test="${product.onSale}">
                <span class="badge badge--sale">
                    -<fmt:formatNumber value="${product.discountPercentage}" pattern="0" />%
                </span>
            </c:if>
            <c:if test="${product.stock <= 5}">
                <span class="badge badge--low-stock">Low Stock</span>
            </c:if>
        </div>
        
        <!-- Quick Actions -->
        <div class="product-card__actions absolute top-3 right-3 flex flex-col gap-2 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <c:if test="${showWishlist}">
                <button 
                    class="action-btn action-btn--wishlist" 
                    data-product-id="${product.id}"
                    aria-label="Add to wishlist"
                    title="Add to wishlist"
                >
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"/>
                    </svg>
                </button>
            </c:if>
            
            <c:if test="${showQuickView}">
                <button 
                    class="action-btn action-btn--quick-view" 
                    data-product-id="${product.id}"
                    aria-label="Quick view"
                    title="Quick view"
                >
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                        <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                    </svg>
                </button>
            </c:if>
            
            <button 
                class="action-btn action-btn--compare" 
                data-product-id="${product.id}"
                aria-label="Add to compare"
                title="Add to compare"
            >
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"/>
                </svg>
            </button>
        </div>
        
        <!-- Stock Indicator -->
        <c:if test="${product.stock == 0}">
            <div class="product-card__overlay absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                <span class="text-white font-semibold text-lg">Out of Stock</span>
            </div>
        </c:if>
    </div>
    
    <!-- Product Content -->
    <div class="product-card__content p-4">
        <!-- Category -->
        <div class="product-card__category mb-2">
            <a href="${pageContext.request.contextPath}/browse?category=${product.category}" 
               class="text-xs text-brand-primary hover:text-brand-primary-dark transition-colors">
                ${product.category}
            </a>
        </div>
        
        <!-- Product Name -->
        <h3 class="product-card__title">
            <a href="${pageContext.request.contextPath}/product?id=${product.id}" 
               class="text-neutral-900 hover:text-brand-primary transition-colors line-clamp-2">
                ${product.name}
            </a>
        </h3>
        
        <!-- Rating -->
        <div class="product-card__rating flex items-center gap-1 mb-2">
            <div class="flex items-center" aria-label="Rating: ${product.rating} out of 5 stars">
                <c:forEach var="i" begin="1" end="5">
                    <svg class="w-4 h-4 ${i <= product.rating ? 'text-yellow-400' : 'text-neutral-300'}" 
                         fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                    </svg>
                </c:forEach>
            </div>
            <span class="text-sm text-neutral-600">(${product.reviewCount})</span>
        </div>
        
        <!-- Description -->
        <c:if test="${product.shortDescription != null}">
            <p class="product-card__description text-sm text-neutral-600 mb-3 line-clamp-2">
                ${product.shortDescription}
            </p>
        </c:if>
        
        <!-- Price -->
        <div class="product-card__price mb-4">
            <c:choose>
                <c:when test="${product.onSale}">
                    <div class="flex items-center gap-2">
                        <span class="text-lg font-semibold text-error">
                            $<fmt:formatNumber value="${product.salePrice}" pattern="0.00" />
                        </span>
                        <span class="text-sm text-neutral-500 line-through">
                            $<fmt:formatNumber value="${product.price}" pattern="0.00" />
                        </span>
                    </div>
                </c:when>
                <c:otherwise>
                    <span class="text-lg font-semibold text-neutral-900">
                        $<fmt:formatNumber value="${product.price}" pattern="0.00" />
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Actions -->
        <div class="product-card__footer">
            <c:choose>
                <c:when test="${product.stock > 0}">
                    <button 
                        class="btn btn--primary w-full add-to-cart-btn" 
                        data-product-id="${product.id}"
                        data-product-name="${product.name}"
                        data-product-price="${product.onSale ? product.salePrice : product.price}"
                    >
                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"/>
                        </svg>
                        Add to Cart
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn--secondary w-full" disabled>
                        Out of Stock
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</article>
