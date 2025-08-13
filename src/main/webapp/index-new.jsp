<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="components/layout/base.jsp">
    <jsp:param name="title" value="Smart Technology Store" />
    <jsp:param name="description" value="Discover the latest IoT devices and smart technology solutions at IoT Bay" />
</jsp:include>

<jsp:body>
    <!-- Hero Section -->
    <section class="hero-section bg-gradient-to-br from-brand-primary to-brand-secondary text-white relative overflow-hidden">
        <div class="hero-background absolute inset-0 opacity-10">
            <div class="hero-shapes"></div>
        </div>
        
        <div class="container mx-auto px-4 py-20 relative z-10">
            <div class="grid lg:grid-cols-2 gap-12 items-center">
                <div class="hero-content">
                    <h1 class="text-4xl lg:text-6xl font-bold leading-tight mb-6">
                        Welcome to the
                        <span class="text-gradient bg-gradient-to-r from-yellow-400 to-orange-400 bg-clip-text text-transparent">
                            Future of IoT
                        </span>
                    </h1>
                    <p class="text-xl text-brand-light mb-8 leading-relaxed">
                        Discover cutting-edge IoT devices that transform your world. 
                        From smart home solutions to industrial automation.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <a href="browse" class="btn btn--primary btn--lg group">
                            Shop Now
                            <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                            </svg>
                        </a>
                        <a href="categories" class="btn btn--secondary btn--lg">
                            Explore Categories
                        </a>
                    </div>
                </div>
                
                <div class="hero-visual relative">
                    <div class="hero-device-showcase">
                        <div class="floating-device animate-float">
                            <div class="device-card bg-white bg-opacity-10 backdrop-blur-sm rounded-2xl p-6 border border-white border-opacity-20">
                                <div class="device-icon w-16 h-16 bg-gradient-to-br from-blue-400 to-purple-500 rounded-xl flex items-center justify-center mb-4">
                                    <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-lg mb-2">Smart Dashboard</h3>
                                <p class="text-sm text-brand-light">Real-time monitoring</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-20 bg-white">
        <div class="container mx-auto px-4">
            <div class="text-center mb-16">
                <h2 class="text-3xl lg:text-4xl font-bold text-neutral-900 mb-4">
                    Why Choose IoT Bay?
                </h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    We're your trusted partner in the IoT revolution, offering premium devices and exceptional service.
                </p>
            </div>
            
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div class="feature-card group">
                    <div class="feature-icon-container">
                        <div class="feature-icon bg-gradient-to-br from-blue-500 to-blue-600">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Premium Quality</h3>
                    <p class="text-neutral-600">Carefully curated IoT devices from trusted manufacturers worldwide.</p>
                </div>
                
                <div class="feature-card group">
                    <div class="feature-icon-container">
                        <div class="feature-icon bg-gradient-to-br from-green-500 to-green-600">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Expert Support</h3>
                    <p class="text-neutral-600">24/7 technical support to help you integrate and optimize your IoT solutions.</p>
                </div>
                
                <div class="feature-card group">
                    <div class="feature-icon-container">
                        <div class="feature-icon bg-gradient-to-br from-purple-500 to-purple-600">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M11.3 1.046A1 1 0 0112 2v5h4a1 1 0 01.82 1.573l-7 10A1 1 0 018 18v-5H4a1 1 0 01-.82-1.573l7-10a1 1 0 011.12-.38z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Fast Delivery</h3>
                    <p class="text-neutral-600">Quick and secure shipping to get your IoT projects up and running fast.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Preview Section -->
    <section class="py-20 bg-neutral-50">
        <div class="container mx-auto px-4">
            <div class="text-center mb-16">
                <h2 class="text-3xl lg:text-4xl font-bold text-neutral-900 mb-4">
                    Explore Our Categories
                </h2>
                <p class="text-lg text-neutral-600">
                    From smart homes to industrial solutions
                </p>
            </div>
            
            <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
                <a href="categories?category=smart-home" class="category-card group">
                    <div class="category-icon">
                        <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-lg mb-2">Smart Home</h3>
                    <p class="text-sm text-neutral-600">Automation & Control</p>
                    <div class="category-arrow">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                </a>
                
                <a href="categories?category=sensors" class="category-card group">
                    <div class="category-icon">
                        <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-lg mb-2">Sensors</h3>
                    <p class="text-sm text-neutral-600">Monitoring & Detection</p>
                    <div class="category-arrow">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                </a>
                
                <a href="categories?category=networking" class="category-card group">
                    <div class="category-icon">
                        <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M2 5a2 2 0 012-2h8a2 2 0 012 2v10a2 2 0 002 2H4a2 2 0 01-2-2V5zm3 1h6v4H5V6zm6 6H5v2h6v-2z" clip-rule="evenodd"></path>
                            <path d="M15 7h1a2 2 0 012 2v5.5a1.5 1.5 0 01-3 0V9a1 1 0 00-1-1h-1v-1z"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-lg mb-2">Networking</h3>
                    <p class="text-sm text-neutral-600">Connectivity Solutions</p>
                    <div class="category-arrow">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                </a>
                
                <a href="categories?category=industrial" class="category-card group">
                    <div class="category-icon">
                        <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-lg mb-2">Industrial</h3>
                    <p class="text-sm text-neutral-600">Enterprise Solutions</p>
                    <div class="category-arrow">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 bg-gradient-to-r from-brand-primary to-brand-secondary text-white">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-3xl lg:text-4xl font-bold mb-6">
                Ready to Transform Your World?
            </h2>
            <p class="text-xl text-brand-light mb-8 max-w-2xl mx-auto">
                Join thousands of innovators who trust IoT Bay for their smart technology needs.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <a href="register" class="btn btn--secondary btn--lg">
                    Get Started Today
                </a>
                <a href="contact" class="btn btn--outline btn--lg">
                    Contact Sales
                </a>
            </div>
        </div>
    </section>
</jsp:body>
