<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    // If products are not set, redirect to CategoryPageController
    List<Product> products = (List<Product>) request.getAttribute("products");
    model.Category category = (model.Category) request.getAttribute("category");
    
    if (products == null || category == null) {
        // Redirect to CategoryPageController to fetch data
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/category/agriculture");
        return;
    }
    
    String searchKeyword = (String) request.getParameter("search");
    if (products == null) {
        products = new ArrayList<>();
    }
    // Expose to EL
    request.setAttribute("products", products);
    request.setAttribute("category", category);
%>

<t:base title="Smart Agriculture Solutions - IoT Bay" description="Precision agriculture IoT solutions for crop/irrigation/livestock.">

    <!-- Hero Section -->
    <section class="hero bg-gradient-to-r from-green-50 to-emerald-100">
        <div class="container">
            <div class="hero__content">
                <h1 class="hero__title">Smart Agriculture Revolution</h1>
                <p class="hero__subtitle">
                    Transform traditional farming with precision agriculture IoT technology. Monitor soil conditions, 
                    optimize irrigation, track livestock, and maximize crop yields with data-driven insights.
                </p>
                <div class="hero__actions">
                    <a href="#products" class="btn btn--primary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                        </svg>
                        Explore Solutions
                    </a>
                    <a href="#benefits" class="btn btn--outline btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                        See Benefits
                    </a>
                </div>
            </div>
            <div class="hero__image">
                <img src="${pageContext.request.contextPath}/images/agriculture-hero.jpg" 
                     alt="Smart Agriculture Technology" 
                     class="hero__image"
                     onerror="this.src='${pageContext.request.contextPath}/images/sample3.png'">
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="container py-12">
        <!-- Breadcrumb -->
        <nav class="mb-8">
            <ol class="flex items-center gap-2 text-sm text-neutral-600">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="hover:text-primary">Home</a></li>
                <li>/</li>
                <li><a href="${pageContext.request.contextPath}/browse" class="hover:text-primary">Categories</a></li>
                <li>/</li>
                <li class="text-neutral-900 font-medium">Smart Agriculture</li>
            </ol>
        </nav>

        <!-- Benefits Section -->
        <section id="benefits" class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Precision Agriculture Benefits</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Harness the power of IoT to create sustainable, efficient, and profitable farming operations that adapt to changing conditions in real-time.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="text-center">
                    <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-3">
                        <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">35% Higher Yields</h3>
                    <p class="text-neutral-600 text-sm">Optimize growing conditions and resource allocation for maximum crop productivity</p>
                </div>

                <div class="text-center">
                    <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-3">
                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">50% Water Savings</h3>
                    <p class="text-neutral-600 text-sm">Smart irrigation systems reduce water waste while maintaining optimal soil moisture</p>
                </div>

                <div class="text-center">
                    <div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-3">
                        <svg class="w-6 h-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">40% Cost Reduction</h3>
                    <p class="text-neutral-600 text-sm">Lower operational costs through automated monitoring and precise resource management</p>
                </div>

                <div class="text-center">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-3">
                        <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">95% Early Detection</h3>
                    <p class="text-neutral-600 text-sm">Identify crop diseases and pest issues before they spread across the entire field</p>
                </div>
            </div>
        </section>

        <!-- Smart Farming Solutions -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Comprehensive Smart Farming Solutions</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    From soil monitoring to livestock tracking, our integrated IoT ecosystem covers every aspect of modern agriculture.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Soil & Crop Monitoring -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Soil & Crop Monitoring</h3>
                        <p class="text-neutral-600 mb-4">
                            Monitor soil moisture, nutrients, pH levels, and crop health in real-time for optimal growing conditions.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Multi-depth Soil Sensors
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Drone-based Crop Imaging
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Disease Detection AI
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Smart Irrigation -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Irrigation Systems</h3>
                        <p class="text-neutral-600 mb-4">
                            Automated irrigation control based on soil moisture, weather forecasts, and crop requirements.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Zone-based Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Weather Integration
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Water Usage Analytics
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Livestock Management -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-orange-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Livestock Tracking</h3>
                        <p class="text-neutral-600 mb-4">
                            Track animal health, location, and behavior patterns with wearable IoT devices and smart feeding systems.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                GPS Animal Tracking
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Health Monitoring
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Automated Feeding
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Weather Monitoring -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Weather Stations</h3>
                        <p class="text-neutral-600 mb-4">
                            Local weather monitoring and forecasting for informed decision-making and risk management.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Microclimate Monitoring
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Frost Alerts
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Predictive Analytics
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Greenhouse Automation -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-teal-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Greenhouse Control</h3>
                        <p class="text-neutral-600 mb-4">
                            Complete greenhouse automation with climate control, lighting, and ventilation management.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Climate Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                LED Growth Lighting
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Automated Ventilation
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Farm Management Platform -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-indigo-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Farm Analytics Platform</h3>
                        <p class="text-neutral-600 mb-4">
                            Comprehensive dashboard for data visualization, reporting, and farm performance analytics.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Real-time Dashboards
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Yield Predictions
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Cost-Benefit Analysis
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter and Search Section -->
        <section id="products" class="mb-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6 mb-8">
                <div>
                    <h2 class="text-2xl font-bold text-neutral-900 mb-2">Smart Agriculture Products</h2>
                    <p class="text-neutral-600">Transform your farm with precision agriculture technology</p>
                </div>
                
                <!-- Search and Filter Controls -->
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="relative">
                        <form action="${pageContext.request.contextPath}/category-agriculture.jsp" method="get" class="flex">
                            <input type="text" 
                                   name="search" 
                                   value="${param.search != null ? param.search : ''}"
                                   placeholder="Search agriculture products..." 
                                   class="form-input rounded-r-none w-64">
                            <button type="submit" class="btn btn--primary rounded-l-none">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>
                            </button>
                        </form>
                    </div>
                    
                    <select class="form-select" onchange="filterProducts(this.value)">
                        <option value="">All Categories</option>
                        <option value="sensors">Soil Sensors</option>
                        <option value="irrigation">Irrigation</option>
                        <option value="livestock">Livestock</option>
                        <option value="weather">Weather Stations</option>
                        <option value="greenhouse">Greenhouse</option>
                        <option value="drones">Drones & UAV</option>
                    </select>
                    
                    <select class="form-select" onchange="sortProducts(this.value)">
                        <option value="">Sort by</option>
                        <option value="name">Name A-Z</option>
                        <option value="price-low">Price: Low to High</option>
                        <option value="price-high">Price: High to Low</option>
                        <option value="newest">Newest First</option>
                    </select>
                </div>
            </div>
        </section>

        <!-- Products Grid Section (Section 1.1 - Hierarchical Product Information) -->
        <section id="products" class="py-8">
            <div class="container">
                <!-- Skeleton Loading State (Section 3.2) -->
                <div id="products-skeleton" class="product-grid hidden">
                    <c:forEach begin="1" end="8" varStatus="loop">
                        <div class="skeleton-card">
                            <div class="skeleton skeleton-image"></div>
                            <div class="skeleton skeleton-text skeleton-text--title"></div>
                            <div class="skeleton skeleton-text"></div>
                            <div class="skeleton skeleton-text skeleton-text--short"></div>
                        </div>
                    </c:forEach>
                </div>
                
                <c:choose>
                    <c:when test="${products != null && !empty products}">
                        <div class="product-grid" id="products-grid">
                            <c:forEach var="p" items="${products}">
                                <div class="product-card" 
                                     data-product-id="${p.id}" 
                                     data-price="${p.price}" 
                                     data-name="${fn:toLowerCase(p.name)}"
                                     data-category="agriculture"
                                     tabindex="0"
                                     role="article"
                                     aria-label="Product: ${p.name}">
                                    <div class="product-card__image-container">
                                        <img class="product-card__image" 
                                             src="${p.imageUrl != null && !empty p.imageUrl ? p.imageUrl : 'images/default-product.png'}" 
                                             alt="${p.name}" 
                                             loading="lazy"
                                             width="300"
                                             height="300"
                                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                        <!-- Stock Badge (Visibility of System Status - Nielsen's Heuristic 1) -->
                                        <c:if test="${p.stockQuantity > 0 && p.stockQuantity < 5}">
                                            <span class="product-card__badge product-card__badge--warning" aria-label="Low stock: ${p.stockQuantity} remaining">
                                                Low Stock
                                            </span>
                                        </c:if>
                                        <c:if test="${p.stockQuantity == 0}">
                                            <span class="product-card__badge product-card__badge--error" aria-label="Out of stock">
                                                Out of Stock
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="product-card__body">
                                        <div class="product-card__header">
                                            <h3 class="product-card__title">${p.name}</h3>
                                            <!-- Key Spec Badge (Section 1.1 - Recognition rather than recall) -->
                                            <span class="product-card__spec-badge" title="Communication Protocol">LoRaWAN</span>
                                        </div>
                                        <p class="product-card__description">
                                            <c:choose>
                                                <c:when test="${fn:length(p.description) > 100}">
                                                    ${fn:substring(p.description, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <div class="product-card__footer">
                                            <div class="product-card__price-info">
                                                <div class="product-card__price">$<fmt:formatNumber value="${p.price}" pattern="#.00" /></div>
                                                <div class="product-card__stock-status">
                                                    <c:choose>
                                                        <c:when test="${p.stockQuantity > 0}">
                                                            <span class="text-success text-sm">??In Stock</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-error text-sm">??Out of Stock</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="product-card__actions">
                                                <a href="${pageContext.request.contextPath}/product?id=${p.id}" 
                                                   class="btn btn--outline btn--sm"
                                                   aria-label="View details for ${p.name}">
                                                    View Details
                                                </a>
                                                <button type="button"
                                                        onclick="if(typeof addToCart === 'function') { addToCart(${p.id}, 1); } else { window.location.href='${pageContext.request.contextPath}/product?id=${p.id}'; }"
                                                        class="btn btn--primary btn--sm"
                                                        aria-label="Add ${p.name} to cart"
                                                        <c:if test="${p.stockQuantity == 0}">disabled</c:if>>
                                                    <c:choose>
                                                        <c:when test="${p.stockQuantity > 0}">Add to Cart</c:when>
                                                        <c:otherwise>Out of Stock</c:otherwise>
                                                    </c:choose>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State (Section 3.2) -->
                        <div class="empty-state text-center py-16">
                            <div class="empty-state__icon mb-6">
                                <svg class="w-24 h-24 mx-auto text-neutral-400" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-4">No agriculture products found</h3>
                            <p class="text-lg text-neutral-600 mb-8 max-w-md mx-auto">
                                <c:choose>
                                    <c:when test="${param.search != null && !empty param.search}">
                                        We couldn't find any agriculture products matching "${param.search}". Try adjusting your search terms.
                                    </c:when>
                                    <c:otherwise>
                                        There are no agriculture products available at this time. Please check back later.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="${pageContext.request.contextPath}/browse" class="btn btn--primary">
                                Browse All Products
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Success Stories Section -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Farmer Success Stories</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Real results from farmers who have embraced smart agriculture technology to improve their operations.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-green-600 mb-2">+45%</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Corn Yield Increase</div>
                        <p class="text-sm text-neutral-600">"Smart soil sensors helped me optimize fertilizer application and increase yields significantly." - John Miller, Iowa</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-blue-600 mb-2">60%</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Water Savings</div>
                        <p class="text-sm text-neutral-600">"The smart irrigation system reduced our water usage while maintaining healthy crops." - Maria Rodriguez, California</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card__body text-center">
                        <div class="text-3xl font-bold text-orange-600 mb-2">$50K</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-2">Annual Savings</div>
                        <p class="text-sm text-neutral-600">"Precision agriculture tools helped us reduce costs and increase profitability dramatically." - Tom Wilson, Nebraska</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="card bg-gradient-to-r from-green-600 to-emerald-600 text-white">
            <div class="card__body text-center py-16">
                <h2 class="text-3xl font-bold mb-4">Ready to Modernize Your Farm?</h2>
                <p class="text-xl mb-8 opacity-90">
                    Join thousands of farmers who are already benefiting from smart agriculture technology. 
                    Get expert guidance on implementing IoT solutions for your farm.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn--secondary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Get Free Consultation
                    </a>
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--outline btn--lg border-white text-white hover:bg-white hover:text-green-600">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                        </svg>
                        Explore All Products
                    </a>
                </div>
            </div>
        </section>
    </main>

    <!-- Include Footer -->

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Product filtering and sorting functionality
        function filterProducts(category) {
            const products = document.querySelectorAll('.product-card');
            products.forEach(product => {
                if (!category || product.dataset.category === category) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }

        function sortProducts(sortBy) {
            const grid = document.getElementById('products-grid');
            if (!grid) return;
            
            const products = Array.from(grid.querySelectorAll('.product-card'));
            
            products.sort((a, b) => {
                switch(sortBy) {
                    case 'name':
                        const titleA = a.querySelector('.product-card__title')?.textContent || '';
                        const titleB = b.querySelector('.product-card__title')?.textContent || '';
                        return titleA.localeCompare(titleB);
                    case 'price-low':
                        return parseFloat(a.dataset.price || 0) - parseFloat(b.dataset.price || 0);
                    case 'price-high':
                        return parseFloat(b.dataset.price || 0) - parseFloat(a.dataset.price || 0);
                    default:
                        return 0;
                }
            });
            
            products.forEach(product => grid.appendChild(product));
        }
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Show skeleton loading if products are being loaded
            const productsGrid = document.getElementById('products-grid');
            const skeleton = document.getElementById('products-skeleton');
            
            if (productsGrid && productsGrid.children.length === 0 && skeleton) {
                skeleton.classList.remove('hidden');
            } else if (skeleton) {
                skeleton.classList.add('hidden');
            }
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Counter animation on scroll for success stories
        function animateCounters() {
            const counters = document.querySelectorAll('.text-3xl');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const counter = entry.target;
                        const text = counter.textContent;
                        
                        // Animate the counter
                        counter.style.opacity = '0';
                        setTimeout(() => {
                            counter.textContent = text;
                            counter.style.opacity = '1';
                            counter.style.transition = 'opacity 0.5s ease';
                        }, 200);
                    }
                }
            });
            
            counters.forEach(counter => observer.observe(counter));
        }

        // Initialize animations when page loads
        document.addEventListener('DOMContentLoaded', animateCounters);
    </script>
</t:base>
