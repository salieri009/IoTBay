<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Pagination Component
    
    Parameters:
    - currentPage: current page number (1-based)
    - totalPages: total number of pages
    - totalItems: total number of items
    - baseUrl: base URL for pagination links
    - showInfo: boolean (show items info, default: true)
--%>

<c:set var="currentPage" value="${param.currentPage != null ? param.currentPage : 1}" />
<c:set var="totalPages" value="${param.totalPages != null ? param.totalPages : 1}" />
<c:set var="totalItems" value="${param.totalItems != null ? param.totalItems : 0}" />
<c:set var="baseUrl" value="${param.baseUrl != null ? param.baseUrl : pageContext.request.requestURI}" />
<c:set var="showInfo" value="${param.showInfo != null ? param.showInfo : true}" />

<c:if test="${totalPages > 1}">
    <nav class="pagination-container" aria-label="Pagination Navigation" role="navigation">
        
        <!-- Items Info -->
        <c:if test="${showInfo}">
            <div class="pagination-info text-sm text-neutral-600 mb-4">
                <c:set var="startItem" value="${(currentPage - 1) * 12 + 1}" />
                <c:set var="endItem" value="${currentPage * 12 > totalItems ? totalItems : currentPage * 12}" />
                
                Showing ${startItem} to ${endItem} of ${totalItems} results
            </div>
        </c:if>
        
        <!-- Pagination Controls -->
        <div class="pagination flex items-center justify-center gap-1">
            
            <!-- First Page -->
            <c:if test="${currentPage > 2}">
                <a href="${baseUrl}?page=1${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item pagination__item--nav" 
                   aria-label="Go to first page">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M15.707 15.707a1 1 0 01-1.414 0l-5-5a1 1 0 010-1.414l5-5a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 010 1.414zm-6 0a1 1 0 01-1.414 0l-5-5a1 1 0 010-1.414l5-5a1 1 0 011.414 1.414L5.414 10l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd"/>
                    </svg>
                </a>
            </c:if>
            
            <!-- Previous Page -->
            <c:if test="${currentPage > 1}">
                <a href="${baseUrl}?page=${currentPage - 1}${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item pagination__item--nav" 
                   aria-label="Go to previous page">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                    </svg>
                </a>
            </c:if>
            
            <!-- Page Numbers -->
            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
            <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />
            
            <!-- Show first page if not in range -->
            <c:if test="${startPage > 1}">
                <a href="${baseUrl}?page=1${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item">
                    1
                </a>
                <c:if test="${startPage > 2}">
                    <span class="pagination__ellipsis">…</span>
                </c:if>
            </c:if>
            
            <!-- Page range -->
            <c:forEach var="page" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${page == currentPage}">
                        <span class="pagination__item pagination__item--current" aria-current="page">
                            ${page}
                        </span>
                    </c:when>
                    <c:otherwise>
                        <a href="${baseUrl}?page=${page}${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                           class="pagination__item"
                           aria-label="Go to page ${page}">
                            ${page}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <!-- Show last page if not in range -->
            <c:if test="${endPage < totalPages}">
                <c:if test="${endPage < totalPages - 1}">
                    <span class="pagination__ellipsis">…</span>
                </c:if>
                <a href="${baseUrl}?page=${totalPages}${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item">
                    ${totalPages}
                </a>
            </c:if>
            
            <!-- Next Page -->
            <c:if test="${currentPage < totalPages}">
                <a href="${baseUrl}?page=${currentPage + 1}${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item pagination__item--nav" 
                   aria-label="Go to next page">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                    </svg>
                </a>
            </c:if>
            
            <!-- Last Page -->
            <c:if test="${currentPage < totalPages - 1}">
                <a href="${baseUrl}?page=${totalPages}${param.queryString != null ? '&'.concat(param.queryString) : ''}" 
                   class="pagination__item pagination__item--nav" 
                   aria-label="Go to last page">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10.293 15.707a1 1 0 010-1.414L14.586 10l-4.293-4.293a1 1 0 111.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0zm-6 0a1 1 0 010-1.414L8.586 10 4.293 5.707a1 1 0 011.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                    </svg>
                </a>
            </c:if>
            
        </div>
        
        <!-- Mobile Page Info -->
        <div class="pagination-mobile-info mt-4 text-center text-sm text-neutral-600 sm:hidden">
            Page ${currentPage} of ${totalPages}
        </div>
        
        <!-- Items per page selector (optional) -->
        <c:if test="${param.showItemsPerPage}">
            <div class="items-per-page mt-4 flex items-center justify-center gap-2 text-sm">
                <label for="items-per-page" class="text-neutral-600">Items per page:</label>
                <select id="items-per-page" class="form__select text-sm" onchange="changeItemsPerPage(this.value)">
                    <option value="12" ${param.itemsPerPage == 12 ? 'selected' : ''}>12</option>
                    <option value="24" ${param.itemsPerPage == 24 ? 'selected' : ''}>24</option>
                    <option value="48" ${param.itemsPerPage == 48 ? 'selected' : ''}>48</option>
                    <option value="96" ${param.itemsPerPage == 96 ? 'selected' : ''}>96</option>
                </select>
            </div>
        </c:if>
        
    </nav>
</c:if>

<script>
function changeItemsPerPage(value) {
    const url = new URL(window.location);
    url.searchParams.set('itemsPerPage', value);
    url.searchParams.set('page', '1'); // Reset to first page
    window.location.href = url.toString();
}

// Keyboard navigation for pagination
document.addEventListener('keydown', function(e) {
    if (e.ctrlKey || e.metaKey) {
        var paginationCurrentPage = parseInt('${currentPage}');
        var paginationTotalPages = parseInt('${totalPages}');
        
        if (e.key === 'ArrowLeft' && paginationCurrentPage > 1) {
            e.preventDefault();
            window.location.href = '${baseUrl}?page=${currentPage - 1}${param.queryString != null ? "&".concat(param.queryString) : ""}';
        } else if (e.key === 'ArrowRight' && paginationCurrentPage < paginationTotalPages) {
            e.preventDefault();
            window.location.href = '${baseUrl}?page=${currentPage + 1}${param.queryString != null ? "&".concat(param.queryString) : ""}';
        }
    }
});
</script>
