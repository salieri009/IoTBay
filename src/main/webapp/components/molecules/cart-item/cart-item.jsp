<%--
  ============================================
  Molecule: Cart Item
  ============================================
  
  Description:
    A card component representing a single item in the shopping cart.
    Includes product image, details, price, quantity controls, and remove button.
    
  Parameters:
    - itemId: The unique ID of the cart item
    - productId: The unique ID of the product
    - productName: Name of the product
    - productDescription: Description of the product
    - productImageUrl: URL of the product image
    - price: Unit price of the product
    - quantity: Current quantity in cart
    - maxQuantity: Maximum available stock
    
  Usage:
    <jsp:include page="/components/molecules/cart-item/cart-item.jsp">
        <jsp:param name="itemId" value="${item.id}" />
        <jsp:param name="productId" value="${item.product.id}" />
        <jsp:param name="productName" value="${item.product.name}" />
        ...
    </jsp:include>
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="cart-item bg-white border border-neutral-200 rounded-lg p-4 transition-shadow hover:shadow-sm" 
     data-item-id="${param.itemId}"
     data-product-id="${param.productId}"
     role="article"
     aria-label="Cart item: ${param.productName}">
    <div class="flex flex-col sm:flex-row gap-4">
        <!-- Product Image -->
        <div class="cart-item-image flex-shrink-0">
            <a href="${pageContext.request.contextPath}/product?productId=${param.productId}" 
               class="block aspect-square w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-neutral-100 border border-neutral-200"
               aria-label="View ${param.productName} details">
                <img src="${not empty param.productImageUrl ? param.productImageUrl : 'images/default-product.png'}" 
                     alt="${param.productName}" 
                     class="w-full h-full object-cover"
                     loading="lazy"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
            </a>
        </div>
        
        <!-- Product Details -->
        <div class="flex-1 min-w-0 flex flex-col justify-between">
            <div class="flex items-start justify-between gap-4 mb-2">
                <div class="flex-1 min-w-0">
                    <h3 class="cart-item-name text-lg font-semibold text-neutral-900 mb-1 leading-tight">
                        <a href="${pageContext.request.contextPath}/product?productId=${param.productId}" 
                           class="hover:text-brand-primary transition-colors">
                            ${param.productName}
                        </a>
                    </h3>
                    <p class="cart-item-description text-sm text-neutral-600 line-clamp-2 mb-2">
                        ${param.productDescription}
                    </p>
                    <!-- Key Spec Badge (Placeholder/Optional) -->
                    <div class="flex flex-wrap gap-2 mb-3">
                        <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-brand-primary/10 text-brand-primary">
                            LoRaWAN
                        </span>
                        <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-neutral-100 text-neutral-700">
                            12V DC
                        </span>
                    </div>
                    <div class="cart-item-price text-lg font-bold text-brand-primary">
                        $<fmt:formatNumber value="${param.price}" pattern="#,##0.00" />
                    </div>
                </div>
                
                <!-- Remove Button -->
                <button 
                    class="remove-btn flex-shrink-0 p-2 text-neutral-400 hover:text-red-600 hover:bg-red-50 rounded-full transition-colors"
                    onclick="removeItem(event, ${param.itemId})" 
                    aria-label="Remove ${param.productName} from cart"
                    title="Remove item">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                        <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                </button>
            </div>
            
            <!-- Quantity Controls and Subtotal -->
            <div class="flex items-center justify-between pt-4 border-t border-neutral-100 mt-auto">
                <div class="quantity-controls flex items-center gap-3">
                    <label for="quantity-${param.itemId}" class="sr-only">Quantity for ${param.productName}</label>
                    
                    <!-- Decrease Button -->
                    <button type="button" 
                            class="w-8 h-8 flex items-center justify-center rounded-full border border-neutral-300 text-neutral-600 hover:bg-neutral-100 hover:text-neutral-900 transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary/50" 
                            onclick="updateQuantity(event, ${param.itemId}, ${param.quantity - 1})"
                            aria-label="Decrease quantity">
                        &minus;
                    </button>
                    
                    <input 
                        type="number" 
                        id="quantity-${param.itemId}"
                        value="${param.quantity}" 
                        min="1" 
                        max="${param.maxQuantity}"
                        class="quantity-value w-16 text-center border-neutral-300 rounded-md focus:ring-brand-primary focus:border-brand-primary text-neutral-900 font-medium"
                        readonly
                        aria-label="Quantity">
                        
                    <!-- Increase Button -->
                    <button type="button" 
                            class="w-8 h-8 flex items-center justify-center rounded-full border border-neutral-300 text-neutral-600 hover:bg-neutral-100 hover:text-neutral-900 transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary/50" 
                            onclick="updateQuantity(event, ${param.itemId}, ${param.quantity + 1})"
                            aria-label="Increase quantity">
                        &plus;
                    </button>
                </div>
                
                <div class="text-right">
                    <span class="block text-xs text-neutral-500 mb-1">Subtotal</span>
                    <span class="block text-lg font-bold text-neutral-900">
                        $<fmt:formatNumber value="${param.price * param.quantity}" pattern="#,##0.00" />
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
