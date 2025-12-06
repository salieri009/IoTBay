<%--============================================Atom: Input============================================Description:
  Reusable form input component following Atomic Design Pattern. Parameters: - type (string): Input type - 'text'
  , 'email' , 'password' , 'number' , etc. (default: 'text' ) - name (string, required): Input name attribute - id
  (string): Input id attribute - value (string): Input value - placeholder (string): Placeholder text - required
  (boolean): Required field (default: false) - disabled (boolean): Disabled state (default: false) - readonly (boolean):
  Readonly state (default: false) - error (boolean): Error state (default: false) - errorMessage (string): Error message
  to display - ariaLabel (string): Accessibility label - ariaDescribedBy (string): ID of element describing this input -
  autocomplete (string): Autocomplete attribute - pattern (string): Validation pattern - min (string): Minimum value
  (for number/date) - max (string): Maximum value (for number/date) - step (string): Step value (for number) CSS
  Classes: - .input: Base input class - .input--error: Error state - .input--success: Success state Design System: -
  Uses 4px-based spacing (padding: var(--space-3) var(--space-4)) - Single font family (--font-family) - CTA color for
  focus state Dependencies: None (Atom level) Last Updated: 2025 --%>

  <%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <% String type=request.getParameter("type") !=null ? request.getParameter("type") : "text" ; String
          name=request.getParameter("name"); String id=request.getParameter("id"); String
          value=request.getParameter("value"); String placeholder=request.getParameter("placeholder"); boolean
          required="true" .equalsIgnoreCase(request.getParameter("required")); boolean disabled="true"
          .equalsIgnoreCase(request.getParameter("disabled")); boolean readonly="true"
          .equalsIgnoreCase(request.getParameter("readonly")); boolean error="true"
          .equalsIgnoreCase(request.getParameter("error")); String errorMessage=request.getParameter("errorMessage");
          String ariaLabel=request.getParameter("ariaLabel"); String
          ariaDescribedBy=request.getParameter("ariaDescribedBy"); String
          autocomplete=request.getParameter("autocomplete"); String pattern=request.getParameter("pattern"); String
          min=request.getParameter("min"); String max=request.getParameter("max"); String
          step=request.getParameter("step"); String attributes=request.getParameter("attributes"); String
          inputClass="input" ; if (error) { inputClass +=" input--error" ; } if (id==null && name !=null) { id=name; }
          // Expose variables to EL for safe usage pageContext.setAttribute("inputType", type !=null ? type : "text" );
          pageContext.setAttribute("inputName", name); pageContext.setAttribute("inputId", id);
          pageContext.setAttribute("inputValue", value); pageContext.setAttribute("inputPlaceholder", placeholder);
          pageContext.setAttribute("inputRequired", required); pageContext.setAttribute("inputDisabled", disabled);
          pageContext.setAttribute("inputReadonly", readonly); pageContext.setAttribute("inputError", error);
          pageContext.setAttribute("inputErrorMessage", errorMessage); pageContext.setAttribute("inputAriaLabel",
          ariaLabel); pageContext.setAttribute("inputAriaDescribedBy", ariaDescribedBy);
          pageContext.setAttribute("inputAutocomplete", autocomplete); pageContext.setAttribute("inputPattern",
          pattern); pageContext.setAttribute("inputMin", min); pageContext.setAttribute("inputMax", max);
          pageContext.setAttribute("inputStep", step); pageContext.setAttribute("inputAttributes", attributes);
          pageContext.setAttribute("inputClass", inputClass); %>

          <div class="input-wrapper">
            <input type="${inputType}" <c:if test="${!empty inputName}">name="${fn:escapeXml(inputName)}"</c:if>
            <c:if test="${!empty inputId}">id="${fn:escapeXml(inputId)}"</c:if>
            <c:if test="${!empty inputValue}">value="${fn:escapeXml(inputValue)}"</c:if>
            <c:if test="${!empty inputPlaceholder}">placeholder="${fn:escapeXml(inputPlaceholder)}"</c:if>
            <c:if test="${inputRequired}">required</c:if>
            <c:if test="${inputDisabled}">disabled</c:if>
            <c:if test="${inputReadonly}">readonly</c:if>
            <c:if test="${!empty inputAutocomplete}">autocomplete="${fn:escapeXml(inputAutocomplete)}"</c:if>
            <c:if test="${!empty inputPattern}">pattern="${fn:escapeXml(inputPattern)}"</c:if>
            <c:if test="${!empty inputMin}">min="${fn:escapeXml(inputMin)}"</c:if>
            <c:if test="${!empty inputMax}">max="${fn:escapeXml(inputMax)}"</c:if>
            <c:if test="${!empty inputStep}">step="${fn:escapeXml(inputStep)}"</c:if>
            <c:if test="${!empty inputAttributes}">${inputAttributes}</c:if>
            class="${inputClass}"
            <c:if test="${!empty inputAriaLabel}">aria-label="${fn:escapeXml(inputAriaLabel)}"</c:if>
            <c:if test="${!empty inputAriaDescribedBy}">aria-describedby="${fn:escapeXml(inputAriaDescribedBy)}"</c:if>
            <c:if test="${inputError && !empty inputErrorMessage}">aria-invalid="true"</c:if> />

            <c:if test="${inputError && !empty inputErrorMessage}">
              <div class="input-error" id="${fn:escapeXml(inputId)}-error" role="alert">
                <c:out value="${inputErrorMessage}" />
              </div>
            </c:if>
          </div>