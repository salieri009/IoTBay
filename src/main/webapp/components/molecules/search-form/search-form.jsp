<%--
  ============================================
  Molecule: Search Form
  ============================================
  
  Description:
    Search form component composed of input and button atoms.
    Used in header and search pages.
  
  Parameters:
    - action (string): Form action URL (default: '/browse.jsp')
    - method (string): Form method (default: 'get')
    - placeholder (string): Input placeholder text
    - value (string): Initial search value
    - showSuggestions (boolean): Show search suggestions dropdown (default: true)
    - id (string): Form ID (default: 'searchForm')
  
  Dependencies:
    - atoms/input/input.jsp
    - atoms/button/button.jsp
    - atoms/icon/icon.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String action = request.getParameter("action") != null ? request.getParameter("action") : "/browse.jsp";
  String method = request.getParameter("method") != null ? request.getParameter("method") : "get";
  String placeholder = request.getParameter("placeholder") != null ? request.getParameter("placeholder") : "Search IoT devices, sensors, smart home...";
  String value = request.getParameter("value");
  boolean showSuggestions = !"false".equalsIgnoreCase(request.getParameter("showSuggestions"));
  String formId = request.getParameter("id") != null ? request.getParameter("id") : "searchForm";
  String inputId = formId + "Input";
%>

<div class="search-form-wrapper" role="search" aria-label="Search products">
  <form action="${pageContext.request.contextPath}${action}" 
        method="${method}" 
        class="search-form" 
        id="${formId}">
    <label for="${inputId}" class="sr-only">Search products</label>
    <div class="search-form__wrapper">
      <%-- Search Icon (Left) --%>
      <div class="search-form__icon-left" aria-hidden="true">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="search" />
          <jsp:param name="size" value="medium" />
        </jsp:include>
      </div>
      
      <%-- Search Input (Atom) --%>
      <jsp:include page="/components/atoms/input/input.jsp">
        <jsp:param name="type" value="search" />
        <jsp:param name="name" value="q" />
        <jsp:param name="id" value="${inputId}" />
        <jsp:param name="value" value="${value}" />
        <jsp:param name="placeholder" value="${placeholder}" />
        <jsp:param name="autocomplete" value="off" />
        <jsp:param name="ariaLabel" value="Search products" />
        <jsp:param name="ariaDescribedBy" value="${formId}Help" />
      </jsp:include>
      
      <%-- Clear Button (shown when input has value) --%>
      <button type="button"
              class="search-form__clear"
              id="${formId}Clear"
              aria-label="Clear search"
              style="display: none;">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="close" />
          <jsp:param name="size" value="small" />
        </jsp:include>
        <span class="sr-only">Clear search</span>
      </button>
      
      <%-- Search Submit Button (Atom) --%>
      <jsp:include page="/components/atoms/button/button.jsp">
        <jsp:param name="text" value="Search" />
        <jsp:param name="type" value="primary" />
        <jsp:param name="size" value="medium" />
        <jsp:param name="ariaLabel" value="Submit search" />
      </jsp:include>
    </div>
    <div id="${formId}Help" class="sr-only">Press Enter to search, Arrow keys to navigate suggestions, Escape to close</div>
  </form>
  
  <c:if test="${showSuggestions}">
    <%-- Search Suggestions Dropdown --%>
    <div id="${formId}Suggestions" 
         class="search-form__suggestions" 
         role="listbox" 
         aria-label="Search suggestions" 
         aria-hidden="true"
         aria-live="polite">
      <div class="search-form__suggestions-header">
        <span class="search-form__suggestions-title">Suggestions</span>
        <kbd class="search-form__keyboard-hint" aria-label="Use arrow keys to navigate">↑↓</kbd>
      </div>
      <ul class="search-form__suggestions-list" role="list">
        <%-- Populated via JavaScript --%>
      </ul>
      <div class="search-form__suggestions-footer">
        <span class="search-form__suggestions-hint">Press <kbd>Enter</kbd> to search</span>
      </div>
    </div>
  </c:if>
</div>

