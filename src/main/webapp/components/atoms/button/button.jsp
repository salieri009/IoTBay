<%--
  ============================================
  Atom: Button
  ============================================
  
  Description:
    Reusable button component following Atomic Design Pattern.
    Supports multiple variants, sizes, and can render as button or link.
  
  Parameters:
    - text (string, required): Button text/label
    - type (string): 'primary', 'secondary', 'outline', 'ghost' (default: 'primary')
    - size (string): 'small', 'medium', 'large' (default: 'medium')
    - href (string): If provided, renders as <a> tag instead of <button>
    - onclick (string): JavaScript onclick handler
    - disabled (boolean): Disabled state (default: false)
    - ariaLabel (string): Accessibility label
    - icon (string): Icon name to display before text (optional)
    - iconPosition (string): 'left' or 'right' (default: 'left')
    - fullWidth (boolean): Full width button (default: false)
  
  CSS Classes:
    - .btn: Base button class
    - .btn--primary: Primary CTA button (uses --color-cta)
    - .btn--secondary: Secondary button (neutral)
    - .btn--outline: Outline button
    - .btn--ghost: Ghost button (transparent)
    - .btn--sm, .btn--md, .btn--lg: Size variants
  
  Design System:
    - Uses --color-cta for primary buttons (KickoffLabs best practice)
    - Uses 4px-based spacing (padding: var(--space-3) var(--space-6))
    - Single font family (--font-family)
  
  Dependencies: None (Atom level)
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  // Parameter defaults
  String text = request.getParameter("text") != null ? request.getParameter("text") : "";
  String type = request.getParameter("type") != null ? request.getParameter("type") : "primary";
  String size = request.getParameter("size") != null ? request.getParameter("size") : "medium";
  String href = request.getParameter("href");
  String onclick = request.getParameter("onclick");
  boolean disabled = "true".equalsIgnoreCase(request.getParameter("disabled"));
  String ariaLabel = request.getParameter("ariaLabel");
  String icon = request.getParameter("icon");
  String iconPosition = request.getParameter("iconPosition") != null ? request.getParameter("iconPosition") : "left";
  boolean fullWidth = "true".equalsIgnoreCase(request.getParameter("fullWidth"));
  
  // Build CSS classes
  String buttonClass = "btn btn--" + type + " btn--" + size;
  if (fullWidth) {
    buttonClass += " btn--full";
  }
%>

<c:choose>
  <%-- Render as link if href provided --%>
  <c:when test="${!empty href}">
    <a href="${href}" 
       class="${buttonClass}"
       <c:if test="${!empty onclick}">onclick="${onclick}"</c:if>
       <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
       <c:if test="${disabled}">aria-disabled="true" tabindex="-1"</c:if>>
      <c:if test="${!empty icon && iconPosition == 'left'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
      <span>${text}</span>
      <c:if test="${!empty icon && iconPosition == 'right'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
    </a>
  </c:when>
  
  <%-- Render as button --%>
  <c:otherwise>
    <button type="button"
            class="${buttonClass}"
            <c:if test="${disabled}">disabled</c:if>
            <c:if test="${!empty onclick}">onclick="${onclick}"</c:if>
            <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
            <c:if test="${empty ariaLabel && !empty text}">aria-label="${text}"</c:if>>
      <c:if test="${!empty icon && iconPosition == 'left'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
      <span>${text}</span>
      <c:if test="${!empty icon && iconPosition == 'right'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
    </button>
  </c:otherwise>
</c:choose>

