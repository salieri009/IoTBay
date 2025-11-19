<%--
  ============================================
  Molecule: Compatibility Checker
  ============================================
  
  Description:
    Interactive compatibility checker for product compatibility verification.
    Helps engineers verify if products work together.
  
  Parameters:
    - productId (string, required): Product ID to check compatibility for
    - compatibleProducts (List): List of compatible products
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String productId = request.getParameter("productId");
  if (productId == null) {
    productId = "unknown";
  }
  
  String checkerId = "compatibility-checker-" + productId;
%>

<div class="compatibility-checker" id="<%= checkerId %>" role="region" aria-label="Compatibility checker">
  <h4 class="compatibility-checker__title">Check Compatibility</h4>
  <p class="compatibility-checker__description">
    Enter product IDs or names to verify compatibility with this device.
  </p>
  
  <form class="compatibility-checker__form" onsubmit="checkCompatibility(event, '<%= productId %>')">
    <div class="compatibility-checker__input-group">
      <jsp:include page="/components/atoms/input/input.jsp">
        <jsp:param name="type" value="text" />
        <jsp:param name="name" value="compatibleProduct" />
        <jsp:param name="id" value="<%= checkerId %>-input" />
        <jsp:param name="placeholder" value="Enter product ID or name" />
        <jsp:param name="ariaLabel" value="Product to check compatibility" />
      </jsp:include>
      <jsp:include page="/components/atoms/button/button.jsp">
        <jsp:param name="text" value="Check" />
        <jsp:param name="type" value="primary" />
        <jsp:param name="size" value="medium" />
      </jsp:include>
    </div>
  </form>
  
  <div class="compatibility-checker__results" id="<%= checkerId %>-results" role="status" aria-live="polite">
    <%-- Results populated by JavaScript --%>
  </div>
  
  <%-- Quick Check: Compatible Products --%>
  <c:if test="${compatibleProducts != null && !empty compatibleProducts}">
    <div class="compatibility-checker__quick-check">
      <h5 class="compatibility-checker__quick-title">Quick Check - Known Compatible:</h5>
      <div class="compatibility-checker__quick-list">
        <c:forEach var="compatible" items="${compatibleProducts}">
          <button type="button" 
                  class="compatibility-checker__quick-item"
                  onclick="checkCompatibilityQuick('<%= productId %>', '${compatible.id}', '${compatible.name}')"
                  aria-label="Check compatibility with ${compatible.name}">
            <jsp:include page="/components/atoms/icon/icon.jsp">
              <jsp:param name="name" value="check-circle" />
              <jsp:param name="size" value="small" />
            </jsp:include>
            <span>${compatible.name}</span>
          </button>
        </c:forEach>
      </div>
    </div>
  </c:if>
</div>

<script>
function checkCompatibility(event, productId) {
  event.preventDefault();
  const input = event.target.querySelector('input[name="compatibleProduct"]');
  const productToCheck = input.value.trim();
  
  if (!productToCheck) {
    showCompatibilityResult(productId, null, 'Please enter a product ID or name.');
    return;
  }
  
  // Show loading state
  const resultsDiv = document.getElementById('compatibility-checker-' + productId + '-results');
  resultsDiv.innerHTML = '<div class="compatibility-checker__loading">Checking compatibility...</div>';
  
  // Simulate API call (replace with actual API endpoint)
  setTimeout(() => {
    // Mock compatibility check
    const isCompatible = Math.random() > 0.5; // Replace with actual check
    showCompatibilityResult(productId, isCompatible, productToCheck);
  }, 500);
}

function checkCompatibilityQuick(productId, compatibleId, compatibleName) {
  const resultsDiv = document.getElementById('compatibility-checker-' + productId + '-results');
  resultsDiv.innerHTML = `
    <div class="compatibility-checker__result compatibility-checker__result--success">
      <jsp:include page="/components/atoms/icon/icon.jsp">
        <jsp:param name="name" value="check-circle" />
        <jsp:param name="size" value="medium" />
      </jsp:include>
      <div>
        <strong>${compatibleName}</strong> is compatible with this product.
        <p class="text-sm text-neutral-600 mt-1">All features are supported.</p>
      </div>
    </div>
  `;
}

function showCompatibilityResult(productId, isCompatible, productName) {
  const resultsDiv = document.getElementById('compatibility-checker-' + productId + '-results');
  
  if (isCompatible === null) {
    resultsDiv.innerHTML = `
      <div class="compatibility-checker__result compatibility-checker__result--error">
        <span>${productName}</span>
      </div>
    `;
    return;
  }
  
  if (isCompatible) {
    resultsDiv.innerHTML = `
      <div class="compatibility-checker__result compatibility-checker__result--success">
        <svg class="w-6 h-6 text-success" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
        </svg>
        <div>
          <strong>${productName}</strong> is compatible with this product.
          <p class="text-sm text-neutral-600 mt-1">All features are supported.</p>
        </div>
      </div>
    `;
  } else {
    resultsDiv.innerHTML = `
      <div class="compatibility-checker__result compatibility-checker__result--error">
        <svg class="w-6 h-6 text-error" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
        </svg>
        <div>
          <strong>${productName}</strong> may not be fully compatible.
          <p class="text-sm text-neutral-600 mt-1">Please verify protocol and voltage requirements.</p>
        </div>
      </div>
    `;
  }
}
</script>

