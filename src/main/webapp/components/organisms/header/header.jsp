<%--
  ============================================
  Organism: Header
  ============================================
  
  Description:
    Site header composed of logo, navigation, search form, and user menu.
    Refactored to use Atomic Design components.
  
  Dependencies:
    - atoms/icon/icon.jsp
    - atoms/button/button.jsp
    - molecules/navigation-item/navigation-item.jsp
    - molecules/search-form/search-form.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.User" %>

<% 
  User user = (User) session.getAttribute("user");
  boolean isStaff = user != null && "staff".equalsIgnoreCase(user.getRole());
  String currentPath = request.getRequestURI();
%>

<header class="header" role="banner">
  <div class="container">
    <%-- Logo (Atom) --%>
    <a href="<c:url value='/' />" class="header__brand" aria-label="IoT Bay - Home">
      <img src="<c:url value='/images/logo.png' />" alt="IoT Bay Logo" class="header__brand-image" />
      <span class="header__brand-text">IoT Bay</span>
    </a>
    
    <%-- Primary Navigation --%>
    <nav id="site-navigation" class="header__nav" role="navigation" aria-label="Main navigation">
      <ul class="header__nav-list" role="menubar">
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="<c:url value='/' />" />
          <jsp:param name="text" value="Home" />
          <jsp:param name="active" value="${currentPath == '/' || currentPath.endsWith('/index.jsp') ? 'true' : 'false'}" />
        </jsp:include>
        
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="<c:url value='/browse.jsp' />" />
          <jsp:param name="text" value="Products" />
          <jsp:param name="active" value="${currentPath.contains('/browse') ? 'true' : 'false'}" />
        </jsp:include>
        
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="<c:url value='/about.jsp' />" />
          <jsp:param name="text" value="About" />
          <jsp:param name="active" value="${currentPath.contains('/about') ? 'true' : 'false'}" />
        </jsp:include>
      </ul>
    </nav>
    
    <%-- Search Form (Molecule) --%>
    <div class="header__search">
      <jsp:include page="/components/molecules/search-form/search-form.jsp">
        <jsp:param name="action" value="/browse.jsp" />
        <jsp:param name="showSuggestions" value="true" />
      </jsp:include>
    </div>
    
    <%-- User Actions --%>
    <div class="header__actions" role="toolbar" aria-label="User actions">
      <%-- Shopping Cart --%>
      <a href="<c:url value='/cart.jsp' />" 
         class="header__cart-link"
         aria-label="Shopping cart"
         aria-describedby="cartCount">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="cart" />
          <jsp:param name="size" value="large" />
        </jsp:include>
        <span id="cartCount" class="header__cart-count" aria-live="polite" aria-atomic="true">0</span>
        <span class="sr-only">items in cart</span>
      </a>
      
      <%-- User Menu --%>
      <c:choose>
        <c:when test="${user != null}">
          <div class="header__user-menu">
            <button class="header__user-trigger" 
                    onclick="toggleUserMenu()"
                    aria-expanded="false"
                    aria-haspopup="true"
                    aria-controls="userMenuDropdown"
                    aria-label="User menu for ${user.firstName} ${user.lastName}"
                    id="userMenuButton">
              <div class="header__user-avatar" aria-hidden="true">
                ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
              </div>
              <span class="header__user-name">${user.firstName}</span>
              <jsp:include page="/components/atoms/icon/icon.jsp">
                <jsp:param name="name" value="chevron-down" />
                <jsp:param name="size" value="small" />
              </jsp:include>
            </button>
            
            <div class="header__user-dropdown" 
                 id="userMenuDropdown"
                 role="menu"
                 aria-labelledby="userMenuButton">
              <a href="<c:url value='/profile.jsp' />" class="header__user-dropdown-item" role="menuitem">Profile</a>
              <a href="<c:url value='/orderList.jsp' />" class="header__user-dropdown-item" role="menuitem">Orders</a>
              <c:if test="${isStaff}">
                <a href="<c:url value='/admin-dashboard.jsp' />" class="header__user-dropdown-item" role="menuitem">Admin</a>
              </c:if>
              <a href="<c:url value='/logout' />" class="header__user-dropdown-item" role="menuitem">Logout</a>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <jsp:include page="/components/atoms/button/button.jsp">
            <jsp:param name="text" value="Login" />
            <jsp:param name="type" value="primary" />
            <jsp:param name="size" value="medium" />
            <jsp:param name="href" value="<c:url value='/login.jsp' />" />
          </jsp:include>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

