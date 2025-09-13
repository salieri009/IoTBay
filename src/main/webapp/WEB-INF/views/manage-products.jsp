<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    // Mock product data
    List<Product> products = new ArrayList<>();
    products.add(new Product(1, "Smart Home Hub Pro", "Advanced home automation hub", 299.99, 50, "Smart Home", "IoT Solutions Inc.", true));
    products.add(new Product(2, "IoT Sensor Pack", "Complete sensor kit", 149.99, 25, "Industrial IoT", "SmartTech Co.", true));
    products.add(new Product(3, "Smart Thermostat", "WiFi-enabled thermostat", 199.99, 30, "Smart Home", "Global Connect", true));
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products | IoT Bay - Staff Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <jsp:include page="../components/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                Manage <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Products</span>
                            </h1>
                            <p class="text-lg text-neutral-600">Manage product catalog and inventory</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button class="btn btn--secondary">Export Products</button>
                            <button class="btn btn--primary">Add Product</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="card p-6 mb-8">
                        <div class="flex flex-col md:flex-row gap-4 items-center">
                            <div class="flex-1">
                                <input type="text" placeholder="Search products..." class="form-input">
                            </div>
                            <div class="flex items-center gap-3">
                                <select class="form-select">
                                    <option>All Categories</option>
                                    <option>Smart Home</option>
                                    <option>Industrial IoT</option>
                                </select>
                                <button class="btn btn--outline">Filter</button>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="product" items="<%= products %>">
                            <div class="card p-6 hover-lift">
                                <div class="flex items-start justify-between mb-4">
                                    <img src="<%= contextPath %>/images/sample1.png" alt="${product.name}" class="w-16 h-16 rounded-lg object-cover">
                                    <span class="badge badge--success">Active</span>
                                </div>
                                
                                <h3 class="text-lg font-semibold text-neutral-900 mb-2">${product.name}</h3>
                                <p class="text-sm text-neutral-600 mb-4">${product.description}</p>
                                
                                <div class="space-y-2 mb-4">
                                    <div class="flex justify-between text-sm">
                                        <span class="text-neutral-600">Price:</span>
                                        <span class="font-medium text-neutral-900">$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-neutral-600">Stock:</span>
                                        <span class="font-medium text-neutral-900">${product.stockQuantity} units</span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-neutral-600">Category:</span>
                                        <span class="font-medium text-neutral-900">${product.category}</span>
                                    </div>
                                </div>
                                
                                <div class="flex gap-2">
                                    <button class="btn btn--outline btn--sm flex-1">Edit</button>
                                    <button class="btn btn--secondary btn--sm">View</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="../components/footer.jsp" />
    <script src="<%= contextPath %>/js/main.js"></script>
</body>
</html>