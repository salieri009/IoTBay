<%--
  ============================================
  Molecule: Pagination
  ============================================
  
  Description:
    A pagination component for navigating through lists of items.
    
  Parameters:
    - currentPage: The current page number (default: 1)
    - totalPages: The total number of pages (default: 1)
    - onPageChange: The name of the JavaScript function to call when a page is clicked (default: 'goToPage')
    
  Usage:
    <jsp:include page="/components/molecules/pagination/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}" />
        <jsp:param name="totalPages" value="${totalPages}" />
        <jsp:param name="onPageChange" value="goToPage" />
    </jsp:include>
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String currentPageStr = request.getParameter("currentPage");
    int currentPage = (currentPageStr != null && !currentPageStr.isEmpty()) ? Integer.parseInt(currentPageStr) : 1;
    request.setAttribute("currentPage", currentPage);
    
    String totalPagesStr = request.getParameter("totalPages");
    int totalPages = (totalPagesStr != null && !totalPagesStr.isEmpty()) ? Integer.parseInt(totalPagesStr) : 1;
    request.setAttribute("totalPages", totalPages);
    
    String onPageChange = request.getParameter("onPageChange");
    if (onPageChange == null || onPageChange.isEmpty()) {
        onPageChange = "goToPage";
    }
    request.setAttribute("onPageChange", onPageChange);
%>

<nav class="pagination mt-12" aria-label="Product pagination">
    <div class="flex items-center justify-between">
        <div class="flex items-center gap-2">
            <%-- Previous Button --%>
            <button 
                type="button" 
                class="btn btn--ghost btn--sm"
                onclick="${onPageChange}(${currentPage - 1})"
                aria-label="Previous page"
                ${currentPage <= 1 ? 'disabled' : ''}>
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                </svg>
            </button>
            
            <%-- Page Numbers --%>
            <div class="hidden sm:flex items-center gap-1">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <button 
                        type="button" 
                        class="btn btn--sm ${currentPage == i ? 'btn--primary' : 'btn--ghost'}"
                        onclick="${onPageChange}(${i})"
                        aria-label="Page ${i}"
                        ${currentPage == i ? 'aria-current="page"' : ''}>
                        ${i}
                    </button>
                </c:forEach>
            </div>
            
            <%-- Next Button --%>
            <button 
                type="button" 
                class="btn btn--ghost btn--sm"
                onclick="${onPageChange}(${currentPage + 1})"
                aria-label="Next page"
                ${currentPage >= totalPages ? 'disabled' : ''}>
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </div>
        
        <%-- Mobile Page Indicator --%>
        <span class="text-sm text-neutral-600 sm:hidden">
            Page ${currentPage} of ${totalPages}
        </span>
    </div>
</nav>