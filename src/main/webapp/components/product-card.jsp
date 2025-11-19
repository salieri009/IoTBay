<%--
  ============================================
  LEGACY PRODUCT CARD - DEPRECATED
  ============================================
  
  This file is deprecated and maintained for backward compatibility.
  All new code should use: /components/molecules/product-card/product-card.jsp
  
  Migration Guide:
  - Old: <jsp:include page="components/product-card.jsp">
  - New: <jsp:include page="/components/molecules/product-card/product-card.jsp">
  
  Parameters remain the same:
  - product: Product object
  - showQuickView: boolean (optional, default: true)
  - cardSize: string (sm, md, lg - maps to small, medium, large)
  - showWishlist: boolean (optional, default: true)
  ============================================
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  // Map legacy cardSize to new size values
  String cardSize = request.getParameter("cardSize");
  if (cardSize != null) {
    if ("sm".equals(cardSize)) cardSize = "small";
    else if ("md".equals(cardSize)) cardSize = "medium";
    else if ("lg".equals(cardSize)) cardSize = "large";
    else cardSize = "medium"; // default
  } else {
    cardSize = "medium";
  }
  
  // Set product in request scope for new component
  Object product = request.getAttribute("product");
  if (product == null) {
    product = request.getParameter("product");
  }
  if (product != null) {
    request.setAttribute("product", product);
  }
%>

<%-- Redirect to new Atomic Design product card component --%>
<jsp:include page="/components/molecules/product-card/product-card.jsp">
  <jsp:param name="showQuickView" value="${param.showQuickView != null ? param.showQuickView : 'true'}" />
  <jsp:param name="showWishlist" value="${param.showWishlist != null ? param.showWishlist : 'false'}" />
  <jsp:param name="size" value="<%= cardSize %>" />
</jsp:include>
