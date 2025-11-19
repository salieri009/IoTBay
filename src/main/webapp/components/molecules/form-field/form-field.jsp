<%--
  ============================================
  Molecule: Form Field
  ============================================
  
  Description:
    Combines label, input, and error message into a reusable form field.
    Follows Atomic Design Pattern - composed of atoms.
  
  Parameters:
    - label (string, required): Field label text
    - name (string, required): Input name attribute
    - type (string): Input type (default: 'text')
    - value (string): Input value
    - placeholder (string): Placeholder text
    - required (boolean): Required field
    - error (boolean): Error state
    - errorMessage (string): Error message
    - helpText (string): Help text below input
    - id (string): Input id (defaults to name)
  
  Dependencies:
    - atoms/label/label.jsp
    - atoms/input/input.jsp
  
  Usage:
    <jsp:include page="/components/molecules/form-field/form-field.jsp">
      <jsp:param name="label" value="Email Address" />
      <jsp:param name="name" value="email" />
      <jsp:param name="type" value="email" />
      <jsp:param name="required" value="true" />
    </jsp:include>
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String label = request.getParameter("label");
  String name = request.getParameter("name");
  String type = request.getParameter("type") != null ? request.getParameter("type") : "text";
  String value = request.getParameter("value");
  String placeholder = request.getParameter("placeholder");
  boolean required = "true".equalsIgnoreCase(request.getParameter("required"));
  boolean error = "true".equalsIgnoreCase(request.getParameter("error"));
  String errorMessage = request.getParameter("errorMessage");
  String helpText = request.getParameter("helpText");
  String id = request.getParameter("id");
  
  if (id == null && name != null) {
    id = name;
  }
  
  String fieldId = id != null ? id : name;
  String errorId = fieldId + "-error";
  String helpId = fieldId + "-help";
%>

<div class="form-field">
  <%-- Label Atom --%>
  <jsp:include page="/components/atoms/label/label.jsp">
    <jsp:param name="text" value="${label}" />
    <jsp:param name="for" value="${fieldId}" />
    <jsp:param name="required" value="${required ? 'true' : 'false'}" />
  </jsp:include>
  
  <%-- Input Atom --%>
  <jsp:include page="/components/atoms/input/input.jsp">
    <jsp:param name="type" value="${type}" />
    <jsp:param name="name" value="${name}" />
    <jsp:param name="id" value="${fieldId}" />
    <jsp:param name="value" value="${value}" />
    <jsp:param name="placeholder" value="${placeholder}" />
    <jsp:param name="required" value="${required ? 'true' : 'false'}" />
    <jsp:param name="error" value="${error ? 'true' : 'false'}" />
    <jsp:param name="errorMessage" value="${errorMessage}" />
    <jsp:param name="ariaDescribedBy" value="${error ? errorId : (helpText != null ? helpId : '')}" />
  </jsp:include>
  
  <%-- Help Text --%>
  <c:if test="${!empty helpText}">
    <div class="form-help" id="${helpId}">
      ${helpText}
    </div>
  </c:if>
</div>

