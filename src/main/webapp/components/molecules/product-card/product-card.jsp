<%--
  ============================================
  Molecule: Product Card
  ============================================
  
  Description:
    Product display card composed of atoms.
    Refactored from existing product-card.jsp to follow Atomic Design.
  
  Parameters:
    - product (Product): Product object (from request attribute or parameter)
    - showQuickView (boolean): Show quick view button (default: true)
    - showWishlist (boolean): Show wishlist button (default: false)
    - size (string): Card size - 'small', 'medium', 'large' (default: 'medium')
  
  Dependencies:
    - atoms/button/button.jsp
    - atoms/badge/badge.jsp
    - atoms/icon/icon.jsp
  
  Usage:
    <c:set var="product" value="${product}" scope="request" />
    <jsp:include page="/components/molecules/product-card/product-card.jsp">
      <jsp:param name="showQuickView" value="true" />
    </jsp:include>
  
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
  
  String cardClass = "product-card product-card--" + size;
%>

<c:if test="${product != null}">
  <div class="${cardClass}">
    <%-- Product Image --%>
    <div class="product-card__image">
      <a href="${pageContext.request.contextPath}/productDetails.jsp?id=${product.id}">
        <img src="${pageContext.request.contextPath}/images/products/${product.id}.png" 
             alt="${product.name}"
             loading="lazy" />
      </a>
      
      <%-- Stock Badge (Atom) --%>
      <c:choose>
        <c:when test="${product.stockQuantity <= 0}">
          <jsp:include page="/components/atoms/badge/badge.jsp">
            <jsp:param name="text" value="Out of Stock" />
            <jsp:param name="type" value="error" />
            <jsp:param name="size" value="small" />
          </jsp:include>
        </c:when>
        <c:when test="${product.stockQuantity <= 10}">
          <jsp:include page="/components/atoms/badge/badge.jsp">
            <jsp:param name="text" value="Low Stock" />
            <jsp:param name="type" value="warning" />
            <jsp:param name="size" value="small" />
          </jsp:include>
        </c:when>
        <c:otherwise>
          <jsp:include page="/components/atoms/badge/badge.jsp">
            <jsp:param name="text" value="In Stock" />
            <jsp:param name="type" value="success" />
            <jsp:param name="size" value="small" />
          </jsp:include>
        </c:otherwise>
      </c:choose>
    </div>
    
    <%-- Product Info --%>
    <div class="product-card__content">
      <h3 class="product-card__name">
        <a href="${pageContext.request.contextPath}/productDetails.jsp?id=${product.id}">
          ${product.name}
        </a>
      </h3>
      <p class="product-card__category">${product.category}</p>
      <p class="product-card__price">
        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" />
      </p>
    </div>
    
    <%-- Actions --%>
    <div class="product-card__actions">
      <c:if test="${showQuickView}">
        <jsp:include page="/components/atoms/button/button.jsp">
          <jsp:param name="text" value="Quick View" />
          <jsp:param name="type" value="secondary" />
          <jsp:param name="size" value="small" />
          <jsp:param name="onclick" value="showProductModal(${product.id})" />
          <jsp:param name="ariaLabel" value="Quick view ${product.name}" />
        </jsp:include>
      </c:if>
      
      <jsp:include page="/components/atoms/button/button.jsp">
        <jsp:param name="text" value="Add to Cart" />
        <jsp:param name="type" value="primary" />
        <jsp:param name="size" value="small" />
        <jsp:param name="onclick" value="addToCart(${product.id})" />
        <jsp:param name="disabled" value="${product.stockQuantity <= 0 ? 'true' : 'false'}" />
        <jsp:param name="ariaLabel" value="Add ${product.name} to cart" />
      </jsp:include>
    </div>
  </div>
</c:if>

