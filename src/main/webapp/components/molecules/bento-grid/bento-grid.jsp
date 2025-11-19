<%--
  ============================================
  Molecule: Bento Grid
  ============================================
  
  Description:
    Modern Bento Grid layout for organizing content in visually appealing grid.
    Follows Z-pattern and F-pattern reading flow principles.
  
  Parameters:
    - columns (number): Number of columns (default: 4)
    - gap (string): Gap size (default: 'medium')
  
  Usage:
    <jsp:include page="/components/molecules/bento-grid/bento-grid.jsp">
      <jsp:param name="columns" value="4" />
      <jsp:param name="gap" value="medium" />
    </jsp:include>
    <!-- Then add grid items with class "bento-grid-item" -->
  
  Note: This component only provides the grid container class.
  Grid items should be added separately with class "bento-grid-item".
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  int columns = 4;
  try {
    columns = Integer.parseInt(request.getParameter("columns") != null ? request.getParameter("columns") : "4");
  } catch (NumberFormatException e) {
    columns = 4;
  }
  String gap = request.getParameter("gap") != null ? request.getParameter("gap") : "medium";
  
  String gridClass = "bento-grid bento-grid--cols-" + columns + " bento-grid--gap-" + gap;
  request.setAttribute("bentoGridClass", gridClass);
%>

<%-- Grid container will be opened by the calling page --%>

