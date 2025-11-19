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

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
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
  String extraClass = request.getParameter("extraClass");
  String attributes = request.getParameter("attributes");
  String htmlType = request.getParameter("htmlType") != null ? request.getParameter("htmlType") : "button";
  
  // Build Tailwind classes
  StringBuilder sb = new StringBuilder();
  sb.append("inline-flex items-center justify-center rounded-md font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed ");
  
  // Size
  if ("small".equals(size)) {
      sb.append("px-3 py-1.5 text-sm ");
  } else if ("large".equals(size)) {
      sb.append("px-6 py-3 text-lg ");
  } else {
      sb.append("px-4 py-2 text-base ");
  }
  
  // Type
  if ("secondary".equals(type)) {
      sb.append("bg-neutral-200 text-neutral-900 hover:bg-neutral-300 focus:ring-neutral-500 ");
  } else if ("outline".equals(type)) {
      sb.append("border border-neutral-300 text-neutral-700 hover:bg-neutral-50 focus:ring-neutral-500 ");
  } else if ("ghost".equals(type)) {
      sb.append("text-neutral-600 hover:bg-neutral-100 hover:text-neutral-900 focus:ring-neutral-500 ");
  } else if ("danger".equals(type)) {
      sb.append("bg-red-600 text-white hover:bg-red-700 focus:ring-red-500 ");
  } else { // primary
      sb.append("bg-brand-primary text-white hover:bg-brand-primary/90 focus:ring-brand-primary ");
  }
  
  if (fullWidth) {
      sb.append("w-full ");
  }
  
  if (extraClass != null) {
      sb.append(extraClass);
  }
  
  String buttonClass = sb.toString();

  // Expose values for EL access
  pageContext.setAttribute("text", text);
  pageContext.setAttribute("type", type);
  pageContext.setAttribute("size", size);
  pageContext.setAttribute("href", href);
  pageContext.setAttribute("onclick", onclick);
  pageContext.setAttribute("disabled", disabled);
  pageContext.setAttribute("ariaLabel", ariaLabel);
  pageContext.setAttribute("icon", icon);
  pageContext.setAttribute("iconPosition", iconPosition);
  pageContext.setAttribute("fullWidth", fullWidth);
  pageContext.setAttribute("extraClass", extraClass);
  pageContext.setAttribute("attributes", attributes);
  pageContext.setAttribute("htmlType", htmlType);
  pageContext.setAttribute("buttonClass", buttonClass);
%>

<c:choose>
  <%-- Render as link if href provided --%>
  <c:when test="${!empty href}">
    <a href="${href}" 
       class="${buttonClass}"
       <c:if test="${!empty onclick}">onclick="${onclick}"</c:if>
       <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
       <c:if test="${disabled}">aria-disabled="true" tabindex="-1"</c:if>
       <c:if test="${!empty attributes}">${attributes}</c:if>>
      <c:if test="${!empty icon && iconPosition == 'left'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
      <span><c:out value="${text}" /></span>
      <c:if test="${!empty icon && iconPosition == 'right'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
    </a>
  </c:when>
  
  <%-- Render as button --%>
  <c:otherwise>
    <button type="${htmlType}"
            class="${buttonClass}"
            <c:if test="${disabled}">disabled</c:if>
            <c:if test="${!empty onclick}">onclick="${onclick}"</c:if>
            <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
            <c:if test="${empty ariaLabel && !empty text}">aria-label="<c:out value='${text}' />"</c:if>
            <c:if test="${!empty attributes}">${attributes}</c:if>>
      <c:if test="${!empty icon && iconPosition == 'left'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
      <span><c:out value="${text}" /></span>
      <c:if test="${!empty icon && iconPosition == 'right'}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="${icon}" />
        </jsp:include>
      </c:if>
    </button>
  </c:otherwise>
</c:choose>

