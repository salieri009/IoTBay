<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="java.util.Map" %>

<t:base title="Categories | IoT Bay" description="Browse IoT device categories - Smart Home, Industrial, Agricultural, and Warehouse">
    <main>
        <!-- Hero Section -->
        <section class="hero-section bg-gradient-to-br from-brand-primary to-brand-secondary text-white py-16">
            <div class="container">
                <div class="max-w-3xl mx-auto text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">
                        Explore IoT Categories
                    </h1>
                    <p class="text-xl text-blue-100 mb-8">
                        Discover cutting-edge Internet of Things solutions across diverse industries and applications
                    </p>
                    <div class="flex flex-wrap gap-4 justify-center">
                        <a href="#smart-home" class="btn btn--white btn--lg">Smart Home</a>
                        <a href="#industrial" class="btn btn--outline-white btn--lg">Industrial IoT</a>
                        <a href="#agriculture" class="btn btn--outline-white btn--lg">Agriculture</a>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Categories Grid -->
        <section class="categories-section py-16">
            <div class="container">
                
                <!-- Section Header -->
                <div class="text-center mb-12">
                    <h2 class="text-3xl font-bold text-neutral-900 mb-4">Product Categories</h2>
                    <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                        From smart home automation to industrial monitoring, find the perfect IoT solution for your needs
                    </p>
                </div>
                
                <!-- Categories Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <c:forEach var="category" items="${categories}">
                        <c:set var="categorySlug" value="${fn:toLowerCase(fn:replace(category.name, ' ', '-'))}" />
                        <c:set var="productCount" value="${categoryProductCounts[category.id] != null ? categoryProductCounts[category.id] : 0}" />
                        <article id="${categorySlug}" class="category-card group">
                            <div class="category-card__image">
                                <img src="${pageContext.request.contextPath}/images/categories/${categorySlug}.jpg" 
                                     alt="${category.name} Devices" 
                                     class="w-full h-48 object-cover rounded-t-lg"
                                     onerror="this.src='${pageContext.request.contextPath}/images/categories/default.jpg'">
                                <div class="category-card__overlay">
                                    <span class="category-card__count">${productCount}+ Products</span>
                                </div>
                            </div>
                            <div class="category-card__content">
                                <h3 class="category-card__title">${category.name}</h3>
                                <p class="category-card__description">
                                    ${category.description != null && !empty category.description ? category.description : 'Explore our collection of ' += category.name += ' IoT solutions and devices.'}
                                </p>
                                <div class="category-card__actions">
                                    <a href="${pageContext.request.contextPath}/browse.jsp?category=${categorySlug}&categoryId=${category.id}" 
                                       class="btn btn--primary w-full">
                                        Explore ${category.name}
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                    
                    <c:if test="${empty categories}">
                        <!-- Fallback: Show default categories if database is empty -->
                        <article id="smart-home" class="category-card group">
                            <div class="category-card__image">
                                <img src="${pageContext.request.contextPath}/images/categories/smart-home.jpg" 
                                     alt="Smart Home Devices" 
                                     class="w-full h-48 object-cover rounded-t-lg">
                                <div class="category-card__overlay">
                                    <span class="category-card__count">0+ Products</span>
                                </div>
                            </div>
                            <div class="category-card__content">
                                <h3 class="category-card__title">Smart Home</h3>
                                <p class="category-card__description">
                                    Transform your living space with intelligent automation, security systems, 
                                    and energy management solutions.
                                </p>
                                <div class="category-card__actions">
                                    <a href="${pageContext.request.contextPath}/browse.jsp?category=smart-home" 
                                       class="btn btn--primary w-full">
                                        Explore Smart Home
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:if>
                </div>
            </div>
        </section>
        
        <!-- Popular Products Section -->
        <section class="popular-products bg-neutral-100 py-16">
            <div class="container">
                <div class="text-center mb-12">
                    <h2 class="text-3xl font-bold text-neutral-900 mb-4">Popular Products</h2>
                    <p class="text-lg text-neutral-600">
                        Discover our bestselling IoT devices across all categories
                    </p>
                </div>
                
                <!-- Products Grid -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Product cards will be dynamically loaded here -->
                    <c:forEach var="product" items="${popularProducts}" begin="0" end="7">
                        <jsp:include page="/components/molecules/product-card/product-card.jsp">
                            <jsp:param name="product" value="${product}" />
                            <jsp:param name="cardSize" value="sm" />
                        </jsp:include>
                    </c:forEach>
                </div>
                
                <div class="text-center mt-8">
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--outline btn--lg">
                        View All Products
                    </a>
                </div>
            </div>
        </section>
        
    </main>
    
    <script>
        // Smooth scrolling for category links
        document.addEventListener('DOMContentLoaded', function() {
            const categoryLinks = document.querySelectorAll('a[href^="#"]');
            
            categoryLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href').substring(1);
                    const targetElement = document.getElementById(targetId);
                    
                    if (targetElement) {
                        targetElement.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
            
            // Add scroll animation
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);
            
            // Observe category cards
            document.querySelectorAll('.category-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(card);
            });
        });
    </script>
</t:base>
