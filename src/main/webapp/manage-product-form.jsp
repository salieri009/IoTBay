<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product | IoT Bay - Admin Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-3xl mx-auto">
                    <div class="mb-8">
                        <a href="<%= contextPath %>/api/manage/products" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                            &larr; Back to Products
                        </a>
                        <h1 class="text-display-md text-neutral-900">
                            Add New <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Product</span>
                        </h1>
                    </div>

                    <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                        <form action="<%= contextPath %>/api/manage/products" method="post">
                            <%
                                String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
                            %>
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Product Name *</label>
                                    <input type="text" name="name" required class="form-input w-full" placeholder="e.g. Smart Home Hub">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Category ID *</label>
                                    <input type="number" name="categoryId" required min="1" class="form-input w-full" placeholder="1">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Price *</label>
                                    <input type="number" name="price" required step="0.01" min="0" class="form-input w-full" placeholder="99.99">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Stock Quantity *</label>
                                    <input type="number" name="stockQuantity" required min="0" class="form-input w-full" placeholder="100">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Image URL</label>
                                    <input type="url" name="imageUrl" class="form-input w-full" placeholder="https://example.com/image.jpg">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Description</label>
                                    <textarea name="description" rows="4" class="form-input w-full" placeholder="Product description..."></textarea>
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                                <a href="<%= contextPath %>/api/manage/products" class="btn btn--outline">Cancel</a>
                                <button type="submit" class="btn btn--primary">
                                    Create Product
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />
</body>
</html>

