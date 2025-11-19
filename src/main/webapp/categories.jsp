<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

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
                    
                    <!-- Smart Home Category -->
                    <article id="smart-home" class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/smart-home.jpg" 
                                 alt="Smart Home Devices" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">120+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Smart Home</h3>
                            <p class="category-card__description">
                                Transform your living space with intelligent automation, security systems, 
                                and energy management solutions.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Smart Lighting</span>
                                <span class="feature-tag">Security Systems</span>
                                <span class="feature-tag">Climate Control</span>
                                <span class="feature-tag">Voice Assistants</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=smart-home" 
                                   class="btn btn--primary w-full">
                                    Explore Smart Home
                                </a>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Industrial IoT Category -->
                    <article id="industrial" class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/industrial.jpg" 
                                 alt="Industrial IoT Solutions" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">85+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Industrial IoT</h3>
                            <p class="category-card__description">
                                Enhance operational efficiency with sensors, monitoring systems, 
                                and predictive maintenance solutions.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Process Monitoring</span>
                                <span class="feature-tag">Asset Tracking</span>
                                <span class="feature-tag">Predictive Maintenance</span>
                                <span class="feature-tag">Quality Control</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=industrial" 
                                   class="btn btn--primary w-full">
                                    Explore Industrial
                                </a>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Agriculture Category -->
                    <article id="agriculture" class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/agriculture.jpg" 
                                 alt="Agricultural IoT Solutions" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">65+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Agriculture</h3>
                            <p class="category-card__description">
                                Revolutionize farming with precision agriculture, smart irrigation, 
                                and crop monitoring technologies.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Soil Monitoring</span>
                                <span class="feature-tag">Smart Irrigation</span>
                                <span class="feature-tag">Weather Stations</span>
                                <span class="feature-tag">Livestock Tracking</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=agriculture" 
                                   class="btn btn--primary w-full">
                                    Explore Agriculture
                                </a>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Warehouse Category -->
                    <article class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/warehouse.jpg" 
                                 alt="Warehouse IoT Solutions" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">45+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Warehouse & Logistics</h3>
                            <p class="category-card__description">
                                Optimize supply chain operations with inventory tracking, 
                                automated sorting, and fleet management systems.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Inventory Tracking</span>
                                <span class="feature-tag">Fleet Management</span>
                                <span class="feature-tag">Automated Sorting</span>
                                <span class="feature-tag">Environmental Monitoring</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=warehouse" 
                                   class="btn btn--primary w-full">
                                    Explore Warehouse
                                </a>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Healthcare Category -->
                    <article class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/healthcare.jpg" 
                                 alt="Healthcare IoT Solutions" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">35+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Healthcare IoT</h3>
                            <p class="category-card__description">
                                Advance patient care with wearable devices, remote monitoring, 
                                and smart medical equipment.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Patient Monitoring</span>
                                <span class="feature-tag">Wearable Devices</span>
                                <span class="feature-tag">Medication Tracking</span>
                                <span class="feature-tag">Emergency Response</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=healthcare" 
                                   class="btn btn--primary w-full">
                                    Explore Healthcare
                                </a>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Transportation Category -->
                    <article class="category-card group">
                        <div class="category-card__image">
                            <img src="${pageContext.request.contextPath}/images/categories/transportation.jpg" 
                                 alt="Transportation IoT Solutions" 
                                 class="w-full h-64 object-cover rounded-t-lg">
                            <div class="category-card__overlay">
                                <span class="category-card__count">28+ Products</span>
                            </div>
                        </div>
                        <div class="category-card__content">
                            <h3 class="category-card__title">Transportation</h3>
                            <p class="category-card__description">
                                Modernize transportation with connected vehicles, traffic management, 
                                and smart infrastructure solutions.
                            </p>
                            <div class="category-card__features">
                                <span class="feature-tag">Vehicle Tracking</span>
                                <span class="feature-tag">Traffic Management</span>
                                <span class="feature-tag">Route Optimization</span>
                                <span class="feature-tag">Fleet Analytics</span>
                            </div>
                            <div class="category-card__actions">
                                <a href="${pageContext.request.contextPath}/browse?category=transportation" 
                                   class="btn btn--primary w-full">
                                    Explore Transportation
                                </a>
                            </div>
                        </div>
                    </article>
                    
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
