<%--
  ============================================
  Molecule: Navigation Item
  ============================================
  
  Description:
    Navigation link component with optional icon.
    Used in header navigation menus.
  
  Parameters:
    - href (string, required): Link URL
    - text (string, required): Link text
    - icon (string): Icon name (optional)
    - active (boolean): Active state (default: false)
    - ariaLabel (string): Accessibility label
  
  Dependencies:
    - atoms/icon/icon.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String href = request.getParameter("href");
  String text = request.getParameter("text");
  String icon = request.getParameter("icon");
  boolean active = "true".equalsIgnoreCase(request.getParameter("active"));
  String ariaLabel = request.getParameter("ariaLabel");
  
  String linkClass = "nav-item";
  if (active) {
    linkClass += " nav-item--active";
  }
%>

<li role="none">
  <a href="${href}" 
     class="${linkClass}"
     role="menuitem"
     <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
     <c:if test="${active}">aria-current="page"</c:if>>
    <c:if test="${!empty icon}">
      <jsp:include page="/components/atoms/icon/icon.jsp">
        <jsp:param name="name" value="${icon}" />
        <jsp:param name="size" value="small" />
      </jsp:include>
    </c:if>
    <span>${text}</span>
  </a>
</li>

