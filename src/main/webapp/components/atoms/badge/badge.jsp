<%--
  ============================================
  Atom: Badge
  ============================================
  
  Description:
    Status badge component for displaying labels, status, or tags.
  
  Parameters:
    - text (string, required): Badge text
    - type (string): 'cta', 'success', 'warning', 'error', 'neutral' (default: 'neutral')
    - size (string): 'small', 'medium' (default: 'medium')
    - icon (string): Icon name (optional)
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String text = request.getParameter("text");
  String type = request.getParameter("type") != null ? request.getParameter("type") : "neutral";
  String size = request.getParameter("size") != null ? request.getParameter("size") : "medium";
  String icon = request.getParameter("icon");
  
  String badgeClass = "badge badge--" + type + " badge--" + size;
%>

<span class="${badgeClass}" role="status">
  <c:if test="${!empty icon}">
    <jsp:include page="/components/atoms/icon/icon.jsp">
      <jsp:param name="name" value="${icon}" />
    </jsp:include>
  </c:if>
  <span>${text}</span>
</span>

