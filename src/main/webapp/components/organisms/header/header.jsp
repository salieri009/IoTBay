<%--============================================Organism: Header============================================Description:
  Site header composed of logo, navigation, search form, and user menu. Refactored to use Atomic Design components.
  Dependencies: - atoms/icon/icon.jsp - atoms/button/button.jsp - molecules/navigation-item/navigation-item.jsp -
  molecules/search-form/search-form.jsp Last Updated: 2025 --%>

  <%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ page import="model.User" %>
          <div class="py-1">
            <a href="<c:url value='/api/profile' />"
              class="flex items-center gap-3 px-4 py-2.5 text-sm text-neutral-700 hover:bg-brand-primary/5 hover:text-brand-primary transition-colors"
              role="menuitem">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z">
                </path>
              </svg>
              Profile
            </a>
            <a href="<c:url value='/orderhistory' />"
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
              <a href="<c:url value='/admin-dashboard' />"
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
            <a href="<c:url value='/logout' />"
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
            document.addEventListener('click', function (event) {
              const dropdown = document.getElementById('userMenuDropdown');
              const button = document.getElementById('userMenuButton');
              if (dropdown && !dropdown.classList.contains('hidden') && !button.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.classList.add('hidden');
                button.setAttribute('aria-expanded', 'false');
              }
            });
          </script>
          </header>