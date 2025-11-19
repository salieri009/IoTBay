<%--
  ============================================
  Atom: Label
  ============================================
  
  Description:
    Reusable form label component.
  
  Parameters:
    - text (string, required): Label text
    - for (string): ID of associated input
    - required (boolean): Show required indicator
    - id (string): Label id attribute
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String text = request.getParameter("text");
  String forAttr = request.getParameter("for");
  boolean required = "true".equalsIgnoreCase(request.getParameter("required"));
  String id = request.getParameter("id");
%>

<label <c:if test="${!empty forAttr}">for="${forAttr}"</c:if>
       <c:if test="${!empty id}">id="${id}"</c:if>
       class="label <c:if test="${required}">label--required</c:if>">
  ${text}
  <c:if test="${required}">
    <span class="label__required" aria-label="required">*</span>
  </c:if>
</label>

