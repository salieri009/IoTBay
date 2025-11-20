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
  boolean isStaff = user != null && ("staff".equalsIgnoreCase(user.getRole()) || "admin".equalsIgnoreCase(user.getRole()));
  String currentPath = request.getRequestURI();
  
  // Expose to EL
  request.setAttribute("user", user);
  request.setAttribute("isStaff", isStaff);
  request.setAttribute("currentPath", currentPath);
%>

<header class="bg-white border-b border-neutral-200 sticky top-0 z-50" role="banner" style="z-index: 50;">
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
          <div class="relative z-[100]">
            <button class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-neutral-700 hover:bg-neutral-50 hover:text-neutral-900 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 transition-all duration-200 group relative z-[100]" 
                    onclick="toggleUserMenu()"
                    aria-expanded="false"
                    aria-haspopup="true"
                    aria-controls="userMenuDropdown"
                    aria-label="User menu for ${user.firstName != null ? user.firstName : ''} ${user.lastName != null ? user.lastName : ''}"
                    id="userMenuButton">
              <div class="h-10 w-10 rounded-full bg-gradient-to-br from-brand-primary to-brand-secondary text-white flex items-center justify-center text-sm font-bold shadow-md ring-2 ring-white group-hover:ring-brand-primary/20 transition-all" aria-hidden="true">
                <c:choose>
                  <c:when test="${user.firstName != null && !empty user.firstName && user.lastName != null && !empty user.lastName}">
                    ${fn:toUpperCase(fn:substring(user.firstName, 0, 1))}${fn:toUpperCase(fn:substring(user.lastName, 0, 1))}
                  </c:when>
                  <c:when test="${user.firstName != null && !empty user.firstName}">
                    ${fn:toUpperCase(fn:substring(user.firstName, 0, 1))}
                  </c:when>
                  <c:when test="${user.email != null && !empty user.email}">
                    ${fn:toUpperCase(fn:substring(user.email, 0, 1))}
                  </c:when>
                  <c:otherwise>
                    U
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="hidden lg:flex flex-col items-start">
                <span class="text-sm font-semibold text-neutral-900">${user.firstName != null ? user.firstName : 'User'} ${user.lastName != null ? user.lastName : ''}</span>
                <span class="text-xs text-neutral-500 capitalize">${user.role != null ? user.role : 'Customer'}</span>
              </div>
              <svg class="w-4 h-4 text-neutral-400 group-hover:text-neutral-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            
            <div class="absolute right-0 mt-2 w-56 bg-white rounded-xl shadow-xl py-2 ring-1 ring-neutral-200 focus:outline-none hidden z-[9999]" 
                 id="userMenuDropdown"
                 role="menu"
                 aria-labelledby="userMenuButton"
                 style="z-index: 9999;">
              <div class="px-4 py-3 border-b border-neutral-100">
                <p class="text-sm font-semibold text-neutral-900">${user.firstName != null ? user.firstName : 'User'} ${user.lastName != null ? user.lastName : ''}</p>
                <p class="text-xs text-neutral-500 mt-0.5">${user.email != null ? user.email : ''}</p>
              </div>
              <div class="py-1">
                <a href="<c:url value='/profile.jsp' />" class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors" role="menuitem">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                  </svg>
                  Profile
                </a>
                <a href="<c:url value='/orderList.jsp' />" class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors" role="menuitem">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                  </svg>
                  Orders
                </a>
                <c:if test="${isStaff}">
                  <a href="<c:url value='/admin-dashboard.jsp' />" class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors" role="menuitem">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                    </svg>
                    Admin Dashboard
                  </a>
                </c:if>
              </div>
              <div class="border-t border-neutral-100 pt-1">
                <a href="<c:url value='/logout' />" class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 transition-colors" role="menuitem">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                  </svg>
                  Logout
                </a>
              </div>
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

