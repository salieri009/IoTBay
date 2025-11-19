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

<header class="bg-white border-b border-neutral-200 sticky top-0 z-50" role="banner">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-between h-16">
    <%-- Logo (Atom) --%>
    <a href="<c:url value='/' />" class="flex items-center gap-2" aria-label="IoT Bay - Home">
      <img src="<c:url value='/images/logo.png' />" alt="IoT Bay Logo" class="h-8 w-auto" onerror="this.style.display='none'" />
      <span class="text-xl font-bold text-neutral-900">IoT Bay</span>
    </a>
    
    <%-- Primary Navigation --%>
    <nav id="site-navigation" class="hidden md:flex items-center gap-6" role="navigation" aria-label="Main navigation">
      <ul class="flex items-center gap-6" role="menubar">
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="${pageContext.request.contextPath}/" />
          <jsp:param name="text" value="Home" />
          <jsp:param name="active" value="${currentPath == '/' || currentPath.endsWith('/index.jsp') ? 'true' : 'false'}" />
        </jsp:include>
        
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="${pageContext.request.contextPath}/browse.jsp" />
          <jsp:param name="text" value="Products" />
          <jsp:param name="active" value="${currentPath.contains('/browse') ? 'true' : 'false'}" />
        </jsp:include>
        
        <jsp:include page="/components/molecules/navigation-item/navigation-item.jsp">
          <jsp:param name="href" value="${pageContext.request.contextPath}/about.jsp" />
          <jsp:param name="text" value="About" />
          <jsp:param name="active" value="${currentPath.contains('/about') ? 'true' : 'false'}" />
        </jsp:include>
      </ul>
    </nav>
    
    <%-- Search Form (Molecule) --%>
    <div class="hidden md:block flex-1 max-w-md mx-8">
      <jsp:include page="/components/molecules/search-form/search-form.jsp">
        <jsp:param name="action" value="/browse.jsp" />
        <jsp:param name="showSuggestions" value="true" />
      </jsp:include>
    </div>
    
    <%-- User Actions --%>
    <div class="flex items-center gap-4" role="toolbar" aria-label="User actions">
      <%-- Shopping Cart --%>
      <a href="<c:url value='/cart.jsp' />" 
         class="relative p-2 text-neutral-600 hover:text-brand-primary transition-colors"
         aria-label="Shopping cart"
         aria-describedby="cartCount">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="cart" />
          <jsp:param name="size" value="large" />
        </jsp:include>
        <span id="cartCount" class="absolute top-0 right-0 inline-flex items-center justify-center px-1.5 py-0.5 text-xs font-bold leading-none text-white transform translate-x-1/4 -translate-y-1/4 bg-red-600 rounded-full" aria-live="polite" aria-atomic="true">0</span>
        <span class="sr-only">items in cart</span>
      </a>
      
      <%-- User Menu --%>
      <c:choose>
        <c:when test="${user != null}">
          <div class="relative">
            <button class="flex items-center gap-2 text-sm font-medium text-neutral-700 hover:text-neutral-900 focus:outline-none" 
                    onclick="toggleUserMenu()"
                    aria-expanded="false"
                    aria-haspopup="true"
                    aria-controls="userMenuDropdown"
                    aria-label="User menu for ${user.firstName} ${user.lastName}"
                    id="userMenuButton">
              <div class="h-8 w-8 rounded-full bg-brand-primary text-white flex items-center justify-center text-xs font-bold" aria-hidden="true">
                ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
              </div>
              <span class="hidden lg:block">${user.firstName}</span>
              <jsp:include page="/components/atoms/icon/icon.jsp">
                <jsp:param name="name" value="chevron-down" />
                <jsp:param name="size" value="small" />
              </jsp:include>
            </button>
            
            <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 ring-1 ring-black ring-opacity-5 focus:outline-none hidden" 
                 id="userMenuDropdown"
                 role="menu"
                 aria-labelledby="userMenuButton">
              <a href="<c:url value='/profile.jsp' />" class="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100" role="menuitem">Profile</a>
              <a href="<c:url value='/orderList.jsp' />" class="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100" role="menuitem">Orders</a>
              <c:if test="${isStaff}">
                <a href="<c:url value='/admin-dashboard.jsp' />" class="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100" role="menuitem">Admin</a>
              </c:if>
              <a href="<c:url value='/logout' />" class="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100" role="menuitem">Logout</a>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <jsp:include page="/components/atoms/button/button.jsp">
            <jsp:param name="text" value="Login" />
            <jsp:param name="type" value="primary" />
            <jsp:param name="size" value="medium" />
            <jsp:param name="href" value="${pageContext.request.contextPath}/login.jsp" />
          </jsp:include>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  
  <script>
    function toggleUserMenu() {
      const dropdown = document.getElementById('userMenuDropdown');
      const button = document.getElementById('userMenuButton');
      const isExpanded = button.getAttribute('aria-expanded') === 'true';
      
      if (isExpanded) {
        dropdown.classList.add('hidden');
        button.setAttribute('aria-expanded', 'false');
      } else {
        dropdown.classList.remove('hidden');
        button.setAttribute('aria-expanded', 'true');
      }
    }
    
    // Close menu when clicking outside
    document.addEventListener('click', function(event) {
      const dropdown = document.getElementById('userMenuDropdown');
      const button = document.getElementById('userMenuButton');
      if (dropdown && !dropdown.classList.contains('hidden') && !button.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.classList.add('hidden');
        button.setAttribute('aria-expanded', 'false');
      }
    });
  </script>
</header>

