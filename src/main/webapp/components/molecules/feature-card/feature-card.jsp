<%--
  ============================================
  Molecule: Feature Card
  ============================================
  
  Description:
    Displays a feature or trust indicator with an icon, title, and description.
    Used in the "Why Choose Us" section.
  
  Parameters:
    - title (string, required): The feature title
    - description (string, required): The feature description
    - iconSvgPath (string, required): The SVG path data for the icon
    - iconColorClass (string): Tailwind class for icon background color (e.g., 'bg-brand-primary-100')
    - iconTextClass (string): Tailwind class for icon text color (e.g., 'text-brand-primary')
  
  Usage:
    <jsp:include page="/components/molecules/feature-card/feature-card.jsp">
      <jsp:param name="title" value="Free Shipping" />
      <jsp:param name="description" value="On Orders $50+" />
      <jsp:param name="iconSvgPath" value="..." />
      <jsp:param name="iconColorClass" value="bg-accent-100" />
      <jsp:param name="iconTextClass" value="text-accent" />
    </jsp:include>
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String iconSvgPath = request.getParameter("iconSvgPath");
    String iconColorClass = request.getParameter("iconColorClass") != null ? request.getParameter("iconColorClass") : "bg-neutral-100";
    String iconTextClass = request.getParameter("iconTextClass") != null ? request.getParameter("iconTextClass") : "text-neutral-600";
%>

<div class="feature-card text-center p-6 bg-neutral-50 rounded-lg h-full">
    <div class="w-16 h-16 <%= iconColorClass %> rounded-full flex items-center justify-center mx-auto mb-4">
        <svg class="w-8 h-8 <%= iconTextClass %>" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
            <path fill-rule="evenodd" d="<%= iconSvgPath %>" clip-rule="evenodd"></path>
        </svg>
    </div>
    <h3 class="text-lg font-semibold text-neutral-900 mb-2"><%= title %></h3>
    <p class="text-sm text-neutral-600"><%= description %></p>
</div>
