<%--
  ============================================
  MOLECULE: CATEGORY CARD
  ============================================
  
  Description: Displays a category with icon, title, list of sub-items, and a link.
  
  Parameters:
  - href: Link URL
  - title: Category Title
  - iconColorClass: CSS class for icon background (e.g., bg-brand-primary-100)
  - iconTextClass: CSS class for icon text color (e.g., text-brand-primary)
  - iconSvgPath: SVG path data
  - subItems: Comma-separated list of sub-items
  ============================================
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="href" value="${param.href}" />
<c:set var="title" value="${param.title}" />
<c:set var="iconColorClass" value="${param.iconColorClass}" />
<c:set var="iconTextClass" value="${param.iconTextClass}" />
<c:set var="iconSvgPath" value="${param.iconSvgPath}" />

<a href="${href}" 
   class="category-card group bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 p-6 border border-neutral-200 hover:border-brand-primary">
    <div class="category-card__icon mb-4">
        <div class="w-16 h-16 ${iconColorClass} rounded-lg flex items-center justify-center group-hover:bg-brand-primary group-hover:scale-110 transition-all duration-300">
            <svg class="w-8 h-8 ${iconTextClass} group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="${iconSvgPath}"/>
            </svg>
        </div>
    </div>
    <h3 class="text-xl font-semibold text-neutral-900 mb-2">${title}</h3>
    <ul class="text-sm text-neutral-600 space-y-1 mb-4">
        <c:forTokens items="${param.subItems}" delims="," var="item">
            <li>${fn:trim(item)}</li>
        </c:forTokens>
    </ul>
    <span class="text-brand-primary font-medium group-hover:underline inline-flex items-center">
        Explore →
    </span>
</a>
