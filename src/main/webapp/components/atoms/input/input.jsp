<%--
  ============================================
  Atom: Input
  ============================================
  
  Description:
    Reusable form input component following Atomic Design Pattern.
  
  Parameters:
    - type (string): Input type - 'text', 'email', 'password', 'number', etc. (default: 'text')
    - name (string, required): Input name attribute
    - id (string): Input id attribute
    - value (string): Input value
    - placeholder (string): Placeholder text
    - required (boolean): Required field (default: false)
    - disabled (boolean): Disabled state (default: false)
    - readonly (boolean): Readonly state (default: false)
    - error (boolean): Error state (default: false)
    - errorMessage (string): Error message to display
    - ariaLabel (string): Accessibility label
    - ariaDescribedBy (string): ID of element describing this input
    - autocomplete (string): Autocomplete attribute
    - pattern (string): Validation pattern
    - min (string): Minimum value (for number/date)
    - max (string): Maximum value (for number/date)
    - step (string): Step value (for number)
  
  CSS Classes:
    - .input: Base input class
    - .input--error: Error state
    - .input--success: Success state
  
  Design System:
    - Uses 4px-based spacing (padding: var(--space-3) var(--space-4))
    - Single font family (--font-family)
    - CTA color for focus state
  
  Dependencies: None (Atom level)
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String type = request.getParameter("type") != null ? request.getParameter("type") : "text";
  String name = request.getParameter("name");
  String id = request.getParameter("id");
  String value = request.getParameter("value");
  String placeholder = request.getParameter("placeholder");
  boolean required = "true".equalsIgnoreCase(request.getParameter("required"));
  boolean disabled = "true".equalsIgnoreCase(request.getParameter("disabled"));
  boolean readonly = "true".equalsIgnoreCase(request.getParameter("readonly"));
  boolean error = "true".equalsIgnoreCase(request.getParameter("error"));
  String errorMessage = request.getParameter("errorMessage");
  String ariaLabel = request.getParameter("ariaLabel");
  String ariaDescribedBy = request.getParameter("ariaDescribedBy");
  String autocomplete = request.getParameter("autocomplete");
  String pattern = request.getParameter("pattern");
  String min = request.getParameter("min");
  String max = request.getParameter("max");
  String step = request.getParameter("step");
  
  String inputClass = "input";
  if (error) {
    inputClass += " input--error";
  }
  
  if (id == null && name != null) {
    id = name;
  }
%>

<div class="input-wrapper">
  <input type="${type}"
         <c:if test="${!empty name}">name="${name}"</c:if>
         <c:if test="${!empty id}">id="${id}"</c:if>
         <c:if test="${!empty value}">value="${value}"</c:if>
         <c:if test="${!empty placeholder}">placeholder="${placeholder}"</c:if>
         <c:if test="${required}">required</c:if>
         <c:if test="${disabled}">disabled</c:if>
         <c:if test="${readonly}">readonly</c:if>
         <c:if test="${!empty autocomplete}">autocomplete="${autocomplete}"</c:if>
         <c:if test="${!empty pattern}">pattern="${pattern}"</c:if>
         <c:if test="${!empty min}">min="${min}"</c:if>
         <c:if test="${!empty max}">max="${max}"</c:if>
         <c:if test="${!empty step}">step="${step}"</c:if>
         class="${inputClass}"
         <c:if test="${!empty ariaLabel}">aria-label="${ariaLabel}"</c:if>
         <c:if test="${!empty ariaDescribedBy}">aria-describedby="${ariaDescribedBy}"</c:if>
         <c:if test="${error && !empty errorMessage}">aria-invalid="true"</c:if> />
  
  <c:if test="${error && !empty errorMessage}">
    <div class="input-error" id="${id}-error" role="alert">
      ${errorMessage}
    </div>
  </c:if>
</div>

