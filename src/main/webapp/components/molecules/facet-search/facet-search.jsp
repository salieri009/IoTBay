<%--
  ============================================
  Molecule: Facet Search
  ============================================
  
  Description:
    Faceted search component with immediate feedback.
    Used in browse page for filtering products.
  
  Parameters:
    - id (string): Unique ID
    - categories (List): Available categories
    - priceRange (object): Price range filter
    - onFilterChange (string): JavaScript callback function name
  
  Dependencies:
    - atoms/input/input.jsp
    - atoms/button/button.jsp
    - molecules/accordion/accordion.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String id = request.getParameter("id") != null ? request.getParameter("id") : "facet-search";
  String onFilterChange = request.getParameter("onFilterChange") != null ? request.getParameter("onFilterChange") : "handleFilterChange";
%>

<div class="facet-search" id="<%= id %>" role="search" aria-label="Product filters">
  <%-- Price Range --%>
  <jsp:include page="/components/molecules/accordion/accordion.jsp">
    <jsp:param name="id" value="<%= id %>-price" />
    <jsp:param name="title" value="Price Range" />
    <jsp:param name="open" value="false" />
  </jsp:include>
    <div class="facet-search__price-range">
      <div class="facet-search__price-inputs">
        <jsp:include page="/components/atoms/input/input.jsp">
          <jsp:param name="type" value="number" />
          <jsp:param name="name" value="priceMin" />
          <jsp:param name="id" value="<%= id %>-price-min" />
          <jsp:param name="placeholder" value="Min" />
          <jsp:param name="ariaLabel" value="Minimum price" />
        </jsp:include>
        <span class="facet-search__price-separator">to</span>
        <jsp:include page="/components/atoms/input/input.jsp">
          <jsp:param name="type" value="number" />
          <jsp:param name="name" value="priceMax" />
          <jsp:param name="id" value="<%= id %>-price-max" />
          <jsp:param name="placeholder" value="Max" />
          <jsp:param name="ariaLabel" value="Maximum price" />
        </jsp:include>
      </div>
      <jsp:include page="/components/atoms/button/button.jsp">
        <jsp:param name="text" value="Apply" />
        <jsp:param name="type" value="primary" />
        <jsp:param name="size" value="small" />
        <jsp:param name="onclick" value="<%= onFilterChange %>('price')" />
      </jsp:include>
    </div>
  </jsp:include>
  
  <%-- Categories --%>
  <jsp:include page="/components/molecules/accordion/accordion.jsp">
    <jsp:param name="id" value="<%= id %>-category" />
    <jsp:param name="title" value="Category" />
    <jsp:param name="open" value="false" />
  </jsp:include>
    <div class="facet-search__categories" role="group" aria-label="Product categories">
      <c:forEach var="category" items="${categories}">
        <label class="facet-search__checkbox-label">
          <input type="checkbox" 
                 name="category" 
                 value="${category.id}"
                 class="facet-search__checkbox"
                 onchange="<%= onFilterChange %>('category')"
                 aria-label="Filter by ${category.name}">
          <span class="facet-search__checkbox-text">${category.name}</span>
          <span class="facet-search__checkbox-count" aria-label="${category.count} products">(${category.count})</span>
        </label>
      </c:forEach>
    </div>
  </jsp:include>
  
  <%-- Stock Status --%>
  <jsp:include page="/components/molecules/accordion/accordion.jsp">
    <jsp:param name="id" value="<%= id %>-stock" />
    <jsp:param name="title" value="Stock Status" />
    <jsp:param name="open" value="false" />
  </jsp:include>
    <div class="facet-search__stock" role="group" aria-label="Stock status">
      <label class="facet-search__radio-label">
        <input type="radio" 
               name="stock" 
               value="all"
               class="facet-search__radio"
               checked
               onchange="<%= onFilterChange %>('stock')"
               aria-label="Show all products">
        <span class="facet-search__radio-text">All Products</span>
      </label>
      <label class="facet-search__radio-label">
        <input type="radio" 
               name="stock" 
               value="in-stock"
               class="facet-search__radio"
               onchange="<%= onFilterChange %>('stock')"
               aria-label="Show only in-stock products">
        <span class="facet-search__radio-text">In Stock Only</span>
      </label>
      <label class="facet-search__radio-label">
        <input type="radio" 
               name="stock" 
               value="low-stock"
               class="facet-search__radio"
               onchange="<%= onFilterChange %>('stock')"
               aria-label="Show only low stock products">
        <span class="facet-search__radio-text">Low Stock</span>
      </label>
    </div>
  </jsp:include>
  
  <%-- Clear Filters --%>
  <jsp:include page="/components/atoms/button/button.jsp">
    <jsp:param name="text" value="Clear All Filters" />
    <jsp:param name="type" value="outline" />
    <jsp:param name="size" value="medium" />
    <jsp:param name="fullWidth" value="true" />
    <jsp:param name="onclick" value="clearAllFilters('<%= id %>')" />
  </jsp:include>
</div>

<script>
function clearAllFilters(facetId) {
  const facet = document.getElementById(facetId);
  if (!facet) return;
  
  // Clear all inputs
  facet.querySelectorAll('input[type="checkbox"]').forEach(cb => cb.checked = false);
  facet.querySelectorAll('input[type="radio"]').forEach(radio => {
    if (radio.value === 'all') radio.checked = true;
    else radio.checked = false;
  });
  facet.querySelectorAll('input[type="number"]').forEach(input => input.value = '');
  
  // Trigger filter change
  if (typeof handleFilterChange === 'function') {
    handleFilterChange('clear');
  }
}
</script>

