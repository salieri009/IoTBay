<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <c:set var="currentPath" value="${pageContext.request.servletPath}" />
      <c:set var="isLoggedIn" value="${not empty sessionScope.user}" />
      <c:set var="userName" value="${sessionScope.user.firstName}" />
      <c:set var="isStaff" value="${sessionScope.user.role eq 'staff' or sessionScope.user.role eq 'admin'}" />

      <header class="bg-white border-b border-neutral-200 sticky top-0 z-50">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex items-center justify-between h-16">
            <!-- Logo -->
            <div class="flex-shrink-0">
              <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2">
                <span class="text-2xl font-bold text-brand-primary">IoT Bay</span>
              </a>
            </div>

            <!-- Main Navigation -->
            <nav class="hidden md:flex items-center space-x-8">
              <a href="${pageContext.request.contextPath}/browse"
                class="text-neutral-700 hover:text-brand-primary transition-colors ${fn:contains(currentPath, '/browse') ? 'text-brand-primary font-semibold' : ''}">
                Browse
              </a>
              <a href="${pageContext.request.contextPath}/categories"
                class="text-neutral-700 hover:text-brand-primary transition-colors ${fn:contains(currentPath, '/categories') ? 'text-brand-primary font-semibold' : ''}">
                Categories
              </a>
              <a href="${pageContext.request.contextPath}/about.jsp"
                class="text-neutral-700 hover:text-brand-primary transition-colors ${fn:contains(currentPath, 'about') ? 'text-brand-primary font-semibold' : ''}">
                About
              </a>
              <a href="${pageContext.request.contextPath}/contact.jsp"
                class="text-neutral-700 hover:text-brand-primary transition-colors ${fn:contains(currentPath, 'contact') ? 'text-brand-primary font-semibold' : ''}">
                Contact
              </a>
            </nav>

            <!-- Right Side: Cart & User Menu -->
            <div class="flex items-center gap-4">
              <!-- Cart -->
              <a href="${pageContext.request.contextPath}/cart"
                class="relative p-2 text-neutral-700 hover:text-brand-primary transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z">
                  </path>
                </svg>
                <c:if test="${not empty sessionScope.cartItemCount and sessionScope.cartItemCount > 0}">
                  <span
                    class="absolute -top-1 -right-1 bg-brand-primary text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center">
                    ${sessionScope.cartItemCount}
                  </span>
                </c:if>
              </a>

              <!-- User Menu -->
              <c:choose>
                <c:when test="${isLoggedIn}">
                  <div class="relative">
                    <button id="userMenuButton" onclick="toggleUserMenu()"
                      class="flex items-center gap-2 p-2 text-neutral-700 hover:text-brand-primary transition-colors"
                      aria-expanded="false" aria-haspopup="true">
                      <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z">
                        </path>
                      </svg>
                      <span class="hidden md:inline text-sm font-medium">${userName}</span>
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                      </svg>
                    </button>

                    <!-- Dropdown Menu -->
                    <div id="userMenuDropdown"
                      class="hidden absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-neutral-200"
                      role="menu">
                      <div class="py-1">
                        <a href="${pageContext.request.contextPath}/api/profile"
                          class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors"
                          role="menuitem">
                          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z">
                            </path>
                          </svg>
                          Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/orderhistory"
                          class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors"
                          role="menuitem">
                          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2">
                            </path>
                          </svg>
                          Orders
                        </a>
                        <c:if test="${isStaff}">
                          <a href="${pageContext.request.contextPath}/admin-dashboard"
                            class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors"
                            role="menuitem">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z">
                              </path>
                            </svg>
                            Admin Dashboard
                          </a>
                        </c:if>
                      </div>
                      <div class="border-t border-neutral-100 pt-1">
                        <a href="${pageContext.request.contextPath}/logout"
                          class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 transition-colors"
                          role="menuitem">
                          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                            </path>
                          </svg>
                          Logout
                        </a>
                      </div>
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/login.jsp"
                    class="bg-brand-primary text-white px-4 py-2 rounded-lg hover:bg-brand-primary-700 transition-colors">
                    Login
                  </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </header>

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
        document.addEventListener('click', function (event) {
          const dropdown = document.getElementById('userMenuDropdown');
          const button = document.getElementById('userMenuButton');
          if (dropdown && !dropdown.classList.contains('hidden') &&
            !button.contains(event.target) && !dropdown.contains(event.target)) {
            dropdown.classList.add('hidden');
            button.setAttribute('aria-expanded', 'false');
          }
        });
      </script>