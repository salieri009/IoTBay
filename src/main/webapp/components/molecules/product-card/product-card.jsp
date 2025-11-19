<%--
  ============================================
  Molecule: Product Card
  ============================================
  
  Description:
    Product display card composed of atoms.
    Refactored to use Tailwind CSS directly.
  
  Parameters:
    - product (Product): Product object (from request attribute or parameter)
    - showQuickView (boolean): Show quick view button (default: true)
    - showWishlist (boolean): Show wishlist button (default: false)
    - size (string): Card size - 'small', 'medium', 'large' (default: 'medium')
  
  Dependencies:
    - atoms/button/button.jsp
    - atoms/badge/badge.jsp
    - atoms/icon/icon.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  // Get product from request attribute or parameter
  Object productObj = request.getAttribute("product");
  if (productObj == null) {
    productObj = pageContext.getAttribute("product", PageContext.REQUEST_SCOPE);
  }
  
  boolean showQuickView = !"false".equalsIgnoreCase(request.getParameter("showQuickView"));
  boolean showWishlist = "true".equalsIgnoreCase(request.getParameter("showWishlist"));
  String size = request.getParameter("size") != null ? request.getParameter("size") : "medium";
  
  // Size classes could be handled here if needed, but grid usually controls width
%>

<c:if test="${product != null}">
  <div class="group relative bg-white rounded-xl shadow-sm hover:shadow-lg transition-all duration-300 border border-neutral-200 overflow-hidden flex flex-col h-full">
    <%-- Product Image --%>
    <div class="relative aspect-square bg-neutral-100 overflow-hidden">
      <a href="${pageContext.request.contextPath}/productDetails.jsp?id=${product.id}" class="block w-full h-full">
        <img src="${pageContext.request.contextPath}/images/products/${product.id}.png" 
             alt="${product.name}"
             class="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-500"
             loading="lazy"
             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
      </a>
      
      <%-- Stock Badge (Atom) --%>
      <div class="absolute top-3 left-3 z-10">
        <c:choose>
          <c:when test="${product.stockQuantity <= 0}">
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
              Out of Stock
            </span>
          </c:when>
          <c:when test="${product.stockQuantity <= 10}">
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
              Low Stock
            </span>
          </c:when>
          <c:otherwise>
            <%-- Optional: Don't show "In Stock" to keep it clean, or show "New" etc. --%>
          </c:otherwise>
        </c:choose>
      </div>
      
      <%-- Wishlist Button (Floating) --%>
      <c:if test="${showWishlist}">
        <button class="absolute top-3 right-3 p-2 rounded-full bg-white/80 backdrop-blur-sm text-neutral-500 hover:text-red-500 hover:bg-white transition-colors shadow-sm" aria-label="Add to wishlist">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
        </button>
      </c:if>
    </div>
    
    <%-- Product Info --%>
    <div class="p-4 flex-1 flex flex-col">
      <p class="text-xs text-neutral-500 mb-1 uppercase tracking-wider font-medium">${product.category}</p>
      <h3 class="text-lg font-semibold text-neutral-900 mb-2 leading-tight group-hover:text-brand-primary transition-colors line-clamp-2">
        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=${product.id}">
          ${product.name}
        </a>
      </h3>
      
      <div class="mt-auto flex items-end justify-between">
        <p class="text-xl font-bold text-neutral-900">
          <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" />
        </p>
        
        <%-- Rating (Static for now) --%>
        <div class="flex items-center gap-1 text-yellow-400 text-sm">
            <svg class="w-4 h-4 fill-current" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/></svg>
            <span class="text-neutral-400 font-medium ml-1">4.5</span>
        </div>
      </div>
    </div>
    
    <%-- Actions (Hover or Always visible on mobile) --%>
    <div class="p-4 pt-0 grid grid-cols-2 gap-3">
      <c:if test="${showQuickView}">
        <button onclick="openQuickView(${product.id})" class="w-full py-2 px-3 rounded-lg border border-neutral-200 text-sm font-medium text-neutral-700 hover:bg-neutral-50 hover:text-neutral-900 transition-colors">
          Quick View
        </button>
      </c:if>
      <button onclick="addToCart(${product.id})" class="w-full py-2 px-3 rounded-lg bg-brand-primary text-white text-sm font-medium hover:bg-brand-primary-dark transition-colors shadow-sm hover:shadow">
        Add to Cart
      </button>
    </div>
  </div>
</c:if>

