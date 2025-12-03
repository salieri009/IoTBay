<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                <t:base title="Manage Products" description="Manage product catalog and inventory">
                    <!-- Page Header -->
                    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="max-w-6xl mx-auto">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                                            Manage <span
                                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Products</span>
                                        </h1>
                                        <p class="text-lg text-neutral-600">
                                            Manage product catalog and inventory
                                        </p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <button onclick="alert('Export feature coming soon')"
                                            class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Products
                                        </button>

                                        <a href="${pageContext.request.contextPath}/api/manage/products/form"
                                            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Add Product
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Products Grid -->
                    <section class="py-12">
                        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="max-w-6xl mx-auto">
                                <!-- Filters and Search -->
                                <div class="bg-white shadow rounded-lg p-6 mb-8">
                                    <div class="flex flex-col md:flex-row gap-4 items-center">
                                        <div class="flex-1 w-full">
                                            <input type="text" placeholder="Search products..."
                                                class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                        </div>
                                        <div class="flex items-center gap-3 w-full md:w-auto">
                                            <select
                                                class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                                <option>All Categories</option>
                                                <option>Smart Home</option>
                                                <option>Industrial IoT</option>
                                            </select>
                                            <button
                                                class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                Filter
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                    <c:choose>
                                        <c:when test="${not empty products}">
                                            <c:forEach var="product" items="${products}">
                                                <div
                                                    class="bg-white rounded-lg shadow hover:shadow-lg transition-shadow duration-200 p-6 flex flex-col h-full">
                                                    <div class="flex items-start justify-between mb-4">
                                                        <img src="${pageContext.request.contextPath}${product.imageUrl != null && !empty product.imageUrl ? product.imageUrl : '/images/default-product.png'}"
                                                            alt="${product.name}"
                                                            class="w-16 h-16 rounded-lg object-cover bg-neutral-100"
                                                            onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'">

                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${product.stockQuantity > 0 ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}">
                                                            ${product.stockQuantity > 0 ? 'Active' : 'Out of Stock'}
                                                        </span>
                                                    </div>

                                                    <h3 class="text-lg font-semibold text-neutral-900 mb-2">
                                                        <c:out value="${product.name}" />
                                                    </h3>
                                                    <p class="text-sm text-neutral-600 mb-4 line-clamp-2 flex-grow">
                                                        <c:out
                                                            value="${product.description != null ? product.description : 'No description available'}" />
                                                    </p>

                                                    <div class="space-y-2 mb-4">
                                                        <div class="flex justify-between text-sm">
                                                            <span class="text-neutral-600">Price:</span>
                                                            <span class="font-medium text-neutral-900">
                                                                $
                                                                <fmt:formatNumber value="${product.price}"
                                                                    pattern="#,##0.00" />
                                                            </span>
                                                        </div>
                                                        <div class="flex justify-between text-sm">
                                                            <span class="text-neutral-600">Stock:</span>
                                                            <span class="font-medium text-neutral-900">
                                                                <c:out value="${product.stockQuantity}" /> units
                                                            </span>
                                                        </div>
                                                        <div class="flex justify-between text-sm">
                                                            <span class="text-neutral-600">Category ID:</span>
                                                            <span class="font-medium text-neutral-900">
                                                                <c:out value="${product.categoryId}" />
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="flex gap-2 mt-auto">
                                                        <a href="${pageContext.request.contextPath}/manage/products/update?id=${product.id}"
                                                            class="flex-1 inline-flex justify-center items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                            Edit
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/product?id=${product.id}"
                                                            class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-brand-700 bg-brand-100 hover:bg-brand-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-500">
                                                            View
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="col-span-full text-center py-12">
                                                <svg class="mx-auto h-12 w-12 text-neutral-400" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                                </svg>
                                                <p class="mt-2 text-neutral-600">No products found.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </section>
                </t:base>