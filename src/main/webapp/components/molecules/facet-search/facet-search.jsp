<%--
  ============================================
  Molecule: Facet Search
  ============================================
  
  Description:
    Faceted search component with immediate feedback.
    Refactored to use Tailwind CSS and native details/summary.
  
  Parameters:
    - id (string): Unique ID
    - categories (List): Available categories
    - priceRange (object): Price range filter
    - onFilterChange (string): JavaScript callback function name
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String id = request.getParameter("id") != null ? request.getParameter("id") : "facet-search";
  String onFilterChange = request.getParameter("onFilterChange") != null ? request.getParameter("onFilterChange") : "handleFilterChange";
%>

<div class="space-y-1" id="<%= id %>" role="search" aria-label="Product filters">
  
  <%-- Price Range --%>
  <details class="group py-4 border-b border-neutral-200" open>
    <summary class="flex items-center justify-between font-medium text-neutral-900 cursor-pointer list-none select-none">
      <span>Price Range</span>
      <span class="transition group-open:rotate-180">
        <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
      </span>
    </summary>
    <div class="text-neutral-600 mt-4 group-open:animate-fadeIn">
      <div class="flex items-center gap-2 mb-3">
        <div class="relative flex-1">
          <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-neutral-500">$</span>
          <input type="number" name="priceMin" id="<%= id %>-price-min" placeholder="Min" 
                 class="w-full pl-7 pr-3 py-2 border border-neutral-300 rounded-lg text-sm focus:ring-brand-primary focus:border-brand-primary"
                 aria-label="Minimum price">
        </div>
        <span class="text-neutral-400">-</span>
        <div class="relative flex-1">
          <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-neutral-500">$</span>
          <input type="number" name="priceMax" id="<%= id %>-price-max" placeholder="Max" 
                 class="w-full pl-7 pr-3 py-2 border border-neutral-300 rounded-lg text-sm focus:ring-brand-primary focus:border-brand-primary"
                 aria-label="Maximum price">
        </div>
      </div>
      <button type="button" onclick="<%= onFilterChange %>('price')" 
              class="w-full py-2 px-4 bg-neutral-100 hover:bg-neutral-200 text-neutral-900 text-sm font-medium rounded-lg transition-colors">
        Apply Price
      </button>
    </div>
  </details>
  
  <%-- Categories --%>
  <details class="group py-4 border-b border-neutral-200" open>
    <summary class="flex items-center justify-between font-medium text-neutral-900 cursor-pointer list-none select-none">
      <span>Category</span>
      <span class="transition group-open:rotate-180">
        <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
      </span>
    </summary>
    <div class="text-neutral-600 mt-4 space-y-2 group-open:animate-fadeIn" role="group" aria-label="Product categories">
      <c:forEach var="category" items="${categories}">
        <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
          <input type="checkbox" 
                 name="category" 
                 value="${category.id}"
                 class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary"
                 onchange="<%= onFilterChange %>('category')"
                 aria-label="Filter by ${category.name}">
          <span class="flex-1 text-sm">${category.name}</span>
          <span class="text-xs text-neutral-400 bg-neutral-100 px-2 py-0.5 rounded-full">(${category.count})</span>
        </label>
      </c:forEach>
      <%-- Fallback if no categories --%>
      <c:if test="${empty categories}">
        <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
          <input type="checkbox" name="category" value="industrial" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('category')">
          <span class="flex-1 text-sm">Industrial</span>
        </label>
        <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
          <input type="checkbox" name="category" value="smarthome" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('category')">
          <span class="flex-1 text-sm">Smart Home</span>
        </label>
      </c:if>
    </div>
  </details>
  
  <%-- Protocol --%>
  <details class="group py-4 border-b border-neutral-200">
    <summary class="flex items-center justify-between font-medium text-neutral-900 cursor-pointer list-none select-none">
      <span>Protocol</span>
      <span class="transition group-open:rotate-180">
        <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
      </span>
    </summary>
    <div class="text-neutral-600 mt-4 space-y-2 group-open:animate-fadeIn" role="group" aria-label="Communication protocols">
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="protocol" value="wifi" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('protocol')">
        <span class="text-sm">Wi-Fi</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="protocol" value="bluetooth" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('protocol')">
        <span class="text-sm">Bluetooth / BLE</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="protocol" value="lorawan" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('protocol')">
        <span class="text-sm">LoRaWAN</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="protocol" value="zigbee" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('protocol')">
        <span class="text-sm">Zigbee</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="protocol" value="mqtt" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('protocol')">
        <span class="text-sm">MQTT</span>
      </label>
    </div>
  </details>

  <%-- Use Case --%>
  <details class="group py-4 border-b border-neutral-200">
    <summary class="flex items-center justify-between font-medium text-neutral-900 cursor-pointer list-none select-none">
      <span>Use Case</span>
      <span class="transition group-open:rotate-180">
        <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
      </span>
    </summary>
    <div class="text-neutral-600 mt-4 space-y-2 group-open:animate-fadeIn" role="group" aria-label="Use cases">
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="usecase" value="monitoring" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('usecase')">
        <span class="text-sm">Monitoring</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="usecase" value="automation" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('usecase')">
        <span class="text-sm">Automation</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="checkbox" name="usecase" value="tracking" class="w-4 h-4 text-brand-primary border-neutral-300 rounded focus:ring-brand-primary" onchange="<%= onFilterChange %>('usecase')">
        <span class="text-sm">Asset Tracking</span>
      </label>
    </div>
  </details>

  <%-- Stock Status --%>
  <details class="group py-4 border-b border-neutral-200">
    <summary class="flex items-center justify-between font-medium text-neutral-900 cursor-pointer list-none select-none">
      <span>Stock Status</span>
      <span class="transition group-open:rotate-180">
        <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
      </span>
    </summary>
    <div class="text-neutral-600 mt-4 space-y-2 group-open:animate-fadeIn" role="group" aria-label="Stock status">
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="radio" name="stock" value="all" class="w-4 h-4 text-brand-primary border-neutral-300 focus:ring-brand-primary" checked onchange="<%= onFilterChange %>('stock')">
        <span class="text-sm">All Items</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="radio" name="stock" value="in-stock" class="w-4 h-4 text-brand-primary border-neutral-300 focus:ring-brand-primary" onchange="<%= onFilterChange %>('stock')">
        <span class="text-sm">In Stock Only</span>
      </label>
      <label class="flex items-center gap-3 cursor-pointer hover:text-brand-primary transition-colors">
        <input type="radio" name="stock" value="on-sale" class="w-4 h-4 text-brand-primary border-neutral-300 focus:ring-brand-primary" onchange="<%= onFilterChange %>('stock')">
        <span class="text-sm">On Sale</span>
      </label>
    </div>
</details>
  
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

