<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Search and Filter Component
    
    Parameters:
    - currentKeyword: string (current search keyword)
    - currentCategory: string (current selected category)
    - currentPriceMin: number (current min price filter)
    - currentPriceMax: number (current max price filter)
    - currentSort: string (current sort option)
    - categories: List<Category> (available categories)
--%>

<div class="search-filter-panel bg-white rounded-lg shadow-sm border border-neutral-200 p-6 mb-6">
    <!-- Search Section -->
    <div class="search-section mb-6">
        <form action="${pageContext.request.contextPath}/browse" method="get" class="search-form">
            <div class="flex gap-4">
                <!-- Main Search Input -->
                <div class="flex-1 relative">
                    <label for="search-input" class="sr-only">Search products</label>
                    <input 
                        type="text" 
                        id="search-input"
                        name="keyword" 
                        value="${param.currentKeyword}"
                        placeholder="Search for IoT devices, sensors, smart home products..."
                        class="form__input w-full pl-10 pr-4"
                        autocomplete="off"
                    >
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <svg class="w-5 h-5 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    
                    <!-- Search Suggestions (hidden by default, shown via JavaScript) -->
                    <div id="search-suggestions" class="absolute top-full left-0 right-0 bg-white border border-neutral-200 rounded-md shadow-lg z-50 hidden">
                        <!-- Populated via JavaScript -->
                    </div>
                </div>
                
                <!-- Search Button -->
                <button type="submit" class="btn btn--primary px-6">
                    <span class="hidden sm:inline">Search</span>
                    <svg class="w-5 h-5 sm:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"/>
                    </svg>
                </button>
            </div>
            
            <!-- Hidden inputs for preserving other filter states -->
            <input type="hidden" name="category" value="${param.currentCategory}">
            <input type="hidden" name="priceMin" value="${param.currentPriceMin}">
            <input type="hidden" name="priceMax" value="${param.currentPriceMax}">
            <input type="hidden" name="sort" value="${param.currentSort}">
        </form>
    </div>
    
    <!-- Filters Toggle (Mobile) -->
    <div class="flex items-center justify-between mb-4 lg:hidden">
        <h3 class="font-semibold text-neutral-900">Filters</h3>
        <button 
            id="filters-toggle" 
            class="btn btn--ghost btn--sm"
            aria-expanded="false"
            aria-controls="filters-content"
        >
            <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M3 3a1 1 0 011-1h12a1 1 0 011 1v3a1 1 0 01-.293.707L12 11.414V15a1 1 0 01-.293.707l-2 2A1 1 0 018 17v-5.586L3.293 6.707A1 1 0 013 6V3z" clip-rule="evenodd"/>
            </svg>
            Filters
        </button>
    </div>
    
    <!-- Filters Content -->
    <div id="filters-content" class="filters-content hidden lg:block">
        <form action="${pageContext.request.contextPath}/browse" method="get" class="filters-form">
            <!-- Preserve search keyword -->
            <input type="hidden" name="keyword" value="${param.currentKeyword}">
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                
                <!-- Category Filter -->
                <div class="filter-group">
                    <label for="category-select" class="filter-label">Category</label>
                    <select id="category-select" name="category" class="form__select">
                        <option value="">All Categories</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.slug}" 
                                    ${param.currentCategory == category.slug ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Price Range Filter -->
                <div class="filter-group">
                    <label class="filter-label">Price Range</label>
                    <div class="flex gap-2">
                        <input 
                            type="number" 
                            name="priceMin" 
                            value="${param.currentPriceMin}"
                            placeholder="Min $" 
                            class="form__input text-sm"
                            min="0"
                            step="0.01"
                        >
                        <span class="self-center text-neutral-400">-</span>
                        <input 
                            type="number" 
                            name="priceMax" 
                            value="${param.currentPriceMax}"
                            placeholder="Max $" 
                            class="form__input text-sm"
                            min="0"
                            step="0.01"
                        >
                    </div>
                </div>
                
                <!-- Brand Filter -->
                <div class="filter-group">
                    <label for="brand-select" class="filter-label">Brand</label>
                    <select id="brand-select" name="brand" class="form__select">
                        <option value="">All Brands</option>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.slug}" 
                                    ${param.currentBrand == brand.slug ? 'selected' : ''}>
                                ${brand.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Sort Options -->
                <div class="filter-group">
                    <label for="sort-select" class="filter-label">Sort By</label>
                    <select id="sort-select" name="sort" class="form__select">
                        <option value="relevance" ${param.currentSort == 'relevance' ? 'selected' : ''}>Relevance</option>
                        <option value="name_asc" ${param.currentSort == 'name_asc' ? 'selected' : ''}>Name (A-Z)</option>
                        <option value="name_desc" ${param.currentSort == 'name_desc' ? 'selected' : ''}>Name (Z-A)</option>
                        <option value="price_asc" ${param.currentSort == 'price_asc' ? 'selected' : ''}>Price (Low to High)</option>
                        <option value="price_desc" ${param.currentSort == 'price_desc' ? 'selected' : ''}>Price (High to Low)</option>
                        <option value="rating_desc" ${param.currentSort == 'rating_desc' ? 'selected' : ''}>Highest Rated</option>
                        <option value="newest" ${param.currentSort == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="popular" ${param.currentSort == 'popular' ? 'selected' : ''}>Most Popular</option>
                    </select>
                </div>
            </div>
            
            <!-- Filter Actions -->
            <div class="flex flex-wrap items-center justify-between gap-4 mt-6 pt-6 border-t border-neutral-200">
                <div class="flex flex-wrap gap-2">
                    <button type="submit" class="btn btn--primary">
                        Apply Filters
                    </button>
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--ghost">
                        Clear All
                    </a>
                </div>
                
                <!-- Active Filters Display -->
                <div class="active-filters flex flex-wrap gap-2">
                    <c:if test="${param.currentKeyword != null && !param.currentKeyword.isEmpty()}">
                        <span class="filter-tag">
                            Search: "${param.currentKeyword}"
                            <a href="${pageContext.request.contextPath}/browse?category=${param.currentCategory}&priceMin=${param.currentPriceMin}&priceMax=${param.currentPriceMax}&sort=${param.currentSort}" 
                               class="filter-tag__remove" aria-label="Remove search filter">×</a>
                        </span>
                    </c:if>
                    
                    <c:if test="${param.currentCategory != null && !param.currentCategory.isEmpty()}">
                        <span class="filter-tag">
                            Category: ${param.currentCategory}
                            <a href="${pageContext.request.contextPath}/browse?keyword=${param.currentKeyword}&priceMin=${param.currentPriceMin}&priceMax=${param.currentPriceMax}&sort=${param.currentSort}" 
                               class="filter-tag__remove" aria-label="Remove category filter">×</a>
                        </span>
                    </c:if>
                    
                    <c:if test="${param.currentPriceMin != null || param.currentPriceMax != null}">
                        <span class="filter-tag">
                            Price: $${param.currentPriceMin != null ? param.currentPriceMin : '0'} - $${param.currentPriceMax != null ? param.currentPriceMax : '∞'}
                            <a href="${pageContext.request.contextPath}/browse?keyword=${param.currentKeyword}&category=${param.currentCategory}&sort=${param.currentSort}" 
                               class="filter-tag__remove" aria-label="Remove price filter">×</a>
                        </span>
                    </c:if>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Mobile filters toggle
    const filtersToggle = document.getElementById('filters-toggle');
    const filtersContent = document.getElementById('filters-content');
    
    if (filtersToggle && filtersContent) {
        filtersToggle.addEventListener('click', function() {
            const isExpanded = filtersContent.classList.contains('hidden');
            
            if (isExpanded) {
                filtersContent.classList.remove('hidden');
                filtersToggle.setAttribute('aria-expanded', 'true');
            } else {
                filtersContent.classList.add('hidden');
                filtersToggle.setAttribute('aria-expanded', 'false');
            }
        });
    }
    
    // Auto-submit form on filter changes
    const filterSelects = document.querySelectorAll('#category-select, #brand-select, #sort-select');
    filterSelects.forEach(select => {
        select.addEventListener('change', function() {
            this.closest('form').submit();
        });
    });
    
    // Search suggestions (placeholder for future implementation)
    const searchInput = document.getElementById('search-input');
    const searchSuggestions = document.getElementById('search-suggestions');
    
    if (searchInput && searchSuggestions) {
        let searchTimeout;
        
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length >= 2) {
                searchTimeout = setTimeout(() => {
                    // Implement search suggestions API call here
                    // fetchSearchSuggestions(query);
                }, 300);
            } else {
                searchSuggestions.classList.add('hidden');
            }
        });
        
        // Hide suggestions when clicking outside
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !searchSuggestions.contains(e.target)) {
                searchSuggestions.classList.add('hidden');
            }
        });
    }
});
</script>
