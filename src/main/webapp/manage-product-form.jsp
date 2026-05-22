<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User, model.Product" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    Product editProduct = (Product) request.getAttribute("product");
    boolean isEditMode = (editProduct != null);
    String pageTitle = isEditMode ? "Edit Product" : "Add New Product";
    String formAction = isEditMode ? request.getContextPath() + "/manage/products/update" : request.getContextPath() + "/api/manage/products";
    String submitLabel = isEditMode ? "Update Product" : "Create Product";
%>

<t:base title="<%= pageTitle %> | IoT Bay">
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-3xl mx-auto">
                    <div class="mb-8">
                        <a href="${pageContext.request.contextPath}/api/manage/products"
                            class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                            &larr; Back to Products
                        </a>
                        <h1 class="text-display-md text-neutral-900">
                            <%= isEditMode ? "Edit" : "Add New" %> <span
                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Product</span>
                        </h1>
                    </div>

                    <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800" role="alert">
                                <strong>Error:</strong> <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <form action="<%= formAction %>" method="post">
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                            <% if (isEditMode) { %>
                                <input type="hidden" name="product_id" value="<%= editProduct.getId() %>">
                                <input type="hidden" name="created_at" value="<%= editProduct.getCreatedAt() %>">
                            <% } %>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Product Name *</label>
                                    <input type="text" name="name" required class="form-input w-full"
                                        placeholder="e.g. Smart Home Hub"
                                        value="<%= isEditMode ? editProduct.getName() : "" %>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Category ID *</label>
                                    <input type="number" name="categoryId" required min="1" class="form-input w-full"
                                        placeholder="1"
                                        value="<%= isEditMode ? editProduct.getCategoryId() : "" %>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Price *</label>
                                    <input type="number" name="price" required step="0.01" min="0"
                                        class="form-input w-full" placeholder="99.99"
                                        value="<%= isEditMode ? editProduct.getPrice() : "" %>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Stock Quantity *</label>
                                    <input type="number" name="stockQuantity" required min="0" class="form-input w-full"
                                        placeholder="100"
                                        value="<%= isEditMode ? editProduct.getStockQuantity() : "" %>">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Image URL</label>
                                    <input type="url" name="imageUrl" class="form-input w-full"
                                        placeholder="https://example.com/image.jpg"
                                        value="<%= (isEditMode && editProduct.getImageUrl() != null) ? editProduct.getImageUrl() : "" %>">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Description</label>
                                    <textarea name="description" rows="4" class="form-input w-full"
                                        placeholder="Product description..."><%= (isEditMode && editProduct.getDescription() != null) ? editProduct.getDescription() : "" %></textarea>
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                                <a href="${pageContext.request.contextPath}/api/manage/products"
                                    class="btn btn--outline">Cancel</a>
                                <button type="submit" class="btn btn--primary">
                                    <%= submitLabel %>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>
</t:base>