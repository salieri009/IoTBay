<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Sitemap - IoT Bay" description="Complete site map of all IoT Bay pages and sections">
    <main class="py-12">
        <div class="container max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
            <!-- Hero Section -->
            <section class="text-center mb-12">
                <h1 class="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">Sitemap</h1>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                    Find all pages and sections of the IoT Bay website
                </p>
            </section>

            <!-- Sitemap Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Main Pages -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <h2 class="text-xl font-bold text-neutral-900 mb-4">Main Pages</h2>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/" class="text-neutral-600 hover:text-brand-primary transition-colors">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/browse.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Browse Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/categories.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Categories</a></li>
                        <li><a href="${pageContext.request.contextPath}/about.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Contact</a></li>
                    </ul>
                </div>

                <!-- Shopping -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <h2 class="text-xl font-bold text-neutral-900 mb-4">Shopping</h2>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/browse.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">All Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/category-smarthome.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Smart Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/category-industrial.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Industrial</a></li>
                        <li><a href="${pageContext.request.contextPath}/category-agriculture.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Agriculture</a></li>
                        <li><a href="${pageContext.request.contextPath}/category-warehouse.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Warehouse</a></li>
                        <li><a href="${pageContext.request.contextPath}/browse.jsp?featured=true" class="text-neutral-600 hover:text-brand-primary transition-colors">Featured Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/browse.jsp?new=true" class="text-neutral-600 hover:text-brand-primary transition-colors">New Arrivals</a></li>
                    </ul>
                </div>

                <!-- Account -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <h2 class="text-xl font-bold text-neutral-900 mb-4">Account</h2>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/login.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/register.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Register</a></li>
                        <li><a href="${pageContext.request.contextPath}/Profiles.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Profile</a></li>
                        <li><a href="${pageContext.request.contextPath}/orderList.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Order History</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Shopping Cart</a></li>
                    </ul>
                </div>

                <!-- Support -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <h2 class="text-xl font-bold text-neutral-900 mb-4">Support</h2>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/help.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Help Center</a></li>
                        <li><a href="${pageContext.request.contextPath}/faq.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">FAQ</a></li>
                        <li><a href="${pageContext.request.contextPath}/shipping.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Shipping & Returns</a></li>
                        <li><a href="${pageContext.request.contextPath}/warranty.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Warranty Info</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Contact Us</a></li>
                    </ul>
                </div>

                <!-- Legal -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <h2 class="text-xl font-bold text-neutral-900 mb-4">Legal & Policies</h2>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/privacy.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Privacy Policy</a></li>
                        <li><a href="${pageContext.request.contextPath}/terms.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Terms of Service</a></li>
                        <li><a href="${pageContext.request.contextPath}/sitemap.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Sitemap</a></li>
                    </ul>
                </div>

                <!-- Admin (if logged in as staff) -->
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'staff'}">
                    <div class="bg-white rounded-lg border border-neutral-200 p-6">
                        <h2 class="text-xl font-bold text-neutral-900 mb-4">Admin</h2>
                        <ul class="space-y-2">
                            <li><a href="${pageContext.request.contextPath}/admin-dashboard.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Dashboard</a></li>
                            <li><a href="${pageContext.request.contextPath}/manage-products.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Manage Products</a></li>
                            <li><a href="${pageContext.request.contextPath}/manage-users.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Manage Users</a></li>
                            <li><a href="${pageContext.request.contextPath}/manage-access-logs.jsp" class="text-neutral-600 hover:text-brand-primary transition-colors">Access Logs</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>

            <!-- Quick Links -->
            <section class="mt-12 bg-neutral-50 rounded-lg p-8">
                <h2 class="text-2xl font-bold text-neutral-900 mb-6 text-center">Quick Links</h2>
                <div class="flex flex-wrap justify-center gap-4">
                    <a href="${pageContext.request.contextPath}/browse.jsp" class="px-4 py-2 bg-white border border-neutral-200 rounded-lg hover:border-brand-primary hover:text-brand-primary transition-colors">Shop Now</a>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="px-4 py-2 bg-white border border-neutral-200 rounded-lg hover:border-brand-primary hover:text-brand-primary transition-colors">Get Support</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="px-4 py-2 bg-white border border-neutral-200 rounded-lg hover:border-brand-primary hover:text-brand-primary transition-colors">Create Account</a>
                    <a href="${pageContext.request.contextPath}/faq.jsp" class="px-4 py-2 bg-white border border-neutral-200 rounded-lg hover:border-brand-primary hover:text-brand-primary transition-colors">View FAQ</a>
                </div>
            </section>
        </div>
    </main>
</t:base>

