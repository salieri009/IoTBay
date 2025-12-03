<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
                    <%@ page import="model.User" %>
                        <%@ page import="model.Product" %>
                            <%@ page import="java.util.List" %>
                                <%@ page import="java.util.ArrayList" %>

                                    <% User user=(User) session.getAttribute("user"); if (user==null ||
                                        (!"staff".equalsIgnoreCase(user.getRole()) &&
                                        !"admin".equalsIgnoreCase(user.getRole()))) {
                                        response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } //
                                        Get products from request attribute List<Product> products = (List<Product>)
                                            request.getAttribute("products");
                                            if (products == null) {
                                            products = new ArrayList<>();
                                                }
                                                %>

                                                <t:base>
                                                    <jsp:attribute name="title">Manage Products | IoT Bay - Staff Portal
                                                    </jsp:attribute>
                                                    <jsp:attribute name="customCSS">admin.css</jsp:attribute>

                                                    <jsp:body>
                                                        <!-- Page Header -->
                                                        <section
                                                            class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                                                            <div class="container">
                                                                <div class="max-w-6xl mx-auto">
                                                                    <div class="flex items-center justify-between">
                                                                        <div>
                                                                            <h1
                                                                                class="text-display-lg text-neutral-900 mb-2">
                                                                                Manage <span
                                                                                    class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Products</span>
                                                                            </h1>
                                                                            <p class="text-lg text-neutral-600">
                                                                                Manage product catalog and inventory
                                                                            </p>
                                                                        </div>
                                                                        <div class="flex items-center gap-3">
                                                                            <jsp:include
                                                                                page="/components/atoms/button/button.jsp">
                                                                                <jsp:param name="text"
                                                                                    value="Export Products" />
                                                                                <jsp:param name="type"
                                                                                    value="secondary" />
                                                                                <jsp:param name="onclick"
                                                                                    value="alert('Export feature coming soon')" />
                                                                            </jsp:include>

                                                                            <jsp:include
                                                                                page="/components/atoms/button/button.jsp">
                                                                                <jsp:param name="text"
                                                                                    value="Add Product" />
                                                                                <jsp:param name="type"
                                                                                    value="primary" />
                                                                                <jsp:param name="href"
                                                                                    value="${pageContext.request.contextPath}/api/manage/products/form" />
                                                                            </jsp:include>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>

                                                        <!-- Products Grid -->
                                                        <section class="py-12">
                                                            <div class="container">
                                                                <div class="max-w-6xl mx-auto">
                                                                    <!-- Filters and Search -->
                                                                    <div class="card p-6 mb-8">
                                                                        <div
                                                                            class="flex flex-col md:flex-row gap-4 items-center">
                                                                            <div class="flex-1">
                                                                                <input type="text"
                                                                                    placeholder="Search products..."
                                                                                    class="form-input">
                                                                            </div>
                                                                            <div class="flex items-center gap-3">
                                                                                <select class="form-select">
                                                                                    <option>All Categories</option>
                                                                                    <option>Smart Home</option>
                                                                                    <option>Industrial IoT</option>
                                                                                </select>
                                                                                <jsp:include
                                                                                    page="/components/atoms/button/button.jsp">
                                                                                    <jsp:param name="text"
                                                                                        value="Filter" />
                                                                                    <jsp:param name="type"
                                                                                        value="outline" />
                                                                                </jsp:include>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div
                                                                        class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                                                        <c:choose>
                                                                            <c:when test="${not empty products}">
                                                                                <c:forEach var="product"
                                                                                    items="${products}">
                                                                                    <div class="card p-6 hover-lift">
                                                                                        <div
                                                                                            class="flex items-start justify-between mb-4">
                                                                                            <img src="${pageContext.request.contextPath}${product.imageUrl != null && !empty product.imageUrl ? product.imageUrl : '/images/default-product.png'}"
                                                                                                alt="${product.name}"
                                                                                                class="w-16 h-16 rounded-lg object-cover"
                                                                                                onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'">

                                                                                            <jsp:include
                                                                                                page="/components/atoms/badge/badge.jsp">
                                                                                                <jsp:param name="text"
                                                                                                    value="${product.stockQuantity > 0 ? 'Active' : 'Out of Stock'}" />
                                                                                                <jsp:param name="type"
                                                                                                    value="${product.stockQuantity > 0 ? 'success' : 'warning'}" />
                                                                                            </jsp:include>
                                                                                        </div>

                                                                                        <h3
                                                                                            class="text-lg font-semibold text-neutral-900 mb-2">
                                                                                            ${product.name}
                                                                                        </h3>
                                                                                        <p
                                                                                            class="text-sm text-neutral-600 mb-4 line-clamp-2">
                                                                                            ${product.description !=
                                                                                            null ? product.description :
                                                                                            'No description available'}
                                                                                        </p>

                                                                                        <div class="space-y-2 mb-4">
                                                                                            <div
                                                                                                class="flex justify-between text-sm">
                                                                                                <span
                                                                                                    class="text-neutral-600">Price:</span>
                                                                                                <span
                                                                                                    class="font-medium text-neutral-900">
                                                                                                    $
                                                                                                    <fmt:formatNumber
                                                                                                        value="${product.price}"
                                                                                                        pattern="#,##0.00" />
                                                                                                </span>
                                                                                            </div>
                                                                                            <div
                                                                                                class="flex justify-between text-sm">
                                                                                                <span
                                                                                                    class="text-neutral-600">Stock:</span>
                                                                                                <span
                                                                                                    class="font-medium text-neutral-900">${product.stockQuantity}
                                                                                                    units</span>
                                                                                            </div>
                                                                                            <div
                                                                                                class="flex justify-between text-sm">
                                                                                                <span
                                                                                                    class="text-neutral-600">Category
                                                                                                    ID:</span>
                                                                                                <span
                                                                                                    class="font-medium text-neutral-900">${product.categoryId}</span>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="flex gap-2">
                                                                                            <div class="flex-1">
                                                                                                <jsp:include
                                                                                                    page="/components/atoms/button/button.jsp">
                                                                                                    <jsp:param
                                                                                                        name="text"
                                                                                                        value="Edit" />
                                                                                                    <jsp:param
                                                                                                        name="type"
                                                                                                        value="outline" />
                                                                                                    <jsp:param
                                                                                                        name="size"
                                                                                                        value="small" />
                                                                                                    <jsp:param
                                                                                                        name="fullWidth"
                                                                                                        value="true" />
                                                                                                    <jsp:param
                                                                                                        name="href"
                                                                                                        value="${pageContext.request.contextPath}/manage/products/update?id=${product.id}" />
                                                                                                </jsp:include>
                                                                                            </div>
                                                                                            <div>
                                                                                                <jsp:include
                                                                                                    page="/components/atoms/button/button.jsp">
                                                                                                    <jsp:param
                                                                                                        name="text"
                                                                                                        value="View" />
                                                                                                    <jsp:param
                                                                                                        name="type"
                                                                                                        value="secondary" />
                                                                                                    <jsp:param
                                                                                                        name="size"
                                                                                                        value="small" />
                                                                                                    <jsp:param
                                                                                                        name="href"
                                                                                                        value="${pageContext.request.contextPath}/product?id=${product.id}" />
                                                                                                </jsp:include>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:forEach>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div
                                                                                    class="col-span-full text-center py-12">
                                                                                    <p class="text-neutral-600">No
                                                                                        products found.</p>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>
                                                    </jsp:body>
                                                </t:base>