<%--
  ============================================
  Atom: Icon
  ============================================
  
  Description:
    Reusable icon component using SVG sprites or inline SVG.
  
  Parameters:
    - name (string, required): Icon name (e.g., 'search', 'cart', 'user')
    - size (string): 'small', 'medium', 'large' (default: 'medium')
    - ariaLabel (string): Accessibility label
    - ariaHidden (boolean): Hide from screen readers (default: true for decorative icons)
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String name = request.getParameter("name");
  String size = request.getParameter("size") != null ? request.getParameter("size") : "medium";
  String ariaLabel = request.getParameter("ariaLabel");
  boolean ariaHidden = !"false".equalsIgnoreCase(request.getParameter("ariaHidden"));
  
  String iconClass = "inline-block fill-current ";
  if ("small".equals(size)) {
      iconClass += "w-4 h-4";
  } else if ("large".equals(size)) {
      iconClass += "w-6 h-6";
  } else if ("xlarge".equals(size)) {
      iconClass += "w-8 h-8";
  } else {
      iconClass += "w-5 h-5";
  }
%>

<span class="${iconClass}" 
      <c:if test="${ariaHidden}">aria-hidden="true"</c:if>
      <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
      role="img">
  <%-- Icon SVG will be inserted here --%>
  <%-- For now, using a placeholder - implement with actual SVG sprites or inline SVG --%>
  <svg class="w-full h-full" viewBox="0 0 24 24" fill="currentColor">
    <use href="#icon-${name}" />
  </svg>
</span>

