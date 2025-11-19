<%--
  ============================================
  Atom: Skeleton Loader
  ============================================
  
  Description:
    Skeleton loading component for better perceived performance.
    Shows placeholder content while data loads.
  
  Parameters:
    - type (string): 'text', 'image', 'card', 'button', 'list' (default: 'text')
    - width (string): Width (e.g., '100%', '200px', '50%')
    - height (string): Height (e.g., '20px', '100px')
    - lines (number): Number of lines for text type (default: 1)
    - rounded (boolean): Rounded corners (default: false)
  
  Usage:
    <jsp:include page="/components/atoms/skeleton/skeleton.jsp">
      <jsp:param name="type" value="card" />
    </jsp:include>
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String type = request.getParameter("type") != null ? request.getParameter("type") : "text";
  String width = request.getParameter("width") != null ? request.getParameter("width") : "100%";
  String height = request.getParameter("height") != null ? request.getParameter("height") : "1rem";
  int lines = 1;
  try {
    lines = Integer.parseInt(request.getParameter("lines") != null ? request.getParameter("lines") : "1");
  } catch (NumberFormatException e) {
    lines = 1;
  }
  boolean rounded = "true".equalsIgnoreCase(request.getParameter("rounded"));
  
  String skeletonClass = "skeleton skeleton--" + type;
  if (rounded) {
    skeletonClass += " skeleton--rounded";
  }
%>

<c:choose>
  <c:when test="${type == 'text'}">
    <div class="skeleton-text" style="width: ${width};">
      <c:forEach var="i" begin="1" end="<%= lines %>">
        <div class="${skeletonClass}" 
             style="width: ${i == lines && lines > 1 ? '80%' : '100%'}; height: ${height}; margin-bottom: ${i < lines ? '0.5rem' : '0'};"></div>
      </c:forEach>
    </div>
  </c:when>
  
  <c:when test="${type == 'image'}">
    <div class="${skeletonClass}" 
         style="width: ${width}; height: ${height};"></div>
  </c:when>
  
  <c:when test="${type == 'card'}">
    <div class="skeleton-card">
      <div class="skeleton skeleton--image" style="width: 100%; height: 200px; margin-bottom: 1rem;"></div>
      <div class="skeleton skeleton--text" style="width: 100%; height: 1rem; margin-bottom: 0.5rem;"></div>
      <div class="skeleton skeleton--text" style="width: 80%; height: 1rem; margin-bottom: 0.5rem;"></div>
      <div class="skeleton skeleton--text" style="width: 60%; height: 1rem;"></div>
    </div>
  </c:when>
  
  <c:when test="${type == 'button'}">
    <div class="${skeletonClass}" 
         style="width: ${width}; height: ${height};"></div>
  </c:when>
  
  <c:when test="${type == 'list'}">
    <div class="skeleton-list">
      <c:forEach var="i" begin="1" end="<%= lines %>">
        <div class="skeleton-list-item" style="margin-bottom: ${i < lines ? '1rem' : '0'};">
          <div class="skeleton skeleton--image" style="width: 60px; height: 60px; display: inline-block; margin-right: 1rem; vertical-align: top;"></div>
          <div style="display: inline-block; width: calc(100% - 80px);">
            <div class="skeleton skeleton--text" style="width: 100%; height: 1rem; margin-bottom: 0.5rem;"></div>
            <div class="skeleton skeleton--text" style="width: 70%; height: 0.875rem;"></div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:when>
  
  <c:otherwise>
    <div class="${skeletonClass}" 
         style="width: ${width}; height: ${height};"></div>
  </c:otherwise>
</c:choose>

