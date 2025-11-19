<%--
  ============================================
  Molecule: Accordion
  ============================================
  
  Description:
    Progressive disclosure component for hiding/showing content.
    Used for product specifications, FAQs, and complex information.
  
  Parameters:
    - id (string, required): Unique ID
    - title (string, required): Accordion title
    - open (boolean): Initially open (default: false)
    - icon (string): Icon name (optional)
  
  Usage:
    <jsp:include page="/components/molecules/accordion/accordion.jsp">
      <jsp:param name="id" value="specs-accordion" />
      <jsp:param name="title" value="Technical Specifications" />
    </jsp:include>
      <!-- Accordion content here -->
    </jsp:include>
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String id = request.getParameter("id");
  String title = request.getParameter("title");
  boolean open = "true".equalsIgnoreCase(request.getParameter("open"));
  String icon = request.getParameter("icon");
  
  if (id == null) {
    id = "accordion-" + System.currentTimeMillis();
  }
  
  String buttonId = id + "-button";
  String panelId = id + "-panel";
%>

<div class="accordion" data-accordion-id="<%= id %>">
  <h3 class="accordion-header">
    <button id="<%= buttonId %>"
            class="accordion-button <c:if test="${open}">accordion-button--open</c:if>"
            type="button"
            aria-expanded="${open}"
            aria-controls="<%= panelId %>"
            data-accordion-toggle="<%= id %>">
      <c:if test="${!empty icon}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
          <jsp:param name="size" value="small" />
        </jsp:include>
      </c:if>
      <span class="accordion-title">${title}</span>
      <jsp:include page="/components/atoms/icon/icon.jsp">
        <jsp:param name="name" value="chevron-down" />
        <jsp:param name="size" value="small" />
        <jsp:param name="ariaHidden" value="true" />
      </jsp:include>
    </button>
  </h3>
  
  <div id="<%= panelId %>"
       class="accordion-panel <c:if test="${open}">accordion-panel--open</c:if>"
       role="region"
       aria-labelledby="<%= buttonId %>"
       aria-hidden="${!open}">
    <div class="accordion-content">
      <jsp:doBody/>
    </div>
  </div>
</div>

<script>
(function() {
  const accordionId = '<%= id %>';
  const button = document.getElementById('<%= buttonId %>');
  const panel = document.getElementById('<%= panelId %>');
  
  if (!button || !panel) return;
  
  button.addEventListener('click', function() {
    const isOpen = button.getAttribute('aria-expanded') === 'true';
    
    button.setAttribute('aria-expanded', !isOpen);
    button.classList.toggle('accordion-button--open');
    panel.setAttribute('aria-hidden', isOpen);
    panel.classList.toggle('accordion-panel--open');
  });
})();
</script>

